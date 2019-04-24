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
SELECT T1.ProductID,T2.ProductName,T2.UnitPrice,SUM(Quantity) AS TotalSelling
FROM [dbo].[Order Details] T1 JOIN [dbo].[Products]  AS T2 ON T1.ProductID = T2.ProductID
WHERE T1.ProductID=75
GROUP BY T1.ProductID,T2.ProductName,T2.UnitPrice
HAVING SUM(Quantity)>1000

ALTER FUNCTION sumsale(@Product int)
RETURNS TABLE
AS
RETURN(
	SELECT T1.ProductID,T2.ProductName,T2.UnitPrice,SUM(Quantity) AS TotalSelling
	FROM [dbo].[Order Details] T1 JOIN [dbo].[Products]  AS T2 ON T1.ProductID = T2.ProductID
	WHERE T1.ProductID= @Product
	GROUP BY T1.ProductID,T2.ProductName,T2.UnitPrice
	HAVING SUM(Quantity)>1000
)
--Check sumsale function
SELECT * FROM sumsale(75)

--4.	To calculate salary for salesman, manager would like to know total amount of money each salesman have been sold. .
--Write a function to display information as follow :
--EmployeeID, LastName, FirstName, TotalAmount 

SELECT T1.EmployeeID,T2.FirstName,T2.LastName,SUM([dbo].TotalAmount(T1.OrderID)) AS TotalAmount
FROM Orders AS T1
	 JOIN [dbo].Employees T2 ON T1.EmployeeID = T2.EmployeeID
WHERE T1.EmployeeID =1 
GROUP BY T1.EmployeeID,T2.FirstName,T2.LastName

CREATE FUNCTION SalemanCal(@EmployeeID int)
RETURNS TABLE
AS
RETURN(
		SELECT T1.EmployeeID,T2.FirstName,T2.LastName,SUM([dbo].TotalAmount(T1.OrderID)) AS TotalAmount
	FROM Orders AS T1
		 JOIN [dbo].Employees T2 ON T1.EmployeeID = T2.EmployeeID
	WHERE T1.EmployeeID = @EmployeeID
	GROUP BY T1.EmployeeID,T2.FirstName,T2.LastName
)
--TEST
SELECT * FROM [dbo].SalemanCal(1)