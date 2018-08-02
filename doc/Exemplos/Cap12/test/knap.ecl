%
% ECLiPSe SAMPLE CODE
%
% Bounded-Knapsack problem from
% http://rosettacode.org/wiki/Knapsack_problem/
% Pack 0 or more items of each type, obeying the knapsack weight
% constraint.
% There is a limited supply of each item type.
%
% Using ic as a finite-domain solver.
%

:- lib(ic).
:- lib(branch_and_bound).
:- lib(ic_prop_test_util). % For the random numbers


model(Weights, Values, Bounds, Capacity, Amounts, Weight, Value) :-
        ( foreach(Bound,Bounds), foreach(Amount,Amounts) do
            Amount $:: 0..Bound
        ),
        integers(Amounts),
        Amounts*Weights $= Weight,
        Weight $=< Capacity,
        Amounts*Values $= Value.

solve(Weights, Values, Bounds, Capacity, Amounts, Weight, Value) :-
        model(Weights, Values, Bounds, Capacity, Amounts, Weight,
              Value),
        Cost #= -Value,
        minimize(search(Amounts, 0, largest, indomain_reverse_split,
                        complete, []), Cost).

main(Capacity) :-
        data(Names, Weights, Values, Bounds, Capacity),
        solve(Weights, Values, Bounds, Capacity, Amounts, Weight,
              Value),
        ( foreach(Amount,Amounts), foreach(Name,Names) do
            ( Amount >0 -> printf("%d of %w%n", [Amount,Name]) ;
                           true )
        ),
        writeln(weight=Weight;value=Value).


% data(Names, Weights, Values, Bounds, Capacity)
%% data(
%%         [map,compass,water,sandwich,glucose,tin,banana,apple,
%%          cheese,beer,
%%          'suntan cream',camera,'t-shirt',trousers,umbrella,
%%          'waterproof trousers',
%%          'waterproof overclothes','note-case',sunglasses,
%%          towel,socks,book],
%%         [  9,13,153, 50,15,68,27,39,23,52,11,32,24,48,73,42,43,
%%            22, 7,18, 4,30],
%%         [150,35,200, 60,60,45,60,40,30,10,70,30,15,10,40,70,75,
%%          80,20,12,50,10],
%%         [  1, 1,  2,  2, 2, 3, 3, 3, 1, 3, 1, 1, 2, 2, 1, 1, 1,
%%            1, 1, 2, 1, 2], 
%%         400
%%     ).

random_data(data([],[],[],[],_), 0).
random_data(data([Counter|Ls], [W|Ws], [V|Vs], [B|Bs], _), Counter) :-
        random_int_between(1, 50, W),
        random_int_between(1, 100, V),
        random_int_between(1, 15, B),
        New_Counter is Counter - 1,
        random_data(data(Ls, Ws, Vs, Bs, _), New_Counter).

init_data(data(Names, Weights, Values, Bounds, Capacity)) :-
        random_data(data(Names, Weights, Values, Bounds, Capacity), Capacity).
           

data(Names, Weights, Values, Bounds, Capacity) :-
        init_data(data(Names, Weights, Values, Bounds, Capacity)).

run(Times) :-
        N is 2^Times,
        ( count(I, 1, Times),
          param(N)
        do 
            profile(main(N))
        ).


pro(N) :- profile(main(N)).