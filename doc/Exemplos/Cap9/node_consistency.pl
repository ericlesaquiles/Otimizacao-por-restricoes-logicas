% consistente_por_no([Dominios-Restricoes|DsRs],
%                    [NovosDominios-Restricoes|DnsRs]) :-
%   NovosDominios sao consistentes por no com suas respectivas restricoes
%

consistente_por_no([], []).
consistente_por_no([D-Res|DsRs],[Dn-Res|DnsRs]) :-
  functor(Res, _, N),
  (
    N \== 1 ->
    Dn = D
  ;
    consistente_por_no_primitivo(D, Res, Dn),
  ),
  consistente_por_no(DsRs, DnsRs).


consistente_por_no_primitivo([], _, []).
consistente_por_no_primitivo([D1|Ds], R, [D1|Dn]) :-
  apply(R, [D1]), !,
  consistente_por_no_primitivo(Ds, R, Dn).


consistente_por_no_primitivo([D|Ds], R, Dn) :-
  consistente_por_no_primitivo(Ds, R, Dn).
