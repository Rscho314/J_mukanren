NB. https://github.com/jasonhemann/microKanren
(0 : 0)
from scheme source:
-------------------
- o  == ?
- eq == =

miscellaneous:
--------------
- most likely, making a var would mean adding a dimension
  to the existing array (TODO).
)


NB. (define (var c) (vector c))
var =. 3 : '] ` (1&$) @. (0&=@#@$)y'

NB. (define (var? x) (vector? x))
varo =. 3 : '0&<#$y'

NB. util (not in scheme source)
assert_vars =. 4 : 'assert. */ ; varo &.> x ; y'
fail =. 3 : 'assert. 0:y'
NB. (define (var=? x1 x2) (= (vector-ref x1 0) (vector-ref x2 0)))
vareqo =. 4 : '({. x) -: {. y'

(0 : 0)
(define (walk u s)
  (let ((pr (and (var? u) (assp (lambda (v) (var=? u v)) s))))
    (if pr (walk (cdr pr) s) u)))
)
NB. instead of an alist, we use a 2d boxed array (1st row = keys, 2nd = vals)
isin =. 4 : '+/ ; x&-: &.> {.y'
getin =. 4 : '(>@{:y) {~ I. ; x&-: &.> {.y'
walk =. 4 : '0&{:: ` (1&{:: walk~ 0&{:: getin 1&{::) @. (varo@>@{. *. 0&{:: isin 1&{::) x ; <y'

NB. (define (ext-s x v s) `((,x . ,v) . ,s))
NB. x v s is a boxed array
exts =. 3 : '(}: ; 2&{::) y'

NB. (define mzero '())
mzero =. ''

NB. (define (unit s/c) (cons s/c mzero))
unit =. 3 : 'y , mzero'

(0 : 0)
(define (unify u v s)
  (let ((u (walk u s)) (v (walk v s)))
    (cond
      ((and (var? u) (var? v) (var=? u v)) s)
      ((var? u) (ext-s u v s))
      ((var? v) (ext-s v u s))
      ((and (pair? u) (pair? v))
       (let ((s (unify (car u) (car v) s)))
         (and s (unify (cdr u) (cdr v) s))))
(else (and (eqv? u v) s)))))
)
NB. again, args are taken as a single boxed array
NB. pairs are boxed arrays
extsinv =. 3 : 'exts@b;a;2&{:: y'  NB. (ext-s v u s)
andeqvo =. 3 : '''''&[`2&{::@.a-:b y'  NB. (and (eqv? u v) s)
unify =. 3 : 0
  a=. 0&{:: walk 2&{::  NB. (var? u)
  b=. 1&{:: walk 2&{::  NB. (var? v)
  
  #.((a vareqo b) , (varo@a , varo@b)) y
)
andeqvo`extsinv`exts`exts````2&{::@. #.((a vareqo b) , (varo@a , varo@b)) 1 1 ; 2 2 ; < 2 2 $ 1 1 ; 2 2 ; 3 3 ; 4 4
1 1 ; 2 2 ; < 2 2 $ 1 1 ; 2 2 ; 3 3 ; 4 4
((varo@(0&{:: walk 2&{::)) , (varo@(1&{:: walk 2&{::))) 1 1 ; 2 2 ; < 2 2 $ 1 1 ; 2 2 ; 3 3 ; 4 4

(0 : 0)
(define (== u v)
  (lambda (s/c)
    (let ((s (unify u v (car s/c))))
(if s (unit `(,s . ,(cdr s/c))) mzero))))
)
