length([X|Xs], N) :-
  N > 0,
  K is N -1,
  len(Xs, K).

length([], 0).
