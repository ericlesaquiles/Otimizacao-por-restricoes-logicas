% subtermo(Sub, termo) :-
%   Sub eh um termo que aparece em termo
%

subtermo(Termo, Termo).
subtermo(Sub, Termo) :-
  compound(Termo),
  functor(Termo, _, N),
  subtermo(N, Sub, Termo).

subtermo(N, Sub, Termo) :-
  arg(N, Termo, Arg),
  subtermo(Sub, Arg).
subtermo(N, Sub, Termo) :-
  N > 1,
  N1 is N - 1,
  subtermo(N1, Sub, Termo).
