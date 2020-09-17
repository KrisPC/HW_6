;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;1.31
(define interior-node
	(lambda (content lnode rnode)
		(list content lnode rnode)))

(define leaf
  (lambda (content)
    (content)))

(define leaf?
  (lambda (bintree)
   (not (pair? bintree))))

(define lson cadr)

(define rson caddr)

(define contents-of
	(lambda (bintree)
		(if (leaf? bintree)
			bintree
			(car bintree))))

;1.32
(define double-tree
  (lambda (bintree)
    (if (leaf? bintree)
        (* 2 bintree)
        (interior-node (contents-of bintree)
        (double-tree (lson bintree))
        (double-tree (rson bintree))))))

(double-tree (interior-node 'blue
                            (interior-node 'red
                                           (leaf 26)
                                           (leaf 24))
                            (interior-node 'yellow
                                           (leaf 10)
                                           (leaf 12))))                                           

;1.33
(define mark-leaves-with-red-depth
	(lambda (btree)
		(mark-leaves-with-red-accumulated btree 0)))

(define mark-leaves-with-red-accumulated
	(lambda (btree n)
		(cond ((leaf? btree) n)
			((eq? (contents-of btree) 'red)
				(interior-node 'red
					(mark-leaves-with-red-accumulated (lson btree) (+ n 1))
					(mark-leaves-with-red-accumulated (rson btree) (+ n 1))))
			(else
				(interior-node (contents-of btree)
					(mark-leaves-with-red-accumulated (lson btree) n)
					(mark-leaves-with-red-accumulated (rson btree) n))))))