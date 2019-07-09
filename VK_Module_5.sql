CREATE DATABASE VK_module_5
GO

USE VK_module_5
GO


DROP TABLE IF EXISTS suppliers
GO

CREATE TABLE suppliers(
	supplierid INT PRIMARY KEY,
	name VARCHAR(20),
	rating INT,
	city VARCHAR(20)
);

INSERT INTO suppliers
		(supplierid,
		name,
		rating,
		city)
	VALUES
		(1, 'Smith', 20, 'London'),
		(2, 'Jonth', 10, 'Paris'),
		(3, 'Blacke', 30, 'Paris'),
		(4, 'Clarck', 20, 'London'),
		(5, 'Adams', 30, 'Athens')

GO


DROP TABLE IF EXISTS details
GO

CREATE TABLE details(
	detailid INT PRIMARY KEY,
	name VARCHAR(20),
	color VARCHAR(20),
	weight INT,
	city VARCHAR(20)
);

INSERT INTO details
		(detailid,
		name,
		color,
		weight,
		city)
	VALUES
		(1, 'Screw', 'Red', 12, 'London'),
		(2, 'Bolt', 'Green', 17, 'Paris'),
		(3, 'Male-screw', 'Blue', 17, 'Roma'),
		(4, 'Male-screw', 'Red', 14, 'London'),
		(5, 'Wheel', 'Blue', 12, 'Paris'),
		(6, 'Bloom', 'Red', 19, 'London')

GO


DROP TABLE IF EXISTS products
GO

CREATE TABLE products(
	productid INT PRIMARY KEY,
	name VARCHAR(20),
	city VARCHAR(20)
);

INSERT INTO products
		(productid,
		name,
		city)
	VALUES
		(1, 'HDD', 'Paris'),
		(2, 'Perforator', 'Roma'),
		(3, 'Reader', 'Athens'),
		(4, 'Printer', 'Athens'),
		(5, 'FDD', 'London'),
		(6, 'Terminal', 'Oslo'),
		(7, 'Ribbon', 'London')

GO


DROP TABLE IF EXISTS supplies
GO

CREATE TABLE supplies(
	supplierid INT,
	detailid INT,
	productid INT,
	quantity INT,
	CONSTRAINT supplier_id FOREIGN KEY (supplierid) 
    REFERENCES suppliers(supplierid),
	CONSTRAINT detail_id FOREIGN KEY (detailid)
    REFERENCES details(detailid),
	CONSTRAINT product_id FOREIGN KEY (productid) 
    REFERENCES products(productid)
	);

INSERT INTO supplies
		(supplierid,
		detailid,
		productid,
		quantity)
	VALUES
		(1, 1, 1, 200),
		(1, 1, 4, 700),
		(2, 3, 1, 400),
		(2, 3, 2, 200),
		(2, 3, 3, 200),
		(2, 3, 4, 500),
		(2, 3, 5, 600),
		(2, 3, 6, 400),
		(2, 3, 7, 800),
		(2, 5, 2, 100),
		(3, 3, 1, 200),
		(3, 4, 2, 500),
		(4, 6, 3, 300),
		(4, 6, 7, 300),
		(5, 2, 2, 200),
		(5, 2, 4, 100),
		(5, 5, 5, 500),
		(5, 5, 7, 100),
		(5, 6, 2, 200),
		(5, 1, 4, 100),
		(5, 3, 4, 200),
		(5, 4, 4, 800),
		(5, 5, 4, 400),
		(5, 6, 4, 500);

		--------------------------------------------------------------------------------------------------------------------------------------------
		select * from suppliers
		select * from details
		select * from products
		select * from supplies

--1. Написати запити з використанням під-запитів:
--1a. Отримати номери виробів, для яких всі деталі постачає постачальник 3
select s.detailid
from supplies AS s
where s.supplierid = 3

--1b. Отримати номера і прізвища постачальників, які постачають деталі для якого-небудь виробу з деталлю 1 в кількості більшій,
-- ніж середній об’єм поставок деталі 1 для цього виробу
SELECT sr.supplierid
		,sr.name
FROM suppliers AS sr
WHERE sr.supplierid IN (SELECT DISTINCT s.supplierid 
						FROM supplies AS s
						WHERE s.detailid = 1 AND s.quantity > (SELECT AVG(quantity) 
																FROM supplies AS s
																WHERE s.detailid = 1));

--1c. Отримати повний список деталей для всіх виробів, які виготовляються в Лондоні
SELECT * 
FROM details AS d
WHERE d.detailid IN (
		SELECT DISTINCT s.detailid 
		FROM supplies AS s
		WHERE s.productid IN ( 
				SELECT p.productid 
				FROM products AS p
				WHERE p.city = 'London'))

--1d. Показати номери і назви постачальників, що постачають принаймні одну червону деталь
SELECT DISTINCT s.supplierid, s.name 
FROM suppliers as s
WHERE s.supplierid IN 
		(SELECT sp.supplierid
		FROM supplies as sp
		WHERE sp.detailid IN 
				(SELECT d.detailid
				FROM details as d
				WHERE d.color = 'Red'));

--1e. Показати номери деталей, які використовуються принаймні в одному виробі, який поставляється постачальником 2
SELECT DISTINCT sp.detailid
FROM supplies AS sp
WHERE sp.productid IN 
		(SELECT sp.productid
		FROM supplies AS sp
		WHERE sp.supplierid = 2)

--1f. Отримати номери виробів, для яких середній об’єм поставки деталей  більший за найбільший об’єм поставки будь-якої деталі для виробу 1
SELECT s.productid
	 ,AVG(s.quantity) AS average_quantity
FROM supplies AS s
GROUP BY s.productid
HAVING AVG(s.quantity) > (SELECT MAX(s.quantity)
						FROM supplies AS s
						WHERE s.productid = 1);

--1g. Вибрати вироби, що ніколи не постачались (під-запит)
SELECT p.* 
FROM products AS p
WHERE p.productid NOT IN (SELECT s.productid 
						FROM supplies AS s);

--2. Написати запити використовуючи CTE або Hierarchical queries:
--2.1 Написати довільний запит з двома СТЕ (в одному є звертання до іншого)
	;WITH cte1 AS
(
SELECT supplierid, SUM(quantity) AS total
 FROM supplies
 GROUP BY supplierid
 )

, cte2 AS 
(
SELECT supplierid, total
 FROM cte1
 WHERE total >3000
 )
 
 SELECT * 
 FROM cte2;

--2.2 Обчислити за допомогою рекурсивної CTE факторіал від 10 та вивести у форматі таблиці з колонками Position та Value
	;WITH Factorial (Position, Value) AS
(
SELECT 1, 1 
UNION ALL
SELECT Position + 1, (Position + 1) * Value
FROM Factorial
WHERE Position < 10
)

SELECT Position, Value
FROM Factorial
WHERE Position = 10;

--2.3 Обчислити за допомогою рекурсивної CTE перші 20 елементів ряду Фібоначчі та вивести у форматі таблиці з колонками Position та Value
	;WITH Fibonacci(Position, Value, Col3, Col4) AS
(
 SELECT Positionr = 1, Value=1, Col3 = 1, Col4 = 1 + 1
 UNION ALL
 SELECT Position + 1, Value = Col3, Col3b = Col4, Col4=Col3 + Col4
 FROM Fibonacci 
 WHERE Position < 20
)

SELECT Position, Value 
FROM Fibonacci;

--2.4 Розділити вхідний період 2013-11-25 до 2014-03-05 на періоди по календарним місяцям за допомогою рекурсивної CTE
--    та вивести у форматі таблиці з колонками StartDate та EndDate

--2.5 Розрахувати календар поточного місяця за допомогою рекурсивної CTE та вивести дні місяця у форматі таблиці з колонками 				
--    Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
SET DATEFIRST 1;
GO
;WITH CTE_Calendar AS
(
SELECT CAST('20190701' AS DATE) AS [Date]
UNION ALL
SELECT DATEADD(dd, 1, [Date])
FROM CTE_Calendar
WHERE DATEADD(dd, 1, [Date]) <= '20190731'
)
SELECT [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday], [Sunday] 
FROM (SELECT [DayDate] = DATEPART(dd,[Date])
			,[WeekDayName] = DATENAME(dw,[Date])
			,[WeekNumber] = DATEPART(week, [Date]) FROM CTE_Calendar
) AS ST
PIVOT
(
MIN([DayDate])
FOR [WeekDayName] IN ([Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday], [Sunday])
)
AS PivotCalendar;

--2.6 Створити таблицю  geography  та занести в неї дані 
DROP TABLE IF EXISTS geography
GO

CREATE TABLE [geography]
(
id int not null primary key, 
name varchar(20), 
region_id int
)
GO

ALTER TABLE [geography] ADD CONSTRAINT R_GB 
FOREIGN KEY (region_id) REFERENCES [geography] (id)
GO

insert into [geography] values (1, 'Ukraine', null);
insert into [geography] values (2, 'Lviv', 1);
insert into [geography] values (8, 'Brody', 2);
insert into [geography] values (18, 'Gayi', 8);
insert into [geography] values (9, 'Sambir', 2);
insert into [geography] values (17, 'St.Sambir', 9);
insert into [geography] values (10, 'Striy', 2);
insert into [geography] values (11, 'Drogobych', 2);
insert into [geography] values (15, 'Shidnytsja', 11);
insert into [geography] values (16, 'Truskavets', 11);
insert into [geography] values (12, 'Busk', 2);
insert into [geography] values (13, 'Olesko', 12);
insert into [geography] values (30, 'Lvivska st', 13);
insert into [geography] values (14, 'Verbljany', 12);
insert into [geography] values (3, 'Rivne', 1);
insert into [geography] values (19, 'Dubno', 3);
insert into [geography] values (31, 'Lvivska st', 19);
insert into [geography] values (20, 'Zdolbuniv', 3);
insert into [geography] values (4, 'Ivano-Frankivsk', 1);
insert into [geography] values (21, 'Galych', 4);
insert into [geography] values (32, 'Svobody st', 21);
insert into [geography] values (22, 'Kalush', 4);
insert into [geography] values (23, 'Dolyna', 4);
insert into [geography] values (5, 'Kiyv', 1);
insert into [geography] values (24, 'Boryspil', 5);
insert into [geography] values (25, 'Vasylkiv', 5);
insert into [geography] values (6, 'Sumy', 1);
insert into [geography] values (26, 'Shostka', 6);
insert into [geography] values (27, 'Trostjanets', 6);
insert into [geography] values (7, 'Crimea', 1);
insert into [geography] values (28, 'Yalta', 7);
insert into [geography] values (29, 'Sudack', 7);

GO

--2.7 Написати запит  який повертає регіони першого рівня 
	;WITH REGION_CTE AS 
(
SELECT g.region_id 
		,g.id AS place_ID
		,g.name 
		,1 AS PlaceLevel 
FROM geography AS g
WHERE region_id = 1
)

SELECT * 
FROM REGION_CTE;

--2.8 Написати запит який повертає під-дерево для конкретного регіону
	;WITH REGION_CTE AS 
(
SELECT g.region_id
		,g.id AS place_ID
		,g.name
		,0 AS PlaceLevel 
FROM geography AS g
WHERE region_id  = 4
UNION ALL 
SELECT g.region_id
		,g.id AS Place_ID
		,g.name
		,PlaceLevel + 1 
FROM REGION_CTE AS r INNER JOIN geography AS g 
ON r.place_ID = g.region_id 
)

SELECT * 
FROM REGION_CTE;

--2.9 Написати запит котрий вертає повне дерево  від root ('Ukraine') і додаткову колонку, яка вказує на рівень в ієрархії
	;WITH UKR_TREE AS (
SELECT g.region_id 
		,g.id AS Place_ID
		,g.name
		,-1 AS PlaceLevel
FROM geography AS g
WHERE g.region_id IS NULL
UNION ALL
SELECT g.region_id  
        ,g.id AS Place_ID
        ,g.name
		,PlaceLevel = PlaceLevel + 1
FROM geography AS g INNER JOIN UKR_TREE AS u
ON g.region_id = u.Place_ID
)

SELECT *
FROM UKR_TREE
WHERE PlaceLevel >= 0

--2.10 Написати запит який повертає дерево для регіону Lviv 
	;WITH LVIV_REG AS
(
SELECT g.name 
		,g.id
		,g.region_id
		,1 AS level
FROM geography AS g
WHERE id = 2
UNION ALL
SELECT g.name  
		,g.id
		,g.region_id
		,level = level + 1
FROM geography AS g INNER JOIN LVIV_REG AS lv
            ON lv.id = g.region_id
)
SELECT *
FROM LVIV_REG

--2.11 Написати запит який повертає дерево зі шляхами для регіону Lviv
	;WITH LVIV_PATH AS
(
SELECT g.name
		,g.id
		,g.region_id
		,1 AS level
		,CAST(CONCAT('/', g.name) AS varchar(50)) AS path
FROM geography AS g
WHERE id = 2
UNION ALL
SELECT g.name
		,g.id
		,g.region_id
		,level + 1
		,CAST(CONCAT(path, '/', g.name) AS varchar(50))
FROM geography AS g INNER JOIN LVIV_PATH AS lp 
ON lp.id = g.region_id
)

SELECT name
		,level
		,path 
FROM LVIV_PATH

--2.12 Написати запит, який повертає дерево зі шляхами і довжиною шляхів для регіону Lviv
	;WITH LVIV_PATH AS
(
SELECT name
		,g.id
		,g.region_id
		,1 AS pathlen
		,CAST(CONCAT('/', g.name) AS varchar(50)) AS path
		,center = (SELECT name FROM geography WHERE id = 2) 
FROM geography AS g
WHERE region_id = 2
UNION ALL
SELECT g.name
		,g.id
		,g.region_id
		,pathlen + 1
		,CAST(CONCAT(path, '/', g.name) AS varchar(50))
		,center
FROM geography AS g INNER JOIN LVIV_PATH AS lp 
ON lp.id = g.region_id
)
SELECT name
, center
, pathlen
, ('/Lviv' + path) AS path 
FROM LVIV_PATH 

--3. Написати запити використовуючи UNION, UNION ALL, EXCEPT, INTERSECT:
--3.1 Вибрати постачальників з Лондона або Парижу
SELECT s.supplierid
      ,s.name
	  ,s.city
FROM suppliers AS s
WHERE s.city = 'London'
UNION ALL
SELECT s.supplierid
      ,s.name
	  ,s.city
FROM suppliers AS s
WHERE s.city = 'Paris'

--3.2 Вибрати всі міста, де є постачальники  і/або деталі (два запити – перший повертає міста з дублікатами, другий без дублікатів).
--    Міста у кожному запиті  відсортувати в алфавітному порядку 
--3.2(1) Вибрати всі міста, де є постачальники і деталі (з дублікатами)
SELECT * FROM
(SELECT s.city
 FROM suppliers AS s
INTERSECT
 SELECT d.city
 FROM details AS d
) AS c
ORDER BY c.city

--3.2(2) Вибрати всі міста, де є постачальники або деталі (без дублікатів)
SELECT * FROM
(SELECT s.city
 FROM suppliers AS s
 UNION
 SELECT d.city
 FROM details AS d
) AS c
ORDER BY c.city

--3.3 Вибрати всіх постачальників за вийнятком тих, що постачають деталі з Лондона
SELECT s.name 
FROM suppliers AS s
EXCEPT
SELECT s.name 
FROM suppliers AS s 
WHERE s.city = 'London';

--3.4 Знайти різницю між множиною продуктів, які знаходяться в Лондоні та Парижі  і множиною продуктів, які знаходяться в Парижі та Римі
SELECT p.productid
		,p.name
		,p.city
FROM products AS p
WHERE p.city = 'London' OR p.city = 'Paris'
EXCEPT
SELECT p.productid
		,p.name
		,p.city
FROM products AS p
WHERE p.city = 'Paris' OR  p.city = 'Roma'

--3.5 Вибрати поставки, що зробив постачальник з Лондона, а також поставки зелених деталей за виключенням поставлених виробів з Парижу 
--(код постачальника, код деталі, код виробу)
SELECT s.supplierid
		,s.detailid
		,s.productid
FROM supplies AS s
WHERE s.supplierid IN (SELECT sr.supplierid
					FROM suppliers AS sr
					WHERE sr.city = 'London')
UNION
SELECT s.supplierid
		,s.detailid
		,s.productid
FROM supplies AS s
WHERE s.detailid IN (SELECT d.detailid
					FROM details AS d
					WHERE d.color = 'Green') AND s.productid NOT IN (SELECT p.productid
																FROM products AS p
																WHERE p.city = 'Paris')