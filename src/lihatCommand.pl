/*deklarasi rules*/
lihatCommand :- has_started,
                write('Aksi utama yang tersedia: '), nl,
                write('1. ambilKartu'), nl,
                N is 2,
                command_tantang(N,N1),nl,
                command_mainkanKartu(N1, N2),
                command_tangkap(N2,N3),
                command_uni(N3,N4),
                
                write('Aksi pendukung yang tersedia: '), nl,
                write('1. lihatCommand'), nl, write('2. lihatKartu'),nl, write('3. cekInfo'), nl.

/*deklarasi rules*/              
/*kalau player sebelumnya mengeluarkan wild_draw_four, maka player sekarang bisa tantang*/
command_tantang(NomorAwal, NomorSetelah) :- last_played(_, kartu(hitam, wild_draw_four)), !,
                                            write(NomorAwal), write('. tantang'), nl,
                                            NomorSetelah is NomorAwal+1.
                                         
/*deklarasi fakta*/
command_tantang(NomorAwal, NomorAwal).
                                          
/*deklarasi rules*/
command_mainkanKartu(NomorAwal, NomorSetelah) :- \+ last_played(_, kartu(hitam, wild_draw_four)), \+ last_played(_, kartu(_, draw_two)),!,
                                                write(NomorAwal),write('. mainkanKartu(NomorUrutKartuDiTangan)'), nl,
                                               NomorSetelah is NomorAwal+1.
/*deklarasi fakta*/
command_mainkanKartu(NomorAwal,NomorAwal).
                                             
/*deklarasi rules*/
command_tangkap(NomorAwal, NomorSetelah) :- \+ last_played(_, kartu(hitam, wild_draw_four)), \+ last_played(_, kartu(_, draw_two)),!,
                                                write(NomorAwal),write('. tangkap(NamaPemain)'), nl,
                                               NomorSetelah is NomorAwal+1.
/*deklarasi fakta*/
command_tangkap(NomorAwal, NomorAwal).

/*deklarasi rules*/
command_uni(NomorAwal, NomorSetelah) :- \+ last_played(_, kartu(hitam, wild_draw_four)), \+ last_played(_, kartu(_, draw_two)),!,
                                                write(NomorAwal),write('. uni(NomorUrutKartuDiTangan)'), nl,
                                               NomorSetelah is NomorAwal+1.
/*deklarasi fakta*/
command_uni(NomorAwal, NomorAwal).