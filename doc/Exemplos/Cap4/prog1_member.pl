member(X,[X|Xs]).
member(X, [_|Xs]) :- member(X, Xs).
