#lang racket

(define (solve-quadratic a b c)
  (let ((discriminant (- (expt b 2) (* 4 (* a c)))))
    (cond
      ((> discriminant 0)
       (let ((sol1 (/ (+ (- b) (sqrt (- (expt b 2) (* 4 (* a c))))) (* 2 a)))
             (sol2 (/ (- (- b) (sqrt (- (expt b 2) (* 4 (* a c))))) (* 2 a))))
         (cons sol1 (cons sol2 '())))
       )
      ((= discriminant 0)
       (cons (/ (- b) (* 2 a)) '())
       )
      (else '())
      )
    )
  )

