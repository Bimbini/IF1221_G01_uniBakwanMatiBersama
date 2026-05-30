% Validasi jika kartu tidak termasuk kategori kartu angka
notAngka(kartu(hitam, _)).
notAngka(kartu(_, skip)).
notAngka(kartu(_, reverse)).
notAngka(kartu(_, draw_two)).

% Fungsi Discard Pile untuk start game
discardPile :-
    deck(DeckBefore),
    takeDiscardPile(DeckBefore, FirstCard, Rest),
    updateDeck(Rest),

    retractall(last_played(_, _)),
    asserta(last_played(start, FirstCard)),

    FirstCard = kartu(X, Y),
    assertz(current_color(X)),
    write('Kartu discard top: '), write(X), write('-'), write(Y), write('.'), nl, nl.


% Fungsi Helper, akan mengambil kartu kembali 
% jika kartu yang diambil bukan kartu angka
takeDiscardPile(List, FirstCard, Rest):-
    random_pick(List, X, Rest1),
    (   \+ notAngka(X) -> FirstCard = X,
                          Rest = Rest1;
        takeDiscardPile(Rest1, FirstCard, Rest)).
