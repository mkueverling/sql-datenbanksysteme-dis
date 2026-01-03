
-- A Tabelle Vorlesungen 
-- 1. Geben Sie alle Titel aufsteigend sortiert aus.
select Titel
	from Vorlesungen
	order by Titel
-- 2. Wie lautet der Titel der Vorlesung Nr. 5001? 
select Titel
	from Vorlesungen
	where VorlNr=5001
-- !3. Wie viele Vorlesungen gibt es?
select count(Titel) as AnzahlVorlesungen
    from Vorlesungen
select AnzahlVorlesungen=count(Titel)
    from Vorlesungen

-- 4. Welche Vorlesungen haben genau 4 SWS? 
select Titel 
	from Vorlesungen
	where SWS=4
-- 5. Welche Vorlesungen haben im Titel das Wort "Wissen"?
select *
	from Vorlesungen
	where Titel like '%wissen%'
-- Die Platzhalter bei like
-- _ genau ein Zeichen
-- % kein oder mehrere Zeichen
-- [abcd] Es muss ein a,b, c oder d sein
-- [0123456789] , [0-9]  Positive Selektion von Zeichen
-- [^abcd] Negativ Selektion von Zeichen
-- Alle Vorlesungen wo ein Konsonat im Titel auftritt
select Titel 
	from Vorlesungen
	where Titel like '%[^aeiou]%'
-- 6. Geben Sie alle Vorlesungen mit 10-ner Stelle 5 aus.
select Titel 
	from Vorlesungen
	where VorlNr like '%5_'
--	where (VorlNr/10)%10=5 Die Alternative für Mathe-Fans

-- !7. Geben Sie Vorlesungen sortiert nach der Länge des Titels aus.
select Titel 
	from Vorlesungen
	order by len(Titel) asc
-- asc für ascending = Aufsteigend, kann wegfallen, da es der Standard ist.

-- 8. Welche Vorlesungsbezeichnungen bestehen aus genau einem Wort?
-- Alle Vorlesungen aus einem Wort
select Titel 
	from Vorlesungen
	where Titel not like '% %'
-- 9. Geben Sie die 3 Vorlesungen mit den größten Nummern aus. 
select top 3 VorlNr, Titel 
	from Vorlesungen
	order by VorlNr desc
   
-- B Tabelle Professoren 
-- 1. Erzeugen Sie die Liste aller Professoren (Name, PersNr), alphabetisch sortiert.
select Name, PersNr
	from Professoren
	order by Name
-- 2. Geben Sie alle Namen der Professoren vom Rang C3 aus.
select Name
	from Professoren
	where Rang='C3'
-- 3. Welche Professoren haben ihre Personalnummer im Bereich 2130 – 2150? 
select Name
	from Professoren
	where PersNr between 2130 and 2150;
-- 4. Welche Professoren haben in ihrem Namen "s" oder "pp"? 
select Name
	from Professoren
	where Name like '%s%' or Name like '%pp%'
-- 5. Erzeugen Sie die Liste aller Professoren (Name, Rang), 
--    nach Rang absteigend und alphabetisch aufsteigend sortiert.
select Name, Rang
	from Professoren
	order by Rang desc, Name asc
-- !6. Wie viele Professoren sind bei uns tätig?
select count(Name)
	from Professoren
-- !7. Geben Sie den Raum des Professors mit dem kürzesten Namen aus.
select top 1 Raum  
	from Professoren
	order by len(Name) asc

-- C Tabelle Studenten 
-- !1. Listen Sie alle Studierenden auf, nach Semster "gruppiert" 
--  und innerhalb des Semesters alphabetisch sortiert!
select * 
	from Studenten
	order by Semester, Name

-- 2. Wer hat die Matrikelnummer 26830? 
select Name	
	from Studenten
	where MatrNr=26830
-- 3. Wessen Name fängt mit T an im 2. Semester? 
select Name	
	from Studenten
	where Semester=2 and Name like 'T%'
-- 4. Wie viele Studierende gibt es mit "Sch" im Namen? 
select count(Name)
	from Studenten
	where Name like '%sch%'

-- !5. Wie viele studieren im 1., 3. und 5. Semester insgesamt? 
select count(Name) as AnzahlStudierende
	from Studenten
	where Semester in (1,3,5)
-- 6. Wer studiert im 10. Semester oder höher?
select Name
	from Studenten
	where Semester>=10
-- !7. Erzeugen Sie eine Liste mit den ersten 2 Buchstaben jedes Namens
select left(Name,2) as Ersten2Buchstaben
	from Studenten
-- !8. Geben Sie die Studierenden absteigend sortiert nach der Länge des Namens aus
select Name
	from Studenten
	order by len(Name) desc   
-- D Prüfen
-- !1. Ermitteln Sie die beste, schlechteste und die Durchschnittsnote
select top 1 Note
	from prüfen 
	order by Note asc
select 
		min(Note) as BesteNote, 
		max(Note) as SchlechtesteNote, 
		avg(Note) as Durchschnitt
	from prüfen 
select * from prüfen

insert into prüfen(MatrNr,VorlNr,PersNr,Note)
  values(27034,5001,2126,2.7)
