:- include('random7cards.pl').
:- include('giliran.pl').
:- include('efekKartu.pl').


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
    assertz(player_hand(Player, Card)),                 % FIX: player_hand, bukan hand
    updateDeck(DeckAfter),
    format('~w mendapatkan kartu: ~w~n', [Player, Card]), % FIX: ~n bukan ~-n
    N1 is N - 1,
    ambilNKartu(N1, Player).
