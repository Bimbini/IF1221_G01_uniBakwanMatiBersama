/* FILES */
:- include('randomize.pl').
:- include('discardpile.pl').

/* START THE GAME */
% main function
startGame :-
    amountOfPlayers(Jumlah), nl, % check amount
    nameOfPlayers([], Jumlah, 1, AllNames), nl, % masukin nama, nama final di AllNames
    urutanPemain(AllNames, Jumlah),  % buat random order
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl, nl,
    discardPile. % show first card


% Dapet input berapa player
amountOfPlayers(Jumlah) :-
    write('Masukan jumlah pemain: '),
    read(N),
    % if jumlah not 2 - 4, error
    ((N < 2 ; N > 4) -> 
    write('Mohon masukkan angka antara 2 - 4.'), nl, amountOfPlayers(Jumlah)
    % else, lanjut
    ; Jumlah = N). % if 2 - 4, valid

% Dapet input nama player
isNameInList([Name|_], Name). % if same, return true

isNameInList([_|Tail], Name) :- % if not same continue
    isNameInList(Tail, Name).

nameOfPlayers(_, Jumlah, Count,[]) :- % basis if jumlah atau counter 0, stop
    Count > Jumlah.

nameOfPlayers(StartList, Jumlah, Count, [Name | Tail]) :- % rekursi
    Count =< Jumlah,
    write('Masukan nama pemain '), write(Count), write(': '),
    read(TempName),
    % if name dupe, error
    ((isNameInList(StartList, TempName)) -> 
    write('Nama sudah digunakan. Masukkan nama lain.'), nl, nameOfPlayers(StartList, Jumlah, Count, [Name | Tail])
    % else, lanjut input
    ; Count1 is Count + 1, 
    Name = TempName,
    nameOfPlayers([Name | StartList], Jumlah, Count1, Tail)).

% Output order main random
urutanPemain(AllNames, Jumlah) :-
    write('Urutan pemain: '),
    makeUrutan(AllNames, Jumlah),
    write('.'), nl, nl.

makeUrutan([], 0). % basis kalau jumlah 0, stop

makeUrutan(AllNames, Jumlah) :- % rekursi
    Jumlah > 0,
    random_pick(AllNames, Name, NamesLeft), % randomize urutan
    write(Name),
    Jumlah1 is Jumlah - 1,
    (Jumlah1 > 0 -> write(' - ') ; true),
    makeUrutan(NamesLeft, Jumlah1).