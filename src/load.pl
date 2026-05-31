loadGame :-
    \+has_started,
    write('Masukkan nama file yang akan dimuat: '),
    readCode(Codes),

    % menambahkan ".txt" di akhir
    add_tail(Codes, 46, Codes1),
    add_tail(Codes1, 116, Codes2),
    add_tail(Codes2, 120, Codes3),
    add_tail(Codes3, 116, FullCodes),

    name(LoadFile, FullCodes),
    bukaFile(LoadFile).

loadGame :-
    has_started,
    write('Load gagal! Saat ini permainan sudah dimulai.'), nl.

readCode(Codes) :-
    get_code(C),
    restCode(C, Codes).

restCode(46, []) :- !. % kalau udah titik
restCode(C, [C|Tail]) :-
    get_code(NextC),
    restCode(NextC, Tail).

bukaFile(LoadFile) :-
    file_exists(LoadFile), !,

    all_cards(All),
    assertz(deck(All)),

    open(LoadFile, read, S),
    read(S, Info),
    readInfo(S, Info),
    close(S),

    format('Status permainan berhasil dimuat dari ~w.~n', [LoadFile]),
    giliran([PemainSekarang | _]),
    format('Melanjutkan ke giliran ~w.~n', [PemainSekarang]),
    assertz(has_started).

bukaFile(LoadFile) :-
    format('Gagal: File ~w tidak ditemukan.~n', [LoadFile]),
    fail.

readInfo(S, Info) :- 
    at_end_of_stream(S), !,
    prosesInfo(Info).
readInfo(S, Info) :- 
    \+at_end_of_stream(S), !,
    prosesInfo(Info),
    read(S, Info1),
    readInfo(S, Info1).

prosesInfo(urutan_pemain:Urutan) :- !,
    assertz(fixed_urutanplayer(Urutan)),
    assertz(giliran(Urutan)).

prosesInfo(giliran:Pemain) :-
    giliran([Pemain | _]), !.
prosesInfo(giliran:Pemain) :-
    giliran([Head | Tail]),
    Head \== Pemain,
    add_tail(Tail, Head, NewGiliran),
    retractall(giliran(_)),
    assertz(giliran(NewGiliran)),
    prosesInfo(giliran:Pemain), !.

prosesInfo(discard_top:Warna-Jenis) :- !,
    assertz(last_played(startLoad, kartu(Warna, Jenis))),
    hapusDeck(Warna, Jenis).

prosesInfo(warna_aktif:Warna) :- !,
    assertz(current_color(Warna)).

prosesInfo(arah_permainan:Arah) :- !,
    assertz(arah(Arah)).

prosesInfo(status_UNI:Status) :- !,
    assertz(status_uni(Status)).

prosesInfo(Pemain:List) :-
    Pemain = kartu(Nama),
    convertListKartu(List, Res),
    assertz(player_hand(Nama, Res)),
    hapusListDeck(Res), !.

convertListKartu([], []).
convertListKartu([Warna-Jenis | Tail1], [kartu(Warna, Jenis) | Tail2]) :-
    convertListKartu(Tail1, Tail2).

hapus(_, [], []).
hapus(kartu(Warna, Jenis), [kartu(Warna, Jenis) | Tail], Tail) :- !.
hapus(CariKartu, [H | Tail], [H | Tail1]) :-
    hapus(CariKartu, Tail, Tail1).

hapusDeck(Warna, Jenis) :-
    deck(CurretDeck),
    hapus(kartu(Warna, Jenis), CurretDeck, NewDeck), !,
    retractall(deck(_)),
    assertz(deck(NewDeck)).

hapusDeck(_, _) :- !.

hapusListDeck([]).
hapusListDeck([kartu(Warna, Jenis) | Tail]) :-
    hapusDeck(Warna, Jenis), hapusListDeck(Tail).