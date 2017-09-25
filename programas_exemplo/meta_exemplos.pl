%
% Os programas aqui presentes foram inspirados nos exemplos ou exercícios do livros
%   "The Art of Prolog", de Ehud Shapiro et al
%   "Constraint Logical Programming Using Eclipse", de Mark Wallace et al
%
% Eles serao refatorados a medida que o tempo permitir
%
% O arquivo esta dividido em pedacos, relativos ao conteudo tratado.
% Tenha em mente que essa divisao eh um tanto artificial e alguns programas presentes em um pedaco sao extendidos em outro.
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             %
%     Inspecao de estrutura   %
%                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

constante(X) :- atomic(X).

numero(X) :- integer(X).
numero(X) :- float(X).

list([_|_]). % para uma definicao mais correta, seria necessario o fato list([]),
             % mas, no momento, isso nao se mostrou necessario

% flatten([[a, b], c, d, [[e, f,[g]]]], Ys) :-
%   Ys = [a, b, c, d, e, f, g].
%
%   Todos os elementos devem ser constantes
%   Comente uma das duas versoes a seguir
%

%flatten([X|Xs], Ys) :-
  %flatten(X, Ys1),
  %flatten(Xs, Ys2),
  %append(Ys1, Ys2, Ys).
%flatten(X, [x]) :-
  %constante(X),
  %X \= [].
%flatten([], []).


% Versao mais eficiente, um pouco menos clara
% usa S como uma pilha (empilha listas a serem abertas)
%
%flatten([X|Xs], Ys) :-
  %flatten([X|Xs], [], Ys).

%flatten([X|Xs], S, [X|Ys]) :-     %
  %constante(X),                   % Se X for constante, adiciona ao resultado
  %X \= [],
  %flatten(Xs, S, Ys).
%flatten([X|Xs], S, Ys) :-
  %list(X),                        % Se X for uma lista, aplique flattena X
  %flatten(X, [Xs|S], Ys).         % e "salve" Xs para uma aplicacao posterior
%flatten([], [X|S], Ys) :-
  %flatten(X, S, Ys).              % Comeca a fazer "pop" na lista, para aplicar o flatten
%flatten([],[],[]).


% subtermo(sub, termo) :-
%   sub eh um subtermo de termo
% subtermo(v(a), p(b,v(a))). tem sucesso
%
% Subtermo pode ser usado para testar se o primeiro argumento eh um subtermo do segundo
% Ou para gerar, no primeiro argumento, subtermos do segundo.
%
% Considere o goal subtermo(a, f(X, Y))?
%   eventualmente, chega-se ao goal subtermo(a, X)?, e a eh instanciado a X, pela primeira regra
%   esse subgoal tambem pode chegar a segunda regra, gerando um erro na avaliacao de compound(X)
%   esse comportamento eh indesejavel, e sera visto como contorna-lo mais para frente
%
subtermo(Termo, Termo).                   % Subtermo(A, B) é relacao reflexiva
subtermo(Sub, Termo) :-
  compound(Termo),                % Termo precisa ser um termo composto
  functor(Termo, _, N),           % Pega o nome do funtor e aridade
  subtermo(N, Sub, Termo).

subtermo(N, Sub, Termo) :-
  arg(N, Termo, Arg),             % Checa se Sub eh subtermo do N-esimo argumento (arg comeca a contar do 1)
  subtermo(Sub, Arg).
subtermo(N, Sub, Termo) :-        % Atravessa por cada um dos N argumentos do termo Termo
  N > 1,
  N1 is N - 1,
  subtermo(N1, Sub, Termo).

% substituto(Ve, No, Vet, Not) :-
%   Not eh o resultado de substituir todas as ocorrencias de Ve em Vet por No
% substituto(a, b, v(b, n, a, l(a)), v(b, n ,b, l(b)))? tem sucesso
%
substituto(Ve, No, Ve, No).
substituto(Ve, _, Vet, Vet) :-
  constante(Vet),
  Vet \= Ve.                       % Nao queremos duas regras para o mesmo caso

substituto(Ve, No, Vet, Not) :-
  compound(Vet),
  functor(Vet, T, N),
  functor(Not, T, N),             % Os termos novos e velhos devem ter a mesma aridade e nome
  substituto(N, Ve, No, Vet, Not).

substituto(N, Ve, No, Vet, Not) :-
  N > 0,
  arg(N, Vet, Arg),               % Pega o ultimo subtermo
  substituto(Ve, No, Arg, Arg1),   % e substitui recursivamente
  arg(N, Not, Arg1),              %
  N1 is N - 1,
  substituto(N1, Ve, No, Vet, Not).
substituto(0, _, _, _, _) :- !.



% derivada(Expressao, X, ExpressaoDerivada) :-
%   ExpressaoDerivada eh D(Expressao), a derivada simbolica da Expressao em funcao de X
%
% Esta primeira parte eh so o basico.. predicados de inspecao serao usados logo mais
%

derivada(sen(X), X, cos(X)).
derivada(cos(X), X, -sen(X)).
derivada(exp(X), X, exp(X)).
derivada(log(X), X, 1/X).
derivada(X, X, 1).
derivada(N, _, N) :-
  numero(N).

% Regra do tombo
derivada(F^N, X, DF*N*X^N-1) :-
  numero(N),
  derivada(F, X, DF).

% Linearidade:
derivada(F+G, X, DF+DG):-
  derivada(F, X, DF),
  derivada(G, X, DG).
derivada(F-G, X, DF-DG):-
  derivada(F, X, DF),
  derivada(G, X, DG).
derivada(C*F, X, C*DF):-
  numero(C),
  derivada(F, X, DF).

% Regra da multiplicacao
derivada(F*G, X, DF*G + F*DG) :-
  derivada(F, X, DF),
  derivada(G, X, DG).

% Regra da reciproca
derivada(1/F, X, -(DF/F*F)) :-
  derivada(F, X, DF).

% Regra da divisao
derivada(F/G, X, ((F*DG) - (DF*G))/(G*G)) :-
  derivada(F, X, DF),
  derivada(G, X, DG).

% Regra da cadeia (aqui ha o uso do univ)
%
derivada(F_G_x, X, DF * DG) :-
  F_G_x =.. [_,G_x],
  derivada(F_G_x, G_x, DF),
  derivada(G_x, X, DG).


% map(P, Xs, Ys) :-
%   Ys eh o resultado de se aplicar P a cada elemento de Xs
%   se P for uma P/N para N > 1, Xs precisa ser uma lista de listas
%
% map/3 usa apply/2 como auxiliar
%
% apply(P, [X1, ..., Xn]) :-
%   P(X1, ..., Xn)? tem sucesso
%

apply(P, Xs) :-
  Goal =.. [P|Xs],
  Goal.

map(_, [], []).
map(P, [X|Xs], [Y|Ys]) :-
  list(X),
  flatten([X|Y], Z),          % Essencial para que a lista fique bonitinha
  apply(P, Z),              % Aqui, nossa convencao de que o ultimo "argumento" corresponde ao resultado eh crucial
  map(P, Xs, Ys).

map(P, [X|Xs], [Y|Ys]) :-
  apply(P, [X, Y]),         % Aqui, nossa convencao de que o ultimo "argumento" corresponde ao resultado eh crucial
  map(P, Xs, Ys).






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             %
%     Meta programacao        %
%                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Z is X + Y nao funciona se Y e/ou Z sao variaveis
%
% plus(X, Y, Z) :-
%   se ao menos duas das letras nao sao variaveis, o resultado eh o desejado
%

plus(X, Y, Z) :- nonvar(X), nonvar(Y), Z is X+Y.
plus(X, Y, Z) :- nonvar(Z), nonvar(Y), X is Z-Y.
plus(X, Y, Z) :- nonvar(X), nonvar(Z), Y is Z-X.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             %
%     Exemplos Gerais         %
%                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Arvores binarias

% arvore_b(A) :-
%   A eh uma arvore binaria

arvore_b(void).                     % uma arvore vazia eh uma arvore
arvore_b(arvore(_, D, E)) :-        % uma arvore de ramos E e D eh uma arvore se E e D sao uma arvore
  arvore_b(D),
  arvore_b(E).

% mem_arv_b(E, A) :-
%   E eh um elemento de A, ou seja, esta em algum noh da arvore
%

mem_arv_b(X,arvore_b(X, _, _)).      % lembrese: '_' eh uma variavel anonima
mem_arv_b(X, arvore_b(_, E, _)) :-
  mem_arv_b(X, E).
mem_arv_b(X, arvore_b(_, _, D)) :-
  mem_arv_b(X, D).

% iso_arv_b(A, B) :-
%   A arvore binaria A eh isomorfa a arvore binaria B
%
% Uma arvore a(Ela, Ea, Da) eh isomorfa a uma a(Elb, Eb, Db) se:
%   Ea eh isomorfa a Eb e Da a Db ou se
%   Ea eh isomorfa a Db e Da a Eb
%

iso_arv_b(void, void).
iso_arv_b(arvore_b(_, EA, DA), arvore_b(_, EB, DB)) :-
  iso_arv_b(EA, EB),
  iso_arv_b(DA, DB).
iso_arv_b(arvore_b(_, EA, DA), arvore_b(_, EB, DB)) :-
  iso_arv_b(EA, DB),
  iso_arv_b(DA, EB).

