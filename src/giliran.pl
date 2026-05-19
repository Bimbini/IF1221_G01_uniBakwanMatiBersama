:- dynamic(giliran/1).
:- dynamic(arah/1).

giliran([]).

add_tail([], X, [X]).
add_tail([H|T], X, [H|L]) :- add_tail(T, X, L).

/* when called keluarin dulu sekarang giliran siapa 
baru list update the next person di paling depan list */
currentPlayer :-
    arah(clockwise), !,
    rotate_kiri.

currentPlayer :-
    arah(counter_clockwsie),
    rotate_kanan.

rotate_kiri :-
    giliran([H | T]),
    add_tail(T, H, NewGiliran),
    updateList(NewGiliran).
    NewGiliran = [Next|_],
    format('Giliran ~w.~n~n', [Next]).


rotate_kanan :-
    giliran(G),
    init_last(G, Front, Last),
    NewGiliran = [Last | Front],
    updateList(NewGiliran),
    format('Giliran ~w.~n~n', [Next]).