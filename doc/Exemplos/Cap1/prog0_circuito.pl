resistor(power,nl).
resistor(power,n2).
transistor(n2,ground,nl).
transistor(n3,n4,n2).
transistor(n5,ground,n4).

inverter(Input, Output) :-
  transistor(input, ground, Output),
  resistor(power, Output).

nand_gate(Input1, Input2, Output) :-
  transistor(Inputl,X,Output),
  transistor(Input2,ground,X),
  resistor(power,Output).

and_gate(Inputl, Input2, Output) :-
  nand_gate(Inputl,Input2,X),
  inverter(X,Output).
