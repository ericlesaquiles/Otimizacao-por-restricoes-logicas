%% busca_com_dom(+Lista)
% Faz a busca por backtracking nas variáveis de Lista
%

busca_com_dom(Lista) :-
  ( fromto(Lista, Vars, Resto, [])
  do
    escolhe_var(Vars, Var, Resto),
    indomain(Var).
  ).

escolhe_var(Lista, Var, Resto) :- Lista = [Var | Resto].

