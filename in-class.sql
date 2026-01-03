-- Skript vom 11.11.2025
/*

Tabelle1 left outer join Tabelle2

Am gebräuchlichsten : inner join
Danach, wenn es geht, den left join verwenden. Hierfür ggfs. Tabellen umsortieren

Ich möchte gerne alle Zahlen von 0-999 erzeugen in einer Tabelle
*/

-- Tabelle löschen wenn vorhanden
drop table if exists IDs
go
-- Tabelle erstellen
create table IDs (
	ID	int primary key
)
go

-- Daten einfügen... Zwei prinzipielle Wege

insert into IDs(ID)							-- Einfügen konkreter Einzeldaten
	values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)

	                                        -- Einfügen berechneter Daten
insert into IDs(ID)							-- Ich füge neue Daten in eine bestehende Tabelle ein
	select I1.ID*100+I2.ID*10+I3.ID as ID	-- Hier erstelle in aufgrund vorhandener Daten neue Daten
		from IDs I1
			cross join IDs I2
			cross join IDs I3
		where I1.ID*100+I2.ID*10+I3.ID
		  not in (select ID from IDs)		-- Lass Daten, die drin sind, weg

select * from IDs

-- Beispiel sonst: 
-- Wandele alle Lieferschein um in Rechnungen

-- Ich kann Daten entfernen
delete -- select *	-- Script-Idee: Hiermit kann ich kurz prüfen, was gelöscht wird
	from IDs
	where ID>900	-- Immer an die Where-Bedingung denken!
go
-- Ich kann Daten aktualisieren
update IDs set
	ID = ID+2000
	where ID=123	-- In der Regel hat ein Update eine Where Bedingung!
go

/*

Das CRUD-Prinzip

Für Daten           Für Objecte 
DML                 DDL
(Data Manipulation  (Data Definition Language)
Language) 

insert              create
		  select
update              alter
delete              drop
*/

-- Datenpflege

--- Professoren -----------------------------------
drop table if exists Professoren				-- wenn vorhanden
go

create table Professoren
(
  PersNr int          primary key,
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
   values (2136,'Curie','C4',36), 
          (2137,'Kent','C4',7)
insert into Professoren(PersNr,Name)
   values (2210,'Groß') 
insert into Professoren(PersNr)
   values (2211) 

update Professoren set Raum = null
update Professoren set Raum = '248'
update Professoren set PersNr=2210 where Name ='Popper'

update Professoren set
        Name = 'Kant'
    where Name='Kent'
--    where PersNr=2137 -- Alternativ


--- Views -------------------------------------

select * from Professoren
select * from Assistenten
go

create or alter view THPersonen
as
	select PersNr,Name from Professoren
	union	-- Verbindet Tabellen "vertikal"
	select PersNr,Name from Assistenten
go

select * from THPersonen	-- Lässt sich nutzen wie eine Tabelle
  order by Name

-- Update an "daunterliegenden" Tabellen schlagen im View durch
update Professoren set 
		Name='Klein' 
	where Name='Groß'
go

-- Weiterer View
create or alter view Hörer
as
	select S.MatrNr, S.Name, V.Titel as Vorlesung
		from Studenten S
			join hören h
				on h.MatrNr=S.MatrNr
			join Vorlesungen V
				on V.VorlNr=h.VorlNr
go

select * from Hörer