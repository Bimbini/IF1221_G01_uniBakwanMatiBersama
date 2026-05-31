:- dynamic(kartu_efek_terakhir/4).                  %(player, warnakartu, efekkartu, giliran)
:- initialization(assertz(kartu_efek_terakhir(none, none, none, 0))).

last_effect :-
    kartu_efek_terakhir(P,W,J,N),
    (J == none -> 
        write('Tidak ada kartu aksi sebelumya!'), nl
        ;
        format('Kartu aksi terakhir yang dimainkan: ~w-~w (oleh ~w, ~w giliran lalu)~n', [W, J, P, N])
    ).
    

catat_aksi(P,W,J) :-
    retractall(kartu_efek_terakhir(_,_,_,_)),
    assertz(kartu_efek_terakhir(P,W,J,0)).

catat_giliran :-
    retract(kartu_efek_terakhir(P,W,J,N)),
    N1 is N+1,
    assertz(kartu_efek_terakhir(P,W,J,N1)).


efek_mimic(Pemain, skip) :- !,
    kartu_efek_terakhir(_, W, _, _),
    catat_aksi(Pemain, W, skip),
    (arah(clockwise) -> rotate_kiri ; rotate_kanan),
    giliran([Player | _]),
    format('[SKIP] ~w diskip~n', [Player]), nl.

efek_mimic(Pemain, reverse) :- !,
    kartu_efek_terakhir(_, W, _, _),
    catat_aksi(Pemain, W, reverse),
    balik_arah.

efek_mimic(Pemain, draw_two) :- !,
    kartu_efek_terakhir(_, W, _, _),
    catat_aksi(Pemain, W, draw_two),
    retractall(draw(_)),
    assertz(draw(2)).

efek_mimic(Pemain, wild_draw_four) :- !,
    kartu_efek_terakhir(_, W, _, _),
    catat_aksi(Pemain, W, wild_draw_four),
    retractall(draw(_)),
    assertz(draw(4)).

efek_mimic(Pemain, J) :-               % fallback untuk efek lain
    efek_kartu(Pemain, J).