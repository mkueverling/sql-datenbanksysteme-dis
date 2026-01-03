-- Beispiele zu Count

select * from Professoren
-- Zählt die vorhandenen Zeilen
select count(*) from Professoren
-- Zählt die Einträge, bei denen der Name von NULL verschieden ist
select count(Name) from Professoren

select count(Rang) from Professoren
-- Zählt die Anzahl der Unterschiedlichen von NULL verschiedenen Werte
select count(distinct Rang) from Professoren
select distinct Rang from Professoren

select count(*) 
	from Professoren
	where Rang='C4'

-- Ideen zum Order by
select Name, Rang
	from Professoren
	order by 2 desc, 1 asc  -- Sortiert nach zweiter Spalte, und dann nach 1ter Spalte

select Name, Rang
	from Professoren
	order by Rang desc, Name asc

-- GROUP BY
select 
		Rang,	-- Hier sind die Spalten nach denen gruppiert wird,
				-- diese MÜSSEN in der group by Klausel angegeben werden.
		count(*) as Anzahl	-- Hier wird innerhalb der Gruppe die Statistik erzeugt
	from Professoren
	group by Rang

-- Werden Vorlesungen von C4-Profs mehr gehört als die von C3-Profs?
-- Wir gehen schrittweise vor
-- 1. Tabelle mit Prof und Vorlesung und Anzahl der Hörer
select
		Professoren.Name,
		Vorlesungen.Titel,
		count(hören.MatrNr) as Anzahl
	from Professoren
		join Vorlesungen
			on Vorlesungen.gelesenVon=Professoren.PersNr
		join hören
			on hören.VorlNr=Vorlesungen.VorlNr
	group by Professoren.Name, Vorlesungen.Titel
	order by Professoren.Name, Vorlesungen.Titel

select
		Professoren.Name,
		Vorlesungen.Titel,
		hören.MatrNr
	from Professoren
		join Vorlesungen
			on Vorlesungen.gelesenVon=Professoren.PersNr
		join hören
			on hören.VorlNr=Vorlesungen.VorlNr
	order by Professoren.Name, Vorlesungen.Titel

select
		Professoren.Name,
		count(hören.MatrNr) as Anzahl
	from Professoren
		join Vorlesungen
			on Vorlesungen.gelesenVon=Professoren.PersNr
		join hören
			on hören.VorlNr=Vorlesungen.VorlNr
	group by Professoren.Name
	order by 2 desc

select
		Professoren.Name,
		Vorlesungen.Titel,
		hören.MatrNr
	from Professoren
		join Vorlesungen
			on Vorlesungen.gelesenVon=Professoren.PersNr
		join hören
			on hören.VorlNr=Vorlesungen.VorlNr
	order by Professoren.Name, Vorlesungen.Titel

-- Alias-Namen
-- Tabelle mit Name der Vorlesung und der daraus folgenden Vorlesung
select VV.Titel, VN.Titel
	from voraussetzen
		join Vorlesungen VV	-- Alias für die erste Verknüpfung
			on VV.VorlNr=voraussetzen.Vorgaenger
		join Vorlesungen VN -- Alias für die zweite Verknüpfung
			on VN.VorlNr=voraussetzen.Nachfolger


select
		P.Name,
		V.Titel,
		h.MatrNr
	from Professoren P
		join Vorlesungen V
			on V.gelesenVon=P.PersNr
		join hören h
			on h.VorlNr=V.VorlNr
	order by P.Name, V.Titel

-- Übungsaufgabe
-- Ermitteln Sie die Vorlesungen, in denen die am längsten studiereden Studenten drin sind
-- Verwenden Sie Alias-Namen beim join
-- 1. Ich brauche die Tabellen
-- Studenten,hören, Vorlesungen
-- 2. Ich verknüpfe diese Tabellen
-- join :-)
-- 3. Ich schaue mir die Daten zunächst 1x an
-- 4. Ergänzen der passenden Spalten, um das Ergebnis zu bekommen.
select top 1 with ties Studenten.Name, Studenten.Semester, Vorlesungen.Titel
	from Vorlesungen
		join hören
			on hören.VorlNr=Vorlesungen.VorlNr
		join Studenten
			on Studenten.MatrNr=hören.MatrNr
		order by Studenten.Semester desc
