USE VK_module_2
GO

--Task4
--Create the first table
CREATE TABLE DJs(
	DJID INT PRIMARY KEY ,
	Stage_Name VARCHAR(50) UNIQUE,
	Genre VARCHAR(30),
	Label VARCHAR(30),
	Radio_Channel VARCHAR(50),
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(30) NOT NULL,
	Date_of_Birth DATE NOT NULL,
	Country VARCHAR(30),
	Position_in_Top100DJs_in_2019 VARCHAR(3),
	Released_Tracks INT,
	Relesed_Albums INT,
	Number_of_Awards INT,
	);

INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (1,'Armin van Buuren', 'Trance', 'Armada', 'ASOT', 'Armin Josef Jacobus Daniel ', 'Van Buuren', '12-25-1976', 'Netherlands', '4', 96, 6, 64)
INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (2,'Hardwell', 'House', 'Revealed', 'Hardwell on Air', 'Robbert ', 'Van de Corput', '01-07-1988', 'Netherlands', '3', 82, 9, 25)
INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (3,'Tiesto', 'House', 'Black Hole', ' Tiesto''s Club Life ', 'Tijs Michiel', 'Verwest', '01-17-1969', 'Indonesia', '6', 174, 11, 48)

GO

--Create the second table
CREATE TABLE Audit_DJs(
	DJID INT IDENTITY(1,1),
	Stage_Name VARCHAR(50) UNIQUE,
	Genre VARCHAR(30),
	Label VARCHAR(30),
	Radio_Channel VARCHAR(50),
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(30) NOT NULL,
	Date_of_Birth DATE NOT NULL,
	Country VARCHAR(30),
	Position_in_Top100DJs_in_2019 VARCHAR(3),
	Released_Tracks INT,
	Relesed_Albums INT,
	Number_of_Awards INT,
	Type_of_Operation VARCHAR(10),
	Date_of_Operation DATETIME NOT NULL Default GETDATE()
	);		

GO

--Create INSERT, DELETE, UPDATE TRIGGERS
--INSERT TRIGGER TR_DJsINSERT
CREATE TRIGGER TR_DJsINSERT 
ON DJs
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Audit_DJs (
		DJID ,
		Stage_Name ,
		Genre ,
		Label ,
		Radio_Channel ,
		First_Name ,
		Last_Name ,
		Date_of_Birth ,
		Country ,
		Position_in_Top100DJs_in_2019 ,
		Released_Tracks ,
		Relesed_Albums ,
		Number_of_Awards ,
		Type_of_Operation ,
		Date_of_Operation 
    )
    SELECT
   		DJID ,
		Stage_Name ,
		Genre ,
		Label ,
		Radio_Channel ,
		First_Name ,
		Last_Name ,
		Date_of_Birth ,
		Country ,
		Position_in_Top100DJs_in_2019 ,
		Released_Tracks ,
		Relesed_Albums ,
		Number_of_Awards ,
        'INS',
		GETDATE()

    FROM
        inserted i

END

GO

INSERT INTO DJs (DJID, Stage_Name, Genre, Label, Radio_Channel, First_Name, Last_Name, Date_of_Birth, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards)
			VALUES (4,'David Guetta', 'EDM', 'Big Beat', NULL, 'Pierre David', 'Guetta', '11-07-1967', 'France', '5', 125, 8, 36)
GO

SELECT * FROM 	DJs
SELECT * FROM 	Audit_DJs

GO


--DELETE TRIGGER TR_DJsDELETE

CREATE TRIGGER TR_DJsDELETE
ON DJs
AFTER DELETE 
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Audit_DJs(
        DJID ,
		Stage_Name ,
		Genre ,
		Label ,
		Radio_Channel ,
		First_Name ,
		Last_Name ,
		Date_of_Birth ,
		Country ,
		Position_in_Top100DJs_in_2019 ,
		Released_Tracks ,
		Relesed_Albums ,
		Number_of_Awards ,
		Type_of_Operation ,
		Date_of_Operation 
    )
    SELECT
   		DJID ,
		Stage_Name ,
		Genre ,
		Label ,
		Radio_Channel ,
		First_Name ,
		Last_Name ,
		Date_of_Birth ,
		Country ,
		Position_in_Top100DJs_in_2019 ,
		Released_Tracks ,
		Relesed_Albums ,
		Number_of_Awards ,
        'DEL',
		GETDATE()

	FROM deleted d

END
GO

DELETE FROM DJs
WHERE DJID = 3
go

SELECT * FROM 	DJs
SELECT * FROM 	Audit_DJs

GO


--UPDATE TRIGGER TR_DJsUPDATE

CREATE TRIGGER TR_DJsUPDATE
ON dbo.DJs
AFTER UPDATE 
AS
BEGIN

INSERT INTO dbo.Audit_DJs(
        DJID ,
		Stage_Name ,
		Genre ,
		Label ,
		Radio_Channel ,
		First_Name ,
		Last_Name ,
		Date_of_Birth ,
		Country ,
		Position_in_Top100DJs_in_2019 ,
		Released_Tracks ,
		Relesed_Albums ,
		Number_of_Awards ,
		Type_of_Operation ,
		Date_of_Operation 
    )
    SELECT
   		DJID ,
		Stage_Name ,
		Genre ,
		Label ,
		Radio_Channel ,
		First_Name ,
		Last_Name ,
		Date_of_Birth ,
		Country ,
		Position_in_Top100DJs_in_2019 ,
		Released_Tracks ,
		Relesed_Albums ,
		Number_of_Awards ,
        'UPD',
		GETDATE()

	FROM deleted d

END
GO

UPDATE DJs
SET Label = 'Armind'
WHERE DJID = 1;

SELECT * FROM 	DJs
SELECT * FROM 	Audit_DJs

GO
