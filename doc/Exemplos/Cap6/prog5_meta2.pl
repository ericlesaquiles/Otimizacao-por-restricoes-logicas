solve(true, 1, Limit) :- !.

solve((G1, G2), C, Limit) :-
  !, solve(G1, C1, Limit), solve(G2, C2, Limit),
  C is min(C1, C2).

solve(G, C, Limit) :-
  clause_cf(G, B, C1), C1 > Limit,
  Limit1 is Limit/C1, solve(B, C2, Limit1),
  C is C1 * C2.
