#lang scheme

(define (read-list path)
  (let ((port (open-input-file path)))
    (let fileReader ((x (read port)))
      (if (eof-object? x)
          (begin
            (close-input-port port)
            '()
            )
          (cons x (fileReader (read port)))
          )
      )
    )
  )

(define (write-longest-subsequence path sequence)
  (with-output-to-file path
    (lambda ()
      (displayln (length sequence))
      (for-each (lambda (x) (displayln x)) sequence)
      )
    #:exists 'truncate)
  )

(define (longest-subsequence lst)
  (let ((longest '()) (subsequence '()))
    (for-each
     (lambda (x)
       (if (or (empty? subsequence) (> x (car subsequence)))
           (begin
             (set! subsequence (cons x subsequence))
             (if (> (length subsequence) (length longest))
                 (set! longest subsequence)
                 #f
                 )
             )
           (set! subsequence (list x))
           )
       (set! longest (reverse longest))
       )
     lst
     )
    longest
    )
  )

(define (find-longest-subsequence in-filepath out-filepath)
  (write-longest-subsequence
   out-filepath
   (longest-subsequence (read-list in-filepath)))
  )

(find-longest-subsequence "in.txt" "out.txt")

