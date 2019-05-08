CREATE TABLE Customers
(
	[CustomerID]		VARCHAR(5)		PRIMARY KEY ,
	[CustomerName]		VARCHAR(30),
	[Address]			VARCHAR(50),
	[City]				VARCHAR(20),
	[Phone]				VARCHAR(10),
)

CREATE TABLE Products
(
	[ProductID]			INTEGER	IDENTITY(1,1) PRIMARY KEY,
	[ProductName]		VARCHAR(50),
	[Price]				MONEY,
)

CREATE TABLE Orders
(
	[OrderID]			INTEGER IDENTITY(1,1)
	CONSTRAINT PK_Orders_OrderID PRIMARY KEY,
	[CustomerID]		VARCHAR(5),
	[OrderDate]			DATETIME,
	[RequiredDate]		DATETIME,
	CONSTRAINT FK_Orders_CustomerID
			FOREIGN KEY (CustomerID)
			REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderDetails
(
	[OrderID]			INTEGER , 
	[ProductID]			INTEGER ,
	[Quantity]			SMALLINT,
	CONSTRAINT PK_OrderDetails PRIMARY KEY ([OrderID],[ProductID]),
	CONSTRAINT FK_OrderDetails_OrderID
			FOREIGN KEY ([OrderID])
			REFERENCES Orders([OrderID]),
	CONSTRAINT FK_OrderDetails_ProductID
			FOREIGN KEY ([ProductID])
			REFERENCES Products([ProductID]),
)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'A0001', N'Ronaldo', N'12 Glassgow', N'London', N'002-342561')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'A0002', N'David Beckham', N'Cerrito 333', N'Florida', N'001-281212')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'B0001', N'Van Persie', N'35 King George', N'London', N'002-214567')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'B0002', N'Bebetov', N'722 DaVinci', N'Florida', N'001-221122')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'C0001', N'Raul Gonzalez', N'12 Orchestra', N'Milan', N'003-234876')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'C0002', N'Carlos Tevez', N'300 Queensbridge', N'London', N'002-879011')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'D0001', N'Kaka', N'Gran Via, 1', N'Milan', N'003-211781')
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [Address], [City], [Phone]) VALUES (N'D0002', N'Thiery Henry', N'Magazinweg 7', N'Barcelona', N'004-982323')
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (1, 1, 12)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (1, 2, 7)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (2, 6, 30)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (3, 1, 15)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (3, 7, 22)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (4, 3, 11)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (4, 4, 55)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (4, 5, 10)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (5, 2, 13)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [Quantity]) VALUES (5, 6, 120)
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [RequiredDate]) VALUES (1, N'A0001', CAST(N'2006-09-13T00:00:00.000' AS DateTime), CAST(N'2006-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [RequiredDate]) VALUES (2, N'D0002', CAST(N'2007-07-30T00:00:00.000' AS DateTime), CAST(N'2007-08-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [RequiredDate]) VALUES (3, N'B0001', CAST(N'2007-11-11T00:00:00.000' AS DateTime), CAST(N'2007-11-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [RequiredDate]) VALUES (4, N'B0001', CAST(N'2008-02-20T00:00:00.000' AS DateTime), CAST(N'2008-03-10T00:00:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [RequiredDate]) VALUES (5, N'C0002', CAST(N'2008-05-12T00:00:00.000' AS DateTime), CAST(N'2008-05-27T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (1, N'Chocolate', 21.0000)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (2, N'Camembert Pierrot', 22.5000)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (3, N'Filo Mix', 7.0000)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (4, N'Zaanse koeken', 9.7500)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (5, N'Gula Malacca', 12.4500)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (6, N'Maxilaku', 20.0000)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (7, N'Steeleye Stout', 18.0000)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Price]) VALUES (8, N'Geitost', 3.7500)

--Display the information of all customer
SELECT * FROM [Customers]
--Display the customers who live in London. The displayed information include: Customer ID, Customer Name, Address, Phone. The list is ordered by Customer Name
SELECT [CustomerID],[CustomerName],[Address],C.[Phone] FROM [Customers] AS C
WHERE C.[City] LIKE '%London%'
ORDER BY [CustomerName]

--Display the number of customers of each city. The displayed information include: Name of City, Number of Customers
SELECT C.[City] ,COUNT(C.[CustomerID]) AS NUMBERCUSTOMMER FROM [Customers] AS C
GROUP BY C.[City]

--Display the name of customers who have at least an order
SELECT C.[CustomerName] FROM Customers AS C
	JOIN [Orders] AS O ON O.[CustomerID] = C.[CustomerID]
GROUP BY C.[CustomerName]
HAVING COUNT(O.OrderID) > 1

--Display the name of customers who have not any order
SELECT C.[CustomerName] FROM Customers AS C
WHERE C.[CustomerID] NOT IN (
							SELECT [CustomerID] FROM [Orders] 	
							)
--Display the number of order for each customers. The displayed information include: Customer ID, Customer Name, Number of Orders
SELECT C.[CustomerID],C.[CustomerName] ,SUM(OrderDetails.Quantity) AS NUMBERORDER FROM OrderDetails 
	JOIN [Orders] AS O ON O.[OrderID] = OrderDetails.OrderID
	JOIN Customers AS C ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID,C.CustomerName

--Display the list of orders,  the sum quantity of each customer’s orders and the sum quantity of all orders. The displayed information include: Customer Name, Product Name, Order Date, Quantity, the Sum Quantity of each Customer’s Orders, the Sum Quantity of all Orders.
SELECT C.[CustomerName] ,P.[ProductName] ,O.[OrderDate],OrderDetails.Quantity,SUM(OrderDetails.Quantity) AS NUMBERORDER FROM OrderDetails 
	JOIN [Orders] AS O ON O.[OrderID] = OrderDetails.[OrderID]
	JOIN [Customers] AS C ON C.[CustomerID] = O.[CustomerID]
	JOIN [Products] AS P ON P.[ProductID] = OrderDetails.ProductID
GROUP BY C.[CustomerName] ,P.[ProductName],O.[OrderDate],OrderDetails.Quantity

SELECT * FROM 






