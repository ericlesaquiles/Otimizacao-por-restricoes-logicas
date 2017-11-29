bounds_consistent_addition([], []).
bounds_consistent_addition([Dx,Dy,Dz], [Dnx, Dny, Dnz]) :-
  min_member(Dx, Xmin),
  min_member(Dy, Ymin),
  min_member(Dz, Zmin),

  Xm is max(Xmin, Ymin + Zmin),
  XM is min(Xmax, Ymax + Zmax),
  new_domain(Xm, XM, Dx, Dnx),

  Ym is max(Ymin, Xmin - Zmax),
  YM is min(Ymax, Xmax - Zmin),
  new_domain(Ym, YM, Dy, Dny),

  Zm is max(Zmin, Ymin - Ymax),
  ZM is min(Zmax, Xmax - Ymin),
  new_domain(Zm, ZM, Dz, Dnz).


new_domain(Vm, VM, Ds, Dn) :-
  Vm =< VM,
  (member(Vm, D) -> append([Vm], Dn) ; true),
  Vm is Vm + 1,
  new_domain(Vm, VM, D, Dn).
new_domain(_, _, _, []).


