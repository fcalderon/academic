;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname homework1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1 Academic integrity agreement
(define I-will-behave #t)

(check-expect I-will-behave true)

; 2 Post test post on Piazza
; Done

; 3 - Define near

; Integer Integer Integer -> Boolean
; Given three integers, int1, int2, and int3, determine whether they are
; at most within an interval of 2.
(define (near? int1 int2 int3)
  (and (<= (get-dif int1 int2) 2)
       (<= (get-dif int1 int3) 2)
       (<= (get-dif int2 int3) 2)))

; Integer Integer -> Integer
; Given two integers, int1, and int2, return their difference
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

; List of Symbols -> Integer
; Given a list of symbols, list-of-symbols, count the number of ocurrences
; of the symbol x in the list
(define (count-xs list-of-symbols)
  (if (empty? list-of-symbols) 0
  (+ (if (equal? 'x (first list-of-symbols)) 1 0) (count-xs (rest list-of-symbols)))))

(equal? 1 (count-xs '(x)))
(equal? 3 (count-xs '(a b c d x ed x a x)))
(equal? 0 (count-xs '(a b c d 1 2 3)))
(equal? 0 (count-xs '()))


; 5) Define an ascending? 
;
; List of Integers -> Boolean
; Given a list of integers, list-of-numbers, returns whether the numbers are
; sorted in ascending order
(define (ascending? list-of-numbers)
  (if (<= (length list-of-numbers) 1) true
        (and (<= (first list-of-numbers) (first (rest list-of-numbers)))
             (ascending? (rest list-of-numbers)))))

(check-expect true (ascending? '()))
(check-expect true (ascending? (list 1000)))
(check-expect true (ascending? (list 1 2 3)))
(check-expect true (ascending? (list 5 8 100)))
(check-expect false (ascending? (list 1 2 3 0)))

; 6 Implement zip2

; List Of Anything List Of Anything -> List of list
; Given two lists of any value type of *equal length*, return a list that
; contains two-elements lists from the first and second lists respectively.
(define (zip2 list1 list2)
  (if (empty? list1) '()
      (cons (list (first list1) (first list2)) (zip2 (rest list1) (rest list2)))))



(check-expect (zip2 '() '()) '())
(check-expect (zip2 '(1) '(2)) (list '(1 2)))
(check-expect (zip2 '(1 3 5) '(2 4 6)) (list '(1 2) '(3 4) '(5 6)))
(check-expect (zip2 (list 1 2 3) (list 'a 'b 'c)) (list (list 1 'a) (list 2 'b) (list 3 'c)))

; 7
;
(define my-picture 39)
(check-expect my-picture 39)
