count([],_,0).

count([X|T],X,C) :-
    count(T, X, TailCount),
    C is TailCount+1.

count([Y|T], X, C) :-
    X \= Y,
    count(T,X,C).

