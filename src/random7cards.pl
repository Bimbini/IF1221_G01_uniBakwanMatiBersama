/*hand itu kartu yang lagi dipegang pemain, argumennya (Nama, ListKartu)*/

/*deklarasi fakta*/
giveCards([],Deck, Deck).
/*deklarasi rules*/
giveCards([Player|Rest], DeckBefore, DeckAfter) :- take7Random(DeckBefore, Cards,NewDeck),
                                                    retractall(player_hand(Player,_)),
                                                    assertz(player_hand(Player, Cards)),
                                                    giveCards(Rest, NewDeck, DeckAfter).
/*deklarasi rules*/
/*panggil ini setelah bagi kartu biar ke update decknya*/
updateDeck(DeckAfter) :-retractall(deck(_)),
                        assertz(deck(DeckAfter)).

take7Random(DeckBefore,Cards, DeckAfter) :- takeNrandom(7,DeckBefore,Cards, DeckAfter).

/*deklarasi fakta*/
takeNrandom(0, Deck,[],Deck).
/*deklarasi rules*/
takeNrandom(N, DeckBefore, [Head|Tail], DeckAfter) :-N > 0,
                                                    NewN is N-1,
                                                    random_pick(DeckBefore, Head, NewDeck),
                                                    takeNrandom(NewN, NewDeck, Tail, DeckAfter).
            
                                            
                                        





