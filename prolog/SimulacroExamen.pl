% --------------------
% Simulacro de Examen
% --------------------

% Define las transiciones del autómata de pila
mueve(q0, a, [z], q0, [a, z]).
mueve(q0, a, [a | H], q0, [a, a | H]).
mueve(q0, b, [a | H], q1, H).

mueve(q1, b, [a | H], q1, H).
mueve(q1, b, [z], q2, [b, z]).

mueve(q2, b, [b | H], q3, [b, b | H]).
mueve(q2, c, [b | H], q3, H).

mueve(q3, c, [b | H], q3, H).

% Define la transición recursiva del autómata
transita(q3, [], [z], qf, [z]) :- !.  % Estado de aceptación cuando pila vuelve a [z]
transita(Qi, [X | Y], R, Qf, T) :-
    mueve(Qi, X, R, P, S),
    transita(P, Y, S, Qf, T),
    X \= [].

% Predicado para aceptar una cadena si el autómata llega al estado final `qf`
acepta(X,Resultado):- !, Resultado is 1, Q=qf,transita(q0,X,[z],Q,_).

% --------------------
% META-INTÉRPRETE CON TRAZA E INDENTACIÓN
% --------------------

% Meta-intérprete que muestra la traza de ejecución con indentación
solve_trace(true, _) :- !.
solve_trace((A, B), Nivel) :-
    !,
    solve_trace(A, Nivel),
    solve_trace(B, Nivel).
solve_trace(A, Nivel) :-
    tab(Nivel*3), write('Nivel '), write(Nivel), write(': '), write(A), nl,
    clause(A, B),
    Nivel1 is Nivel + 1,
    solve_trace(B, Nivel1).

% Ejemplo de uso:
% ?- solve_trace(transita(q0, [a, a, b, b, b, c], [z], qf, _), 0).

% --------------------
% META-INTÉRPRETE CON LÍMITE DE PROFUNDIDAD
% --------------------

% Meta-intérprete que limita el nivel de profundidad de la recursión
solve_pmax(true, _) :- !.
solve_pmax((A, B), Prf) :-
    Prf > 0,
    !,
    solve_pmax(A, Prf),
    solve_pmax(B, Prf).
solve_pmax(A, Prf) :-
    Prf > 0,
    clause(A, B),
    Prf1 is Prf - 1,
    solve_pmax(B, Prf1).

% Ejemplo de uso con límite de profundidad:
% ?- solve_pmax(transita(q0, [a, a, b, b, b, c], [z], qf, _), 10).

% --------------------
% META-INTÉRPRETE DE DERECHA A IZQUIERDA
% --------------------

% Meta-intérprete que evalúa las conjunciones de derecha a izquierda
solve_right_to_left(true) :- !.
solve_right_to_left((A, B)) :-
    !,
    solve_right_to_left(B),
    solve_right_to_left(A).
solve_right_to_left(A) :-
    clause(A, B),
    solve_right_to_left(B).

% Ejemplo de uso:
% ?- solve_right_to_left(transita(q0, [a, a, b, b, b, c], [z], qf, _)).


















