#lang scheme

(displayln "\n--------------------- Task 1 ---------------------")
(define (numNotDiv a b d)
  (cond
    ((< b a) 0)
    ((not (equal? (modulo a d) 0)) (+ 1 (numNotDiv (+ a 1) b d)))
    (else (+ 0 (numNotDiv (+ a 1) b d)))
    )
  )

(display "(numNotDiv 6 12 4) ==> ")
(numNotDiv 6 12 4)

(display "(numNotDiv 1 10 3) ==> ")
(numNotDiv 1 10 3)

(displayln "\n--------------------- Task 2 ---------------------")
(define (missing L n)
  (if (= n 0)
      '()
      (if (not (member n L))
          (append (missing L (- n 1)) (list n))
          (missing L (- n 1)))))

(display "missin '(2 4 6 1) 5 ==> ")
(missing '(2 4 6 1) 5)

(display "missin '(1 2 3 1 5 6 5 4 2) 7 ==> ")
(missing '(1 2 3 1 5 6 5 4 2) 7)

(displayln "\n--------------------- Task 3 ---------------------")
(define (count-bills bills amt)
  (if
   (or (equal? amt 0) (null? bills))
   '()
   (let ((quo (quotient amt (car bills))) (mod (modulo amt (car bills))))
     (if
      (> quo 0)
      (append (list quo) (count-bills (cdr bills) mod))
      (append (list quo) (count-bills (cdr bills) amt))
      )
     )
   )
  )

(display "count-bills '(100 50 20 10 5) 345 ==> ")
(count-bills '(100 50 20 10 5) 345)

(display "count-bills '(16 3 1) 26) ==> ")
(count-bills '(16 3 1) 26)


