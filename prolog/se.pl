% --------------------
% AUT�MATA DE PILA
% --------------------

% Define las transiciones del aut�mata de pila
mueve(q0, a, [z], q0, [a, z]).
mueve(q0, a, [a | H], q0, [a, a | H]).
mueve(q0, b, [a | H], q1, H).

mueve(q1, b, [a | H], q1, H).
mueve(q1, b, [z], q2, [b, z]).

mueve(q2, b, [b | H], q3, [b, b | H]).
mueve(q2, c, [b | H], q3, H).

mueve(q3, c, [b | H], q3, H).

% Define la transici�n recursiva del aut�mata
transita(q3, [], [z], qf, [z]) :- !.  % Estado de aceptaci�n cuando la pila vuelve a [z]
transita(Qi, [X | Y], R, Qf, T) :-
    mueve(Qi, X, R, P, S),
    transita(P, Y, S, Qf, T),
    X \= [].

% Predicado para aceptar una cadena si el aut�mata llega al estado
% final `qf`
acepta(X,Resultado):- !, Resultado is 1, Q=qf,transita(q0,X,[z],Q,_).
% --------------------
% META-INT�RPRETE CON PRUEBAS Y CLAUSULAS BUILT-IN
% --------------------

% Predicados incorporados que el meta-int�rprete reconoce y ejecuta directamente
builtin(A is B).
builtin(A > B).
builtin(A < B).
builtin(A = B).
builtin(A =:= B).
builtin(A =< B).
builtin(A >= B).
builtin(A \= B).
builtin(functor(T, F, N)).
builtin(read(X)).
builtin(write(X)).
builtin(!).

% --------------------
% META-INT�RPRETE CON TRAZA INDENTADA POR NIVELES (sin usar `->`)
% --------------------

solve_trace(true, _) :-!.
solve_trace((A, B), Nivel) :-
    !,
    solve_trace(B, Nivel),
    solve_trace(A, Nivel).

solve_trace(A, _) :-
    builtin(A),    % Si A es un predicado incorporado, se ejecuta directamente
    A,       % Ejecuta el predicado incorporado
    !.             % No contin�a la b�squeda si el predicado se resuelve

solve_trace(A, Nivel) :-
    tab(Nivel * 3),
    write('Nivel '), write(Nivel), write(': '), write(A), nl,
    clause(A, B),  % Si A no es un predicado incorporado, busca una cl�usulapara A
    Nivel1 is Nivel + 1,
    solve_trace(B, Nivel1).  % Resuelve la subconsulta B de forma recursiva

% --------------------
% PARTE 3: Meta-int�rprete con l�mite de profundidad
% --------------------
solve_trace_max(true, _,_) :-!.
solve_trace_max((A, B), Nivel, NivelMax) :-
    Nivel<NivelMax,!,
    solve_trace_max(A, Nivel,NivelMax),
    solve_trace_max(B, Nivel,NivelMax).

solve_trace_max(A, _,_) :-
    builtin(A),    % Si A es un predicado incorporado, se ejecuta directamente
    A,       % Ejecuta el predicado incorporado
    !.             % No contin�a la b�squeda si el predicado se resuelve

solve_trace_max(A, Nivel,NivelMax) :-
    Nivel<NivelMax,
    tab(Nivel * 3),
    write('Nivel '), write(Nivel), write(': '), write(A), nl,
    clause(A, B),  % Si A no es un predicado incorporado, busca una cl�usulapara A
    Nivel1 is Nivel + 1,
    solve_trace_max(B, Nivel1,NivelMax).  % Resuelve la subconsulta B de forma recursiva
% `solve_pmax/3` ejecuta `solve` con un l�mite de profundidad (`Prf`)
% Si la profundidad excede `Prf`, la ejecuci�n falla (se aborta).

% --------------------
% PARTE EXTRA: Meta-int�rprete que eval�a de derecha a izquierda
% --------------------

% `solve_ri/2` es un meta-int�rprete que eval�a de derecha a izquierda sin l�mite de profundidad.
solve_ri(true, true) :- !.
solve_ri((A, B), (ProofB, ProofA)) :-
    !,
    solve_ri(B, ProofB),
    solve_ri(A, ProofA).
solve_ri(A, (A :- builtin)) :-
    builtin(A), !, A.
solve_ri(A, (A :- Proof)) :-
    clause(A, B),
    solve_ri(B, Proof).

% --------------------
% EJEMPLOS DE USO
% --------------------

% 1. Meta-int�rprete con generaci�n de prueba normal
% ?- solve(transita(q0, [a, a, b, b, b, c], [z], qf, _), Proof).
% Esto generar� `Proof` como la estructura que describe la secuencia de pasos.

% 2. Ejecuci�n normal del aut�mata
% ?- acepta([a, a, b, b, b, c], Resultado).
% Resultado debe ser `1` si la cadena es aceptada o `0` si no.

% 3. Ejemplo de uso de `solve_pmax/3` con l�mite de profundidad
% ?- solve_pmax(transita(q0, [a, a, b, b, b, c], [z], qf, _), 10, Proof).
% `Proof` contendr� la prueba hasta la profundidad dada, si es posible resolverlo dentro de ese l�mite.

% 4. Ejemplo de uso de `solve_ri/2` para evaluar de derecha a izquierda
% ?- solve_ri(transita(q0, [a, a, b, b, b, c], [z], qf, _), Proof).
% `Proof` mostrar� la estructura de prueba evaluando de derecha a izquierda sin l�mite de profundidad.



















