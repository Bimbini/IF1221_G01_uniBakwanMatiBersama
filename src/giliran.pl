:- dynamic(giliran/1).

giliran([]).

add_tail([], X, [X]).
add_tail([H|T], X, [H|L]) :- add_tail(T, X, L).

/* when called keluarin dulu sekarang giliran siapa 
baru list update the next person di paling depan list */
currentPlayer :-
    giliran([H|T]), 
    format('Giliran ~w.~n~n', [H]),
    add_tail(T, H, NewGiliran),
    updateList(NewGiliran).

updateList(NewGiliran) :-
    retract(giliran(_)),
    assertz(giliran(NewGiliran)).


setPlayers(Players) :-
    retractall(giliran(_)),
    assertz(giliran(Players)).