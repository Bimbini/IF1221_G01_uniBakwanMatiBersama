:- include('randomize.pl').
:- include('facts.pl').

:- dynamic(deck/1).
:- dynamic(last_played/1).

% Validasi jika kartu tidak termasuk kategori kartu angka
notAngka(kartu(hitam, _)).
notAngka(kartu(_, skip)).
notAngka(kartu(_, reverse)).
notAngka(kartu(_, draw_two)).

% Fungsi Discard Pile untuk start game
discardPile :-
    all_cards(All),
    takeDiscardPile(All, FirstCard, Rest),

    retractall(deck(_)),
    asserta(deck(Rest)),
    retractall(last_played(_)),
    asserta(last_played(start, FirstCard)),

    FirstCard = kartu(X, Y),
    write('Kartu discard top: '), write(X), write('-'), write(Y), write('.'), nl, nl.

% Fungsi Helper, akan mengambil kartu kembali 
% jika kartu yang diambil bukan kartu angka
takeDiscardPile(List, FirstCard, Rest):-
    random_pick(List, X, Rest1),
    (   \+ notAngka(X) -> FirstCard = X,
                          Rest = Rest1;
        takeDiscardPile(Rest1, FirstCard, Rest)).
