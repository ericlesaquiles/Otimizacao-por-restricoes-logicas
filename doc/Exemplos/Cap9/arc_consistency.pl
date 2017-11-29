% consistente_por_arco([Dominios-Restricoes|DsRs],
%                      [NovosDominios-Restricoes|DnsRs]) :-
%   NovosDominios sao consistentes por arco com suas respectivas restricoes
%

consistente_por_arco([],[]).
consistente_por_arco([D1-D2-Res|DsRs],[D1n-D2n-Res|DnsRs]) :-
  consistente_por_arco_primitivo([D1-D2], Res, [D1n-D2n]),
  consistente_por_arco(DsRs, _).

consistente_por_arco([_|Cs],[Cns]).
  consistente_por_arco(Cs,Cns).


consistente_por_arco_primitivo([], _, []).
consistente_por_arco_primitivo(_, [], []).
consistente_por_arco_primitivo([D11|D1s]-[D22|D2s], R, [Dx|D1ns]-[Dy|D2ns]) :-
  (
    apply(R, [D11, D22]) ->
    (
      !, consistente_por_arco_primitivo(D1s-D2s, R, D1ns-D2ns),
      Dx = D11, Dy = D22
    )
  ;
    (
      consistente_por_arco_primitivo([D11]-D2s,R, _-_) ->
      (
        !, Dx = D11,
        consistente_por_arco_primitivo(D1s-D2s, R, D1ns-D2ns)
      )
    ;
      (
        consistente_por_arco_primitivo(D1s-[D22],R, _-_) ->
        (
          !,Dy = D22,
          consistente_por_arco_primitivo(D1s-D2s, R, D1ns-D2ns)
        )
      )
    )
  ).

consistente_por_arco_primitivo([D11|D1s]-[D22|D2s], R, D1ns-D2ns) :-
 consistente_por_arco_primitivo(D1s-D2s, R, D1ns-D2ns).
