:- lib(ic).
:- lib(branch_and_bound).

model(Pesos, Valores, Limitantes, Capacidade, Quantidades, Peso, Valor) :-
        ( foreach(Limitante,Limitantes), foreach(Quantidade,Quantidades) do
                Quantidade $:: 0..Limitante
        ),
        integers(Quantidades),
        Quantidades * Pesos $= Peso,
        Peso $=< Capacidade,
        Quantidades * Valores $= Valor.

resolve(Pesos, Valores, Limitantes, Capacidade, Quantidades, Peso, Valor) :-
        model(Pesos, Valores, Limitantes, Capacidade, Quantidades, Peso, Valor),
        Custo #= -Valor,
        minimize(search(Quantidades, 0, largest, indomain_reverse_split, complete, []),
                 Custo).

principal :-
        dados(Nomes, Pesos, Valores, Limitantes, Capacidade),
        resolve(Pesos, Valores, Limitantes, Capacidade, Quantidades, Peso, Valor),
        ( foreach(Quantidade,Quantidades), foreach(Nome,Nomes) do
                ( Quantidade > 0 -> printf("%d of %w%n", [Quantidade,Nome]) ;
                  true )
        ),
        writeln(peso=Peso ; valor=Valor).
