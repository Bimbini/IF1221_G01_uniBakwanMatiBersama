:- include('giliran.pl').
:- include('ambilKartu.pl').
:- dynamic(arah/1).
:- (arah(_) -> true ; assertz(arah(clockwise))).


% Kartu angka no effect
efek_kartu(_,J) :-
    angka(J), !,
    currentPlayer.          % next

% SKIP skip to the next person
efek_kartu(_,skip) :- !,
    currentPlayer,          % "sekarang giliran A", next
    giliran([Diskip | _]),        % ambil siapa yang kena skip
    format('[SKIP] ~w diskip~n', [Diskip]),
    currentPlayer.          % "sekarang giliran B", next

% REVERSE — balik arah urutan
efek_kartu(_,reverse) :- !,
    balik_arah,
    currentPlayer.          % next


% DRAW TWO ambil 2 kartu , skip
efek_kartu(_,draw_two) :- !,
    giliran([Korban | _]),
    format('[DRAW TWO] ~w ambil 2 kartu~n', [Korban]),
    ambilNKartu(2, Korban),       % ambil 2 kartu
    currentPlayer.          % next

% WILD warna udah diganti di buang_kartu, tinggal pindah giliran
efek_kartu(_,wild) :- !,
    currentPlayer.

% WILD DRAW FOUR berikutnya ambil 4 kartu lalu di-skip
efek_kartu(_,wild_draw_four) :- !, 
    giliran([Korban | _]),
    format('[WILD DRAW FOUR] ~w ambil 4 kartu~n', [Korban]),
    ambilNKartu(4, Korban),       % ambil 4 kartu
    currentPlayer.          % next
