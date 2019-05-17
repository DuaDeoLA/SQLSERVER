USE master
CREATE DATABASE [SalesManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SalesManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\SalesManagement.mdf' , SIZE = 8192KB , MAXSIZE = 8192KB , FILEGROWTH = 3072KB )
 LOG ON 
( NAME = N'SalesManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\SalesManagement_log.ldf' , SIZE = 3072KB , MAXSIZE = 5120KB , FILEGROWTH = 3072KB )
GO
--CREATE customers
USE [SalesManagement]
DROP TABLE IF EXISTS customers
CREATE  TABLE customers
(
	[customerid] VARCHAR(5),
	[customername] VARCHAR (30),
	[address] VARCHAR(50),
	[city] VARCHAR(20),
	[phone] VARCHAR(10),
	CONSTRAINT PK_customers PRIMARY KEY ([customerid])
)

DROP TABLE IF EXISTS products
CREATE  TABLE products
(
	[productid] int Identity (1,1) ,
	[productName] VARCHAR(50),
	[price] MONEY,
	CONSTRAINT PK_products PRIMARY KEY ([productid])
)
DROP TABLE IF EXISTS orders
CREATE  TABLE orders
(
	[orderid] int Identity (1,1) ,
	[customerid] VARCHAR(5),
	[orderdate] datetime,
	[requireddate] datetime,
	CONSTRAINT PK_orders PRIMARY KEY ([orderid]),
	CONSTRAINT FK_orders_customers FOREIGN KEY([customerid]) REFERENCES  customers([customerid]),
)

DROP TABLE IF EXISTS orderdetails
CREATE  TABLE orderdetails
(
	[orderid] int ,
	[productid] int,
	[quantity] smallint,
	CONSTRAINT PK_orderdetails PRIMARY KEY ([orderid],[productid]),
	CONSTRAINT FK_orderdetails_product FOREIGN KEY([productid]) REFERENCES  products([productid]),
	CONSTRAINT FK_orderdetails_order FOREIGN KEY([orderid]) REFERENCES  orders([orderid])
)
---
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'A0001', N'Ronaldo', N'12 Glassgow', N'London', N'002-342561')
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'A0002', N'David Beckham', N'Cerrito 333', N'Florida', N'001-281212')
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'B0001', N'Van Persie', N'35 King George', N'London', N'002-214567')
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'B0002', N'Bebetov', N'722 DaVinci', N'Florida', N'001-221122')
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'C0001', N'Raul Gonzalez', N'12 Orchestra', N'Milan', N'003-234876')
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'C0002', N'Carlos Tevez', N'300 Queensbridge', N'London', N'002-879011')
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'D0001', N'Kaka', N'Gran Via, 1', N'Milan', N'003-211781')
INSERT [dbo].[customers] ([customerid], [customername], [address], [city], [phone]) VALUES (N'D0002', N'Thiery Henry', N'Magazinweg 7', N'Barcelona', N'004-982323')
--
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (1, N'Chocolate', 21.0000)
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (2, N'Camembert Pierrot', 22.5000)
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (3, N'Filo Mix', 7.0000)
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (4, N'Zaanse koeken', 9.7500)
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (5, N'Gula Malacca', 12.4500)
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (6, N'Maxilaku', 20.0000)
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (7, N'Steeleye Stout', 18.0000)
INSERT [dbo].[products] ([productid], [productName], [price]) VALUES (8, N'Geitost', 3.7500)
--
INSERT [dbo].[orders] ([orderid], [customerid], [orderdate], [requireddate]) VALUES (1, N'A0001', CAST(N'2006-09-13T00:00:00.000' AS DateTime), CAST(N'2006-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[orders] ([orderid], [customerid], [orderdate], [requireddate]) VALUES (2, N'D0002', CAST(N'2007-07-30T00:00:00.000' AS DateTime), CAST(N'2007-08-20T00:00:00.000' AS DateTime))
INSERT [dbo].[orders] ([orderid], [customerid], [orderdate], [requireddate]) VALUES (3, N'B0001', CAST(N'2007-11-11T00:00:00.000' AS DateTime), CAST(N'2007-11-25T00:00:00.000' AS DateTime))
INSERT [dbo].[orders] ([orderid], [customerid], [orderdate], [requireddate]) VALUES (4, N'B0001', CAST(N'2008-02-20T00:00:00.000' AS DateTime), CAST(N'2008-03-10T00:00:00.000' AS DateTime))
INSERT [dbo].[orders] ([orderid], [customerid], [orderdate], [requireddate]) VALUES (5, N'C0002', CAST(N'2008-05-12T00:00:00.000' AS DateTime), CAST(N'2008-05-27T00:00:00.000' AS DateTime))
--
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (1, 1, 12)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (1, 2, 7)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (2, 6, 30)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (3, 1, 15)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (3, 7, 22)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (4, 3, 11)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (4, 4, 55)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (4, 5, 10)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (5, 2, 13)
INSERT [dbo].[orderdetails] ([orderid], [productid], [quantity]) VALUES (5, 6, 120)
--
--Display the information of all customers 
SELECT *
FROM customers
--Display the customers who live in London. 
--The displayed information include: Customer ID, Customer Name, Address, Phone. The list is ordered by Customer Name
SELECT customerid,customername, address,phone
FROM customers
WHERE city = 'London'
ORDER BY customername
--Display the number of customers of each city. 
--The displayed information include: Name of City, Number of Customers
SELECT city,COUNT(*) AS 'Number of Customers'
FROM customers
GROUP BY city
--Display the name of customers who have at least an order
SELECT customername
FROM customers
WHERE customerid IN (SELECT DISTINCT customerid FROM orders)
--Display the name of customers who have not any order
SELECT customername,customerid
FROM customers
WHERE customerid NOT IN (SELECT DISTINCT customerid FROM orders)
--Display the number of order for each customers. 
--The displayed information include: Customer ID, Customer Name, Number of Orders
SELECT c.customerid,customername,COUNT(o.orderid) AS 'Number of Order'
FROM customers AS c
	JOIN orders AS o ON c.customerid=o.customerid
GROUP BY c.customerid,customername

--Display the list of orders,  
--the sum quantity of each customer’s orders and the sum quantity of all orders. 
--The displayed information include: Customer Name, Product Name, Order Date, Quantity, 
--the Sum Quantity of each Customer’s Orders, the Sum Quantity of all Orders.
SELECT * FROM
(SELECT * FROM customers AS T1 JOIN orders AS T2 ON T1.customerid = T2.customerid) AS T12
JOIN
(SELECT * FROM orderdetails AS T3 JOIN products AS T4 ON T3.productid=T4.productid) AS T34
ON T12.orderid = T34.orderid





