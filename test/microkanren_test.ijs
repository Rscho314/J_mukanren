NB. microKanren-test.scm

before_all=: 3 : 0
  load jpath'~mukanren/release/mukanren.ijs'
)

test_second_set_t1 =: 3 : 0
  smoutput 5&equivalent callfresh empty_state
  NB.assert ({.'';~1;~5;~1$0) -: {. 5&equivalent callfresh empty_state
)