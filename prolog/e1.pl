final(q1).

mueve(q0,b,q1).
mueve(q0,a,q2).
mueve(q1,a,q0).
mueve(q1,b,q3).
mueve(q2,a,q2).
mueve(q2,b,q3).
mueve(q3,a,q0).
mueve(q3,b,q3).

transita([a|W],Y):-mueve(Y,a,Z),transita(W,Z),final(Z).
transita([b|W],Y):-mueve(Y,b,Z),transita(W,Z),final(Z).
transita([],X):-final(X).



