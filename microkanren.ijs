NB. https://github.com/jasonhemann/microKanren
NB. TODO: for now, namespace is flat (helper functions at top level)
fail =: 3 : 'assert. 0:y'
integerhuh =: (0 = 1&|) *. (0 = {:@+.)
boxhuh =: 3 : '32&=@(3!:0) y'
var =: fail`] @. integerhuh
varhuh =: integerhuh
vareqhuh =: 4 : '*./ (x -: y) , (varhuh x) , (varhuh y)'
walk =: [`(>@(>:@(>@{.@] i.[){])walk]) @. (e.>@{.)
exts =: 2 : '(u ; v);]' NB. probably wrong!
mzero =: <''
unit =: mzero,~]

unify =: 2 :0
NB. written that way bc impossible to assign
NB. probably an interpreter bug
NB. PROBLEM: infinite loop!
NB. REDO {.u walk@] unify ({.v walk y) o[o=.(}.u walk y) unify (}.v walk y)'

]`((u&walk) exts (v&walk))`((v&walk) exts (u&walk))`((}.@u&walk) unify (}.@v&walk))`(mzero"_) @. (1 i.~ (u&walk vareqhuh v&walk)`(varhuh@(u&walk))`(varhuh@(v&walk))`((''&-:@}.@(u&walk)) *: (''&-:@}.@(v&walk)))`(u&walk -: v&walk)`:0)
)
3 unify 5 empty_state

equivalent =: 2 : 'u unify v y'
NB.equivalent =: 2 : 'unit@((u unify v {.) ; }.) `mzero"_ @. (''''-:u unify v {.)'

NB. here var is boxed int. Make boxed vec int?
NB. callfresh postfix!
NB. state and counter are passed as a boxed vector
callfresh =: 1 : '(u@var@>@}.@]) ({.@],>:&.>@}.)'
NB.callfresh =: 1 : ''''';~((>&}.;u&.>@}.);(>:&.>@}.))'

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