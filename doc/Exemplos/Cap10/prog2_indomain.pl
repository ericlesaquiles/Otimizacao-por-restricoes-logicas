%% indomain(+X)
% Insiste que a variável X faça parte de seu domínio

indomain(X) :-
  get_domain_as_list(X,member(X, Domain).
  member(X, Domain),
