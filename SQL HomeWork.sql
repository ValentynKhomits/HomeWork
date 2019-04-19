--Homework_1_SELECT(Single-Table Queries)
--1.
SELECT maker, type
FROM product
WHERE type = 'laptop'
ORDER BY maker

--2.
SELECT model, ram, screen, price
FROM laptop
WHERE price > 1000  
ORDER BY ram, price DESC

--3.
SELECT *
FROM printer
WHERE color = 'y'  
ORDER BY price DESC

--4.
SELECT model, speed, hd, cd, price
FROM pc
WHERE (cd ='12x' OR cd = '24x') AND price < 600 
ORDER BY speed DESC

--5.
SELECT name, class
FROM ships
WHERE name = class
ORDER BY name

--6.
SELECT *
FROM pc
WHERE speed >= 500 AND price < 800 
ORDER BY price DESC

--7.
SELECT *
FROM printer
WHERE type <> 'Matrix' AND price < 300 
ORDER BY type DESC

--8.
SELECT model, speed
FROM pc
WHERE price BETWEEN 400 AND 600 
ORDER BY hd

--9.
SELECT model, speed, hd, price
FROM laptop
WHERE screen >= 12 
ORDER BY price DESC

--10.
SELECT model, type, price
FROM printer
WHERE price < 300 
ORDER BY type DESC

--11.
SELECT model, ram, price
FROM laptop
WHERE ram = 64 
ORDER BY screen

--12.
SELECT model, ram, price
FROM pc
WHERE ram > 64 
ORDER BY hd

--13.
SELECT model, speed, price
FROM pc
WHERE speed BETWEEN 500 AND 750 
ORDER BY hd DESC

--14.
SELECT *
FROM outcome_o
WHERE out >= 2000
ORDER BY out

--15.
SELECT point, date, inc
FROM income_o
WHERE inc BETWEEN 5000.00 AND 10000.00
ORDER BY inc

--16.
SELECT point, date, inc
FROM income
WHERE point = 1
ORDER BY inc

--17.
SELECT point, date, out
FROM outcome
WHERE point = 2
ORDER BY out

--18.
SELECT *
FROM classes
WHERE country = 'Japan'
ORDER BY type DESC

--19.
SELECT name, launched
FROM ships
WHERE launched BETWEEN 1920 AND 1942
ORDER BY launched DESC

--20.
SELECT ship, battle, result
FROM outcomes
WHERE battle = 'Guadalcanal' AND result <> 'sunk'
ORDER BY ship DESC

--21.
SELECT ship, battle, result
FROM outcomes
WHERE result = 'sunk'
ORDER BY ship DESC

--22.
SELECT class, displacement
FROM classes
WHERE displacement >= 40000
ORDER BY type

--23.
SELECT trip_no, town_from, town_to
FROM trip
WHERE town_from = 'London' OR town_to = 'London'
ORDER BY time_out

--24.
SELECT trip_no, plane, town_from, town_to
FROM trip
WHERE plane = 'TU-134'
ORDER BY time_out DESC

--25.
SELECT trip_no, plane, town_from, town_to
FROM trip
WHERE plane <> 'IL-86'
ORDER BY plane

--26.
SELECT trip_no, town_from, town_to
FROM trip
WHERE town_from <> 'Rostov' AND town_to <> 'Rostov'
ORDER BY plane

--27.
SELECT model
FROM pc
WHERE model LIKE '%11%'

--28.
SELECT code, point, date, out, MONTH(date) AS month 
FROM outcome
WHERE MONTH(date) = 3

--29.
SELECT code, point, date, out, DAY(date) AS Day 
FROM outcome
WHERE DAY(date) = 14

--30.
SELECT name
FROM ships
WHERE name LIKE 'W%n'

--31.
SELECT name
FROM ships
WHERE name LIKE '%e%e%' OR name LIKE '%ee%'

--32.
SELECT name, launched
FROM ships
WHERE name NOT LIKE '%a'

--33.
SELECT name
FROM battles
WHERE name LIKE '% %[^c]'

--34.
SELECT *
FROM trip
WHERE FORMAT(time_out, 'HH.MM') BETWEEN 12.00 AND 17.00

--35.
SELECT *
FROM trip
WHERE FORMAT(time_in, 'HH.MM') BETWEEN 17.00 AND 23.00

--36.
SELECT *
FROM trip
WHERE FORMAT(time_in, 'HH.MM') NOT BETWEEN 10.00 AND 21.00

--37.
SELECT date, place
FROM pass_in_trip
WHERE place LIKE '1_'

--38.
SELECT date, place
FROM Pass_in_trip
WHERE place LIKE '_c'

--39.
SELECT name
FROM passenger
WHERE name LIKE '% C%' OR name LIKE '% % C%'

--40.
SELECT name
FROM passenger
WHERE name NOT LIKE '% J%' AND name NOT LIKE '% % J%'

--41.
SELECT CONCAT('середня ціна = ', SUM(price)/COUNT(code)) 
FROM laptop

--42.
SELECT CONCAT('унікальний код: ', code) AS code, CONCAT('модель: ', model) AS model, CONCAT('швидкість:', speed) AS speed,
CONCAT('об’єм памяті: ', ram) AS ram, CONCAT('розмір диску: ', hd) AS hd, CONCAT('швидкість CD-приводу: ', cd) AS sd,
CONCAT('ціна: ', price) AS price 
FROM pc

--43.
SELECT date, FORMAT(date, 'yyyy.MM.dd') AS new_format
FROM income

--44.
SELECT result,
CASE result
	WHEN 'sunk' THEN 'потоплений'
	WHEN 'damaged' THEN 'пошкоджений'
	WHEN 'OK' THEN 'цілий'
END AS equivalent_name
FROM outcomes

--45.
SELECT place, 'ряд: ' + LEFT(TRIM(place),1), 'місце: ' + RIGHT(TRIM(place),1) 
FROM pass_in_trip

--46.    
SELECT CONCAT('from ', RTRIM(town_from)) + ' ' + CONCAT('to ', LTRIM(town_to)) AS trip_from_to  
FROM trip

--47.
SELECT CONCAT(LEFT(trip_no, 1) + RIGHT(trip_no, 1),
		LEFT(id_comp, 1) + RIGHT(id_comp, 1),
		LEFT(TRIM(plane), 1) + RIGHT(TRIM(plane), 1),
		LEFT(TRIM(town_from), 1) + RIGHT(TRIM(town_from), 1),
		LEFT(TRIM(town_to), 1) + RIGHT(TRIM(town_to), 1),
		LEFT((CONVERT(varchar(30), time_out, 121)), 1) + RIGHT((CONVERT(varchar(30), time_out, 121)),1),
		LEFT((CONVERT(varchar(30), time_in, 121)), 1) + RIGHT((CONVERT(varchar(30), time_in, 121)),1))
FROM trip

--48.
SELECT maker, COUNT(pc.model)
FROM pc INNER JOIN product
ON pc.model = product.model
GROUP BY maker
HAVING COUNT(DISTINCT pc.model) >=2

--49.


--50.
SELECT type, COUNT(model)
FROM printer
GROUP BY type

--51.


--52.
SELECT *, DATEDIFF(minute, time_out, time_in)/60.0 AS hours_in_flight
FROM trip

--53.
SELECT point, SUM(out) AS total, MIN(out) AS min, MAX(out) as max
FROM outcome
GROUP BY point

--54.


--55.
SELECT COUNT(*)
FROM (SELECT REVERSE(SUBSTRING(LTRIM(REVERSE(name)), 1, CHARINDEX(' ', (LTRIM(REVERSE(name))))-1)) AS lastname
		FROM passenger
		WHERE REVERSE(SUBSTRING(LTRIM(REVERSE(name)), 1, CHARINDEX(' ', (LTRIM(REVERSE(name))))-1)) LIKE 'S%'
		UNION
		SELECT REVERSE(SUBSTRING(LTRIM(REVERSE(name)), 1, CHARINDEX(' ', (LTRIM(REVERSE(name))))-1)) AS lastname
		FROM passenger
		WHERE REVERSE(SUBSTRING(LTRIM(REVERSE(name)), 1, CHARINDEX(' ', (LTRIM(REVERSE(name))))-1)) LIKE 'B%'
		UNION
		SELECT REVERSE(SUBSTRING(LTRIM(REVERSE(name)), 1, CHARINDEX(' ', (LTRIM(REVERSE(name))))-1)) AS lastname
		FROM passenger
		WHERE REVERSE(SUBSTRING(LTRIM(REVERSE(name)), 1, CHARINDEX(' ', (LTRIM(REVERSE(name))))-1)) LIKE 'A%') AS col1

--Homework_2_SELECT(Join)

--1.
SELECT maker, type, speed, hd
FROM pc INNER JOIN product
ON pc.model = product.model
WHERE hd <= 8
ORDER BY maker

--2.
SELECT maker, speed
FROM pc INNER JOIN product
ON pc.model = product.model
WHERE speed >= 600
ORDER BY maker

--3.
SELECT maker
FROM laptop INNER JOIN product
ON laptop.model = product.model
WHERE speed <= 500
ORDER BY maker

--4.

--5.
SELECT country
FROM classes
WHERE type = 'bb'
INTERSECT
SELECT country
FROM classes
WHERE type = 'bc'

--6.
SELECT pc.model, maker
FROM pc INNER JOIN product
ON pc.model = product.model
WHERE price < 600

--7.
SELECT printer.model, maker,price
FROM printer INNER JOIN product
ON printer.model = product.model
WHERE price > 300

--8.
SELECT maker, pc.model, price
FROM pc INNER JOIN product
ON pc.model = product.model
ORDER BY maker

--9.
SELECT product.maker, pc.model, pc.price
FROM pc INNER JOIN product
ON pc.model = product.model
WHERE pc.price IS NOT NULL

--10.
SELECT product.maker, product.type, laptop.model, laptop.speed
FROM laptop INNER JOIN product
ON laptop.model = product.model
WHERE laptop.speed > 600

--11.
SELECT ships.name, classes.displacement
FROM ships INNER JOIN classes
ON ships.class = classes.class

--12.
SELECT outcomes.ship, battles.name, battles.date, outcomes.result
FROM outcomes INNER JOIN battles
ON outcomes.battle = battles.name
WHERE result = 'OK' OR result = 'damaged'

--13.
SELECT ships.name, classes.country
FROM ships INNER JOIN classes
ON ships.class = classes.class

--14.
SELECT DISTINCT company.name, trip.plane
FROM trip INNER JOIN company
ON trip.id_comp = company.id_comp
WHERE trip.plane = 'Boeing'

--15.
SELECT passenger.name, pass_in_trip.date
FROM passenger INNER JOIN pass_in_trip
ON passenger.id_psg = pass_in_trip.id_psg

--16.
SELECT pc.model, pc.speed, pc.hd
FROM pc INNER JOIN product
ON pc.model = product.model
WHERE product.maker = 'A' AND pc.hd = 10 OR pc.hd = 20
ORDER BY pc.speed

--17.
SELECT maker, [pc], [laptop], [printer] 
FROM Product 
PIVOT (COUNT(model)
FOR type IN ([pc], [laptop], [printer])) pivot_table

--18.
SELECT *
FROM (SELECT screen, price
FROM laptop) AS scr_prc
PIVOT (AVG([price])
FOR [screen] IN ([11], [12], [14], [15])) AS pivot_table

--19.

--20.
SELECT *
FROM laptop AS l1
cross apply
(SELECT MAX(price) AS max_price
FROM laptop l2 INNER JOIN product AS p1
ON p1.model = l2.model
WHERE maker = (SELECT maker FROM product AS p2 WHERE p2.model = l1.model)) AS mprice

--21.

--22.

--23.

--24.

--Homework_3_SELECT(Combining_Sets)
--1.
;WITH cte1 AS
(SELECT model, SUM(price) AS total
 FROM pc
 GROUP BY model)

SELECT model, total
 FROM cte1
 WHERE total >2000

--2.
;WITH cte1 AS
(SELECT model, SUM(price) AS total
 FROM pc
 GROUP BY model)

, cte2 AS 
(SELECT model, total
 FROM cte1
 WHERE total >2000)
 
 SELECT * FROM cte2

--3.

--4.

--5.
WITH numbers(N) AS

(SELECT 1
 UNION ALL
 SELECT N+1 
 FROM numbers 
 WHERE N < 10000)

SELECT * FROM numbers
OPTION (maxrecursion 10000)

GO
--6.
DECLARE @n INT = 0;
WHILE @n < 100000
BEGIN SET @n = @n +1	
print @n	
END;

--7.
WITH allday(D, name) AS
(SELECT CAST('20190101' AS date) AS days, DATENAME(weekday, '20190101')
UNION ALL
SELECT DATEADD(DAY,1,D), DATENAME(weekday, DATEADD(DAY,1,D))
FROM allday
WHERE D < '20191231'),

weekends AS
(SELECT D, name
FROM allday
WHERE name IN ('Saturday', 'Monday'))

SELECT COUNT(*) AS total
FROM weekends
OPTION (maxrecursion 366)

GO

--8.
SELECT DISTINCT maker
FROM product
WHERE type IN ('PC') AND maker NOT IN 
(SELECT maker FROM product WHERE type = 'Laptop')

--9.
SELECT DISTINCT maker
FROM product
WHERE type = 'PC' AND 
NOT maker = ANY (SELECT maker FROM product WHERE type = 'Laptop' )

--10.
SELECT DISTINCT maker
FROM product
WHERE type = 'PC' AND 
maker <> ALL (SELECT maker FROM product WHERE type = 'Laptop' )

--11.
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND maker IN 
(SELECT maker FROM product WHERE type = 'Laptop')

--12.
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND NOT 
maker <> ALL (SELECT maker FROM product WHERE type = 'Laptop')

--13.
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND 
maker = ANY (SELECT maker FROM product WHERE type = 'Laptop')

--14.
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND maker NOT IN
(SELECT maker
FROM product
WHERE type = 'PC' AND (model <> ALL 
(SELECT DISTINCT model FROM pc)))
--15.

--16.

--17.
SELECT DISTINCT maker
FROM product
WHERE EXISTS (SELECT model FROM pc WHERE product.model = pc.model)
--18.

--19.

--20.
SELECT model, price
FROM printer
WHERE price = (SELECT MAX(price) FROM printer)
--21.

--22.
WITH prnt AS
(SELECT p.maker, p.type, color, price
FROM product AS p inner join printer AS pr
ON p.model = pr.model)

SELECT maker, min(price) AS min_price
FROM prnt
WHERE color = 'y'
GROUP BY maker
--23.

--24.

--25.
SELECT maker, (SELECT 
CASE WHEN COUNT(pc.model) = 0 THEN 'no'
	ELSE CONCAT('yes(', COUNT(pc.model),')')
	END) AS available
FROM product AS p left join pc
ON p.model = pc.model
GROUP BY maker
--26.

--27.

--28.

--29.

--30.

--31.
SELECT C.class
FROM classes AS C LEFT JOIN 
(SELECT class, name
 FROM ships
 UNION
 SELECT ship, ship
 FROM outcomes) AS S 
 ON C.class = S.class
GROUP BY C.class
HAVING COUNT(C.class) = 1
--32.
