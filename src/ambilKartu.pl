:- include('random7cards.pl').
:- include('giliran.pl').

% mulai setelah currentPlayer
ambilKartu :-
    giliran([Player|_]),
    jumlahKartuDiambil(_, N),
    ambilNKartu(N, Player),
    currentPlayer.

/* jumlahKartuDiambil(draw_two, 2).
jumlahKartuDiambil(wild_draw_four, 4). */
jumlahKartuDiambil(_, 1).

ambilNKartu(0, _) :- !.
ambilNKartu(N, Player) :- 
    N > 0,
    deck(DeckBefore) /* perlu call updateDeck dulu sebelum ini*/
    takeNrandom(1, DeckBefore, [Card], DeckAfter),
    assertz(hand(Player,Card)),
    updateDeck(DeckAfter),
    format("~w mendapatkan kartu: ~w~-n", [Player, Card]),
    N1 is N - 1,
    ambilNKartu(N1, Player).
