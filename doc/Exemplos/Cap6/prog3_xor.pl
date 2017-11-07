% ou_exclusivo(X, Y, Z) :-
%   se ao menos dois dos argumentos nao sao variaveis,
%   o resultado eh o esperado
%

ou_exclusivo(X, Y, Z) :- nonvar(X), nonvar(Y), Z is X xor Y.
ou_exclusivo(X, Y, Z) :- nonvar(Z), nonvar(Y), X is Z xor Y.
ou_exclusivo(X, Y, Z) :- nonvar(X), nonvar(Z), Y is Z xor X.
