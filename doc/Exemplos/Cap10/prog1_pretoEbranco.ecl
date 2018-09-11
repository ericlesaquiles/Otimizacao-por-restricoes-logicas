:- lib(ic).
:- lib(ic_symbolic).
:- local domain(membro_do_clube(oposicionista_honrado, colaborador_secreto)).

% Oposicionistas Honrados sempre dizem a verdade
% Colaboradores Secretos podem dizer a verdade ou mentir
resmungo_unico(Membro, Verdade) :-
    (Membro &= oposicionista_honrado) => Verdade.

% Colaboradores secretos mentem e dizem a verdade alternadamente
resmungos_consecutivos(Membro, Verdade1, Verdade2) :-
    (Membro &= colaborador_secreto) #= (Verdade1 #\= Verdade2).

resmungos_consecutivos(Membro, Verdade1, Verdade2) :-
    (Membro &= colaborador_secreto) #= (Verdade1 #\= Verdade2).

%% resolve([?Membro_1, ?Membro_2, ?Membro_3])
% Membro_x é unificado com o nome do seu respectivo grupo
%
resolve([Membro_1, Membro_2, Membro_3]):-
    [Membro_1, Membro_2, Membro_3] &:: membro_do_clube,
    [Membro_3_possivelmente_disse, Membro_3_disse, Membro_1_disse,
     Membro_2_disse_primeiro, Membro_2_disse_entao] :: 0..1,
    Membro_1 &\= Membro_2,

    Membro_3_possivelmente_disse #= (Membro_3 &=oposicionista_honrado),
    resmungo_unico(Membro_3, Membro_3_possivelmente_disse),

    Membro_1_disse #= (Membro_3_disse #=Membro_3_possivelmente_disse),
    resmungo_unico(Membro_1, Membro_1_disse),

    Membro_2_disse_primeiro #= (Membro_3 &=colaborador_secreto),
    resmungo_unico(Membro_2, Membro_2_disse_primeiro),

    Membro_2_disse_entao #=(Membro_3_disse #= 0),
    resmungo_unico(Membro_2, Membro_2_disse_entao),

    resmungos_consecutivos(Membro_2, Membro_2_disse_primeiro,
                           Membro_2_disse_entao),
    ic_symbolic:indomain(Membro_1),
    ic_symbolic:indomain(Membro_2),
    ic_symbolic:indomain(Membro_3),
    writeln("Membro_1":Membro_1),
    writeln("Membro_2":Membro_2),
    writeln("Membro_3":Membro_3),
    writeln("Membro_2_disse_primeiro":Membro_2_disse_primeiro),
    writeln("Membro_2_disse_entao":Membro_2_disse_entao).
