length([X|Xs], N) :-
  length(Xs, K),
  N = 1 + K.
length([], 0).
