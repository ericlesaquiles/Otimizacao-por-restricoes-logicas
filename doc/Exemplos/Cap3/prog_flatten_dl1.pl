flatten_dl([X|Xs], Ys\Zs) :-
  flatten_dl(X, As\Bs), flatten_dl(Xs, Cs\Ds),
  append_dl(As\Bs, Cs\Ds, Ys\Zs).
flatten_dl(X,[X|Xs]\Xs) :-
  atomic(X),
  X \= [].
flatten_dl([],Xs\Xs).
