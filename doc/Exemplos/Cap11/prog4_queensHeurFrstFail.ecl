busca(Lista, first_fail) :-
  ( fromto(Lista, Vars, Resto, [])
  do
    delete(Var, Vars, Resto, 0, first_fail),
    indomain(Var)
  ).

