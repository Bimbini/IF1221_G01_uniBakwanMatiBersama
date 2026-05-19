:- dynamic(player_hand/2).
:- dynamic(giliran/1).
:- dynamic(status_uni/1).

tangkap(Player) :- player_hand(Player, Cards),
                hitung_kartu(Cards, 1),
                \+sudah_uni(Player),!,
                format('~w tertangkap tidak menyerukan UNI. ~n ~w mendapatkan 2 kartu penalti. ~n', [Player, Player]),
                ambilNKartuPenalti(Player,2),
                pindah_giliran.

tangkap(_) :- giliran([Penangkap|_]),
                    format('Perintah tidak valid! Anda mendapatkan 1 kartu penalti.'), nl,
                    player_hand(Penangkap, KartuPenangkap),
                    ambilKartuPenalti(Penangkap,KartuPenangkap).


