busca(Lista) :-
  (fromto(Lista, Vars, Resto, [])
   do
     escolhe_vari(Vars, Vari-Domain, Resto),
     escolhe_val(Domain, Val),
     Vari = Val
  ).
