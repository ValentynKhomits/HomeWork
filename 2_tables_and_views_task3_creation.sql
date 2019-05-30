USE VK_module_2
GO

--Task 3
--Create the first table with writters whose works have been filmed
CREATE TABLE Writers(
	WriterID INT PRIMARY KEY ,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(30) NOT NULL UNIQUE,
	Date_of_Birth DATE NOT NULL,
	Date_of_Death DATE,
	Gender VARCHAR(6) NOT NULL,
	Place_of_Birth VARCHAR(30),
	Country VARCHAR(30),
	Written_Works INT,
	Copies_Sold BIGINT,
	Filmes_Made INT CHECK (Filmes_Made>0),
	Inserted_Date DATE,
	Updated_Date DATE
);

INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (1,'John Ronald Reuel', 'Tolkien', '01-03-1892', '09-02-1973', 'Male', 'Bloemfontein', 'South Africa', 26, 100000000, 6)
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (2,'Joanne', 'Rowling', '07-31-1965', NULL, 'Female', 'Yate', 'England', 22, 500000000, 9)
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (3,'Stephen', 'King', '07-21-1947', NULL, 'Male', 'Portland', 'USA', 132, 350000000, 53)
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (4,'Charles Michael', 'Palahniuk', '02-21-1962', NULL, 'Male', 'Pasco', 'USA', 39, 3000000, 5)
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (5,'Thomas', 'Harris', '04-11-1940', NULL, 'Male', 'Jackson', 'USA', 8, 1000000, 3)
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (6,'Mario Gianluigi', 'Puzo', '10-15-1920', '07-02-1999', 'Male', 'Manhattan', 'USA', 132, 50000000, 6)
INSERT INTO Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country, Written_Works, Copies_Sold, Filmes_Made)
			 VALUES (7,'Andrew', 'Hodges', '07-07-1949', NULL, 'Male', 'London', 'England', 5, 1000000, 1);

GO

-- Create view for the first table
CREATE VIEW Current_Writers AS
SELECT WriterID, First_Name, Last_Name, Date_of_Birth, Country, Written_Works
FROM Writers
WHERE Date_of_Death IS NULL;

GO
 
--Create view with check option
CREATE VIEW Male_Writers AS
SELECT WriterID, First_Name, Last_Name, Date_of_Birth, Gender, Country
FROM Writers
WHERE Gender = 'Male'
WITH CHECK OPTION

GO

--Trying to insert record
INSERT INTO Male_Writers (WriterID, First_Name, Last_Name, Date_of_Birth, Gender, Country)
		VALUES(8, 'Jane', 'Ausen', '12-16-1775', 'Female', 'England')

GO



--Create the second table with filmes made
CREATE TABLE Films(
	WriterID INT FOREIGN KEY REFERENCES Writers(WriterID) ,
	The_Name_of_the_Book VARCHAR(100) NOT NULL,
	The_Name_of_the_Film VARCHAR(100) NOT NULL,
	Date_of_the_Premiere DATE NOT NULL,
	Runtime INT,
	Director VARCHAR(50),
	Studio VARCHAR(50),
	Country VARCHAR(30),
	Budget INT,
	Box_Office BIGINT,
	KinoPoisk_Rating NUMERIC(2,1),
	IMDb_Rating NUMERIC(2,1),
	Inserted_Date DATE,
	Updated_Date DATE
);


INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (1, 'The lord of the rings', 'The Lord of the Rings: The Fellowship of the Ring', '12-10-2001', 178, 'Peter Jackson', 'New Line Cinema', 'New Zealand', 93000000, 871000000, 8.6, 8.8)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (1, 'The lord of the rings', 'The Lord of the Rings: The Two Towers', '12-12-2002', 179, 'Peter Jackson', 'New Line Cinema', 'New Zealand', 94000000, 926000000, 8.5, 8.8)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (1, 'The lord of the rings', 'The Lord of the Rings: The Return of the King', '12-17-2003', 200, 'Peter Jackson', 'New Line Cinema', 'New Zealand', 94000000, 1120000000, 8.6, 8.9)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (1, 'The Hobbit', 'The Hobbit: An Unexpected Journey', '12-14-2012', 169, 'Peter Jackson', 'New Line Cinema', 'New Zealand', 315000000, 1021000000, 8.1, 7.9)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (1, 'The Hobbit', 'The Hobbit: The Desolation of Smaug', '12-13-2013', 161, 'Peter Jackson', 'New Line Cinema', 'New Zealand', 217000000, 958000000, 8.0, 7.8)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (1, 'The Hobbit', 'The Hobbit: The Battle of the Five Armies', '12-17-2014', 144, 'Peter Jackson', 'New Line Cinema', 'New Zealand', 250000000, 956000000, 7.8, 7.4)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Philosopher''s Stone', '11-16-2001', 152, 'Chris Columbus', 'Warner Bros. Pictures', 'United Kingdom', 125000000, 975000000, 8.2, 7.6)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Chamber of Secrets', '11-15-2002', 161, 'Chris Columbus', 'Warner Bros. Pictures', 'United Kingdom', 100000000, 879000000, 8.0, 7.4)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Prisoner of Azkaban', '06-04-2004', 142, 'Alfonso Cuaron', 'Warner Bros. Pictures', 'United Kingdom', 130000000, 797000000, 8.1, 7.9)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Goblet of Fire', '11-18-2005', 157, 'Mike Newell', 'Warner Bros. Pictures', 'United Kingdom', 150000000, 897000000, 7.9, 7.7)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Order of the Phoenix', '07-12-2007', 138, 'David Yates', 'Warner Bros. Pictures', 'United Kingdom', 250000000, 956000000, 7.7, 7.5)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Half-Blood Prince', '07-15-2009', 153, 'David Yates', 'Warner Bros. Pictures', 'United Kingdom', 250000000, 934500000, 7.7, 7.6)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Deathly Hallows - Part 1', '11-19-2010', 146, 'David Yates', 'Warner Bros. Pictures', 'United Kingdom', 250000000, 960400000, 7.8, 7.7)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (2, 'Harry Potter', 'Harry Potter and the Deathly Hallows - Part 2', '07-15-2011', 130, 'David Yates', 'Warner Bros. Pictures', 'United Kingdom', 250000000, 1342000000, 8.1, 8.1)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (3, 'It', 'It', '09-05-2017', 135, 'Andy Muschietti', 'Warner Bros. Pictures', 'USA', 3500000, 700400000, 7.3, 7.4)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (3, 'The Shining', 'The Shining', '05-23-1980', 146, 'Stanley Kubrick', 'Warner Bros. Pictures', 'USA', 1900000, 44400000, 7.8, 8.4)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (3, 'The Shawshank Redemption', 'The Shawshank Redemption', '09-23-1994', 142, 'Frank Darabont', 'Columbia Pictures', 'USA', 2500000, 58300000, 9.1, 9.3)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (3, 'The Mist', 'The Mist', '11-21-2007', 126, 'Frank Darabont', 'Dimension Films', 'USA', 18000000, 57300000, 7.6, 7.2)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (3, 'Misery', 'Misery', '12-30-1990', 107, 'Rob Reiner', 'Columbia Pictures', 'USA', 20000000, 61300000, 7.8, 7.8)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (4, 'Fight Club', 'Fight Club', '10-19-1999', 139, 'David Fincher', '20th Century Fox', 'USA', 63000000, 100900000, 8.6, 8.8)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (5, 'The Silence of the Lambs', 'The Silence of the Lambs', '02-14-1991', 118, 'Jonathan Demme', 'Orion Pictures', 'USA', 19000000, 272700000, 8.3, 8.6)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (6, 'The Godfather', 'The Godfather Part 1', '03-24-1972', 177, 'Francis Ford Coppola', 'Paramount Pictures', 'USA', 6500000, 286000000, 8.7, 9.2)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (6, 'The Godfather', 'The Godfather Part 2', '12-12-1974', 200, 'Francis Ford Coppola', 'Paramount Pictures', 'USA', 13000000, 57300000, 8.5, 9.0)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (6, 'The Godfather', 'The Godfather Part 3', '12-25-1990', 162, 'Francis Ford Coppola', 'Paramount Pictures', 'USA', 54000000, 136800000, 8.0, 7.6)
INSERT INTO Films (WriterID, The_Name_of_the_Book, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, Studio, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating)
			VALUES (7, 'Alan Turing: The Enigma', 'The Imitation Game', '11-28-2014', 114, 'Morten Tyldum', 'Black Bear Pictures', 'USA', 14000000, 233600000, 7.6, 8.0);

GO


--Create trigger for the second table
CREATE TRIGGER TR_FilmsUPDATE
ON Films
AFTER UPDATE 
AS
BEGIN

INSERT INTO Films(
		WriterID,
		The_Name_of_the_Book,
		The_Name_of_the_Film,
		Date_of_the_Premiere,
		Runtime,
		Director,
		Studio,
		Country,
		Budget,
		Box_Office,
		KinoPoisk_Rating,
		IMDb_Rating,
		Inserted_Date,
		Updated_Date
	)
    SELECT
		WriterID,
		The_Name_of_the_Book,
		The_Name_of_the_Film,
		Date_of_the_Premiere,
		Runtime,
		Director,
		Studio,
		Country,
		Budget,
		Box_Office,
		KinoPoisk_Rating,
		IMDb_Rating,
		Inserted_Date,
  		GETDATE()

	FROM deleted d

END
GO


--Create view for the second table
CREATE VIEW The_most_profitable_Films 
AS
SELECT WriterID, The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Country, Budget, Box_Office, KinoPoisk_Rating, IMDb_Rating
FROM Films
WHERE Box_Office > 1000000000;

GO
