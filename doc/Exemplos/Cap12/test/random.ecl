:- lib(ic_prop_test_util).

aleat_dados(dados([],[],[],[],_), 0).
aleat_dados(dados([Contador|Ls], [P|Ps], [V|Vs], [Q|Qs], _), Contador) :-
        random_int_between(1, 50,  P),
        random_int_between(1, 100, V),
        random_int_between(1, 15,  Q),
        Novo_Contador is Contador - 1,
        aleat_dados(dados(Ls, Ps, Vs, Qs, _), Novo_Contador).


inic_dados(dados(Nomes, Pesos, Valores, Qtd, _)) :-
        aleat_dados(dados(Nomes, Pesos, Valores, Qtd, _), 100).


dados(Nomes, Pesos, Valores, Qtd, 400) :-
        init_dados(dados(Nomes, Pesos, Valores, Qtd, 400)).
