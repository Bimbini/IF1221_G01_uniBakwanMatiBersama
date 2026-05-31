ambilKartu :-                  %ambilKartu kalo draw2/4
    giliran([Player | _]),
    draw(N),
    N>0, !, 
    retractall(draw(_)),        %reset draw jadi 0 lagi
    assertz(draw(0)),
    format('~w harus mengambil ~w kartu!~n', [Player, N]),
    ambilNKartu(N, Player),
    catat_giliran,
    currentPlayer.              %next


ambilKartu :-                   %ambilKartu normal
    giliran([Player | _]),
    (draw(0) -> true;draw(_)),
    ambilNKartu(1, Player),
    catat_giliran,
    currentPlayer.

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
    N1 is N-1,
    ambilNKartu(N1, Player).