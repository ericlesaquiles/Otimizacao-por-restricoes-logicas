append([], A, A).
append([X|Y], A, [X|C]) :- append(Y, A, C).
