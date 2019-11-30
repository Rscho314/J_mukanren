NB. microKanren-test.scm

before_all=: 3 : 0
  load jpath'~mukanren/release/mukanren.ijs'
)

test_second_set_t1 =: 3 : 0
  assert 1;~5;~1$0 -: (3 : '5&=y') callfresh empty_state
)