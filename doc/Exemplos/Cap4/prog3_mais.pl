% mais(X, Y, Z) :-
%   se ao menos duas das letras nao sao variaveis,
%   o resultado eh o desejado
%

mais(X, Y, Z) :- nonvar(X), nonvar(Y), Z is X+Y.
mais(X, Y, Z) :- nonvar(Z), nonvar(Y), X is Z-Y.
mais(X, Y, Z) :- nonvar(X), nonvar(Z), Y is Z-X.
