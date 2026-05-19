%:- include('random7cards.pl').

:- dynamic(last_played/2).
:- dynamic(player_hand/2).
:- dynamic(current_player/1).
:- dynamic(current_color/1).
:- dynamic(deck/1).

tantang :-
    last_played(PrevPlayer, kartu(hitam, wild_draw_four)), !,
    current_player(Penantang),

    write('Tantangan dilakukan!'), nl,
    write('Memeriksa kartu '), write(PrevPlayer), write(' ...'), nl,

    current_color(W),
    player_hand(PrevPlayer, KartuPrevPlayer),

    (color_match(KartuPrevPlayer, W) ->
        write('Tantangan berhasil! '), write(PrevPlayer), write(' mendapatkan 4 kartu tambahan.'), nl,
        hukuman(PrevPlayer, 4)
    ;
        write('Tantangan gagal. '), write(Penantang), write(' mendapatkan 6 kartu acak.'), nl,
        hukuman(Penantang, 6)
    ),

    retractall(last_played(_, _)),
    currentPlayer.


tantang :- 
    write('Gagal, tidak ada kartu Wild Draw Four yang bisa ditantang'), nl, fail.

color_match([kartu(W, _)|_], W) :- W \== hitam, !.
color_match([_|Tail], W) :- color_match(Tail, W).

hukuman(Pemain, N) :-
    deck(DeckLama),
    player_hand(Pemain, HandLama),
    takeNrandom(N, DeckLama, KartuHukuman, DeckBaru),
    
    addcard(HandLama, KartuHukuman, HandBaru),

    % Update list
    retract(player_hand(Pemain, _)),
    assertz(player_hand(Pemain, HandBaru)),

    retractall(deck(_)),
    assertz(deck(DeckBaru)).

% Pengganti fungsi append
addcard([], L, L).
addcard([Head|Tail], L, [Head|Tail1]) :-
    addcard(Tail, L, Tail1).