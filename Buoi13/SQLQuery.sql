USE northwind

SELECT (UnitPrice*Quantity)*(1-Discount) AS MONEY,OrderID
FROM [dbo].[Order Details]
WHERE OrderID=10254
GROUP BY OrderID

CREATE FUNCTION TotalAmount(@OrderID int)
RETURNS decimal(8,2)
AS
BEGIN
RETURN (
SELECT SUM((UnitPrice*Quantity)*(1-Discount)) AS MONEY
FROM [dbo].[Order Details]
WHERE OrderID=@OrderID
GROUP BY OrderID
)
END

SELECT [dbo].TotalAmount( T1.OrderID ),T1.OrderID  FROM [dbo].[Order Details] AS T1

--b
SELECT COUNT(*)
FROM [dbo].Customers
WHERE Country LIKE 'Germany'
GROUP BY Country;

ALTER FUNCTION NumberOfCustomer(@country nvarchar(15))
RETURNS int
AS
BEGIN
RETURN (
SELECT COUNT(*)
		FROM [dbo].Customers
		WHERE Country = @country
		GROUP BY Country
)	
END

SELECT DISTINCT T2.Country,[dbo].NumberOfCustomer(T2.Country) AS 'NumberOfCustomer'   FROM [dbo].Customers AS T2 
--
SELECT ProductID,SUM(Quantity) AS TotalSelling
FROM [dbo].[Order Details] 
GROUP BY ProductID
HAVING SUM(Quantity)>1000

SELECT ProductID ,SUM(Quantity) FROM [dbo].[Order Details] 
GROUP BY ProductID 



