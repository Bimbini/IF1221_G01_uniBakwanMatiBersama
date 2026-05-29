%:- dynamic(giliran/1).
%:- dynamic(arah/1).

giliran([]).

add_tail([], X, [X]).
add_tail([H|T], X, [H|L]) :- add_tail(T, X, L).

/* when called list diupdate baru tunjukin sekarang giliran siapa */
currentPlayer :-
    arah(clockwise), !,
    rotate_kiri,
    giliran([NextPlayer | _]),
    format('Giliran ~w.~n', [NextPlayer]).

currentPlayer :-
    arah(counter_clockwise), !,
    rotate_kanan,
    giliran([NextPlayer | _]),
    format('Giliran ~w.~n', [NextPlayer]).

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

%clockwise to counterclockwise
balik_arah :-
    arah(clockwise), !,
    retract(arah(clockwise)),
    assertz(arah(counter_clockwise)),
    write('[REVERSE] Arah permainan berubah menjadi berlawanan arah jarum jam!'), nl.

%counterclockwise to clockwise
balik_arah :-
    arah(counter_clockwise), !,
    retract(arah(counter_clockwise)),
    assertz(arah(clockwise)),
    write('[REVERSE] Arah permainan berubah menjadi searah jarum jam!'), nl.