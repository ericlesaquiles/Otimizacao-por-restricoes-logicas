%% backtrack_raso(+Lista)
% Para cada variável em Lista, tente atribuir um valor em seu domínio

backtrack_raso(Lista) :-
  ( foreach(Var,Lista) do once(indomain(Var)) ).

