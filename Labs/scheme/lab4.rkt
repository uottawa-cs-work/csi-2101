#lang scheme

(displayln "\n--------------------- Task 1 ---------------------")
(define (rotate vec m)
  (if
   (= m 0)
   vec
   (let* (
          (len (vector-length vec))
          (result (make-vector len 0))
          (num-rotations (modulo m len))
          )
     (do
         ((i 0 (+ i 1)))
       ((= i len) result)
       (vector-set! result (modulo (+ i num-rotations) len) (vector-ref vec i))
       )
     )
   )
  )

(rotate '#(10 20 30 40 50 60) 1)
(rotate '#(22 18 10 11 6) 3)

(displayln "\n--------------------- Task 2 ---------------------")
(define (find-indices-recursive vec val index)
  (cond
    ((= (vector-length vec) index) '())

    ((= (vector-ref vec index) val)
     (cons index (find-indices-recursive vec val (add1 index)))
     )
    (else (find-indices-recursive vec val (add1 index)))
    )
  )

(define (distance-recursive vec val)
  (let* ((indices (find-indices-recursive vec val 0)) (len (length indices)))
    (cond
      ((= len 0) -1)
      ((= len 1) 0)
      (else
       (let ((last-index (list-ref indices (sub1 len))) (first-index (car indices)))
         (- last-index first-index)
         )
       )
      )
    )
  )

(distance-recursive '#(100 22 34 56 22 18 8 22 99 11) 22)
(distance-recursive '#(5 12 21 34 21 5 89) 34)

(displayln "\n--------------------- Task 3 ---------------------")
(define (find-indices-loop vec val)
  (let* ((len (vector-length vec) )(result '()))
    (do
        ((i 0 (+ i 1)))
      ((= i len) result)
      (cond ((= (vector-ref vec i) val) (set! result (append result (list i)))))
      )
    )
  )

(define (distance-loop vec val)
  (let* ((indices (find-indices-loop vec val)) (len (length indices)))
    (cond
      ((= len 0) -1)
      ((= len 1) 0)
      (else
       (let ((last-index (list-ref indices (sub1 len))) (first-index (car indices)))
         (- last-index first-index)
         )
       )
      )
    )
  )

(distance-loop '#(100 22 34 56 22 18 8 22 99 11) 22)
(distance-loop '#(5 12 21 34 21 5 89) 34)
