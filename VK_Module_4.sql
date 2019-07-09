USE SalesOrders
GO

--Task 1
SELECT DISTINCT [CustCity]
FROM dbo.[Customers];

--Task 2
SELECT [EmpFirstName]
		,[EmpLastName]
		,[EmpPhoneNumber]
FROM dbo.[Employees];
--OR
SELECT [EmpFirstName] + ' ' + [EmpLastName] AS [Employee]
		,[EmpPhoneNumber] AS [PhoneNumber]
FROM dbo.[Employees];

--Task 3
SELECT DISTINCT P.[CategoryID] ,C.[CategoryDescription]
FROM [dbo].[Products] AS P INNER JOIN [dbo].[Categories] AS C
ON C.CategoryID = P.CategoryID
WHERE P.QuantityOnHand >= 1
ORDER BY P.[CategoryID];

--Task 4
SELECT DISTINCT P.[ProductName]
				,P.[RetailPrice]
				,C.[CategoryDescription]
FROM [dbo].[Products] AS P INNER JOIN [dbo].[Categories] AS C
ON C.CategoryID = P.CategoryID
INNER JOIN [dbo].[Product_Vendors] AS PV
ON PV.ProductNumber = P.ProductNumber;

--Task 5
SELECT [VendName]
		,[VendZipCode]
FROM dbo.[Vendors]
ORDER BY [VendZipCode];

--Task 6
SELECT [EmpFirstName]
		,[EmpLastName]
		,[EmpPhoneNumber]
		,[EmpZipCode]
FROM dbo.[Employees]
ORDER BY [EmpLastName], [EmpFirstName];

--Task 7
SELECT [VendName]
FROM dbo.[Vendors];

--Task 8
SELECT [CustFirstName]
		,[CustLastName]
		,[CustState]
FROM dbo.[Customers];

--Task 9
SELECT DISTINCT [ProductName]
		,[RetailPrice]
FROM dbo.[Products] AS p INNER JOIN dbo.[Order_Details] AS OD
on P.[ProductNumber] = OD.[ProductNumber]
WHERE [QuantityOrdered] >= 1;

--Task 10
SELECT [EmployeeID]
		,[EmpFirstName]
		,[EmpLastName]
		,[EmpStreetAddress]
		,[EmpCity]
		,[EmpState]
		,[EmpZipCode]
		,[EmpAreaCode]
		,[EmpPhoneNumber]
FROM dbo.[Employees];

--Task 11
SELECT [VendCity]
		,[VendName] 
FROM dbo.[Vendors]
ORDER BY [VendCity]

--Task 12
SELECT OD.[OrderNumber]
		,MAX(PV.[DaysToDeliver]) AS MaxDaysToDeliver
FROM [Order_Details] AS OD LEFT JOIN [Product_vendors] AS PV
ON OD.[ProductNumber] = PV.[ProductNumber]
GROUP BY [OrderNumber]
ORDER BY [OrderNumber]

--Task 13
SELECT [ProductName]
		,[RetailPrice]*[QuantityOnHand] AS [TotalPrice]
FROM dbo.[Products];

--Task 14
SELECT DaysToDeliver.OrderNumber
	,DATEDIFF(day, Orders.OrderDate, Orders.ShipDate) + DaysToDeliver.MaxDaysToDeliver AS MaxDeliveryTime
FROM
(
SELECT O.OrderNumber, MAX(PV.DaysToDeliver) MaxDaysToDeliver
FROM Orders AS O INNER JOIN Order_Details AS OD
ON O.OrderNumber = OD.OrderNumber INNER JOIN Product_Vendors AS PV
ON PV.ProductNumber = OD.ProductNumber
GROUP BY O.OrderNumber
)
AS DaysToDeliver INNER JOIN Orders
ON DaysToDeliver.OrderNumber = Orders.OrderNumber

--Task 15
WITH [Numbers](N) AS

(SELECT 1
 UNION ALL
 SELECT N+1 
 FROM [Numbers] 
 WHERE N < 10000)

SELECT * FROM [Numbers]
OPTION (MAXRECURSION 10000)

--Task 16
WITH [Allday](D, Name) AS
(SELECT CAST('20190101' AS Date) AS Days, DATENAME(Weekday, '20190101')
UNION ALL
SELECT DATEADD(DAY,1,D), DATENAME(Weekday, DATEADD(DAY,1,D))
FROM [Allday]
WHERE D < '20191231'),

[Weekends] AS
(SELECT D, Name
FROM [Allday]
WHERE Name IN ('Saturday', 'Monday'))

SELECT COUNT(*) AS Total
FROM [Weekends]
OPTION (MAXRECURSION 366)

GO