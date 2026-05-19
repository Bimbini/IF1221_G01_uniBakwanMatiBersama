/* FILES */
%:- include('randomize.pl').
%:- include('discardpile.pl').
%:- include('giliran.pl').

/* START THE GAME */
% main function
startGame :-
    amountOfPlayers(Jumlah), nl, % check amount
    nameOfPlayers([], Jumlah, 1, AllNames), nl, % masukin nama, nama final di AllNames
    urutanPemain(AllNames, Jumlah, ListUrutan),  % buat random order
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl, nl,
    all_cards(All),
    giveCards(ListUrutan, All, DeckAfter),
    updateDeck(DeckAfter),
    discardPile,
    currentPlayer.


% Dapet input berapa player
amountOfPlayers(Jumlah) :-
    write('Masukan jumlah pemain: '),
    read(N),
    % if jumlah not 2 - 4, error
    ((N < 2 ; N > 4) -> 
    write('Mohon masukkan angka antara 2 - 4.'), nl, amountOfPlayers(Jumlah)
    % else, lanjut
    ; Jumlah = N). % if 2 - 4, valid

% Check if nama udah di list
isNameInList([Name|_], Name). % if same, return true

isNameInList([_|Tail], Name) :- % if not same continue
    isNameInList(Tail, Name).

% Dapet input nama player
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

% Make random order for pemain
urutanPemain(AllNames, Jumlah, ListUrutan) :-
    write('Urutan pemain: '),
    makeUrutan(AllNames, Jumlah, ListUrutan),
    outputListUrutan(ListUrutan).

makeUrutan(_, 0, []). % basis kalau jumlah 0, stop

makeUrutan(AllNames, Jumlah, [Name | Tail]) :- % rekursi
    Jumlah > 0,
    random_pick(AllNames, Name, NamesLeft), % randomize urutan
    Jumlah1 is Jumlah - 1,
    makeUrutan(NamesLeft, Jumlah1, Tail).

% Output / Printing hasilnya
outputListUrutan([]).

outputListUrutan([Head | Tail]) :-
    write(Head), 
    ((Tail \= []) -> write(' - ') ; (write('.'), nl, nl)), % check if udah akhir atau gak
    outputListUrutan(Tail).
