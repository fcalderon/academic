#lang pl

#| 
<TYPE> ::= <num>
       | <null>
       | <sym>

<SE> ::= <TYPE>
       | { cons <TYPE> <null>  | { cons <TYPE> ...}
       | { list <SE> ... }
       | '{ <SE> ... }
|#


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
    [(Div l r) (/ (eval l) (eval r))]))

(: run : String -> Number)
;; evaluate an AE program contained in a string
(define (run str)
  (eval (parse str)))

;; tests
(test (run "3") => 3)
(test (run "{3 + 4}") => 7)
(test (run "{{3 - 4} + 7}") => 6)