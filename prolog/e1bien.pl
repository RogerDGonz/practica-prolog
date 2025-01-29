mueve(q0,b,q1).
mueve(q0,a,q2).
mueve(q1,a,q0).
mueve(q1,b,q3).
mueve(q2,a,q2).
mueve(q2,b,q3).
mueve(q3,a,q0).
mueve(q3,b,q3).

transita(Qi,[],Qi):-!.
transita(Qi,[X|Y],Qf):-X\=[],mueve(Qi,X,P),transita(P,Y,Qf).

acepta(X,Resultado):-transita(q0,X,Qf),Qf=q1,Resultado is 1,!.

