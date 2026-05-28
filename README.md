# IF1221-Logika Komputasional-G01-uniBakwanMatiBersama

## Daftar Isi
[Anggota Kelompok](#angota-kelompok) <br>
[Deskripsi Proyek](#deskripsi-proyek) <br>
[Struktur Repository](#struktur-repository) <br>
[Cara Menjalankan Program](#cara-menjalankan-program) <br>
[Daftar Fitur](#daftar-fitur)

## Anggota Kelompok
Repository ini dibuat oleh Kelompok 1 uniBakwanMatiBersama, yang terdiri oleh: 
+ Necia Aurely Greva Dedevi - 13525130
+ Samantha Michelle S. Silaban - 13525013
+ Syakira Azzahra Rachmania - 13525055
+ Sherin Felicia Danessa - 13525089
+ Jessica Audrey Tjahjadi - 13525142

## Deskripsi Proyek
Program ini merupakan permainan kartu yang bernama Uni yang dibuat dalam GNU Prolog.

## Struktur Repository
```text
IF1221_G01_uniBakwanMatiBersama
├── docs (milestones and laporan stored here)
├── src (all source code stored here)
└── README.md (info about the project)
```

## Cara Menjalankan Program
Untuk menjalankan program, clone repository ini di terminal
```bash
git clone https://github.com/Bimbini/IF1221_G01_uniBakwanMatiBersama.git
```
Lalu gunakan GNU Prolog untuk run, dengan change directory ke file src lalu compile dengan
```
['main.pl'].
```

## Daftar Command
Command untuk memulai game:
```prolog
startGame. %to start the game
```
Command dalam permainan:
```prolog
mainkanKartu(NomorUrutKartuDiTangan). %to play a card in your hand
```
```prolog
ambilKartu. %to take a card from the discard pile
```
```prolog
tantang. %to challenge a draw four card
```
```prolog
uni(NomorUrutKartuDiTangan). %to play then declare you have one card left
```
```prolog
tangkap(NamaPemain). %to catch a player that has one card left but hasn't declared uni 
```
```prolog
lihatCommand. %to look at available commands
```
```prolog
lihatKartu. %to look at all the cards in your hand
```
```prolog
cekInfo. %to check the current info of the game
```
```prolog
saveGame. %to save the game
```
```prolog
loadGame. %to load a game that was saved
```
