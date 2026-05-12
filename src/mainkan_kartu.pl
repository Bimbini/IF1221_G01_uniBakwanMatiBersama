
:- dynamic(player_hand/2).
:- dynamic(current_player/1).
:- dynamic(discard_top/1).
:- dynamic(current_color/1).

ambilKartu(Urutan, Handlist, Kartu) :- 
    nth1(Urutan, Handlist, Kartu).

mainkanKartu(Urutan):-
    current_player(PemainSaatIni),                      % cek giliran siapa skrg
    player_hand(PemainSaatIni,Handlist),                % ambil kartu yg sekarang dipegang
    (ambilKartu(Urutan,Handlist,kartu(W,J)) ->           % ambil kartu yg sesuai Input
        discard_top(kartu(_ ,J_kartu_di_meja)),
        current_color(W_aktif),
        ( (W == W_aktif) ; (J == J_kartu_di_meja) ; (W == hitam) ->
            buang_kartu(PemainSaatIni, kartu(W,J)) 
        ;
            write('Gagal, kartu tidak cocok denga warna atau jenis seperti yang ada di meja'), nl, fail
        ) 
    ;
        write('Gagal, kartu tersebut tidak kamu miliki!'), nl, fail
    ).

buang_kartu(Pemain, kartu(W,J)) :-
    retract(player_hand(Pemain,OldHand)),
    delete(OldHand ,kartu(W,J),NewHand),
    assertz(player_hand(Pemain,NewHand)),

    retract(discard_top(_)),
    assertz(discard_top(kartu(W,J))),

    % kalo wildcard dipake
    (W \== hitam -> retract(current_color(_)), assertz(current_color(W)) ;
        write('silakan tentukan warna baru'), nl
    ), format('~w berhasil mengeluarkan kartu ~w ~w.~n', [Pemain, W, J]),

    (length(NewHand,0)->format('HORE! ~w memenangkan permainan!~n', [Pemain]) 
    ; 
        write('giliran ke pemain berikutnya...'), nl
    ).


% belum menyertakan fitur skip, masi dalam tahap pengerjaan