:- dynamic(giliran/1).
:- dynamic(arah/1).
:- initialization(init_arah).

init_arah :-
    (arah(_) ->).

giliran([]).

add_tail([], X, [X]).
add_tail([H|T], X, [H|L]) :- add_tail(T, X, L).

/* when called keluarin dulu sekarang giliran siapa 
baru list update the next person di paling depan list */
currentPlayer :-
    giliran([H | _]),
    format('Giliran ~w.~n~n', [H]),
    arah(clockwise), !,
    rotate_kiri.

currentPlayer :-
    giliran([H | _]),
    format('Giliran ~w.~n~n', [H]),
    rotate_kanan.

rotate_kiri :-
    giliran([H | T]),
    add_tail(T, H, NewGiliran),
    updateList(NewGiliran).

rotate_kanan :-
    giliran(G),
    init_last(G, Front, Last),
    NewGiliran = [Last | Front],
    updateList(NewGiliran).

% Helper rotate_kanan karna append GABOLEH
init_last([X], [], X).
init_last([H|T], [H|Front], Last) :- init_last(T, Front, Last).

updateList(NewGiliran) :-
    retract(giliran(_)),
    assertz(giliran(NewGiliran)).

setPlayers(Players) :-
    retractall(giliran(_)),
    assertz(giliran(Players)).