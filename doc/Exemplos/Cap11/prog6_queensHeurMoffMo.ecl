busca(Lista, moffmo) :-
  middle_out(Lista, ListaDeSaida),
  ( fromto(ListaDeSaida, Vars, Resto, [])
  do
    delete(Var, Vars, Resto, 0, first_fail),
    indomain(Var)
  ).

