;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname homework1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1
(define I-will-behave #t)

(equal? I-will-behave true)

; 2
; Done

; 3 - Define near

; consumes three integers and determines whether they are all “near” each other, where near means that they are at most within an interval of 2
(define (near? int1 int2 int3)
  (and (<= (get-dif int1 int2) 2)
       (<= (get-dif int1 int3) 2)
       (<= (get-dif int2 int3) 2)))
  
(define (get-dif int1 int2)
  (abs (- int1 int2)))
; Tests for get-dif

(equal? 1 (get-dif 3 2))
(equal? 5 (get-dif 3 8))
(equal? 20 (get-dif 21 1))
(equal? 4 (get-dif 2 -2))


(near? 1 -1 1)
(not (near? 2 -2 2))
(not (near? 0 2 3))

; 4 - Define count-xs
; Consumes a list of symbols and returns the number of occurrences of the symbol x in the list. (The actual symbol x, not some input.)

(define (count-xs list-of-symbols)
  (if (empty? list-of-symbols) 0
  (+ (if (equal? 'x (first list-of-symbols)) 1 0) (count-xs (rest list-of-symbols)))))

(equal? 1 (count-xs '(x)))
(equal? 3 (count-xs '(a b c d x ed x a x)))
(equal? 0 (count-xs '(a b c d 1 2 3)))
(equal? 0 (count-xs '()))


;; 5)
;; Define an ascending? function that determines whether a list of numbers is sorted in ascending order.
;; This means that each element is smaller than or equal to the next one in the list. Again, make sure
;; that you write a proper contract, purpose statement, and tests.
;;
(define (ascending? list-of-numbers)
  (if (<= (length list-of-numbers) 1) true
        (and (<= (first list-of-numbers) (first (rest list-of-numbers)))
             (ascending? (rest list-of-numbers)))))

(check-expect true (ascending? '()))
(check-expect true (ascending? (list 1000)))
(check-expect true (ascending? (list 1 2 3)))
(check-expect true (ascending? (list 5 8 100)))
(check-expect false (ascending? (list 1 2 3 0)))

;; 6
;; Finally, implement a zip2 function that does the following:
;; * It consumes two arguments that are lists of equal length, say (Listof A) and (Listof B)
;;   for some types A and B. (Note that you cannot express the fact that they are equal-length
;;   lists with the way we write contracts, so make sure you mention that in the purpose statement.)
;; * The result is a list that contains two-element lists from the first and the second lists respectively.
;;   Use (List ? ?) to specify “a two-item list of ? and ?” in your contract.
;; You can assume here too that the input is always valid.

(define (zip2 list1 list2)
  (if (empty? list1) '()
      (list (list (first list1) (first list2)) (zip2 (rest list1) (rest list2)))))

(check-expect (zip2 '() '()) '())
(check-expect (zip2 '(1) '(2)) '('(1 2)))
(check-expect (zip2 '(1 3 5) '(2 4 6)) (list '(1 2) '(3 4) '(5 6)))
(check-expect (zip2 (list 1 2 3) (list 'a 'b 'c)) (list (list 1 'a) (list 2 'b) (list 3 'c)))
