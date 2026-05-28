/*
:- dynamic(last_played/2).
:- dynamic(player_hand/2).
:- dynamic(urutan_pemain/1).
:- dynamic(current_player/1).
:- dynamic(discard_top/1).
:- dynamic(current_color/1).
*/

urutan_pemain([pemain1, pemain2]).
current_player(pemain1).

ambilKartu(Urutan, Handlist, Kartu) :-
    nth1(Urutan, Handlist, Kartu).

mainkanKartu(Urutan) :-
    current_player(PemainSaatIni),
    player_hand(PemainSaatIni, Handlist),

    ( ambilKartu(Urutan, Handlist, kartu(W,J))->
        discard_top(kartu(_, J_kartu_di_meja)),
        current_color(W_kartu_di_meja),
        (can_throw(kartu(W, J),kartu(W_kartu_di_meja, J_kartu_di_meja),Handlist)->
            buang_kartu(PemainSaatIni, kartu(W,J)),
            handle_effect(J), ! ;

            write('Gagal, kartu tidak cocok.'), nl,
            fail );

        write('Kartu tidak ada di hand.'), nl,
        fail
    ).

handle_effect(skip) :-
    write('Pemain berikutnya dilewati!'), nl,
    pindah_giliran,
    pindah_giliran.

handle_effect(reverse) :-
    write('Arah permainan dibalik!'), nl,

    retract(current_player(_)),
    ListBaru = [Next | _],
    assertz(current_player(Next)),

    format('Sekarang giliran: ~w~n', [Next]).

handle_effect(draw_two) :-
    pindah_giliran,
    current_player(Target),

    drawCard(Target),
    drawCard(Target),

    format('~w mengambil 2 kartu!~n', [Target]),
    pindah_giliran.

handle_effect(wild) :-
    pindah_giliran.

handle_effect(wild_draw_four) :-
    pindah_giliran,
    current_player(Target),

    drawCard(Target),
    drawCard(Target),
    drawCard(Target),
    drawCard(Target),

    format('~w mengambil 4 kartu!~n', [Target]),
    pindah_giliran.

handle_effect(_) :-
    pindah_giliran.

pindah_giliran :-
    retract(urutan_pemain([Current | Sisa])),
    append(Sisa, [Current], UrutanBaru),
    assertz(urutan_pemain(UrutanBaru)),

    UrutanBaru = [Next | _],

    retract(current_player(_)),
    assertz(current_player(Next)),

    format('Sekarang giliran: ~w~n', [Next]).

buang_kartu(Pemain, kartu(W,J)) :-
    retract(player_hand(Pemain, OldHand)),
    remove_first(kartu(W,J), OldHand, NewHand),
    assertz(player_hand(Pemain, NewHand)),

    retract(discard_top(_)),
    assertz(discard_top(kartu(W,J))),

    retractall(last_played(_, _)),
    assertz(last_played(Pemain, kartu(W, J))),

    (W == hitam->
        write('Kartu Hitam! Pilih warna baru: '),
        read(WarnaBaru),

        retract(current_color(_)),
        assertz(current_color(WarnaBaru)),

        format('Warna sekarang: ~w~n', [WarnaBaru])  ;

        retract(current_color(_)),
        assertz(current_color(W)) ),

    (length(NewHand, 0)-> 
        format('HORE! ~w menang!~n', [Pemain])
        ; write('Kartu berhasil dibuang.'), nl
    ).

remove_first(X, [X|T], T).

remove_first(X, [H|T], [H|R]) :-
    remove_first(X, T, R).

drawCard(Player) :-
    deck(DeckBefore),
    takeNrandom(1, DeckBefore, [Card], DeckAfter),

    retract(player_hand(Player, OldHand)),
    append(OldHand, [Card], NewHand),
    assertz(player_hand(Player, NewHand)),

    retract(deck(_)),
    assertz(deck(DeckAfter)),

    format('~w mendapatkan kartu: ~w~n', [Player, Card]).