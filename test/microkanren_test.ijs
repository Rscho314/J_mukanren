NB. microKanren-test.scm

before_all=: 3 : 0
  load jpath'~mukanren/release/mukanren.ijs'
)

test_integerhuh =: 3 :0
  assert. 0 1 1 1 0 -: (integerhuh 1$1),(integerhuh"0 ] 10 1 0),integerhuh 'a'
)

test_var =: 3 :0
  assert. var 1
)

test_varhuh =: 3 :0
  assert. varhuh 3
)

test_vareqhuh =: 3 :0
  assert. 1 0 0 -: (5 vareqhuh 5),(1 vareqhuh 5),(5 vareqhuh 0)
)

test_walk =: 3 :0
  assert. 'a' -: 1 walk 1 0 2;2;'a';0
)

test_exts =: 3 :0
  assert. ('';~1;3) -: (1"_ exts (3"_)) <''
)

test_unit =: 3 :0
  assert. (1;'') -: unit <1
)

test_unify =: 3 :0
  assert. ('';~3;5) -: 3 unify 5 (<'')
)

test_equivalent =: 3 :0
  smoutput 3 equivalent 5 empty_state
  NB.assert. (0;~(3;5);'';'') -: 3 equivalent 5 empty_state
)

NB. Are we missing an op on empty_state?
NB. Otherwise, why needed to give 0 to equivalent??
test_second_set_t1 =: 3 :0
  NB.smoutput {.'';~1;~5;~1$0
  smoutput (2 : '5 equivalent 0 v y') callfresh empty_state
)