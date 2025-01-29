/*instalacion electrica */
/*estados de los switches*/
live(outside):-true.
ok(_).
down(s1):-true.
up(s2):-true.
up(s3):-true.


/*bombillas*/
ligth(l1):-true.
ligth(l2):-true.

live(W):-connected_to(W,W1),live(W1).

/*P2*/
connected_to(w5,outside).
connected_to(w6,w5):-ok(cb2).
connected_to(p2,w6):-ok(p2).

/*P1*/
connected_to(w3,w5):-ok(cb1).
connected_to(p1,w3):-ok(p1).

/*L2*/
connected_to(w4,w3):-ok(s3),up(s3).
connected_to(l2,w4):-ok(l2).

/*L1*/
connected_to(w2,w3):-ok(s1),down(s1).
connected_to(w1,w3):-ok(s1),up(s1).
connected_to(w0,w2):-ok(s2),down(s2).
connected_to(w0,w1):-ok(s2),up(s2).
connected_to(l1,w0):-ok(l1).
