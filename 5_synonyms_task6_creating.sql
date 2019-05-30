--Task6
-- Create a synonym for the Writers table
CREATE SYNONYM dbo.Authors FOR dbo.Writers
--Query the Writers table by using the synonym
SELECT WriterID, First_Name, Last_Name, Date_of_Birth, Date_of_Death, Gender, Place_of_Birth, Country 
FROM dbo.Authors

-- Create a synonym for the Films table
CREATE SYNONYM dbo.Movies FOR dbo.Films
--Query the Films table by using the synonym
SELECT The_Name_of_the_Film, Date_of_the_Premiere, Runtime, Director, KinoPoisk_Rating, IMDb_Rating 
FROM dbo.Movies
WHERE KinoPoisk_Rating > 8.0

-- Create a synonym for the DJs table
CREATE SYNONYM dbo.Disc_Jockeys FOR dbo.DJs
--Query the DJs table by using the synonym
SELECT Stage_Name, Genre, Label, Radio_Channel, Country, Position_in_Top100DJs_in_2019, Released_Tracks, Relesed_Albums, Number_of_Awards 
FROM dbo.Disc_Jockeys
WHERE Relesed_Albums > 10

-- Create a synonym for the The_most_profitable_Films view
CREATE SYNONYM The_most_commercial_Films FOR The_most_profitable_Films
--Query the The_most_profitable_Films view by using the synonym
SELECT * 
FROM The_most_commercial_Films