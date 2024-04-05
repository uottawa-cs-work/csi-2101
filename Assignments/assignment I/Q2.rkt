#lang scheme

; Custom while loop implementation
(define (while condition body)
  (when (condition)
    (body)
    (while condition body)
    )
  )

(define (hidden-words main-string string-list)
  (let ((results '()))
    (for-each
     (lambda (curr-string)
       (let ((i 0) (j 0))
         (while
          (lambda () (and (< i (string-length main-string)) (< j (string-length curr-string))))
          (lambda ()
            (begin
              (if
               (equal? (string-ref main-string i) (string-ref curr-string j))
               (set! j (+ 1 j))
               #f
               )
              (set! i (+ 1 i))
              )
            )
          )

         (if
          (= j (string-length curr-string))
          (set! results (append results (list curr-string)))
          #f
          )
         )
       )
     string-list
     )
    results
    )
  )

(hidden-words "subdermatoglyphic" '("set" "graphic" "drama" "toy" "brag"))
