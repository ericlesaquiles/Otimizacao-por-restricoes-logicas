% Recebe tuplas variavel-dominio
% e restrições


backtrack([], Res).
backtrack([V1-D1| Vars], Res) :-
  member(V1,D1),

  backtrack(Vars, Res).


backtrack(D-R, )



%

backtrack(R) :-
  functor(R, _, 0),
  partial_satisfiable(R).


partial_satisfiable(R) :-

