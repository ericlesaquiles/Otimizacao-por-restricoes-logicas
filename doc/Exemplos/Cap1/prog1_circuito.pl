resistor(energia,n1).
resistor(energia,n2).
transistor(n2,ground,n1).
transistor(n3,n4,n2).
transistor(n5,ground,n4).

inversor(Entrada, Saida) :-
  transistor(Entrada, ground, Saida),
  resistor(energia, Saida).

porta_nand(Entrada1, Entrada2, Saida) :-
  transistor(Entradal, X, Saida),
  transistor(Entrada2, ground, X),
  resistor(energia, Saida).

porta_and(Entrada1, Entrada2, Saida) :-
  porta_nand(Entrada1, Entrada2, X),
  inversor(X, Saida).
