/* LIST */
:- dynamic(last_played/2).
:- dynamic(player_hand/2).
:- dynamic(urutan_player/1).
:- dynamic(current_player/1).
:- dynamic(discard_top/1).
:- dynamic(current_color/1).
:- dynamic(giliran/1).
:- dynamic(status_uni/1).
:- dynamic(deck/1).
:- dynamic(arah/1).
:- (arah(_) -> true ; assertz(arah(clockwise))).

/* FILES */
:-include('start_game.pl').
:-include('end_game.pl').
:-include('ambilKartu.pl').
:-include('cekInfo.pl').
:-include('discardpile.pl').
:-include('facts.pl').
:-include('giliran.pl').
:-include('lihatCommand.pl').
:-include('lihatKartu.pl').
:-include('mainkan_kartu.pl').
:-include('random7cards.pl').
:-include('randomize.pl').
:-include('rules.pl').
:-include('tantang.pl').
:-include('uni.pl').
:-include('tangkap.pl').
