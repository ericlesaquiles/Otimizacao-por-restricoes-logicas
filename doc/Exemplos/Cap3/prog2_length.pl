% length(Xs, N) :-
%   N é a quantidade de elementos na lista Xs
%

lenght([X|Xs], N) :-
  length(Xs, K),
  N is 1 + K.

length([], 0).
