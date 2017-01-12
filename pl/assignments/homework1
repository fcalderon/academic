;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname homework1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1
(define I-will-behave #t)

(equal? I-will-behave true)

; 2
; In progress

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


; 5 
