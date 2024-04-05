#lang scheme


(define (make-graph-helper graph size)
  (cond
    ((= size 1) (hash-set! graph 1 '()))
    (else
     (begin
       (hash-set! graph size '())
       (make-graph-helper graph (- size 1))
       ))
    )
  graph
  )


(define (make-graph . args)
  (cond
    ((= (length args) 0) (make-graph-helper (make-hash) 1))
    ((= (length args) 1) (make-graph-helper (make-hash) (list-ref args 0)))
    (else (displayln "Error: Method only takes 0 or 1 arguments"))
    )
  )


(define (add-vertex g)
  (let ((largest-vertex (car (reverse (hash-keys g #t)))))
    (displayln largest-vertex)
    (hash-set! g (+ 1 largest-vertex) '())
    )
  g
  )


(define (add-edge g u v)
  (cond
    ((not (and (list? (hash-ref g u #f)) (list? (hash-ref g v #f)))) (displayln "Error: Both vertices must exist in graph"))
    (else
     (hash-set! g u (append (hash-ref g u #f) (list v)))
     )
    )
  g
  )


(define path-found #f)
(define (find-path-helper g start end path)
  (set! path (append path (list start)))

  (if
   (= start end)
   (begin (set! path-found #t) path)
   (begin
     (for-each
      (lambda (x)
        (when (not path-found)
          (if
           (not (member x path))
           (let ((new-path (find-path-helper g x end path)))
             (if path-found (set! path new-path) (display ""))
             )
           (display "")
           )
          )
        )
      (hash-ref g start)
      )
     path
     )
   )

  (if path-found path '())
  )


(define (find-path g u v)
  (find-path-helper g u v '())
  )


(define (edges g)
  (let ((result '()))
    (for-each
     (lambda (x)
       (set!
        result
        (append
         result
         (map (lambda (y) (cons x y)) (hash-ref g x))
         )
        ))
     (hash-keys g)
     )
    result
    )
  )

;; Test cases
(let ((graph (make-graph 5)))
  (add-edge graph 1 2)
  (add-edge graph 1 3)
  (add-edge graph 2 3)
  (add-edge graph 3 4)
  (find-path graph 1 4)
  )

