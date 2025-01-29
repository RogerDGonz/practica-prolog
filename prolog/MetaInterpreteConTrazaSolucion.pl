conectado(w2,w1).
conectado(w3,w2).
valor(w1,1).
valor(W,X):-conectado(W,V),valor(V,X).

solve_traza(Meta):-solve_traza_nivel(Meta,0).
solve_traza_nivel(true,_):-!.
solve_traza_nivel((A, B),Prf) :-!, solve_traza_nivel(A,Prf), solve_traza_nivel(B,Prf).
solve_traza_nivel(A,Prf):-!,Prf1 is Prf+1,
 clause(A,B), solve_traza_nivel(B,Prf1), Espacios is 3*Prf1,tab(Espacios),
 write(Prf1),tab(1), write(A), nl.
