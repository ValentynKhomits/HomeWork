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
SELECT [CategoryID]
		,[ProductName] 
FROM dbo.[Products]
WHERE [QuantityOnHand] >= 1
ORDER BY [CategoryID];

--Task 4
SELECT [ProductName]
		,[CategoryID]
		,[VendorID]
		,[WholesalePrice]
FROM dbo.[Product_Vendors] AS PV INNER JOIN dbo.[Products] AS P
ON PV.ProductNumber = P.ProductNumber
ORDER BY [ProductName];

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

--Task 14 ??
SELECT OD.[OrderNumber]
		,MAX(PV.[DaysToDeliver]) AS MaxDaysToDeliver
FROM [Order_Details] AS OD LEFT JOIN [Product_vendors] AS PV
ON OD.[ProductNumber] = PV.[ProductNumber]
GROUP BY [OrderNumber]
ORDER BY [OrderNumber];
+
SELECT OrderNumber, DATEDIFF(day, OrderDate, ShipDate) AS DaysToOrderProcessing 
FROM Orders

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