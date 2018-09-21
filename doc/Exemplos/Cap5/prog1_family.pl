% pai(?Pai, ?Filhx).
% mae(?Mae, ?Filhx).
% avoh(?Avó, ?Netx).
% avo(?Avô, ?Netx).
% irmao(?Pai, ?Irmao1, ?Irmao2).
% tio(?Pai, ?Tio, ?Sobrinhx).

avo(Avo, Neto):-
         pai(Avo, Avo_filho),
         pai(Avo_filho, Neto).
avoh(Avoh,Neto):-
         mae(Avoh, Filha_da_avoh),
         mae(Filha_da_avoh, Neto).
irmao(Pai, Irmao1, Irmao2):-
       pai(Pai, Irmao1),
       pai(Pai, Irmao2).
tio(Pai, Tio, Sobrinho):-
       irmao(_,Pai,Tio),
       pai(Tio, Sobrinho).

pai(meu_pai, eu).
pai(eu, meu_pai).
pai(eu, filho_meu_e_de_minha_esposa).
pai(meu_pai, filho_de_minha_filha_adotiva).
mae(minha_filha_adotiva, eu).
mae(minha_esposa, minha_filha_adotiva).

% O filho meu e de minha esposa é o irmão adotado de meu pai
% O filho meu e de minha esposa é meu tio
% Filho de minha filha adotiva é meu irmão, Filho de minha irmã adotiva é meu neto
% Minha esposa é minha avó Eu sou meu avô
              irmao(_, meu_pai, filho_meu_e_de_minha_esposa).
              tio(filho_meu_e_de_minha_esposa, meu_pai, eu),
              irmao(_, filho_de_minha_filha_adotiva, eu),
              avo(eu, filho_de_minha_filha_adotiva),
              avoh(minha_esposa, eu),
              avo(eu, eu).
