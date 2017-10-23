lenght([X|Xs], N) :-
  N > 0,
  K is N -1,
  length(Xs, K).

length([], 0).
