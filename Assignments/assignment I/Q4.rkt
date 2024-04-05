#lang racket

#|
Swaps the values of two indices in a vector
A swap is only made if:
0 <= index1 < vector-length
0 <= index2 < vector-length
index1 != index2
|#

(define (insert heap value)
  (heapify
   (vector-append heap (vector value))
   (vector-length heap)
   )
  )

(define (heapSwap heap index1 index2)
  (cond
    ((= index1 index2) heap)
    ((and (< index1 0) (>= index1 (vector-length heap))) heap)
    ((and (< index2 0) (>= index2 (vector-length heap))) heap)
    (else
     (let
         (
          (lstRepr (vector->list heap))
          (val1 (vector-ref heap index1))
          (val2 (vector-ref heap index2))
          )
       (list->vector (list-set (list-set lstRepr index1 val2) index2 val1))
       )
     )
    )
  )

;EDITED THIS METHOD FOR ASSIGNMENT

(define (heapify heap index)
  ;ireturn heap if root is reached
  (if
   (= index 0)
   heap
   (let*
       (
        (parentIndex (floor (/ (- index 1) 2)))
        (parent (vector-ref heap parentIndex))
        (child (vector-ref heap index))
        )

     ;heapify up if child is less than parent
     (if
      (<= child parent)
      (heapify (heapSwap heap parentIndex index) parentIndex)
      heap
      )
     )
   )
  )

;EDITED THIS METHOD FOR ASSIGNMENT

(define (downheap heap index)
  (let
      (
       (len (vector-length heap))
       (leftIndex (+ (* 2 index) 1 ))
       (rightIndex (+ (* 2 index) 2 ))
       )

    (cond
      ((>= leftIndex len) heap)

      ((>= rightIndex len)
       (if
        (< (vector-ref heap leftIndex) (vector-ref heap index))
        (downheap (heapSwap heap index leftIndex) leftIndex)
        heap
        )
       )

      ((<= (vector-ref heap leftIndex) (vector-ref heap rightIndex))
       (downheap (heapSwap heap index leftIndex) leftIndex)
       )

      (else (downheap (heapSwap heap index rightIndex) rightIndex))
      )
    )
  )


;EDITED THIS METHOD FOR ASSIGNMENT

#| Removes element from Heap and displays
old heap, new heap, and the removed value |#
(define (remove heap)
  ;if heap is empty return null
  (if
   (= (vector-length heap) 0)
   null
   (let
       ((removed (vector-ref heap 0))
        (len (vector-length heap)))
     (downheap (vector-take (heapSwap heap 0 (- len 1)) (- len 1)) 0)
     )
   )
  )

;Question 4a)

(define (heap-sort vec)
  (letrec
      ((create-heap
        (lambda (incoming-vec outgoing-vec)
          (if (vector-empty? incoming-vec)
              outgoing-vec
              (create-heap (vector-drop incoming-vec 1) (insert outgoing-vec (vector-ref incoming-vec 0)))
              )
          )
        )
       (sort-vec
        (lambda (incoming-heap outgoing-vec)
          (if (vector-empty? incoming-heap)
              outgoing-vec
              (sort-vec (remove incoming-heap) (vector-append outgoing-vec (vector (vector-ref incoming-heap 0))))
              )
          )
        )
       )
    (sort-vec (create-heap vec '#()) '#())
    )
  )

;Question 4b)

(define (insertion-sort vec)
  (letrec
      ((insert
        (lambda (x V)
          (if (vector-empty? V)
              (vector x)
              (let ((y (vector-ref V 0))
                    (M (vector-drop V 1)))
                (if (< x y)
                    (vector-append (vector x) V)
                    (vector-append (vector y) (insert x M))
                    )
                )
              )
          )
        )
       )

    (if
     (vector-empty? vec)
     '#()
     (insert (vector-ref vec 0) (insertion-sort (vector-drop vec 1)))
     )
    )
  )

