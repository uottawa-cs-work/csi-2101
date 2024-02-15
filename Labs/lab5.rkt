#lang scheme

#| Heap is of type Vector |#

#|
Swaps the values of two indices in a vector
A swap is only made if:
0 <= index1 < vector-length
0 <= index2 < vector-length
index1 != index2
|#
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

(define (heapify heap index)
  (if
   (= index 0)
   heap
   (let*
       (
        (parentIndex (floor (/ (- index 1) 2)))
        (parent (vector-ref heap parentIndex))
        (child (vector-ref heap index))
        )

     (if
      (>= child parent)
      (heapify (heapSwap heap parentIndex index) parentIndex)
      heap
      )
     )
   )
  )

(define (insert heap value)
  (heapify
   (vector-append heap (make-vector 1 value))
   (vector-length heap)
   )
  )

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
        (> (vector-ref heap leftIndex) (vector-ref heap index))
        (downheap (heapSwap heap index leftIndex) leftIndex)
        heap
        )
       )

      ((>= (vector-ref heap leftIndex) (vector-ref heap rightIndex))
       (downheap (heapSwap heap index leftIndex) leftIndex)
       )

      (else (downheap (heapSwap heap index rightIndex) rightIndex))
      )
    )

  )

#| Removes element from Max-Heap and displays
old heap, new heap, and the removed value |#
(define (remove heap)
  (if
   (= (vector-length heap) 0)
   null
   (let
       (
        (removed (vector-ref heap 0))
        (len (vector-length heap))
        )
     (display "Old Heap: ")
     (displayln heap)
     (display "New heap: ")
     (displayln (downheap (vector-take (heapSwap heap 0 (- len 1)) (- len 1)) 0))
     (display "Removed: ")
     removed
     )
   )
  )

(displayln "\n--------------------- Task 1 ---------------------")
#| Test cases for insert |#
; Insert into empty heap
(insert '#() 10)

; Insert into non-empty heap
(insert '#(30 20 10) 25)

; Inserted element is max element
(insert '#(30 20 10) 40)

; Insert element is min element
(insert '#(30 20 10) 0)

; Insert element into heap with duplicates
(insert '#(30 20 20 10) 25)


(displayln "\n--------------------- Task 2 ---------------------")
#| Test cases for remove |#
; Remove from empty heap
(remove '#())

; Remove from heap with 1 element
(displayln "")
(remove '#(10))

; Remove from heap with more than 1 element
(displayln "")
(remove '#(40 30 20 10))

; Remove from heap with duplicates
(displayln "")
(remove '#(40 30 30 20 10))
