aceptado(W):-palindromo(W,[]).

palindromo([],[]):-true.

palindromo([a|W],W1):-palindromo(W,[a|W1]).
palindromo([b|W],W1):-palindromo(W,[b|W1]).
palindromo([e|W],W1):-iguales(W,W1).

iguales([],[]):-true.
iguales([X|W],[X|W1]):-iguales(W,W1).

