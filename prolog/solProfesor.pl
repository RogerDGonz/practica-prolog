mueve(q0,a,[z],q0,[a,z]).
mueve(q0,a,[a|H],q0,[a|[a|H]]).
mueve(q0,b,[a|H],q1,H).

mueve(q1,b,[a|H],q1,H).
mueve(q1,b,[z],q2,[b,z]).

mueve(q2,b,[b|H],q3,[b|[b|H]]).
mueve(q2,c,[b|H],q3,H).

mueve(q3,c,[b|H],q3,H).


transita(q3,[],[z],qf,[z]):-!.
transita(Qi,[X|Y],R,Qf,T):- transita(P,Y,S,Qf,T),mueve(Qi,X,R,P,S),X \=[].
acepta(X,Resultado):- !, Resultado is 1, Q=qf,transita(q0,X,[z],Q,_).

solve(true):-!.
solve((A,B)):-!, solve(B), solve(A).
solve(A):-predicate_property(A,built_in),!,call(A).
solve(A):-!,clause(A,B),solve(B).


