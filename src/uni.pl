
%:- dynamic(status_uni/1). 
%:- dynamic(player_hand/2).
%:- dynamic(giliran/1).
%:- dynamic(deck/1).

/*list yang udh teriak uni*/
status_uni([]). 

hitung_kartu([],0).
hitung_kartu([_|Tail], N) :- hitung_kartu(Tail, NewN),
                                 N is NewN+1.

uni(Indeks_kartu) :-  giliran([Player|_]),
                        player_hand(Player, Cards),
                        hitung_kartu(Cards, 2),
                        !,
                        (
                            mainkanKartu(Indeks_kartu) ->
                                format('~w menyerukan UNI! ~n',[Player]),
                                status_uni(ListLama),
                                append_list(ListLama, Player, ListBaru),
                                retractall(status_uni(_)),
                                assertz(status_uni(ListBaru))
                            ;
                                true
                        ).
   

uni(_) :- giliran([Player|_]),
                    player_hand(Player, Cards),
                    \+hitung_kartu(Cards, 2),
                    format('Perintah UNI gagal! ~w mendapat 1 kartu penalti. ~n', [Player]),
                    ambilKartuPenalti(Player,Cards),
                    pindah_giliran.

ambilKartuPenalti(Player, Cards):- deck(DeckAwal),
                                    takeNrandom(1, DeckAwal, [Kartu], DeckBaru),
                                    updateDeck(DeckBaru),
                                    append_list(Cards, Kartu, NewCards),
                                    retractall(player_hand(Player,_)),
                                    assertz(player_hand(Player,NewCards)),
                                    hapusStatusUNI(Player).
                    
ambilNKartuPenalti(_,0).
ambilNKartuPenalti(Player, N) :- N >0,
                                 NewN is N-1,
                                 player_hand(Player,Cards),
                                 ambilKartuPenalti(Player, Cards),
                                 ambilNKartuPenalti(Player, NewN).


hapusStatusUNI(Player) :- status_uni(List),
                          delete_Elmt(Player, List, NewList),
                          retractall(status_uni(_)),
                          assertz(status_uni(NewList)).

delete_Elmt(_, [], []).
delete_Elmt(Elmt, [Elmt|Tail], Tail) :-  !.
delete_Elmt(Elmt, [Head|Tail], [Head|NewTail]) :- delete_Elmt(Elmt, Tail, NewTail).



sudah_uni(Player) :- status_uni(List),
                     ada_diList(Player, List).

ada_diList(Player,[Player|_]).                    
ada_diList(Player, [_|Tail]) :- ada_diList(Player, Tail).             

append_list([],Element, [Element]).
append_list([Head|Tail], Element, [Head|NewTail]) :- append_list(Tail, Element, NewTail).     

