--- Professoren -----------------------------------
if object_id('Professoren') is not null -- Objekt löschen
  drop table Professoren				-- wenn vorhanden
go

create table Professoren
(
  PersNr int primary key,
  Name   varchar(50)  not null,
  Rang   varchar(5)   null,
  Raum   varchar(5)   null
)
go

select * from Professoren	-- Sollte zunächst leer sein

insert into Professoren select 2125,'Sokrates','C4',226
insert into Professoren(PersNr,Name,Rang,Raum)	-- Alternative Form des Einfügens
   values (2126,'Russel','C4',232)
insert into Professoren select 2127,'Kopernikus','C3',310
insert into Professoren select 2133,'Popper','C3',52
insert into Professoren select 2134,'Augustinus','C3',309
insert into Professoren(PersNr,Name,Rang,Raum)
   values (2136,'Curie','C4',36)
insert into Professoren(PersNr,Name,Rang,Raum)
   values (2137,'Kent','C4',7)

--- Studenten -----------------------------------
if object_id('Studenten') is not null
  drop table Studenten
go

create table Studenten
(
  MatrNr     int primary key,
  Name       varchar(50),
  Semester   int
)
go

--- Vorlesungen -----------------------------------
if object_id('Vorlesungen') is not null
  drop table Vorlesungen
go

create table Vorlesungen
(
  VorlNr     int primary key,
  Titel      varchar(50),
  SWS        int,
  gelesenVon int
)
go

insert into Vorlesungen select 5001,'Grundzüge',4,2137
insert into Vorlesungen select 5041,'Ethik',4,2125
insert into Vorlesungen select 5043,'Erkenntnistheorie',3,2126
insert into Vorlesungen select 5049,'Mäeutik',2,2125
insert into Vorlesungen select 4052,'Logik',4,2125
insert into Vorlesungen select 5052,'Wissenschaftstheorie',3,2126
insert into Vorlesungen select 5216,'Bioethik',2,2126
insert into Vorlesungen select 5259,'Der Wiener Kreis',2,2133
insert into Vorlesungen select 5022,'Glaube und Wissen',2,2134
insert into Vorlesungen select 4630,'Die 3 Kriterien',4,2137
go

--- Assistenten -----------------------------------
if object_id('Assistenten') is not null
  drop table Assistenten
go

create table Assistenten
(
  PersNr     int,
  Name       varchar(50),
  Fachgebiet varchar(50),
  Boss       int
  
  primary key (PersNr)
)
go

--- voraussetzen -----------------------------------
if object_id('voraussetzen') is not null
  drop table voraussetzen
go

create table voraussetzen
(
  Vorgaenger int,
  Nachfolger int,
  
  primary key (Vorgaenger, Nachfolger)
)
go

--- hören -----------------------------------
if object_id('hören') is not null
  drop table hören
go

create table hören
(
  MatrNr int,
  VorlNr  int,
  
  primary key (MatrNr, VorlNr)
)
go

--- prüfen -----------------------------------
if object_id('prüfen') is not null
  drop table prüfen
go

create table prüfen
(
  MatrNr int,
  VorlNr int,
  PersNr int,
  Note   float,
  
  primary key (MatrNr, VorlNr, PersNr)
)
go

--- Daten einfügen --------------------------------
insert into Studenten select 24002,'Xenokrates',18
insert into Studenten select 25403,'Jones',12
insert into Studenten select 26120,'Fichte',10
insert into Studenten select 26830,'Aristoxenos',8
insert into Studenten select 27550,'Schopenhauer',6
insert into Studenten select 28106,'Carnap',3
insert into Studenten select 29120,'Theophrastos',2
insert into Studenten select 29555,'Feuerbach',2


insert into voraussetzen select 5001,5041
insert into voraussetzen select 5001,5043
insert into voraussetzen select 5001,5049
insert into voraussetzen select 5041,5216
insert into voraussetzen select 5043,5052
insert into voraussetzen select 5041,5052
insert into voraussetzen select 5052,5259


insert into prüfen select 28106,5001,2126,1
insert into prüfen select 25403,5041,2125,2.3
insert into prüfen select 27550,4630,2137,2.7


insert into hören select 26120,5001
insert into hören select 27550,5001
insert into hören select 27550,4052
insert into hören select 28106,5041
insert into hören select 28106,5052
insert into hören select 28106,5216
insert into hören select 28106,5259
insert into hören select 29120,5001
insert into hören select 29120,5041
insert into hören select 29120,5049
insert into hören select 29555,5022
insert into hören select 25403,5022

insert into Assistenten select 3002,'Platon','Ideenlehre',2125
insert into Assistenten select 3003,'Aristoteles','Syllologik',2125
insert into Assistenten select 3004,'Wittgenstein','Sprechtheorie',2126
insert into Assistenten select 3005,'Rhetikus','Planetenbewegung',2127
insert into Assistenten select 3006,'Newton','Keplersche Gesetze',2127
insert into Assistenten select 3007,'Spinoza','Gott und Natur',2126		