#lang scheme

#|
ASSUMPTIONS:
- All query image files are pre-computed and stored in the
queryImages directory

- They are named q<#>.jpg.txt
|#

; Author: Raman Gupta
; Student Number: 300290648

#|
Description: This function reads a file containing a pre-computed histogram

Input:
path (string) path to the histogram file

Output:
A list of the format '(<number of bins>, value1, value2, ...)
|#
(define (read-histogram path)
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


#|
Description: Read all filenames in a directory that end with '.jpg.txt'

Input:
path (string) the path to the directory

Output:
A list of all the filenames that end with '.jpg.txt'
|#
(define (read-dataset-filenames path)
  (map
   (lambda (x) (path->string x))
   (filter
    (lambda (x) (string-suffix? (path->string x) ".jpg.txt"))
    (directory-list path)
    )
   )
  )


#|
Description: Finds the sum of all bin values in a histogram

Input:
histogram (list) list of bin values for histogram

Output:
A decimal number that is the sum of all bin values
|#
; Using foldl since its similar to JavaScript reduce function
(define (sum-histogram histogram) (foldl + 0 histogram))


#|
Description: Normalizes a histogram

Input:
histogram (list) A histogram

Output:
A list that is the normalized histogram
|#
(define (normalize-histogram histogram)
  (let ((sum (sum-histogram histogram)))
    (map (lambda (x) (/ x sum)) histogram)
    )
  )


#|
Description: Returns the similarity ratio of two histograms

Input:
h1 (list) A normalized histogram
h2 (list) A normalized histogram

Output:
A decimal number that is the similarity ratio of the two histograms
|#
(define (compare-histogram h1 h2)
  (sum-histogram
   (map (lambda (x y) (min x y)) h1 h2))
  )


#|
Description: Compare all images in a directory against a query image histogram

Input:
queryHistogram (list) the histogram of the query image
datasetFileNames (list) a list of filenames to compare against (.jpg.txt)
databaseDir (string) the path of the image dataset directory

Output:
A list of pairs containing the simliarity ratio and the filename
|#
(define (compare-dataset-images queryHistogram datasetFileNames datasetDir)
  (map
   (lambda (x)
     (let ((histogram (cdr (read-histogram (string-append datasetDir "/" x)))))
       (cons
        (compare-histogram (normalize-histogram queryHistogram) (normalize-histogram histogram))
        x
        )
       )
     )
   datasetFileNames
   )
  )


#|
Description: A compartor for a pair

Input:
a (pair) A pair of a number and a filename
b (pair) A pair of a number and a filename
|#
(define (pair-sorter a b) (> (car a) (car b)))


#|
Description: Displays the results of a simliarity search nicely
Input:
results (list) the results of a similarity search
|#
(define (display-results results)
  (for-each
   (lambda (x)
     (display (cdr x))
     (display ": ")
     (displayln (car x))
     )
   results
   )
  )


#|
Description: Finds the 5 most similar images to a query image

Input:
queryHistogramFilename (string) the name of query image
file (assumed to exist in the queryImages directory)

imageDatasetDirectory (string) the path to the image dataset directory
|#
(define (similarity-search queryHistogramFilename imageDatasetDirectory)
  (display-results
   (take
    (sort
     (compare-dataset-images
      (cdr (read-histogram (string-append "queryImages/" queryHistogramFilename)))
      (read-dataset-filenames imageDatasetDirectory)
      imageDatasetDirectory
      )
     pair-sorter
     )
    5
    )
   )
  )

(displayln "Top 5 similar images to q00.jpg: ")
(similarity-search "q00.jpg.txt" "imageDataset2_15_20")

