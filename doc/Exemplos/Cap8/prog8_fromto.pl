do__1(Last, Last) :- !.
do__1(In, Last) :- Body, do__1(Out, Last).

do__1(From, To)?
