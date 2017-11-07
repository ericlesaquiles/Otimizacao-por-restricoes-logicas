busca(Lista, Backtracks) :-
  inicia_backtracks,
  ( fromto(Lista, Vars, Resto, []),
  do
    escolhe_vars(Vars, Vari-Dominio, Resto),
    escolhe_vals(Dominio, Val),
    Vari = Val,
    conta_backtracks
  ),
  pega_backtracks(Backtracks).

inicia_backtracks :-
  setval(backtracks, 0).

pega_backtracks(B) :-
  getval(backtracks, B).

conta_backtracks :-
  on_backtracking(incval(backtracks)).

on_backtracking(_).
on_backtracking(Q) :-
  once(Q),
  fail.

