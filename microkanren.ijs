NB. https://github.com/jasonhemann/microKanren
NB. TODO: for now, namespace is flat (helper functions at top level)
NB. This version assumes lvars are integers (walk, exts)
integerhuh =: (0&=@#@$ *. (1 4 e.~ (3!:0)))
var =: ]
varhuh =: integerhuh
vareqhuh =: var@[ = var@]
walk =: [`(>@(>:@(>@{.@] i.[){])$:]) @. (e.>@{.)
exts =: 2 : ',~<@;/@(u`v`:0)'
mzero =: <''
unit =: mzero,~]
unify =: 2 :0
  ]`(u&walk exts ] v&walk)`(v&walk exts ] u&walk)`(}.@u&walk $: }.@v&walk ] {.@u&walk $: {.@v&walk)`]`(mzero"_) @. (1 i.~(u&walk vareqhuh v&walk)`(varhuh@u&walk)`(varhuh@v&walk)`(''&-:@}.@u&walk *: ''&-:@}.@v&walk)`(u&walk -: v&walk)`:0)
)
equivalent =: 2 :0
 (((unit u unify v {.y);}.y)"_)`(mzero"_) @. ] mzero-:u unify v {.y
)
callfresh =: 1 : '(u@var@>@}.@])({.@],>:&.>@}.)'

mplus =: 2 :0
  (v"_)`((v $: u'')"_)`((({.u),((}.u) $: v))"_)@.(1 i.~(-:~<'')`(0-.@-:(3!:0))`:0) u
)

bind =: 2 :0
  (mzero"_)`(((u'') $: v)"_)(((v {.u) mplus ((}.u) $: v))"_)`@.(1 i.~(-:~<'')`(0-.@-:(3!:0))`:0) u
)

disj =: 2 :0
  (u@]) mplus (v@])
)

conj =. 2 :0
  (u@]) bind v
)