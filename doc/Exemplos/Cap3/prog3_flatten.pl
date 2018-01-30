flatten([X|Xs], Ys) :-
  flatten(X, Ys1),
  flatten(Xs, Ys2),
  append(Ys1, Ys2, Ys).
flatten(X, X) :-
  atomic(X),
  X \= [].
flatten([], []).
