% Busca(Lista, Credito) :-
%   Busca por solucoes com um dado credito

busca(Lista, Credito) :-
  ( fromto(Lista, Vars, Resto, []),
    fromto(Credito, CreditoAtual, NovoCredito, _)
  do
    escolhe_vari(Vars, Vari-Dominio, Resto),
    escolhe_val(Dominio, Val, CreditoAtual, NovoCredito),
    Vari = Val
  ).

escolhe_val(Dominio, Val, CreditoAtual, NovoCredito) :-
  compartilha_credito(Dominio, CreditoAtual, DomCredLista),
  member(Val-NovoCredito, DomCredLista).

