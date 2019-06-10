CREATE DATABASE VK_module_3

USE VK_module_3
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

--Task 1
UPDATE suppliers
SET rating = rating + 10
WHERE rating < (SELECT rating 
				FROM suppliers
				WHERE supplierid = 4)

--Task 2
SELECT productid, name INTO products_london
FROM products
WHERE city = 'London' OR productid IN (SELECT productid
										FROM supplies AS s left join suppliers AS sr
										ON s.supplierid = sr.supplierid
										WHERE city = 'London' )

SELECT * FROM products_london

--Task 3 ??
DELETE FROM supplies
WHERE detailid IS NULL

--Task 4 


--Task 5
UPDATE supplies
SET quantity = quantity + (quantity/100*10)
WHERE detailid IN (SELECT S.detailid
					FROM supplies AS S LEFT JOIN details AS D
					ON S.detailid = D.detailid
					WHERE color = 'Red')

--Task 6
SELECT DISTINCT color, city INTO color_city
FROM details

SELECT * FROM color_city

--Task 7 
SELECT detailid INTO details_london
FROM details
WHERE detailid IN (SELECT DISTINCT s.detailid
					FROM supplies AS s LEFT JOIN suppliers AS sr
					ON s.supplierid = sr.supplierid
					WHERE city = 'London' ) OR detailid IN (SELECT DISTINCT s.detailid
															FROM supplies AS s LEFT JOIN products AS p
															ON s.productid = p.productid
															WHERE city = 'London' )

SELECT * FROM details_london

--Task 8
INSERT INTO suppliers
		(supplierid,
		name,
		rating,
		city)
	VALUES
		(10, 'White', NULL, 'New York');

--Task 9
DELETE FROM supplies
WHERE productid = (SELECT DISTINCT S.productid
					FROM supplies AS S LEFT JOIN products AS P
					ON S.productid = P.productid
					WHERE city = 'Roma');

DELETE FROM products
WHERE city = 'Roma';

--Task 10
SELECT city INTO city_1 
FROM (
		SELECT city
		FROM supplies AS s INNER JOIN suppliers AS sr  
		ON s.supplierid = sr.supplierid
		UNION
		SELECT city
		FROM supplies AS s INNER JOIN details AS d  
		ON s.detailid = d.detailid
		UNION
		SELECT city
		FROM supplies AS s INNER JOIN products AS p  
		ON s.productid = p.productid) AS C


SELECT * FROM city_1

--Task 11
UPDATE details
SET color = 'Yellow'
WHERE color = 'Red' AND weight < 15;

--Task 12
SELECT productid, city INTO product_O 
FROM products
WHERE city LIKE '_o%'

SELECT * FROM product_O

--Task 13 ??
UPDATE suppliers
SET rating = rating + 10
WHERE supplierid IN (SELECT supplierid
					FROM supplies
					GROUP BY supplierid
					HAVING AVG(quantity) > (SELECT AVG(quantity)
											FROM supplies));

--Task 14
CREATE TABLE product_1 (
	supplierid INT,
	name VARCHAR(20),
	productid INT
);

INSERT INTO product_1(
			supplierid, 
			name, 
			productid) 
	SELECT sr.supplierid, sr.name, ss.productid 
	FROM supplies AS ss LEFT JOIN suppliers AS sr
	ON ss.supplierid = sr.supplierid   
	WHERE productid = 1;

GO

--Task 15
INSERT INTO product_1 
SELECT 4 AS supplierid, 'Anderson' AS name, 1 AS productid
UNION ALL
SELECT 5, 'Muerta', 1;

--MERGE Task 1
CREATE TABLE tmp_details(
	detailid INT PRIMARY KEY,
	name VARCHAR(20),
	color VARCHAR(20),
	weight INT,
	city VARCHAR(20)
);

INSERT INTO tmp_details
		(detailid,
		name,
		color,
		weight,
		city)
	VALUES
		(1, 'Screw', 'Blue', 13, 'Osaka'),
		(2, 'Bolt', 'Pink', 12, 'Tokio'),
		(18, 'Whell-24', 'Red', 14, 'Lviv'),
		(19, 'Whell-28', 'Pink', 15, 'London')

GO

--Task 2
MERGE details AS D
	USING (SELECT detailid, name, color, weight, city FROM tmp_details)
	AS T (detailid, name, color, weight, city)
	ON (D.detailid = T.detailid)
WHEN MATCHED THEN
	UPDATE SET D.name = T.name, D.color = T.color, D.weight = T.weight, D.city = T.city
WHEN NOT MATCHED THEN
	INSERT (detailid, name, color, weight, city) VALUES (T.detailid, T.name, T.color, T.weight, T.city)
OUTPUT $action, deleted.*, inserted.*;