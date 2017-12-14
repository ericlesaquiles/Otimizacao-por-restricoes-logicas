busca(Lista, Backtrackings) :-
  inicia_backtrackings,
  ( fromto(Lista, Vars, Resto, []),
  do
    escolhe_vars(Vars, Vari-Dominio, Resto),
    escolhe_vals(Dominio, Val),
    Vari = Val,
    conta_backtrackings
  ),
  pega_backtrackings(Backtrackings).

inicia_backtrackings :-
  setval(backtrackings, 0).

pega_backtrackings(B) :-
  getval(backtrackings, B).

conta_backtrackings :-
  on_backtracking(incval(backtrackings)).

on_backtracking(_).
on_backtracking(Q) :-
  once(Q),
  fail.

