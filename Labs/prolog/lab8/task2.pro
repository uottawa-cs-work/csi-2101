couple(john, jane).
couple(jack, kelly).
couple(max, maria).
couple(martin, rachel).
couple(jake, fiona).
couple(mona, brian).

% Predicates
couple(M, F) :- couple(F, M).

parent(P, C) :- child(C, P).

father(F, C) :- male(F), parent(F, C).

mother(M, C) :- female(M), parent(M, C).

fullSibling(S1, S2) :- parent(P, S1), parent(P, S2), S1 \= S2.

% halfSibling(HS1, HS2) :- parent(P1, HS1), parent(P2, HS2), P1 \= P2, HS1 \= HS2.
halfSibling(HS1, HS2) :-
  parent(P1, HS1),
  parent(P1, HS2),
  parent(P2, HS1),
  \+ parent(P2, HS2),
  P1 \= P2,
  HS1 \= HS2.

fullBrother(FB, S) :- male(FB), fullSibling(FB, S).

fullSister(FS, S) :- female(FS), fullSibling(FS, S).

halfBrother(HB, S) :- male(HB), halfSibling(HB, S).

halfSister(HS, HS) :- female(HS), halfSibling(HS, HS).

child(sylvie, john).
child(bruno, kelly).
child(sylvie ,maria).
child(zach, maria).
child(zach, max).
child(emma, max).
child(emma, fiona).
child(gilles, martin).
child(gilles, rachel).
child(bruno, martin).
child(anne, martin).
child(anne, kelly).

female(jane).
female(kelly).
female(maria).
female(rachel).
female(fiona).
female(mona).
female(sylvie).
female(anne).
female(emma).

male(john).
male(jack).
male(max).
male(martin).
male(jake).
male(brian).
male(zach).
male(bruno).
male(paul).
male(tim).
male(zach).
male(sam).
male(gilles).

