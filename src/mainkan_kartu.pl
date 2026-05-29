/*
:- dynamic(last_played/2).
:- dynamic(player_hand/2).
:- dynamic(urutan_pemain/1).
:- dynamic(current_player/1).
:- dynamic(current_color/1).
*/


ambilDariHand(1, [H|_], H).
ambilDariHand(N, [_|T], Kartu) :- N>1,
                                N1 is N-1,
                                ambilDariHand(N1,T,Kartu).

mainkanKartu(Urutan) :-
    giliran([PemainSaatIni | _]),
    player_hand(PemainSaatIni, Handlist),

    ( ambilDariHand(Urutan, Handlist, kartu(W,J))->
        %discard_top(kartu(_, J_kartu_di_meja)),
        last_played(_, kartu(W_kartu_di_meja, J_kartu_di_meja)),
        %current_color(W_kartu_di_meja),
        (can_throw(kartu(W, J),kartu(W_kartu_di_meja, J_kartu_di_meja),Handlist)->
            buang_kartu(PemainSaatIni, kartu(W,J)),
            ;
            write('Gagal, kartu tidak cocok.'), nl,
            fail );

        write('Kartu tidak ada di hand.'), nl,
        fail
    ).



buang_kartu(Pemain, kartu(W,J)) :-
    retract(player_hand(Pemain, OldHand)),
    remove_first(kartu(W,J), OldHand, NewHand),
    assertz(player_hand(Pemain, NewHand)),

    %retract(discard_top(_)),
    %assertz(discard_top(kartu(W,J))),

    retractall(last_played(_, _)),
    assertz(last_played(Pemain, kartu(W, J))),

    (W == hitam->
        write('Kartu Hitam! Pilih warna baru: '),
        read(WarnaBaru),

        retractall(current_color(_)),
        assertz(current_color(WarnaBaru)),

        format('Warna sekarang: ~w~n', [WarnaBaru])  ;

        retractall(current_color(_)),
        assertz(current_color(W)) ),

    write('Kartu berhasil dibuang.'), nl,
    (player_hand(Pemain, []) -> endGame(Pemain, giliran) ; efek_kartu(_, J)).

    

remove_first(X, [X|T], T).

remove_first(X, [H|T], [H|R]) :-
    remove_first(X, T, R).

