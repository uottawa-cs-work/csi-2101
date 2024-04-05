duplicateKth(InputList, X, L) :-
    duplicateKth(InputList, X, X, L).

duplicateKth([],_,_,[]).

duplicateKth([H|T], X, 1, [H,H|Rest]) :-
    duplicateKth(T, X, X, Rest).

duplicateKth([H|T], X, I, [H|Rest]) :-
    I > 1,
    N is I - 1,
    duplicateKth(T, X, N, Rest).

count([],_,0).

count([X|T],X,C) :-
    count(T, X, TailCount),
    C is TailCount+1.

count([Y|T], X, C) :-
    X \= Y,
    count(T,X,C).

