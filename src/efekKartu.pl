/*
:- include('giliran.pl').
:- include('ambilKartu.pl').
:- dynamic(arah/1).
:- (arah(_) -> true ; assertz(arah(clockwise))).
*/

angka(J) :- integer(J), J>=0, J=<9.

% Kartu angka no effect
efek_kartu(_,J) :-
    angka(J), !,
    currentPlayer.          % next

% SKIP skip to the next person
efek_kartu(_,skip) :- !,
    (arah(clockwise) -> rotate_kiri;rotate_kanan),
    giliran([Player | _]),        % ambil siapa yang kena skip
    format('[SKIP] ~w diskip~n', [Player]),
    currentPlayer.          % "sekarang giliran B", next

% REVERSE — balik arah urutan
efek_kartu(_,reverse) :- !,
    balik_arah,
    currentPlayer.          % next


% DRAW TWO ambil 2 kartu , skip
efek_kartu(_,draw_two) :- !,
    (arah(clockwise) -> rotate_kiri;rotate_kanan),
    giliran([Player | _]),
    format('[DRAW TWO] ~w ambil 2 kartu~n', [Player]),
    ambilNKartu(2, Player),       % ambil 2 kartu
    currentPlayer.          % next

% WILD warna udah diganti di buang_kartu, tinggal pindah giliran
efek_kartu(_,wild) :- !,
    currentPlayer.

% WILD DRAW FOUR berikutnya ambil 4 kartu lalu di-skip
efek_kartu(_,wild_draw_four) :- !, 
    (arah(clockwise) -> rotate_kiri;rotate_kanan),
    giliran([Player | _]),
    format('[WILD DRAW FOUR] ~w ambil 4 kartu~n', [Player]),
    ambilNKartu(4, Player),       % ambil 4 kartu
    currentPlayer.          % next
