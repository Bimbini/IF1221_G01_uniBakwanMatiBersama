%:- dynamic(last_played/2). % revisi 
%:- dynamic(player_hand/2).
%:- dynamic(current_player/1).
%:- dynamic(discard_top/1).
%:- dynamic(current_color/1).



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

pindah_giliran :-
    retract(urutan_pemain([Current | Sisa])), % Ambil pemain sekarang
    append(Sisa, [Current], UrutanBaru),      % Pindahkan dia ke antrian belakang
    assertz(urutan_pemain(UrutanBaru)),       % Simpan urutan baru

    UrutanBaru = [Next | _],                  % Pemain berikutnya adalah yang paling depan
    retract(current_player(_)),
    assertz(current_player(Next)),
    format('Sekarang giliran: ~w~n', [Next]).

buang_kartu(Pemain, kartu(W,J)) :-
    retract(player_hand(Pemain,OldHand)),
    delete(OldHand ,kartu(W,J),NewHand),
    assertz(player_hand(Pemain,NewHand)),

    retract(discard_top(_)),
    assertz(discard_top(kartu(W,J))),

    retractall(last_played(_, _)),
    assertz(last_played(Pemain, kartu(W, J))),

    % kalo wildcard dipake
    (W == hitam -> 
        write('Kartu Hitam! Masukkan warna baru (merah/biru/hijau/kuning): '), 
        read(WarnaBaru), % Mengambil input dari keyboard pemain
        retract(current_color(_)), 
        assertz(current_color(WarnaBaru)),
        format('Warna sekarang berubah menjadi: ~w~n', [WarnaBaru])
    ;   
        % Jika kartu biasa, otomatis ganti warna sesuai kartu yang dibuang
        retract(current_color(_)), 
        assertz(current_color(W))
    ),
    (length(NewHand,0)->format('HORE! ~w memenangkan permainan!~n', [Pemain]) 
    ; 
        write('giliran ke pemain berikutnya...'), nl
    ).


