#lang scheme

(displayln "\n--------------------- Task 1 ---------------------")
(define (first-unique L)
  (letrec
      ((contains (lambda (lst elem)
                   (cond
                     ((null? lst) #f)
                     ((equal? (car lst) elem) #t)
                     (else (contains (cdr lst) elem))
                     )
                   )))

    (let loop ((lst L))
      (cond
        ((null? lst) 0)
        ((contains (cdr lst) (car lst)) (loop (cdr lst)))

        (else (car lst)))))
  )


(first-unique '(18 22 17 19 21 18 17))
(first-unique '(7 2 2 1 8 1))

(displayln "\n--------------------- Task 2 ---------------------")
(define (reverse-string str)
  (let loop ((end (sub1 (string-length str))) (answer ""))
    (if
     (>= end 0)
     (loop (sub1 end) (string-append answer (string (string-ref str end))))
     answer
     )
    )
  )
(reverse-string "rahim")
(reverse-string "extension")

(displayln "\n--------------------- Task 3 ---------------------")
(define (all-substrings str n)
  (let loop ((start 0) (end n))
    (cond
      ((> end (string-length str)) '())
      (else (cons (substring str start end) (loop (add1 start) (add1 end))))
      )
    )
  )


(all-substrings "Rahim" 2)
(all-substrings "Green" 5)

