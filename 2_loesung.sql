-- Mehrere Tabellen abfragen
-- 1. Listen Sie alle Vorlesungen und die Namen der Professoren, die sie lesen, auf.
-- 2. Wie viele Professoren halten Vorlesungen?
select count(distinct P.Name)

select count(distinct P.PersNr) -- !!!! Besser als Name!
	from Professoren P
		join Vorlesungen V --- Join ist erforderlich, um die Eigenschaft Prof zu prüfen
			on P.PersNr=V.gelesenVon
select count(P.PersNr)
	from Professoren P
		join Vorlesungen V
			on P.PersNr=V.gelesenVon

select count(distinct V.gelesenVon)
	from Vorlesungen V
-- 3. Welche Professoren halten keine Vorlesungen?
select P.Name
	from Professoren P
	where P.PersNr 
		not in (select gelesenVon from Vorlesungen)

select P.Name, *
	from Vorlesungen V right join Professoren P
			on P.PersNr=V.gelesenVon
	where V.Titel is null
-- 4. Wie viele Vorlesungen liest der Professor mit der Personalnr. 2137
select count(*) 
	from Vorlesungen 
	where GelesenVon=2137
-- 5. Welche Vorlesungen hält Prof. Kant?
-- 6. Wie viele SWS hat Prof. Russel im Semester?
-- 7. Ermitteln Sie alle Professoren mit einer SWS>2 
-- 8. Welche Assistenten hat Prof. Sokrates?
-- 9. Wie viele Assistenten hat Prof. Kopernikus?
-- 10. Welche Vorlesungen (VorlNr) hat Zuhörer?
-- 11. Bei wem hatte Frau Carnap ihre Prüfung mit Note 1?

-- 12. Welche Note hat Frau Carnap in der Vorlesung Grundzüge?
/* Vorgehensweise
1. Welche Tabellen benötige ich?
	Vorlesungen
	Studenten
	prüfen
2. Sinnvolle Reihenfolge der Tabellen bilden
	a. prüfen, weil da die Note herkommt
	b. Studenten
	c. Vorlesung
3. NAch dem Grundgerüst von vorne nach hinten die Aufgabe abarbeiten!
	a. Ausgabe
	b Filter setzen
*/
-- Die Ausgabe
select PR.Note 
---Die Datenquelle (alle Daten)
	from prüfen PR
	    join Studenten S
			on S.MatrNr=PR.MatrNr
		join Vorlesungen V
			on V.VorlNr=PR.VorlNr
-- Der Filter
    where S.Name='Carnap'
	  and V.Titel='Grundzüge'

-- 12. Welche Note hat Herr Fichte in der Vorlesung Grundzüge?
select PR.Note 
---Die Datenquelle (alle Daten)
	from prüfen PR
	    join Studenten S
			on S.MatrNr=PR.MatrNr
		join Vorlesungen V
			on V.VorlNr=PR.VorlNr
-- Der Filter
    where S.Name='Fichte'
	  and V.Titel='Grundzüge'

-- 13. Ermitteln Sie die Voraussetzungen für alle Vorlesungen mit einem "th" im Titel
-- 14. Listen Sie die Voraussetzungen zu den Vorlesungen Erkenntnistheorie und Wissenschaftstheorie auf
-- Für später oder für die, die schon mal "group by" versuchen möchten!
-- 15. Wie viele Assistenten hat JEDER Prof?
select distinct P.Name from Professoren P 
select count(A.Name), P.Rang
-- select *
	from Assistenten A
		right join Professoren P
			on A.Boss=P.PersNr
    order by Rang
	group by p.Rang
-- 16. Ermitteln Sie die durchschnittliche Semesterzahl der Anwesenden je Vorlesung
-- 17. Ermitteln Sie die durchschnittliche Semesterzahl der Hörer je Professor

--== Beispiele für JOIN und create tanle

-- Test-Skript, welches Tabellen A und B anlegt
-- Erst löschen, wenn vorhanden, dann neu machen.
drop table if exists A
go
create table A (
	ID    int primary key, -- Hierdurch wird die ID eindeutig!
	Value varchar(5)
)
go

drop table if exists B
go
create table B (
	ID    int primary key,
	Value varchar(5)
)
go

insert into A(ID,Value) values (1,'A'), (2,'B'), (3,'C')
insert into B(ID,Value) values (1,'X'), (3,'Y')

select 'A',* from A
select 'B',* from B

select 'join',* 
	from A
		inner join B
			on A.ID=B.ID

select 'right',* 
	from A
		right outer join B
			on A.ID=B.ID

select 'left',* 
	from A
		left join B
			on A.ID=B.ID
select 'full',* 
	from A
		full join B
			on A.ID=B.ID
select 'cross',* 
	from A
		cross join B


-- insert
-- insert fügt NEUE DAten in eine TAbelle ein.

select * from Professoren

-- Bitte Herrn Groß rein in die Tabelle

insert into Professoren(PersNr,Name,Rang,Raum)
                values (2125,'Groß','C3',419)
