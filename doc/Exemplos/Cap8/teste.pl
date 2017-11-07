search(List, Credit) :-
  ( fromto(List, Vars, Rest, []),
    fromto(Credit, CurCredit, NewCredit, _)
  do
    choose_vars(Vars, Var-Domain, Rest),
    choose_vals(Domain, Val, CurCredit, NewCredit),
    Var = Val
  ).

choose_vars(List, Var-Domain, Rest) :-
  List = [Var-Domain|Rest].

choose_vals(Domain, Val, Credit, NewCredit) :-
  share_credit(Domain, Credit, DomCredList),
  member(Val-NewCredit, DomCredList).

%share_credit(Domain, N, DomCredList) :-
  %( fromto(N, CurCredit, NewCredit, 0),
    %fromto(Domain, [Val|Tail], Tail,  _),
    %foreach(Val-N, DomCredList),
    %param(N)
  %do
    %( Tail = [] ->
      %NewCredit is 0
    %;
      %NewCredit is CurCredit -1
    %)
  %).

share_credit(Domain, N, DomCredList) :-
  ( fromto(N, CurCredit, NewCredit, 0),
    fromto(Domain, [Val|Tail], Tail,  _),
    foreach(Val-CurCredit, DomCredList)
  do
    ( Tail = [] ->
      NewCredit is 0
    ;
      NewCredit is CurCredit - fix(ceiling(CurCredit/2))
    )
  ).
