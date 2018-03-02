:- lib(lists).

busca(Rainhas, middle_out) :-
  middle_out(Rainhas, RainhasDeSaida),
  labeling(RainhasDeSaida).

middle_out(Lista, ListaDeSaida) :-
  halve(Lista, PrimeiraMetade, UltimaMetade),
  reverse(PrimeiraMetade, RevPrimeiraMetade),
  splice(UltimaMetade, RevPrimeiraMetade, ListaDeSaida).
