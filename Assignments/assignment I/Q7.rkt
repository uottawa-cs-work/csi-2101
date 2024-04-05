#lang scheme

(define male-prefs-table (make-hash))
(define female-prefs-table (make-hash))

; Custom while loop implementation
(define (while condition body)
  (when (condition)
    (body)
    (while condition body)
    )
  )

; Converst list of preferences to a hash table
(define (preference-list->preference-table! table lst)
  (for-each
   (lambda (item)
     (hash-set! table (car item) (cdr item))
     )
   lst)
  )

; Converts hash table of pairings to list of pairs
(define (pairing-table->pairing-list table)
  (hash-map table (lambda (key value) (cons key value)) #t)
  )

(define (stable-marriage male-prefs-list female-prefs-list)
  (preference-list->preference-table! male-prefs-table male-prefs-list)
  (preference-list->preference-table! female-prefs-table female-prefs-list)

  (let ((male-pairings (make-hash)) (female-pairings (make-hash)))
    (while
     ; Condition
     (lambda () (not (= (length (hash-keys male-pairings)) (length male-prefs-list))))

     ; Body
     (lambda ()
       (for-each
        (lambda (curr-male)
          (when (not (= (length (hash-keys male-pairings)) (length male-prefs-list)))
            (let*
                ((curr-male-prefs (hash-ref male-prefs-table curr-male))
                 (curr-female (car curr-male-prefs))
                 (curr-female-prefs (hash-ref female-prefs-table curr-female))
                 (curr-pairing (hash-ref female-pairings curr-female #f)) ; Either #f or a male
                 )
              (hash-set! male-prefs-table curr-male (cdr curr-male-prefs))

              (if (not curr-pairing)
                  (begin
                    (hash-set! male-pairings curr-male curr-female)
                    (hash-set! female-pairings curr-female curr-male)
                    )
                  (if
                   (< (index-of curr-female-prefs curr-male) (index-of curr-female-prefs curr-pairing))
                   (begin
                     (hash-remove! male-pairings curr-pairing)
                     (hash-set! male-pairings curr-male curr-female)
                     (hash-set! female-pairings curr-female curr-male)
                     )
                   #f
                   )
                  )

              (if
               (empty? (cdr curr-male-prefs))
               (begin
                 (hash-remove! male-prefs-table curr-male)
                 )
               #f
               )
              )
            )
          )
        (hash-keys male-prefs-table #t)
        )
       )
     )

    (pairing-table->pairing-list male-pairings)
    )
  )

(stable-marriage
 '(("Jack" . ("Jane" "Amanda" "Kelly")) ("John". ("Amanda" "Jane" "Kelly")) ("Mike". ("Amanda" "Jane" "Kelly")))
 '(("Jane" . ("Mike" "Jack" "John")) ("Amanda". ("John" "Mike" "Jack")) ("Kelly". ("Mike" "John" "Jack")))
 )


