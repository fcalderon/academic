#lang pl 02

#| 
<TYPE> ::= <num>
       | <null>
       | <sym>

<SE> ::= <TYPE>
       | { cons <TYPE> <null>  | { cons <TYPE> ...}
       | { list <SE> ... }
       | '{ <SE> ... }
|#

;; 1 BNF

; 1.B

#| BNF for the AE language:
   <AE> ::= <num>
          | { <AE> + <AE> }
          | { <AE> - <AE> }
          | { <AE> * <AE> }
          | { <AE> / <AE> }
|#

;; AE abstract syntax trees
(define-type AE
  [Num Number]
  [Add AE AE]
  [Sub AE AE]
  [Mul AE AE]
  [Div AE AE])

(: parse-sexpr : Sexpr -> AE)
;; parses s-expressions into AEs
(define (parse-sexpr sexpr)
  (match sexpr
    [(number: n) (Num n)]
    [(list lhs '+ rhs) (Add (parse-sexpr lhs) (parse-sexpr rhs))]
    [(list lhs '- rhs) (Sub (parse-sexpr lhs) (parse-sexpr rhs))]
    [(list lhs '* rhs) (Mul (parse-sexpr lhs) (parse-sexpr rhs))]
    [(list lhs '/ rhs) (Div (parse-sexpr lhs) (parse-sexpr rhs))]
    [else (error 'parse-sexpr "bad syntax in ~s" sexpr)]))

(: parse : String -> AE)
;; parses a string containing an AE expression to an AE AST
(define (parse str)
  (parse-sexpr (string->sexpr str)))

(: eval : AE -> Number)
;; consumes an AE and computes the corresponding number
(define (eval expr)
  (cases expr
    [(Num n)   n]
    [(Add l r) (+ (eval l) (eval r))]
    [(Sub l r) (- (eval l) (eval r))]
    [(Mul l r) (* (eval l) (eval r))]
    [(Div l r) (if (zero? (eval r))
                   999
                   (/ (eval l) (eval r)))]))

(: run : String -> Number)
;; evaluate an AE program contained in a string
(define (run str)
  (eval (parse str)))

;; tests
(test (run "3") => 3)
(test (run "{3 + 4}") => 7)
(test (run "{{3 - 4} + 7}") => 6)
(test (run "{3 / 0}") => 999)
(test (run "{0 / 0}") => 999)
(test (run "{1 / {5 - {2 + 3}}}") => 999)

;; 1.C 

#| 1.C.1 -  |#


;; 1.C.2

#|
<MAE> ::= <num>
        | { + <MAE> <MAE> }
        | { - <MAE> <MAE> }
        | { * <MAE> <MAE> }
        | { / <MAE> <MAE> }
        | { set <MAE> }
        | get
        | { seq { set <MAE> } { set <MAE> } ... }
|#


;; 2 Higher Order Function
;; Build sum of squares using fold and map

; square : given a number returns the square of that number
(: square : Number -> Number)
(define (square n)
  (* n n))

(test (square 1) => 1)
(test (square 5) => 25)
(test (square -2) => 4)
(test (square 0) => 0)

; takes a list of numbers as input, and produces a number
; which is the sum of the squares of all of the numbers in the list
(: sum-of-squares : (Listof Number) -> Number)
(define (sum-of-squares LoN)
  (foldl + 0 (map square LoN)))

(test (sum-of-squares (list 1)) => 1)
(test (sum-of-squares (list 1 1)) => 2)
(test (sum-of-squares (list 0)) => 0)
(test (sum-of-squares (list -1 2 -4 4)) => 37)
(test (sum-of-squares '()) => 0)
             

;; 3 Typed Racket

;; 3.A

(define-type BINTREE
  [Leaf Number]
  [Node BINTREE BINTREE])

; tree-map : takes in a numeric function f and a binary tree,
; and returns a tree with the same shape but using f(n) for
; values in its leaves
(: tree-map : (Number -> Number) BINTREE -> BINTREE)
(define (tree-map f btree)
  (cases btree
    [(Leaf number) (Leaf (f number))]
    [(Node b1 b2)  (Node (tree-map f b1) (tree-map f b2))]))

(test (tree-map add1 (Node (Leaf 1) (Node (Leaf 2) (Leaf 3))))
      => (Node (Leaf 2) (Node (Leaf 3) (Leaf 4))))
(test (tree-map add1 (Leaf 1)) => (Leaf 2))


(: tree-fold : (Any -> Any) (BINTREE -> Number) BINTREE -> Any)
(define (tree-fold consumer leaf-function tree)
  0)

; tree-reverse : consumes a tree and returns a tree that is its mirror image.
(: tree-reverse : BINTREE -> BINTREE)
(define (tree-reverse bintree)
  bintree)

(define minutes-spent 180)