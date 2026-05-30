/*
:- include('giliran.pl').
:- include('ambilKartu.pl').                                %buat dynamic fact draw 2/4 atau tidak
:- dynamic(arah/1).
:- (arah(_) -> true ; assertz(arah(clockwise))).
*/

angka(J) :- integer(J), J>=0, J=<9.

% Kartu angka no effect
efek_kartu(_,J) :-
    angka(J), !,
    currentPlayer.                                          % next

% SKIP skip to the next person
efek_kartu(_,skip) :- !,
    (arah(clockwise) -> rotate_kiri;rotate_kanan),
    giliran([Player | _]),                                  % ambil siapa yang kena skip
    format('[SKIP] ~w diskip~n', [Player]),
    currentPlayer.                                          % next

% REVERSE balik arah urutan
efek_kartu(_,reverse) :- !,
    balik_arah,
    currentPlayer.                                          % next


% DRAW TWO ambil 2 kartu , skip
efek_kartu(_,draw_two) :- !,
    retractall(draw(_)),
    assertz(draw(2)),
    currentPlayer.

% WILD warna udah diganti di buang_kartu, tinggal pindah giliran
efek_kartu(_,wild) :- !,
    currentPlayer.

% WILD DRAW FOUR berikutnya ambil 4 kartu lalu di-skip
efek_kartu(_,wild_draw_four) :- !, 
    retractall(draw(_)),
    assertz(draw(4)),
    currentPlayer.
