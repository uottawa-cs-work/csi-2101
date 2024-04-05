#lang racket

(define (geometric-sequence-loop s r n)
  (do ((i 0 (+ i 1))
       (result '() (cons currNum result))
       (currNum s (* currNum r)))
    ((= i n) (reverse result))
    )
  )

(geometric-sequence-loop 9 -1 7)
