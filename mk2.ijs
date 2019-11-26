NB. https://github.com/jasonhemann/microKanren
(0 : 0)
from scheme source:
-------------------
- _huh  == ?
- _eq == =
)
NB. general utils (not in scheme code)
fail =. 3 : 'assert. 0:y'
integer_huh =. 3 : '(0&=@#@$ *. (1 4 e.~ (3!:0))) y'
box_huh =. 3 : '32&=@(3!:0) y'

NB. (define (var c) (vector c))
NB. we use a boxed integer as variable
var =. 3 : 'fail ` < @. integer_huh y'

NB. (define (var? x) (vector? x))
NB. must be boxed and hold an integer
var_huh =. 3 : '0: ` (integer_huh@>) @. box_huh y'

NB. (define (var=? x1 x2) (= (vector-ref x1 0) (vector-ref x2 0)))
varorfail =. 3 : 'fail ` ] @. var_huh y' NB. not in scheme code
var_eq_huh =. 4 : '*./ (x -: y) , (var_huh x) , (var_huh y)'

(0 : 0)
(define (walk u s)
  (let ((pr (and (var? u) (assp (lambda (v) (var=? u v)) s))))
    (if pr (walk (cdr pr) s) u)))
)
NB. instead of an alist, we use a 2d boxed array (1st row = keys, 2nd = vals)
NB. example : (<2) walk  2 2 $ 1 ; 2 ; 3 ; 4
NB. x can't be nil (correct?)
walk =. 4 : '(x&[ ` (y walk~ ](x i.~{.y)&{({:y)&[) )@. ](var_huh x)*.(#@{.y)~: x i.~{.y'

NB. (define (ext-s x v s) `((,x . ,v) . ,s))
NB. x v s is a boxed array
NB. No circularity check!!
exts =. 3 : '(}: ; {:) y'
extsinv =. 3 : '(|.@}: ; {:) y'

NB. (define mzero '())
mzero =. ''

NB. (define (unit s/c) (cons s/c mzero))
NB. s/c is boxed
unit =. 3 : 'y ; mzero'

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
NB. CONTINUE HERE! are boxed int the right representation?
NB. really try to understand the unification algorithm!
NB. again, args are taken as a single boxed array
unify =. 3 : 0
  a=.(0&{:: walk 2&{::) y
  b=.(1&{:: walk 2&{::) y
  c =. 2&{:: y
  pair_huh =. 2&=@#
  i =. a var_eq_huh b
  ii =. 1 &= var_huh a
  iii =. 1 &= var_huh b
  iv =. (pair_huh a) *. (pair_huh b)
  v =. a -: b
  NB.c&[`((exts (a;b),<c)&[)`((exts (b;a),<c)&[)`((unify ({. &.> a),({. &.> b) , <c)&[)`c&[`mzero&[ @. ] 1 i.~ i , ii, iii, iv, v
(unify ({. &.> a);(<{. &.> b) , <c) NB. this fails
)

(<2) ; (<3) ; <2 2 $ ;/3 4 5 6
unify (<2 2) ; (<3 3) ; <2 2 $ ;/3 4 5 6
exts (<2) ; (<2) ; <2 2 $ ;/3 4 5 6


(0 : 0)
(define (== u v)
  (lambda (s/c)
    (let ((s (unify u v (car s/c))))
(if s (unit `(,s . ,(cdr s/c))) mzero))))
)
