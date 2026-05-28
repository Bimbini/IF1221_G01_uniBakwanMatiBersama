# IF1221-Logika Komputasional-G01-uniBakwanMatiBersama

## Daftar Isi
[Anggota Kelompok](#angota-kelompok) <br>
[Deskripsi Proyek](#deskripsi-proyek) <br>
[Struktur Repository] (#struktur-repository) <br>
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
Untuk menjalankan program, clone repository ini dengan terminal
```
git clone https://github.com/Bimbini/IF1221_G01_uniBakwanMatiBersama.git
```
Lalu gunakan GNU Prolog untuk run, dengan change directory ke file src lalu compile dengan
```
['main.pl'].
```

## Daftar Fitur 
```
startGame. %to start the game
```
```
mainkanKartu(NomorUrutKartuDiTangan). %to play a card in your hand
```
```
ambilKartu. %to take a card from the discard pile
```
```
tantang. %to challenge a draw four card
```
```
uni(NomorUrutKartuDiTangan). %to play then declare you have one card left
```
```
tangkap(NamaPemain). %to catch a player that has one card left but hasn't declared uni 
```
```
lihatCommand. %to look at available commands
```
```
lihatKartu. %to look at all the cards in your hand
```
```
cekInfo. %to check the current info of the game
```
```
saveGame. %to save the game
```
```
loadGame. %to load a game that was saved
```
