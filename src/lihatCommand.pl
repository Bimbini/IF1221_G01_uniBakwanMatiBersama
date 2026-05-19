%:- dynamic(last_played/2).
/*deklarasi rules*/
lihatCommand :- write('Aksi utama yang tersedia: '), nl,
                write('1. ambilKartu'), nl,
                N is 2,
                command_mainkanKartu(N, N1),
                command_tantang(N1),nl,
                write('Aksi pendukung yang tersedia: '), nl,
                write('1. lihatCommand'), nl, write('2. lihatKartu'),nl, write('3. cekInfo'),nl, write('4. tangkap'), nl, write('5. uni'), nl.

/*deklarasi rules*/              
/*kalau player sebelumnya mengeluarkan wild_draw_four, maka player sekarang bisa tantang*/
command_tantang(NomorAwal) :- last_played(_, kartu(hitam, wild_draw_four)), !,
                                            write(NomorAwal), write('. tantang'), nl.
                                          
/*deklarasi fakta*/
command_tantang(_).
                                          
/*deklarasi rules*/
command_mainkanKartu(NomorAwal, NomorSetelah) :- \+ last_played(_, kartu(hitam, wild_draw_four)), !,
                                                write(NomorAwal),write('. mainkanKartu(NomorUrutKartuDiTangan)'), nl,
                                               NomorSetelah is NomorAwal+1.
/*deklarasi fakta*/
command_mainkanKartu(NomorAwal, NomorAwal).
                                             
