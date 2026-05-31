/* DYNAMIC LIST */
:- dynamic(last_played/2).
:- dynamic(player_hand/2).
:- dynamic(current_color/1).
:- dynamic(giliran/1).
:- dynamic(fixed_urutanplayer/1).
:- dynamic(status_uni/1).
:- dynamic(deck/1).
:- dynamic(arah/1).
:- dynamic(has_started/0).
:- dynamic(draw/1).
:- dynamic(warna_sebelumnya/1).
:- initialization((draw(_) -> true ; assertz(draw(0)))).
:- initialization((arah(_) -> true ; assertz(arah(clockwise)))).

/* FILES */
:-include('ambilKartu.pl').
:-include('cekInfo.pl').
:-include('discardpile.pl').
:-include('efekKartu.pl').
:-include('end_game.pl').
:-include('facts.pl').
:-include('giliran.pl').
:-include('godsHand.pl').
:-include('lihatCommand.pl').
:-include('lihatKartu.pl').
:-include('mainkan_kartu.pl').
:-include('random7cards.pl').
:-include('randomize.pl').
:-include('rules.pl').
:-include('start_game.pl').
:-include('tantang.pl').
:-include('uni.pl').
:-include('tangkap.pl').
:-include('save.pl').
:-include('load.pl').
:-include('mimic.pl').