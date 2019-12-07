NB. https://github.com/jasonhemann/microKanren
NB. TODO: for now, namespace is flat (helper functions at top level)
fail =: 3 : 'assert. 0:y'
integerhuh =: 3 : '(0&=@#@$ *. (1 4 e.~ (3!:0))) y'
boxhuh =: 3 : '32&=@(3!:0) y'
var =: fail`] @. integerhuh
varhuh =: integerhuh
vareqhuh =: 4 : '*./ (x -: y) , (varhuh x) , (varhuh y)'
walk =: [`(>@(>:@(>@{.@] i.[){])walk]) @. (e.>@{.)
exts =: 2 : '(u ; v);]'
mzero =: <''
unit =: mzero,~]

unify =: 2 : 0
  pairhuh =. ''-.@-:}. NB. i.e, cdr is not null
  d       =. u&walk vareqhuh v&walk
  e       =. varhuh@u&walk
  f       =. varhuh@v&walk
  g       =. pairhuh@u&walk *. pairhuh@v&walk
  h       =. u&walk -: v&walk NB. probably WRONG!
  i       =. ]
  j       =. u&walk exts v&walk
  k       =. v&walk exts u&walk
  l       =. {.@u&walk unify {.@v&walk ] }.@u&walk unify }.@v&walk
  m       =. mzero"_

  i`j`k`l`m @.d`e`f`g`h`:0
)


equivalent =: 2 : 'unit@((u unify v {.) ; }.) `mzero"_ @. (''''-:u unify v {.)'

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