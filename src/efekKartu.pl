% Kartu angka no effect
efek_kartu(_,J) :-
    angka(J), !,
    currentPlayer.                                          % next

% SKIP skip to the next person
efek_kartu(Pemain,skip) :- !,
    (last_played(_, kartu(mimic, mimic)) -> 
        kartu_efek_terakhir(_, W, _, _) 
        ;
        last_played(_, kartu(W, skip))
    ),
    catat_aksi(Pemain,W,skip),
    (arah(clockwise) -> rotate_kiri;rotate_kanan),
    giliran([Player | _]),                                  % ambil siapa yang kena skip
    format('[SKIP] ~w diskip~n', [Player]), nl,
    currentPlayer.                                          % next

% REVERSE balik arah urutan
efek_kartu(Pemain,reverse) :- !,
    (last_played(_, kartu(mimic, mimic)) -> 
        kartu_efek_terakhir(_, W, _, _) 
        ;
        last_played(_, kartu(W, reverse))
    ),
    catat_aksi(Pemain,W,reverse),
    balik_arah,
    currentPlayer.                                          % next


% DRAW TWO ambil 2 kartu , skip
efek_kartu(Pemain,draw_two) :- !,
    (last_played(_, kartu(mimic, mimic)) -> 
        kartu_efek_terakhir(_, W, _, _) 
        ;
        last_played(_, kartu(W, draw_two))
    ),
    catat_aksi(Pemain,W,draw_two),
    retractall(draw(_)),
    assertz(draw(2)),
    currentPlayer.

% WILD warna udah diganti di buang_kartu, tinggal pindah giliran
efek_kartu(Pemain,wild) :- !,
    (last_played(_, kartu(mimic, mimic)) -> 
        kartu_efek_terakhir(_, W, _, _) 
        ;
        last_played(_, kartu(W, wild))
    ),
    catat_aksi(Pemain,W,wild),
    currentPlayer.

% WILD DRAW FOUR berikutnya ambil 4 kartu lalu di-skip
efek_kartu(Pemain,wild_draw_four) :- !, 
    (last_played(_, kartu(mimic, mimic)) -> 
        kartu_efek_terakhir(_, W, _, _) 
        ;
        last_played(_, kartu(W, wild_draw_four))
    ),
    catat_aksi(Pemain,W,wild_draw_four),
    retractall(draw(_)),
    assertz(draw(4)),
    currentPlayer.

efek_kartu(Pemain,mimic) :- !,
    kartu_efek_terakhir(_,_,J,_),
    ((J == none ; J == wild) ->
        catat_aksi(Pemain, hitam, mimic),
        currentPlayer
        ;
        format('Kartu mimic menyalin efek ~w!~n~n', [J]),
        efek_mimic(Pemain, J),
        inputWarna(WarnaBaru),
        retractall(current_color(_)),
        assertz(current_color(WarnaBaru)),
        format('Warna sekarang: ~w~n', [WarnaBaru]),
        currentPlayer
    ).
