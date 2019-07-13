CREATE DATABASE VK_module_6
GO

USE VK_module_6
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

GO

--1. Написати команду, яка повертає список продуктів, складений в алфавітному порядку міст де вони знаходяться + порядковий номер деталі 
--   в списку (наскрізна нумерація для порядкового номера). 
SELECT [productid]
		,[name]
		,[city]
		,ROW_NUMBER() OVER(ORDER BY [city]) AS N'порядковий номер'
FROM [dbo].[products];

--2. Написати команду, яка повертає список продуктів, складений в алфавітному порядку міст де вони знаходяться + порядковий номер в межах
--   одного міста (відсортований за іменем продукту).
SELECT [productid]
		,[name]
		,[city]
		,ROW_NUMBER() over(partition by [city]
							order by [name]) AS N'порядковий номер в межах міста'
FROM [dbo].[products];

--3. Використовуючи за основу попередній запит написати запит, який повертає міста з порядковим номером 1. 
SELECT *
FROM
(SELECT [productid]
		,[name]
		,[city]
		,ROW_NUMBER() over(partition by [city]
							order by [name]) AS N'порядковий номер в межах міста'
FROM [dbo].[products]) AS cte_number_one
WHERE [порядковий номер в межах міста] = 1;

--4. Написати запит, який повертає список продуктів, деталей, їхні поставки,  загальну кількість поставок для кожного продукту
--   і загальну кількість поставок для кожної деталі. 
SELECT [productid]
		,[detailid]
		,[quantity]
		,SUM(quantity) over(partition by [productid]) AS all_quantity_per_prod
		,SUM(quantity) over(partition by [detailid]) AS all_quantity_per_det
FROM [dbo].[supplies];

--5. Організувати посторінковий вивід інформації з таблиці поставок, відсортований за  постачальниками, вивести записи з 10 по 15 запис,
--   додатково вивести порядковий номер стрічки і загальну кількість записів у таблиці поставок. 
SELECT *
FROM
(SELECT [supplierid]
		,[detailid]
		,[productid]
		,[quantity]
		,ROW_NUMBER() over(order by [supplierid]) AS rn
		,count(*) over( ) AS tot
FROM [dbo].[supplies]) AS cte_suppliers
WHERE rn BETWEEN 10 AND 15;

--6. Написати запит, що розраховує середню кількість елементів в поставці і виводить ті поставки, де кількість елементів менше середньої. 
SELECT *
FROM
(SELECT [supplierid]
		,[detailid]
		,[productid]
		,[quantity]
		,AVG(quantity) over() AS avg_qty
FROM [dbo].[supplies]) AS cte_avg
WHERE quantity < avg_qty