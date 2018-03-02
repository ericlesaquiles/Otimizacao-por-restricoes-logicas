%% rainhas(-Rainhas, ++Numero)
% Rainhas contém a posição de cada rainha por coluna
%

:- lib(ic)

rainhas(Rainhas, Numero) :-
  dim(RainhaStruct,[Numero]),
  restricoes(RainhaStruct, Numero),
  struct_para_lista(RainhaStruct, Rainhas),
  busca(Rainhas).

restricoes(RainhaStruct, Numero) :-
  ( for(I,1,Numero),
    param(RainhaStruct,Numero)
  do
    RainhaStruct[I] :: 1..Numero,
    (for(J,1,I-1),
      param(I,RainhaStruct)
    do
      RainhaStruct[I] #\= RainhaStruct[J],
      RainhaStruct[I]-RainhaStruct[J] #\= I-J,
      RainhaStruct[I]-RainhaStruct[J] #\= J-I
    )
  ).

struct_para_lista(Struct, Lista) :-
  ( foreacharg(Arg,Struct),
    foreach(Var,Lista)
  do
    Var = Arg
  ).
