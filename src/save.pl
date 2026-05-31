saveGame :- has_started,
            draw(0),!,
            write('Masukan nama file penyimpanan: '),
            readCode(Codes),

            % menambahkan ".txt" di akhir
            add_tail(Codes, 46, Codes1),
            add_tail(Codes1, 116, Codes2),
            add_tail(Codes2, 120, Codes3),
            add_tail(Codes3, 116, FullCodes),

            name(X, FullCodes),
            open(X, write, S),
            fixed_urutanplayer(ListGiliran),
            format(S,'urutan_pemain:~q.',[ListGiliran]),nl(S),
            giliran([Head|_]),
            format(S,'giliran:~q.',[Head]),nl(S),
            last_played(_, kartu(W_kartu_di_meja, J_kartu_di_meja)),
            write(S,'discard_top:'),writeCardtoFile(S,kartu(W_kartu_di_meja, J_kartu_di_meja)),write(S,'.'),nl(S),
            current_color(WarnaAktif),
            format(S,'warna_aktif:~w.',[WarnaAktif]),nl(S),
            arah(Arah),
            format(S,'arah_permainan:~w.',[Arah]),nl(S),
            status_uni(ListUni),
            format(S,'status_UNI:~q.',[ListUni]),nl(S),
            cetakKartuNPemain(S,ListGiliran),
            close(S),
            retractall(has_started),
            write('Save berhasil! Permainan diberhentikan.'), resetGame.

saveGame :- has_started,
            draw(N),N>0,!,
            last_played(_, kartu(hitam, wild_draw_four)),
            write('Save gagal! Selesaikan efek kartu terlebih dahulu.'), nl.           

saveGame :- \+has_started,
            write('Permainan belum dimulai. Gunakan startGame terlebih dahulu.'),nl.

writeCardtoFile(S, kartu(Warna, Jenis)) :- format(S, '~w-~w', [Warna, Jenis]).

cetakKartuNPemain(_,[]).
cetakKartuNPemain(S,[Head|Tail]) :- player_hand(Head, Cards),
                                    format(S,"kartu(~q):", [Head]),
                                    write(S,'['),
                                    cetakKartu1Pemain(S,Cards),
                                    write(S,'].'), nl(S),
                                    cetakKartuNPemain(S,Tail).

cetakKartu1Pemain(_,[]).
cetakKartu1Pemain(S,[Card]) :- writeCardtoFile(S,Card).                                  
cetakKartu1Pemain(S,[Head|Tail]) :-    writeCardtoFile(S,Head),write(S,','),
                                        cetakKartu1Pemain(S,Tail).