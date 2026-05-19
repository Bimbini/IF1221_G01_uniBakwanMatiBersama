:- dynamic(last_played/2). % revisi 
:- dynamic(player_hand/2).
:- dynamic(urutan_pemain/1).
urutan_pemain([pemain1, pemain2]).
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
        current_color(W_kartu_di_meja),
        (can_throw(kartu(W, J), kartu(W_kartu_di_meja, J_kartu_di_meja), Handlist) -> 
        % dari rules
            buang_kartu(PemainSaatIni, kartu(W, J)),
            pindah_giliran
        ; 
            write('Gagal, kartu tidak cocok denga warna atau jenis seperti yang ada di meja'), nl, fail
        )
    ;
        write('Gagal, kartu tersebut tidak kamu miliki!'), nl, fail
    ).    

handle_effect(skip) :-
    pindah_giliran,
    write('Pemain berikutnya dilewati!'), nl,
    pindah_giliran.


handle_effect(reverse) :-
    write('Arah permainan dibalik!'), nl.


handle_effect(draw_two) :-

    pindah_giliran,

    current_player(Target),
    drawCard(Target),
    drawCard(Target),
    write(Target),
    write('mengambil 2 kartu!'), nl,

    pindah_giliran.

handle_effect(wild_draw_four) :-

    pindah_giliran,

    current_player(Target),

    drawCard(Target),
    drawCard(Target),
    drawCard(Target),
    drawCard(Target),

    write(Target),
    write(' mengambil 4 kartu!'), nl,

    pindah_giliran.

    handle_effect(_).

pindah_giliran :-
    retract(urutan_pemain([Current | Sisa])), 
    append(Sisa, [Current], UrutanBaru),      
    assertz(urutan_pemain(UrutanBaru)),       

    UrutanBaru = [Next | _],                  
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
        read(WarnaBaru), 
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

    % to do list : 
    % 1. efek draw_two
    % 2. efek wild_draw_four
    % 3. efek skip


