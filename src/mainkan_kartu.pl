ambilDariHand(1, [H|_], H).
ambilDariHand(N, [_|T], Kartu) :- 
    N > 1,
    N1 is N - 1,
    ambilDariHand(N1, T, Kartu).

mainkanKartu(_) :-
    giliran([PemainSaatIni | _]),
    draw(N),
    N>0, !,
    format('~w harus mengambil sebanyak ~w kartu! Silahkan gunakan command "ambilKartu".~n', [PemainSaatIni, N]),
    fail.

mainkanKartu(Urutan) :-
    giliran([PemainSaatIni | _]),
    player_hand(PemainSaatIni, Handlist),

    ( ambilDariHand(Urutan, Handlist, kartu(W,J)) ->
        last_played(_, kartu(_, J_kartu_di_meja)),
        current_color(W_kartu_di_meja),
        ( can_throw(kartu(W, J), kartu(W_kartu_di_meja, J_kartu_di_meja), Handlist) ->
            
            retractall(kartu_sebelumnya(_, _)),
            assertz(kartu_sebelumnya(W_kartu_di_meja, J_kartu_di_meja)),
            
            buang_kartu(PemainSaatIni, kartu(W,J))
        ;
            write('Gagal, kartu tidak cocok.'), nl,
            fail 
        )
    ;
        write('Kartu tidak ada di hand.'), nl,
        fail
    ).

buang_kartu(Pemain, kartu(W,J)) :-
    (J == mimic ->
        write('Menelusuri riwayat permainan.'), nl,
        last_effect
        ;
        (angka(J) ->
            catat_giliran
            ;
            true
        )
    ),
    retract(player_hand(Pemain, OldHand)),
    remove_first(kartu(W,J), OldHand, NewHand),
    assertz(player_hand(Pemain, NewHand)),

    retractall(last_played(_, _)),
    assertz(last_played(Pemain, kartu(W, J))),

    % Print main apa baru tanya warna
    write(Pemain), write(' memainkan kartu '), write(W), write('-'), write(J), write('.'), nl, nl,

    ( W == hitam, J \== mimic ->
        
        write('Kartu Hitam!'), nl, inputWarna(WarnaBaru),
        retractall(current_color(_)),
        assertz(current_color(WarnaBaru)),

        format('Warna sekarang: ~w~n', [WarnaBaru])  
    ;
        retractall(current_color(_)),
        assertz(current_color(W)) 
    ),

    ( player_hand(Pemain, []) -> endGame(Pemain) ; efek_kartu(Pemain, J) ).

remove_first(X, [X|T], T).
remove_first(X, [H|T], [H|R]) :-
    remove_first(X, T, R).

validasi_warna(merah).
validasi_warna(kuning).
validasi_warna(hijau).
validasi_warna(biru).

inputWarna(WarnaBaru) :- write('Pilih warna baru: '),
                        read(Warna),
                        (validasi_warna(Warna)->
                            WarnaBaru = Warna
                        ;
                            write('Warna tidak valid! Harus merah/kuning/hijau/biru.'),nl,
                            inputWarna(WarnaBaru)
                        ).