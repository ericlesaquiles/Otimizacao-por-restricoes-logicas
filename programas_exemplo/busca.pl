
% Searching with naivete
%
naive_search(X-Xdom, Y-YDom) :-
  member(X, Xdom),
  member(Y, Ydom).
  % constraints(X), constraints(Y)

naive_search2(List) :-
  foreach(Var-Domain, List) do member(Var, Domain).


% Less naive
%
% less_naive_search(List) :-
%   assigns valus from the variable domains to all the
%   Var-Domain pairs in List
%
less_naive_search(List) :-
  (fromto(List, Vars, Rest, [])
   do
     choose_var(Vars, Var-Domain, Rest),    % To be defined
     choose_val(Domain, Val),               % ahead
     Var = Val
  ).

% choose_var(List, Var-Domain, Rest) :-
%   Var is a member of List
%   all other members are in Rest
%
%
naive_choose_var(List, Var-Domain, Rest) :-
  List :- [Var|Rest].


% choose_val(Domain, Val) :-
%   Val is a member of Domain
%
%
naive_choose_val(Domain, Val) :-
  member(Val, Domain).


less_naive_choose_val(N, Domain, Val) :-
  select_best(N, Domain, BestList),
  member(Val, BestList).

select_best(N, Domain, BestList) :-
  ( N >= length(Domain) ->
      BestList = Domain
    ;
      length(BestList, N),
      append(BestList, _, Domain)
  ).


% choose_val(Domain, Credit) :-
%   Distributes the Credit trough domain and selects the element with greater credit
%
choose_vals(Domain, Val, Credit, NewCredit) :-
  share_credit(Domain, Credit, DomCredList),
  member(Val-NewCredit, DomCredList).




% search(List, Credit) :-
%   Search on List for solutions with credit Credit
%
search(List, Credit) :-
  ( fromto(List, Vars, Rest, []),
    fromto(Credit, CurCredit, NewCredit, _)
  do
    choose_vars(Vars, Var-Domain, Rest),
    choose_vals(Domain, Val, CurCredit, NewCredit),
    Var = Val
  ).

% share_credit(Domain, N, DomCredList) :-
%   Admits only the first N values
%
share_credit(Domain, N, DomCredList) :-
  ( fromto(N, CurCredit, NewCredit, 0),
    fromto(Domain, [Val|Tail], _),
    foreach(Val-N, DomCredList),
    param(N)
  do
    ( Tail = [] ->
      NewCredit is 0
    ;
      NewCredit is CurCredit -1
    )
  ).


share_credit(Domain, N, DomCredList) :-
  ( fromto(N, CurCredit, NewCredit, 0),
    fromto(Domain, [Val|Tail], _),
    foreach(Val-Credit, DomCredList),
    param(N)
  do
    ( Tail = [] ->
      Credit is CurCredit
    ;
      Credit is fix(ceiling(CurCredit/2))
    ),
    NewCredit is CurCredit - Credit
  ).


share_credit(Domain, N, DomCredList) :-
  ( fromto(N, CurCredit, NewCredit, -1),
    fromto(Domain, [Val|Tail], _),
    foreach(Val-CurCredit, DomCredList),
  do
    ( Tail = [] ->
      NewCredit is -1
    ;
      NewCredit is CurCredit - 1
    )
  ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           %
%   Non-logical Variables   %
%                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% simple example
%
setval(count,0),
( incval(count), fail ; true ),
getval(count, N).


% one(Q) :-
%   query Q succeeds only once
one(Q) :-
  not(twice(Q)),
  getval(n,1).


% twice(Q) :-
%   query Q succeeds twice
twice(Q) :-
  setval(n, 0),
  Q,
  getval(n, 2), !.


% search(List, Backtracks) :-
%   a search which counts the number of backtracks
%
search(List, Backtracks) :-
  init_backtracks,
  ( fromto(List, Vars, Rest, []),
  do
    choose_vars(Vars, Var-Domain, Rest),
    choose_vals(Domain, Val),
    Var = Val,
    count_backtracks
  ),
  get_backtracks(Backtracks).

init_backtracks :-
  setval(backtracks, 0).

get_backtracks(B) :-
  getval(backtracks, B).

count_backtracks :-
  on_backtracking(incval(backtracks)).

on_backtracking(_).
on_backtracking(Q) :-
  once(Q),
  fail.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Solving CSPs
%
% each eclipse program to solve a CSP has the following shape:
%
% :-library(name_of_library)
%
% solve(List) :-
%   declare_domains(List),
%   generate_constraints(List),
%   search(List).
%
%
% // // // COP // // //:
%
% solve(List) :-
%   declare_domains(List, Cost),
%   generate_constraints(List, Cost),
%   search(List, Cost).
%

%
% The suspend library

% Simple example
suspend:(X or Y), X = 0, Y = 1.


%qs([],[]).
%qs([X|Xs], Ys) :-
  %partition(X, Xs, Big, Les),
  %qs(Big, Bs),
  %qs(Les, Ls),
  %append(Ls, [X|Bs], Ys).

%partition(X, [Y|Ys], [Y|Big], Les) :-
  %Y > X, !,
  %partition(X, Ys, Big, Les).
%partition(X, [Y|Ys], Big, [Y|Les]) :-
  %Y =< X,
  %partition(X, Ys, Big, Les).
%partition(_, [], [], []).


qs([],[]).
qs([X|Xs], Ys) :-
  partition(X, Xs, Big, Les),
  qs(Big, Bs),
  qs(Les, Ls),
  append(Ls, [X|Bs], Ys).

partition(X, [Y|Ys], [Y|Big], Les) :-
  Y $> X, partition(X, Ys, Big, Les).
partition(X, [Y|Ys], Big, [Y|Les]) :-
  Y $=< X, partition(X, Ys, Big, Les).
partition(_, [], [], []).


% The value of those variables ranges from 0 to 9
%
[S,E,N,D,M,O,R,Y] ::  0..9.

% The value of those variables ranges from 0 to 9 and are real-valued
%
[S,E,N,D,M,O,R,Y] $::  0..9.

% X is constrained to be an integer
%
integers(X).

% X is constrained to be a real
%
reals(X).

% Reified constraints:
%   Bool is unified with 0
%
$>(1, 8, Bool).

% X is not in the range from 1 to 9
$::(X, 1..9, 0).

% X is in the range from 1 to 9
$::(X, 1..9, 1).
% same as
X :: 1..9.

% User-defined suspensions
%

% Suspends the evaluation of the goal 'X =:= 3' until X is instantiated
% 3 denotes the priority of the goal upon waking up
suspend(X =:= 3, 3, X -> inst).


%
% Consider the CSP:
%   {x != y, y != z, x != z ; x ∈ {0, 1}, y ∈ {0, 1}, z ∈ {0, 1}}
% It can be encoded as:
[X,Y,Z] :: 0..1, X #\= Y, Y #\= Z, X #\= Z.


% Generate an ordered list with elements from 1 to 1000
%
List :: 1..1000, ordered(List).

ordered(List, Order) :-
   List = [] -> true
  ;
  ( fromto(List, [This, Next|Tail], Tail, [_])
    do
      Order(This, Next).
  ).

% Map colouring
%
no_of_regions(4).
neighbour(1,2).
neighbour(1,3).
neighbour(1,4).
neighbour(2,3).
neighbour(2,4).

colour(1). % red
colour(2). % yellow
colour(3). % blue


