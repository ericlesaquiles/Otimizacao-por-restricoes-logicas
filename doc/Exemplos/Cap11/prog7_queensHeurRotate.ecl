rainhas(rotate, Rainhas, Numero) :-
  dim(RainhaStruct,[Numero]),
  constraints(RainhaStruct, Numero),
  struct_para_lista(RainhaStruct, QList),
  busca(QLista, rotate),
  rotate(RainhaStruct, Rainhas).

busca(QLista, rotate) :-
  middle_out_dom(QLista, MOutDom),
  ( foreach(Val, MOutDom),
    param(QLista)
  do
    member(Val, QLista)
  ).

middle_out_dom([Q | _], MOutDom) :-
  get_domain_as_lista(Q,OrigDom),
  middle_out(OrigDom, MOutDom).

rotate(RainhaStruct, Rainhas) :-
  dim(RainhaStruct,[N]),
  dim(RRainhas,[N]),
  ( foreachelem(Q,RainhaStruct,[I]),
    param(RRainhas)
  do
    subscript(RRainhas,[Q],I)
  ),
  struct_para_lista(RRainhas, Rainhas).

