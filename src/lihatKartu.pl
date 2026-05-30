/*Deklarasi Rules*/
lihatKartu :- has_started,
              write('Berikut kartu yang anda miliki'), nl, 
              giliran([Player|_]),
              player_hand(Player,Cards),
              count(Cards,N),
              tunjukan(Cards,1,N).

/*Deklarasi Fakta*/
count([],0).
/*Deklarasi Rules*/
count([_|Tail], N) :- count(Tail, X),
                           N is X+1.
/*Deklarasi Rules*/
tunjukan([],Nomor,N) :- Nomor > N.
tunjukan([Head|Tail], Nomor, N) :- Nomor =< N,
                                    write(Nomor), write('.'),
                                    NewNomor is Nomor + 1,
                                    writeCard(Head),
                                    tunjukan(Tail, NewNomor, N).
/*Deklarasi Rules*/
writeCard(kartu(Warna, Jenis)) :- write(Warna),
                                  write('-'),
                                  write(Jenis), write('.'), nl.