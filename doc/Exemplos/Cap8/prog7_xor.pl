% ou_exclusivo(X, Y) :-
%   sucesso se X xor Y eh 1, falso caso contrario

ou_exclusivo(X, Y) :-
  ( nonvar(X) ->
      sus_y_xor(X,Y),
    ;
      suspend(sus_y_xor, 3, X->inst)
  ).

sus_y_xor(X,Y) :-
  ( nonvar(Y) ->
      xor(X,Y)
    ;
      suspend(xor(X,Y), 3, Y->inst)
  ).

xor(1, 0).
xor(0, 1).

