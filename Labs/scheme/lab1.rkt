#lang racket

(display "TASK 1:\n")
(- (+ 7 (* 13 22)) (/ 51 (* 64 (- 19 (/ 45(+ 32 11))))))

(display "\nTASK 2:\n")
(define PI 3.1415)

(display "Check if sin^2(x) + cos^2(x) = 1\n")
(+ (expt (sin PI) 2) (expt (cos PI) 2))

(display "\nTASK 3:\n")
(define (fact n)
  (if (eqv? n 1)
      1
      (* n (fact (- n 1)))
      )
  )

(display "5! = ")
(fact 5)

(display "7! = ")
(fact 7)

(define (power x y)
  (expt x y)
  )

(display "\n")

(display "4^5 = ")
(power 4 5)

(display "3^6 = ")
(power 3 6)

(define (factSum x y)
  (+ (fact x) (fact y))
  )

(display "\n")

(display "Fact sum 2 3 = ")
(factSum 2 3)

(display "Fact sum 5 6 = ")
(factSum 5 6)
