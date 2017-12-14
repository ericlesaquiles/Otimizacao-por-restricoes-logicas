conta_backtrackings :-
  setval(single_step,true).
conta_backtrackings :-
  getval(single_step,true),
  incval(backtrackings),
  setval(single_step,false).
