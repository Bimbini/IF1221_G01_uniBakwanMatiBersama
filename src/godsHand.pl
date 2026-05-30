% BONUS 1 (add this as aksi utama)

% godsHand gak boleh dipake when someone has to ambil kartu
godsHand :-
    giliran([Player | _]),
    draw(N), 
    N > 0, !,
    write(Player), write(' harus mengambil sebanyak '), write(N), write(' kartu! Silahkan gunakan command "ambilKartu".'), nl,
    fail.

% godsHand has a 12% chance of happening, 0% when all people have 1 card each
godsHand :-
    % check berapa orang yang punya hanya 1 kartu
    fixed_urutanplayer(CheckList),
    countLength(CheckList, Jumlah),
    checkTotalCards(CheckList, Total),
    % if everyone has 1 card left, godsHand gak bakal run
    (Total =:= Jumlah ->
        write('God said that''s cheating, so no.')

        ; % else lanjut
        generateRandomNumber(X, 101), % random 1-100

        % if X is 77 - 88, execute godsHand
        ((X >= 77, X =< 88) ->
            write('God said yes.'), nl,
            write('Kartu '),

            % pick player1 (kartunya diambil)
            fixed_urutanplayer(Content),
            countLength(Content, Length),
            L is Length + 1,
            generateRandomNumber(GetFrom, L),
            findInList(GetFrom, Content, Player1),
            retract(player_hand(Player1, ListKartu1)), % delete current card list, nanti bikin baru soalnya
            % pick a card to be transfered
            countLength(ListKartu1, LengthK),
            LK is LengthK + 1,
            generateRandomNumber(GetKFrom, LK),
            findInList(GetKFrom, ListKartu1, Card),

            removeFromList(Player1, Content, NewContent), % remove player1nya
            removeFromList(Card, ListKartu1, NewListKartu1), % remove kartunya
            assertz(player_hand(Player1, NewListKartu1)), % remake card list untuk player1, kartu udah diremove

            % pick player2 (kartu dikasih ke..)
            generateRandomNumber(GiveTo, Length),
            findInList(GiveTo, NewContent, Player2),
            retract(player_hand(Player2, ListKartu2)), % delete current list
            NewListKartu2 = [Card | ListKartu2], % tambah kartunya
            assertz(player_hand(Player2, NewListKartu2)), % update card list

            % Print the message
            writeWhatCard(Card), write(' milik '), write(Player1), write(' berpindah ke tangan '), write(Player2), write('!'), nl, nl,

            % check if the first pemain habis kartunya cause of godsHand
            ( player_hand(Player1, []) -> endGame(Player1) ; currentPlayer )

            ; % else godsHand no execute
            write('God said no.'), nl,
            currentPlayer
        )
    ).

% Check Total Kartu Setiap Orang
checkTotalCards([], 0). % if empty return 0

checkTotalCards([Head | Tail], Total) :-
    % get list kartu player
    player_hand(Head, Cards),
    countLength(Cards, Length),

    checkTotalCards(Tail, Total1),

    % if hanya punya 1 kartu, add to total
    (Length =:= 1 -> 
    Total is Total1 + 1
    ; % else do nothing
    Total is Total1 + 0
    ).

% Generate a number from 1 to N
generateRandomNumber(X, N) :-
    random(1, N, X). 

% Count length of a list
countLength([], 0). % if empty return 0

countLength([_ | Tail], Length) :-
    countLength(Tail, Length1),
    Length is Length1 + 1.

% Find something in a list dengan index tertentu
findInList(1, [Head | _], Head). % if index reaches 1 (or its head langsung), return the current head

findInList(Index, [_ | Tail], Item) :- % rekursi
    Index > 1,
    Index1 is Index - 1,
    findInList(Index1, Tail, Item).

% Print the card
writeWhatCard(kartu(Warna, Jenis)) :-
    write(Warna), write('-'), write(Jenis).

% Remove something from a list
removeFromList(Item, [Item | Tail], Tail). % if found, return the rest of the list

removeFromList(Item, [Head | Tail1], [Head | Tail2]) :- % if not found put Head in result list and keep going
    removeFromList(Item, Tail1, Tail2).