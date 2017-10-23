analogy(is_to(A, B), is_to(C, X), Answers) :-
  match(A, B, Operation),
  match(C, X, Operation),
  member(X, Answers).

match(inside(Figure1, Figure2),
      inside(Figure3, Figure2),
      exclude_center) :-
  Figure1 = inside(Figure5, Figure6),
  Figure3 = Figure6.

match(inside(Figure1,Figure2),
      inside(Figure2,Figurel),
      invert).
