builtin(A is B). builtin(A > B). builtin(A < B).
builtin(A = B). builtin(A =:= B). builtin(A =< B).
builtin(A >= B). builtin(functor(T, F, N)).
builtin(read(X)). builtin(write(X)).

solve(true):- !.
solve((A,B)) :-!, solve(A), solve(B).
solve(A):- builtin(A), !, A.
solve(A) :- clause(A, B), solve(B).

valor(w1, 1).
conectado(w2, w1).
conectado(w3, w2).
valor(W,X):-conectado(W,V), valor(V,X).
