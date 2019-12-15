NB. https://github.com/jasonhemann/microKanren
NB. TODO: for now, namespace is flat (helper functions at top level)
NB. This version is strict, vars are vectors of a single int
NB. {.==car and }.==cdr may be wrong => redo pair structure?
integerhuh =: 0&=@#@$ *. (1 4 e.~ (3!:0))
var =: 1$]
varhuh =: (#@$ *. integerhuh@{.)
vareqhuh =: (varhuh@[ *. varhuh@])*.(var@[ -: var@])
walk =: 4 : 'x&[`(y walk~(>@]((<1,(({.y)i.<x)){y&[)))@.](varhuh x)*.(<x)e.{.y'
exts =: 2 : '(u;v);]'
mzero =: <''
unit =: mzero;~]
unify =: 2 : ']`((u&walk) exts (v&walk))`((v&walk) exts (u&walk))`(}.@u&walk $: }.@v&walk ] {.@u&walk $: {.@v&walk)`]`(''''"_)@.(1 i.~ (u&walk vareqhuh v&walk)`([: varhuh u&walk)`([: varhuh v&walk)`(''''&-:&}.@(u&walk) *: ''''&-:&}.@(v&walk))`(u&walk -: v&walk)`:0)'
equivalent =: 2 : '(unit u unify v @{.;}.)`(mzero"_)@.(''''&-: @ (u unify v) @ {.)'
NB. CONTINUE HERE, MAKE equivalent and callfresh PLAY WELL!
callfresh =: 1 : '(u@var@>@}.)({.@];>:&.>@}.)'
5 (2 : 'u equivalent v') (1$0) ('';0) NB. ALMOST!
5 (2 : 'u equivalent (1$>}.v) ({.@];>:&.>@}.v)') ('';0) NB. RIGHT!
5 (2 : 'u equivalent v') callfresh ('';0) NB. WRONG!

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