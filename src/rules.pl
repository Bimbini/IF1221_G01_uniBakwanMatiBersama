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

% wild card four cuman boleh dipake kalo pemain gapunya kartu lain yg cocok 
can_throw(kartu(hitam, wild_draw_four), kartu(W_kartu_di_meja, J_kartu_di_meja), Handlist) :- 
         \+ member(kartu(W_kartu_di_meja, _), Handlist).
        \+ member(kartu(_, J_kartu_di_meja), Handlist).








