NB. https://github.com/jasonhemann/microKanren
NB. TODO: for now, namespace is flat (helper functions at top level)
NB. This version assumes lvars are integers (walk, exts)
fail =: 3 : 'assert. 0:y'
integerhuh =: (0&=@#@$ *. (1 4 e.~ (3!:0)))
var =: ] NB.fail`] @. integerhuh
varhuh =: integerhuh
vareqhuh =: var@[ = var@]
walk =: [`(>@(>:@(>@{.@] i.[){])walk]) @. (e.>@{.)
exts =: 2 : 'y;~;/u`v`:0 y'
mzero =: <''
unit =: mzero,~]
unify =: 2 : ']`((u&walk) exts (v&walk))`((v&walk) exts (u&walk))`((}.u&walk ss) $: (}.v&walk ss) ss[ss=.({.u&walk s) $: ({.v&walk s) s[s=.])`]`(mzero"_) @. (1 i.~ (u&walk vareqhuh v&walk)`(varhuh@(u&walk))`(varhuh@(v&walk))`((''''&-:@}.@(u&walk)) *: (''''&-:@}.@(v&walk)))`(u&walk -: v&walk)`:0)'
equivalent =: 2 : '(((unit u unify v {.y);}.y)"_)`(mzero"_) @. ] mzero-:u unify v {. y'
callfresh =: 1 : '(u@var@>@}.@])({.@],>:&.>@}.)'

NB. if mplus doesn't work on boxes, ','<->';'
mplus =: 2 :0
  (v"_)`((v $: u'')"_)`((({.u),((}.u) $: v))"_)@.(1 i.~(-:~<'')`(0-.@-:(3!:0))`:0) u
)

bind =: 2 :0
  (mzero"_)`NB.CONTINUE HERE!@.(1 i.~(-:~<'')`(0-.@-:(3!:0))`:0) u
)