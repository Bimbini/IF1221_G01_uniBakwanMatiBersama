% Main fungsi cekInfo
cekInfo :-
    last_played(_, kartu(X, Y)),
    write('Kartu discard top: '), write(X), write('-'), write(Y), write('.'), nl, nl,

    fixed_urutanplayer(ListGiliran),
    jumlah_di_list(ListGiliran, JumlahPemain),
    write('Urutan pemain: '), printUrutan(ListGiliran, JumlahPemain), nl, nl,
    
    printInfo(ListGiliran, 1, JumlahPemain),



% Print nama sesuai list giliran
printUrutan([A], 1):-
    write(A), write('.').
printUrutan([A|B], P) :-
    write(A), write(' - '),
    P1 is P-1,
    printUrutan(B, P1).


% Print informasi setiap pemain
printInfo([A], P, 1) :-
    player_hand(A, ListKartu),
    jumlah_di_list(ListKartu, JmlKartu),

    write('Nama Pemain '), write(P), write(': '), write(A), nl,
    write('Jumlah kartu : '), write(JmlKartu), nl.

printInfo([A|B], P, Total) :-
    Total > 1,
    player_hand(A, ListKartu),
    jumlah_di_list(ListKartu, JmlKartu),

    write('Nama Pemain '), write(P), write(': '), write(A), nl,
    write('Jumlah kartu : '), write(JmlKartu), nl, nl,
    P1 is P+1,
    Total1 is Total-1,
    printInfo(B, P1, Total1).


% Hitung jumlah kartu pada list
jumlah_di_list([],0).
jumlah_di_list([_|Tail], N) :- 
    jumlah_di_list(Tail, X),
    N is X+1.