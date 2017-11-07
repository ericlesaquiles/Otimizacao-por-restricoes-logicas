% compartilha_credito(Dominio, N, DomCredLista) :-
%    Admite apenas os primeiros N valores.

compartilha_credito(Dominio, N, DomCredLista) :-
  ( fromto(N, AtuCredito, NovoCredito, 0),
    fromto(Dominio, [Val|Tail], Tail, _),
    foreach(Val-N, DomCredLista),
    param(N)
  do
    ( Tail = [] ->
      NovoCredito is 0
    ;
      NovoCredito is AtuCredito - 1
    )
  ).

