arvore_b(vazio).
arvore_b(arvore(A, D, E)) :-
  arvore_b(D),
  arvore_b(E).
