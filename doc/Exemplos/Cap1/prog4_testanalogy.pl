test_analogy(Name, X) :-
  figures(Name, A, B, C),
  answers(Name, Answers),
  analogy(is_to(A,B), is_to(C,X), Answers).

figures(test1,
        [ inside(inside(triangle, triangle),square),
          inside(triangle, square),
          inside(inside(square, circle),square) ]).

answers(test1,
        [ inside(inside(circle, circle), square),
          inside(square, square),
          inside(inside(triangle, circle), square),
          inside(circle, square),
          inside(triangle, square) ]).

