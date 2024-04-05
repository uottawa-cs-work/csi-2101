removeRepetition([], []).

removeRepetition([H|T], Result) :-
    member(H, T), !, 
    removeRepetition(T, Result).

removeRepetition([H|T], [H|Result]) :-
    removeRepetition(T, Result).
