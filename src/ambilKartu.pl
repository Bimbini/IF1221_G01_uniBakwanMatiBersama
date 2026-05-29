/*
:- include('random7cards.pl').
:- include('giliran.pl').
:- include('efekKartu.pl').
*/

ambilKartu :-
    giliran([Player | _]),
    jumlahKartuDiambil(_, N),
    ambilNKartu(N, Player),
    currentPlayer.       


jumlahKartuDiambil(_, 1).     % normal draw selalu 1 kartu. draw_two & wild_draw_four urusannya efek_kartu


% Ambil N kartu acak dari deck, maskin ke tangan player.
ambilNKartu(0, _) :- !.
ambilNKartu(N, Player) :-
    N > 0,
    deck(DeckBefore),                                   % fix: tambah koma lupa lol
    takeNrandom(1, DeckBefore, [Card], DeckAfter),

    retract(player_hand(Player,OldHand)),               % fix masukin kartu ke player_hand
    NewHand = [Card | OldHand],
    assertz(player_hand(Player, NewHand)),                 

    updateDeck(DeckAfter),
    format('~w mendapatkan kartu: ~w~n', [Player, Card]), 
    ambilNKartu(N1, Player).