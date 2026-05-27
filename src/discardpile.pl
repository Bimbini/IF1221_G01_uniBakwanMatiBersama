%:- include('randomize.pl').
%:- include('facts.pl').

%:- dynamic(deck/1).
%:- dynamic(last_played/2).

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

    retractall(discard_top(_)),
    assertz(discard_top(FirstCard)),

    FirstCard = kartu(W,_),

    retractall(current_color(_)),
    assertz(current_color(W)),

    write('Kartu discard top: '),
    writeCard(FirstCard).

% Fungsi Helper, akan mengambil kartu kembali 
% jika kartu yang diambil bukan kartu angka
takeDiscardPile(List, FirstCard, Rest):-
    random_pick(List, X, Rest1),
    (   \+ notAngka(X) -> FirstCard = X,
                          Rest = Rest1;
        takeDiscardPile(Rest1, FirstCard, Rest)).
