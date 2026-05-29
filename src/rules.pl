/*validasi dasar*/
% kartu angka
is_card(kartu(W,J)) :- warna(W), angka(J).

% kartu spesial
is_card(kartu(W,J)) :- warna(W), special(J).

% kartu wild
is_card(kartu(hitam,J)) :- wild_card(J).

/* aturan permainan */
/* can_throw(cardInHand, cardOnTable, playerHandList)*/
% warna sama
can_throw(kartu(W,_), kartu(W,_), _).

% jenis/angka sama
can_throw(kartu(_,J), kartu(_,J), _).

% wild card bisa dipake kpn aja
can_throw(kartu(hitam,wild), _, _).

% wild card four gaboleh ditumpuk dua kali
can_throw(kartu(hitam, wild_draw_four), kartu(_, wild_draw_four), _) :- !, fail.

can_throw(kartu(hitam,wild_draw_four), _, _).








