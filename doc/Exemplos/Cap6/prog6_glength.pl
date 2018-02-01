length(Xs, N) :- nonvar(Xs), length1(Xs, N).
length(Xs, N) :- var(Xs), nonvar(N), length2(Xs, N).
