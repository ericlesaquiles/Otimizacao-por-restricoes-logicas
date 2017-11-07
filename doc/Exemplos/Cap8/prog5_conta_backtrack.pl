conta_backtracks :-
  setval(single_step,true).
conta_backtracks :-
  getval(single_step,true),
  incval(backtracks),
  setval(single_step,false).
