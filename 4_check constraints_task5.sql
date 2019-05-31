USE VK_module_2
GO

--Check Constraints in the Writers table
SELECT *
FROM Writers

--Trying to insert the record to check UNIQUE KEY Constraint
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (8,'Andrew', 'Rowling', '01-01-1990', NULL, 'Male', 'London', 'England', 10, 1000000, 1)
--Record wasnt inserted


--Trying to insert the record to check CHECK Constraint
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (8,'Franz', 'Kafka', '07-03-1883', '06-03-1924', 'Male', 'Prague', 'Czechia', 56, 100000000, 0)
--Record wasnt inserted


--Trying to insert the record to check PRIMARY KEY Constraint
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (7,'Charles John Huffam', 'Dickens', '02-07-1812', '06-09-1870', 'Male', 'Hampshire', 'England', 43, 150000000, 5)
--Record wasnt inserted


--Trying to insert correct record
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (8,'Charles John Huffam', 'Dickens', '02-07-1812', '06-09-1870', 'Male', 'Hampshire', 'England', 43, 150000000, 5)

SELECT *
FROM Writers
WHERE Last_Name = 'Dickens'
--Record was inserted


--Check Constraints in the Films table
SELECT *
FROM Films

--Trying to insert the record to check NOT NULL Constraint
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (8, 'The Girl with the Dragon Tattoo', NULL, '12-20-2011', 158, 'David Fincher', 'New Line Cinema', 'Sweden', 90000000, 232600000, 7.7, 7.8)
--Record wasnt inserted

--Trying to insert correct record
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (8, 'The Girl with the Dragon Tattoo', 'The Girl with the Dragon Tattoo', '12-20-2011', 158, 'David Fincher', 'New Line Cinema', 'Sweden', 90000000, 232600000, 7.7, 7.8)

SELECT *
FROM Films
WHERE The_Name_of_the_Book = 'The Girl with the Dragon Tattoo'
--Record was inserted

--Check Constraints in the DJs table
SELECT *
FROM DJs

--Trying to insert the record to check UNIQUE KEY Constraint
INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (4,'ATB', 'Trance', 'Armada', 'Ecstasy', 'Andre', 'Tanneberger', '02-26-1973', 'Germany', '49', 57, 9, 25)
--Record wasnt inserted

--Trying to insert the record to check PRIMARY KEY Constraint
INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (3,'ATB', 'Trance', 'Kontor Records', 'Ecstasy', 'Andre', 'Tanneberger', '02-26-1973', 'Germany', '49', 57, 9, 25)
--Record wasnt inserted

--Trying to insert the record to check NOT NULL Constraint
INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (4,'ATB', 'Trance', 'Kontor Records', 'Ecstasy', NULL, 'Tanneberger', '02-26-1973', 'Germany', '49', 57, 9, 25)
--Record wasnt inserted

--Trying to insert correct record
INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (4,'ATB', 'Trance', 'Kontor Records', 'Ecstasy', 'Andre', 'Tanneberger', '02-26-1973', 'Germany', '49', 57, 9, 25)

SELECT *
FROM DJs
WHERE Stage_Name = 'ATB'
--Record was inserted
