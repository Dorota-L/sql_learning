-- TODO podzieliæ na osobne pliki

/*tworzenie uzytkownika logistyka*/
create user logistyka identified by whr;
/*nadanie wszystkich uprawnien uzytkownikowi logistyka*/
grant all privileges to logistyka;
/*tworzenie tabeli dzial_sprzedazy*/
CREATE TABLE "DZIAL_SPRZEDAZY" 
   ("ID" NUMBER, 
	"NR_ZAMOWIENIA" VARCHAR2(100 BYTE), 
	"NAZWA_SPRZETU" VARCHAR2(100 BYTE), 
	"ILOSC" NUMBER, 
	"WAGA" NUMBER, 
	"NAZWA_KLIENTA" VARCHAR2(100 BYTE), 
	"ADRES_DOSTAWY" VARCHAR2(100 BYTE), 
	"DATA_DOSTAWY" DATE, 
	"GODZINA_DOSTAWY" DATE
   );
/*tworzenie tabeli dzial_zamowien*/
CREATE TABLE "DZIAL_ZAMOWIEN" 
   ("ID" NUMBER, 
	"NR_ZAMOWIENIA" VARCHAR2(100 BYTE), 
	"NAZWA_KLIENTA" VARCHAR2(100 BYTE), 
	"NAZWA_SPRZETU" VARCHAR2(40 BYTE), 
	"WAGA_SPRZETU" VARCHAR2(100 BYTE), 
	"NAZWA_FABRYKI" VARCHAR2(50 BYTE), 
	"LICZBA_SZTUK" VARCHAR2(30 BYTE)
   );
/*tworzenie tabeli faktury*/
CREATE TABLE "FAKTURY" 
   ("NR_FAKURY" NUMBER, 
	"DATA_WYSTAWIENIA_FAKTURY" DATE, 
	"NETTO" NUMBER(7,2), 
	"BRUTTO" NUMBER(7,2), 
	"PODATEK" NUMBER, 
	"WALUTA" NUMBER
   );
/*tworzenie tabeli magazyn*/
CREATE TABLE "MAGAZYN" 
   ("ID" NUMBER, 
	"NUMER_RAMPY" NUMBER, 
	"NOWY_SPRZET" VARCHAR2(50 BYTE), 
	"PRZEPAKOWANY_SPRZET" VARCHAR2(50 BYTE), 
	"USZKODZONY_SPRZET" VARCHAR2(50 BYTE)
   );
/*tworzenie tabeli pracownicy*/
CREATE TABLE "PRACOWNICY" 
   ("ID" NUMBER, 
	"IMIE" VARCHAR2(20 BYTE), 
	"NAZWISKO" VARCHAR2(30 BYTE), 
	"NR_PESEL" NUMBER(11,0), 
	"PLEC" VARCHAR2(10 BYTE)
   );
/*tworzenie tabeli produkty*/
  CREATE TABLE "PRODUKTY" 
   ("ID" NUMBER, 
	"NAZWA_PRODUKTU" VARCHAR2(50 BYTE), 
	"TYP_PRODUKTU" VARCHAR2(100 BYTE), 
	"CENA_SPRZEDAZY" NUMBER(7,2), 
	"CENA_ZAKUPU" NUMBER(7,2), 
	"STAWKA_PODATKU" NUMBER, 
	"JM"
    );
/*tworzenie tabeli przewoznik*/
CREATE TABLE "PRZEWOZNIK" 
   ("ID" NUMBER, 
	"RODZAJ_AUTA" VARCHAR2(30 BYTE), 
	"WAGA" NUMBER, 
	"ZALADUNEK" VARCHAR2(100 BYTE), 
	"ROZLADUNEK" VARCHAR2(100 BYTE), 
	"NAZWA_PRODUKTU" VARCHAR2(100 BYTE), 
	"MAGAZYN" VARCHAR2(100 BYTE), 
	"KLIENT" VARCHAR2(20 BYTE)
   );
/*tworzenie tabeli odzaje_srodkow_transportu*/
CREATE TABLE "RODZAJE_SRODKOW_TRANSPORTU" 
   ("ID" NUMBER, 
	"NAZWA" VARCHAR2(20 BYTE), 
	"KOD_RODZAJU_SRODKA_TRANSPORTU" NUMBER, 
	"RODZAJ_AUTA" VARCHAR2(30 BYTE), 
	"WAGA" NUMBER, 
	"LADOWNOSC" NUMBER
   );
/*tworzenie tabeli supply_chain*/
CREATE TABLE "SUPPLY_CHAIN" 
   ("ID" NUMBER, 
	"NAZWA_OPIEKUNA" VARCHAR2(60 BYTE), 
	"NAZWA_FABRYKI" VARCHAR2(60 BYTE), 
	"NAZWA_MAGAZYNU" VARCHAR2(60 BYTE), 
	"NAZWA_SPRZETU" VARCHAR2(60 BYTE), 
	"ILOSC" NUMBER, 
    "DATA_DOSTAWY_DO_MAGAZYNU" DATE
   );
/*tworzenie constraints do tabeli faktury*/
ALTER TABLE "FAKTURY" MODIFY ("DATA_WYSTAWIENIA_FAKTURY" NOT NULL);
ALTER TABLE "FAKTURY" MODIFY ("NETTO" NOT NULL);
ALTER TABLE "FAKTURY" MODIFY ("BRUTTO" NOT NULL);
ALTER TABLE "FAKTURY" ADD CHECK (podatek in ('23'));
ALTER TABLE "FAKTURY" ADD CHECK (waluta in ('PLN'));
ALTER TABLE "FAKTURY" ADD PRIMARY KEY ("NR_FAKURY")
;
/*tworzenie constraints do tabeli magazyn*/
ALTER TABLE "MAGAZYN" ADD CHECK (nowy_sprzet in ('tak', 'nie'));
ALTER TABLE "MAGAZYN" MODIFY ("NOWY_SPRZET" NOT NULL);
ALTER TABLE "MAGAZYN" ADD CHECK (przepakowany_sprzet in ('tak', 'nie'));
ALTER TABLE "MAGAZYN" ADD CHECK (uszkodzony_sprzet in ('tak', 'nie'))
;
/*tworzenie constraints do tabeli pracownicy*/
ALTER TABLE "PRACOWNICY" ADD CHECK (plec in ('M', 'K'));
ALTER TABLE "PRACOWNICY" MODIFY ("PLEC" NOT NULL);
ALTER TABLE "PRACOWNICY" MODIFY ("NR_PESEL" NOT NULL);
ALTER TABLE "PRACOWNICY" ADD CONSTRAINT "PK_PRACOWNICY" PRIMARY KEY ("ID")
;
/*zmiana typu danych w tabeli pracownicy*/
ALTER TABLE "PRACOWNICY" MODIFY ("PLEC" VARCHAR2(1));
ALTER TABLE "PRACOWNICY" MODIFY ("NR_PESEL" varchar2(11))
;
/*dodanie kolumny do tabeli pracownicy*/ 
alter table pracownicy
   add "Stanowisko" varchar2(30)
;
/*tworzenie constraints do tabeli produkty*/
ALTER TABLE "PRODUKTY" MODIFY ("NAZWA_PRODUKTU" NOT NULL);
ALTER TABLE "PRODUKTY" MODIFY ("TYP_PRODUKTU" NOT NULL);
ALTER TABLE "PRODUKTY" ADD PRIMARY KEY ("ID")
;
/*zmiana nazwy kolumn w tabeli produkty*/
ALTER TABLE "PRODUKTY" RENAME COLUMN "CENA_ZAKUPU" TO "CENA_NETTO"; 
ALTER TABLE "PRODUKTY" RENAME COLUMN "CENA_SPRZEDAZY" TO "CENA_BRUTTO"
;
/*zmiana nazwy kolumn w tabeli faktury*/
ALTER TABLE "FAKTURY" RENAME COLUMN "NETTO" TO "CENA_NETTO"; 
ALTER TABLE "FAKTURY" RENAME COLUMN "BRUTTO" TO "CENA_BRUTTO";
ALTER TABLE "FAKTURY" RENAME COLUMN "PODATEK" TO "STAWKA_PODATKU"
;
/*dodanie 2 kolumn do tabeli faktury*/
alter table faktury
   add "NAZWA_KLIENTA" varchar2(30);
alter table faktury
   add "NR_ZAMOWIENIA" VARCHAR2(100)
;
/*zmiana nazwy kolumnY w tabeli przewoznik*/
ALTER TABLE "PRZEWOZNIK" RENAME COLUMN "KLIENT" TO "NAZWA_KLIENTA"
; 
/*usuniecie kolumny jm z tabeli produkty*/
alter table "PRODUKTY" drop column "JM"
;
/*tworzenie constraints do tabeli rodzaje_srodkow_transportu*/
ALTER TABLE "RODZAJE_SRODKOW_TRANSPORTU" MODIFY ("NAZWA" NOT NULL);
ALTER TABLE "RODZAJE_SRODKOW_TRANSPORTU" MODIFY ("KOD_RODZAJU_SRODKA_TRANSPORTU" NOT NULL);
ALTER TABLE "RODZAJE_SRODKOW_TRANSPORTU" MODIFY ("RODZAJ_AUTA" NOT NULL);
ALTER TABLE "RODZAJE_SRODKOW_TRANSPORTU" ADD PRIMARY KEY ("ID")
;
/*tworzenie constraints do tabeli dzial_zamowien*/
ALTER TABLE "DZIAL_ZAMOWIEN" ADD CONSTRAINT ID_PK PRIMARY KEY ("ID")
;
/*wstawanie 7 rekordow do tabeli dzial_sprzedazy*/
Insert into LOGISTYKA.DZIAL_SPRZEDAZY (ID,NR_ZAMOWIENIA,NAZWA_SPRZETU,ILOSC,WAGA,NAZWA_KLIENTA,ADRES_DOSTAWY,DATA_DOSTAWY,GODZINA_DOSTAWY) values ('1','wz1','pralka','12','3600','Euronet','ul. 1 Maja 6 02-345 Warszawa',to_date ('20/07/24','RR/MM/DD'),null);
Insert into LOGISTYKA.DZIAL_SPRZEDAZY (ID,NR_ZAMOWIENIA,NAZWA_SPRZETU,ILOSC,WAGA,NAZWA_KLIENTA,ADRES_DOSTAWY,DATA_DOSTAWY,GODZINA_DOSTAWY) values ('2','wz2','kuchenka','4','1200','Media Markt','ul. Krucza 15  01-350 Warszawa', to_date ('20/07/22','RR/MM/DD'),null);
Insert into LOGISTYKA.DZIAL_SPRZEDAZY (ID,NR_ZAMOWIENIA,NAZWA_SPRZETU,ILOSC,WAGA,NAZWA_KLIENTA,ADRES_DOSTAWY,DATA_DOSTAWY,GODZINA_DOSTAWY) values ('3','wz3','zmywarka','10','500','Neonet','ul. Mroczna 44 45-573 Wroclaw', to_date ('20/07/29','RR/MM/DD'),null);
Insert into LOGISTYKA.DZIAL_SPRZEDAZY (ID,NR_ZAMOWIENIA,NAZWA_SPRZETU,ILOSC,WAGA,NAZWA_KLIENTA,ADRES_DOSTAWY,DATA_DOSTAWY,GODZINA_DOSTAWY) values ('4','wz4','okap','2','20','Studia kuchenne Ela','ul. Radosna 56 07-635 Poznan', to_date ('20/08/04','RR/MM/DD'),null);
Insert into LOGISTYKA.DZIAL_SPRZEDAZY (ID,NR_ZAMOWIENIA,NAZWA_SPRZETU,ILOSC,WAGA,NAZWA_KLIENTA,ADRES_DOSTAWY,DATA_DOSTAWY,GODZINA_DOSTAWY) values ('5','wz5','chlodziarka','5','60','Galicja','ul. Jedwabna 89 04-789 Lublin', to_date ('22/08/10','RR/MM/DD'),null);
Insert into LOGISTYKA.DZIAL_SPRZEDAZY (ID,NR_ZAMOWIENIA,NAZWA_SPRZETU,ILOSC,WAGA,NAZWA_KLIENTA,ADRES_DOSTAWY,DATA_DOSTAWY,GODZINA_DOSTAWY) values ('6','wz6','plyta gazowa','20','400','Tajmax','ul. Smocza 176 30-022 Krakow', to_date ('20/07/18','RR/MM/DD'),null);
Insert into LOGISTYKA.DZIAL_SPRZEDAZY (ID,NR_ZAMOWIENIA,NAZWA_SPRZETU,ILOSC,WAGA,NAZWA_KLIENTA,ADRES_DOSTAWY,DATA_DOSTAWY,GODZINA_DOSTAWY) values ('7','wz7','piekarnik','8','260','Media Expert','ul. Prosta 56 90-031 Lodz', to_date ('20/07/30','RR/MM/DD'),null)
;
--zatwierdzenie polecenia insert
			commit;
/*wstawanie  3 rekordow do tabeli dzial_sprzedazy*/
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK) values ('1','wz1','Euronet','pralka top','60','Radomsko',null);
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK) values ('2','wz2','Media_Expert','pralka top','60','Radomsko',null);
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK) values ('3','wz3','Media_Markt','kuchnia','50','Lizbona',null)
;
--zatwierdzenie polecenia insert
			commit;
            
/*usuniecie 3 linii w tabeli dzial_zamowien*/
delete from dzial_zamowien
     where id<=3;   
            
/*dodanie kolumny osoba_wprowadzajaca_zamowienie_do_systemu do tabeli dzial_zamowien */
alter table dzial_zamowien
        add  osoba_wprowadzajaca_zamowienie_do_systemu varchar2 (40)
        ;
/*wstawienie  7 rekordow do tabeli dzial_sprzedazy*/
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK, OSOBA_WPROWADZAJACA_ZAMOWIENIE_DO_SYSTEMU) values ('1','wz1','Euronet','pralka top','300','Radomsko',null, null);
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK,OSOBA_WPROWADZAJACA_ZAMOWIENIE_DO_SYSTEMU) values ('2','wz2','Media_Markt','kuchenka','300','Lipsko',null, null);
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK,OSOBA_WPROWADZAJACA_ZAMOWIENIE_DO_SYSTEMU) values ('3','wz3','Neonet','zmywarka','50','Lizbona',null, null);
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK,OSOBA_WPROWADZAJACA_ZAMOWIENIE_DO_SYSTEMU) values ('4','wz4', 'Studia kuchenne Ela', 'okap', '10', 'Lodz', null, null);
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK,OSOBA_WPROWADZAJACA_ZAMOWIENIE_DO_SYSTEMU) values ('5', 'wz5', 'Galicja','chlodziarka','70', 'Wroclaw', null,null); 
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK,OSOBA_WPROWADZAJACA_ZAMOWIENIE_DO_SYSTEMU) values ('6','wz6','Tajmax', 'plyta_gazowa', '20','Lodz',null,null);
Insert into LOGISTYKA.DZIAL_ZAMOWIEN (ID,NR_ZAMOWIENIA,NAZWA_KLIENTA,NAZWA_SPRZETU,WAGA_SPRZETU,NAZWA_FABRYKI,LICZBA_SZTUK,OSOBA_WPROWADZAJACA_ZAMOWIENIE_DO_SYSTEMU) values ('7','wz7','Media Expert','piekarnik', '32.5','Lipsko', null, null)
;
--zatwierdzenie polecenia insert
			commit;            
 /*zmiana wagi sprzetu w tabeli dzial zamowien*/
   update dzial_zamowien
   set waga_sprzetu = 65
   where id=1
 ;
update dzial_zamowien
    set waga_sprzetu = 40
    where id=2
    ;   
 /*zmiana wagi sprzetu w tabeli dzial sprzedazy*/
 update dzial_sprzedazy
   set waga=780
   where id=1;
update dzial_sprzedazy
   set waga=160
   where id=2;
update dzial_sprzedazy
   set waga=350
   where id=5
;
/*wstawianie  1 rekordu do tabeli magazyn*/
Insert into LOGISTYKA.MAGAZYN (ID,NUMER_RAMPY,NOWY_SPRZET,PRZEPAKOWANY_SPRZET,USZKODZONY_SPRZET) values ('1','1','tak','nie','nie')
;
/*usuniecie danych z tabeli magazyn*/
delete from magazyn
;
/*dodanie 2 kolumn do tabeli magazyn*/
alter table magazyn
   add nazwa_sprzetu varchar2(30)
;
alter table magazyn
   add brak_na_stanie char (3) check (brak_na_stanie in ('tak','nie'))
;
/*wstawianie rekordow do tabeli magazyn*/
Insert into LOGISTYKA.MAGAZYN (ID,NUMER_RAMPY,NOWY_SPRZET,PRZEPAKOWANY_SPRZET,USZKODZONY_SPRZET, NAZWA_SPRZETU,BRAK_NA_STANIE) values ('1','1','tak','nie','nie','pralka_60','nie');
Insert into LOGISTYKA.MAGAZYN (ID,NUMER_RAMPY,NOWY_SPRZET,PRZEPAKOWANY_SPRZET,USZKODZONY_SPRZET, NAZWA_SPRZETU,BRAK_NA_STANIE) values (2,2,'tak','nie','nie','kuchenka', 'nie');
/*dodanie kolumny do tabeli magazyn*/
alter table magazyn
add ilosc number;

--zatwierdzenie polecenia insert
			commit;
 /*dodanie 2 kolumn do tabeli pracownicy*/
 alter table pracownicy
 add column opiekun_firmy varchar2 (30);
    pensja number;
 /*wstawanie rekordow do tabeli pracownicy*/   
 insert into pracownicy (id, imie, nazwisko, nr_pesel, plec, stanowisko) values (1, 'Renata', 'Bak',88012285918, 'M', 'Kierownik')
 insert into 'Bartosz','Karmel','58031245679','M',to_date('58/03/12','RR/MM/DD'),'5120'
--zatwierdzenie polecenia insert
			commit;
            
/*wstawanie  rekordow do tabeli */

Insert into LOGISTYKA.PRZEWOZNIK (ID,RODZAJ_AUTA,WAGA,ZALADUNEK,ROZLADUNEK,NAZWA_PRODUKTU,MAGAZYN,KLIENT) values ('1','van','200','tak','nie','pralka','nie',null);
--zatwierdzenie polecenia insert
			commit;
/*wstawanie  rekordow do tabeli */
Insert into LOGISTYKA.SUPPLY_CHAIN (ID,NAZWA_OPIEKUNA,NAZWA_FABRYKI,NAZWA_MAGAZYNU,NAZWA_SPRZETU,ILOSC,DATA_DOSTAWY_DO_MAGAZYNU) values ('1',null,'Radomsko','Pruszkow','pralka','10',to_date('20/07/05','RR/MM/DD'));
--zatwierdzenie polecenia insert
			commit;


/*zmiana typu danych w tabeli dzial zamowien*/
alter table dzial_zamowien
modify liczba_sztuk number
;
/*uzupelnienie 7 rekordow w tabeli dzial_zamowien*/
update dzial_zamowien
set liczba_sztuk =12
where id =1
;
update dzial_zamowien
set liczba_sztuk =4
where id =2
;
update dzial_zamowien
set liczba_sztuk =10
where id =3
;
update dzial_zamowien
set liczba_sztuk =2
where id =4
;
update dzial_zamowien
set liczba_sztuk =5
where id =5
;
update dzial_zamowien
set liczba_sztuk =20
where id =6
;
update dzial_zamowien
set liczba_sztuk =8
where id =7
;

/*posortowanie danych malejaco w tabeli dzial_zamowien*/
select nazwa_klienta, nazwa_sprzetu,liczba_sztuk
from dzial_zamowien
order by liczba_sztuk desc
;
/*pokazanie, ktora firma kupila najwiecej sztuk i ile*/
select liczba_sztuk, nazwa_klienta
from (
    select liczba_sztuk, nazwa_klienta
    from dzial_zamowien
    order by liczba_sztuk desc 
)
where rownum =1;

/*wybranie klienta ktory zamowil najwiêksza liczbe sztuk*/
select max(liczba_sztuk), nazwa_klienta
from dzial_zamowien
group by nazwa_klienta
having max(liczba_sztuk) = (
    select max(liczba_sztuk) 
    from dzial_zamowien
)

/*wybranie sztuk tam, gdzie jes srednia liczba_sztuk*/
select liczba_sztuk, nazwa_klienta
from dzial_zamowien
where liczba_sztuk > (
    select avg(liczba_sztuk) 
    from dzial_zamowien
);



select *
from dzial_zamowien;


/*wyliczenie sumy wszystkich sztuk w tabeli dzial_zamowien*/
select sum(liczba_sztuk)
    from dzial_zamowien
    ;
/*zrobiennie joina */
select nazwa_klienta, nr_zamowienia,nazwa_sprzetu,waga_sprzetu, waga, liczba_sztuk
from dzial_sprzedazy
inner join dzial_zamowien on dzial_sprzedazy.nr_zamowienia=dzial_zamowien.nr_zamowienia;

