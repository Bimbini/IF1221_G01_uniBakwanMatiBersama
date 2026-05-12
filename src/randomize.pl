/*Hitung jumlah kartu pada list*/
/*Deklarasi Fakta*/
count_list([],0).
/*Deklarasi Rules*/
count_list([_|Tail], N) :- count_list(Tail, X),
                           N is X+1.

/*Ambil elemen sesuai index random*/
/*Deklarasi Fakta*/
get_elmt([Head|Tail], 0, Head,Tail) :- !.
/*Deklarasi Rules*/
get_elmt([Head|Tail], Idx, Elmt, [Head|Rest]) :- NewIdx is Idx-1,
                                                get_elmt(Tail, NewIdx, Elmt, Rest).
/*Pilih kartu random*/
/*Deklarasi Fakta*/
random_pick([Result], Result, []).
/*Deklarasi Rules*/
random_pick(List, Result, NewList):-
    count_list(List, Len),
    random(0, Len, Index),
    get_elmt(List, Index, Result, NewList).



