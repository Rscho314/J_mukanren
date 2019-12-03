NB. https://github.com/jasonhemann/microKanren
NB. TODO: for now, namespace is flat (helper functions at top level)
NB. general utils (not in scheme code)
fail =: 3 : 'assert. 0:y'
integerhuh =: 3 : '(0&=@#@$ *. (1 4 e.~ (3!:0))) y'
boxhuh =: 3 : '32&=@(3!:0) y'
NB. (define (var c) (vector c))
var =: 3 : 'fail ` (1&$) @. integerhuh y'
NB. (define (var? x) (vector? x))
varhuh =: 3 : '0: ` (integerhuh@(''''&$)) @. (1&=@#@$ *. 1&=@#) y'
NB. (define (var=? x1 x2) (= (vector-ref x1 0) (vector-ref x2 0)))
vareqhuh =: 4 : '*./ (x -: y) , (varhuh x) , (varhuh y)'
NB. instead of an alist, we use a 2d boxed array (1st row = keys, 2nd = vals)
NB. example : (1$1) walk  2 2 $ (1$1) ; (1$2) ; (1$2) ; 4
walk =: 4 : 'x&[ ` (y walk~ (>@]((<1,(({.y) i. <x)){y&[))) @.](varhuh x) *. (<x) e. {. y'
NB. (define (ext-s x v s) `((,x . ,v) . ,s))
NB. x v s is the boxed array y
NB. No circularity check!!
exts =: 3 : '(}: ; {:) y'
NB. (define mzero '())
mzero =: <''
NB. (define (unit s/c) (cons s/c mzero))
unit =: 3 : 'y&, &.> mzero'

unify =: 2 : 0
  a       =. u walk y
  b       =. v walk y
  pairhuh =. ''-.@-:}. NB. i.e, cdr is not null
  d       =. a vareqhuh b
  e       =. varhuh a
  f       =. varhuh b
  g       =. (pairhuh a) *. (pairhuh b)
  h       =. a -: b
  i       =. y"_
  j       =. exts a ; b ; y
  k       =. exts b ; a ; y
  l       =. ({.a) unify ({.b) ] (}.a) unify (}.b)
  m       =. mzero"_
  i j k l i m`@. ] 1 i.~ d,e,f,g,h
:
  'ERROR: ''unify'' was invoked as a dyad.'
)

NB. CONTINUE HERE!
equivalent =: 2 : 0
 @.''-:u unify v{.
)

NB. here var is boxed int. Make boxed vec int?
NB. callfresh postfix!
NB. state and counter are passed as a boxed vector
callfresh =: 1 : ''''';~((>&}.;u&.>@}.);(>:&.>@}.))'

NB. this uses a thunk, so it seems it must be a conjunction 
mplus =: 2 : 0
  lft =. x
  rgt =. y
  a =. x -: <'' NB. is null '' or <'' ?
  b =.  (3>:(4!:0) x) *. (1<:(4!:0) x) NB. verb, adverb, or conjunction
  
  c =. y&[
  d =. (3 : '(rgt mplus lft'''') y')
  e =. ({.x) , (}. x) mplus y

  c ` d ` e @. ] 1 i.~ a , b
)

bind =: 2 : 0
  lft =. x
  rgt =. y
  a =. x -: <'' NB. is null '' or <'' ?
  b =.  (3>:(4!:0) x) *. (1<:(4!:0) x) NB. verb, adverb, or conjunction

  c =. mzero
  d =. (3 : 0 '((lft '''') bind rgt) y')
  e =. (y ]{.x) mplus (}.x) bind y

  c ` d ` e @. ] 1 i.~ a , b
)

NB. disj and conj take 2 args and yield a monadic verb (= conjunction)
disj =: 2 : 0
  g1 =. x
  g2 =. y
  (3 : '(g1 y) mplus (g2 y)')
)

conj =: 2 : 0
  g1 =. x
  g2 =. y
  (3 : '(g1 y) bind g2')
)