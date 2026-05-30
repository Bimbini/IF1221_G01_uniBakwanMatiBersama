/* IF GAME ENDS */
% main function
endGame(Pemenang) :-
    retractall(has_started),
    fixed_urutanplayer(ListUrutan), % get the fixed list of players

    write('Permainan selesai! '), write(Pemenang),
    write(' menghabiskan semua kartunya!'), nl, nl,

    write('Berikut perhitungan poin sisa kartu:'), nl,
    scoreboard(ListUrutan, ListScore), nl,

    write('Urutan pemenang:'), nl,
    leaderboard(ListScore), nl, 

    write('Selamat, '), write(Pemenang), write(' menjadi pemenang!'), nl, resetGame.

/* COUNT SCORE (SCOREBOARD) */
scoreboard([], []). % kalau list player habis, stop

scoreboard([Name | Tail1], [[Name, Total] | Tail2]) :-
    perPlayer(Name, Total),
    scoreboard(Tail1, Tail2).

% Count per player points and print it
perPlayer(Name, 0) :- % kalau pemenang (list kartu habis)
    player_hand(Name, []), !,
    write(Name), write(': Kartu Habis = 0 poin'), nl.

perPlayer(Name, Total) :-
    player_hand(Name, ListKartu),
    write(Name), write(': '),
    listPoin(ListKartu, ListPoin),
    printListPoin(ListPoin),
    sumOfPoin(ListPoin, Total),
    write(' = '), write(Total), write(' poin'), nl.

% Facts buat Point per Kartu
% Number 0 cards are worth 1 point
pointKartu(kartu(X, 0), 1) :-
    warna(X),
    angka(0), !.

% Normal number cards (1-9) are worth their number
pointKartu(kartu(X, Number), Number) :-
    warna(X),
    angka(Number), !.

% Special cards (skip, reverse, draw 2) are worth 10 points
pointKartu(kartu(X, Jenis), 10) :-
    warna(X),
    special(Jenis), !.

% Wild cards (wild, draw 4) are worth 20 points
pointKartu(kartu(X, Jenis), 20) :-
    wild_color(X),
    wild_card(Jenis), !.

% Print the equation di scoreboard
listPoin([], []). % kalau kartu habis, stop

listPoin([Kartu | Tail1], [Point | Tail2]) :-
    pointKartu(Kartu, Point),
    listPoin(Tail1, Tail2).

printListPoin([LastOne]) :-
    write(LastOne).

printListPoin([Head | Tail]) :-
    write(Head), write(' + '),
    printListPoin(Tail).

% Hitung total poin
sumOfPoin([], 0). % kalau tidak ada kartu, point = 0

sumOfPoin([Point | Tail], Total) :-
    sumOfPoin(Tail, Total1),
    Total is Total1 + Point.

/* ORDER PLAYER BY SCORE (LEADERBOARD) */
leaderboard(ListScore) :-
    sortList(ListScore, Hasil),
    printListScore(Hasil, 1).

/* 
Algoritma bubble sort yang digunakan:
Source - https://stackoverflow.com/a/24529974 by ppeczek
*/
swap([[Name1, Score1], [Name2, Score2] | Tail], [[Name2, Score2], [Name1, Score1] | Tail]) :-
    Score1 > Score2, !. % kalau order tidak sesuai, swap

swap([X | Tail1], [X | Tail2]) :- 
    swap(Tail1, Tail2). % kalau udah sesuai, lanjut sort

sortList(ListScore, Hasil) :-
    swap(ListScore, List), !,
    sortList(List, Hasil).

sortList(List, List).

% Print leaderboardnya
printListScore([], _).

printListScore([[Name, Total] | Tail], Count) :-
    write(Count), write('. '),
    write(Name), write('('), write(Total), write(' poin)'), nl,
    Count1 is Count + 1,
    printListScore(Tail, Count1).

% When ending the game, reset all data to 0
resetGame :-
    retractall(last_played(_, _)),
    retractall(player_hand(_, _)),
    retractall(current_color(_)),
    retractall(giliran(_)),
    retractall(fixed_urutanplayer(_)),
    retractall(status_uni(_)),
    retractall(deck(_)),
    retractall(arah(_)),
    retractall(has_started),
    retractall(draw(_)),
    assertz(arah(clockwise)),
    assertz(draw(0)).