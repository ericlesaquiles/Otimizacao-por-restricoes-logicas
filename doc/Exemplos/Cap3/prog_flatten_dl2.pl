flatten_dl([X|Xs], Ys\Zs) :-
  flatten_dl(X, Ys\Bs), flatten_dl(Xs, Bs\Zs).
flatten_dl(X,[X|Xs]\Xs) :-
  atomic(X),
  X \= [].
flatten_dl([],Xs\Xs).
