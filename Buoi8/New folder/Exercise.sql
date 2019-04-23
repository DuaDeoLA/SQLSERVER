USE SELL_MANAGE
--Exercise 1
SELECT T1.ProductID,T1.ProductName,T1.selling_price,T2.CategoryName
FROM Product T1 JOIN Category T2 ON T1.CatagoryID = T2.CategoryID
--Exercise 2
SELECT T1.ProductID,T1.ProductName,T1.selling_price,T2.CategoryName
FROM Product T1 JOIN Category T2 ON T1.CatagoryID = T2.CategoryID
WHERE T2.CategoryName='Mountain Frames'
--Exercise 3
SELECT T1.OrderID,T1.CustomerID,T2.CustomerName,T1.OrderDate,T1.deliveryDate
FROM Orders T1 JOIN Customer T2 ON T1.CustomerID = T2.CustomerID
WHERE MONTH(T1.OrderDate)=09 AND YEAR(T1.OrderDate)=2018
--Exercise 4
SELECT T1.orderID,T1.ProductID,T2.ProductName,T2.selling_price, T1.buying_qty
FROM OrderDetail T1 JOIN Product T2 On T1.ProductID = T2.ProductID
--Exercise 5
SELECT T1.orderID,T1.ProductID,T2.ProductName,T2.selling_price, T1.buying_qty
FROM OrderDetail T1 JOIN Product T2 On T1.ProductID = T2.ProductID 
WHERE T1.orderID in (SELECT T3.OrderID
						FROM Orders T3 JOIN Customer T4 on T3.CustomerID = T4.CustomerID
						WHERE T4.CustomerName='Sam Abolrous')
--Exercise 6
SELECT T1.orderID,T1.ProductID,T2.ProductName,T2.selling_price, T1.buying_qty
FROM OrderDetail T1 JOIN Product T2 On T1.ProductID = T2.ProductID
WHERE T2.selling_price = (SELECT MAX(T4.selling_price) FROM OrderDetail T3 JOIN Product T4 On T3.ProductID = T4.ProductID)
--Exercise 7
SELECT T1.CustomerID,T2.CustomerName,COUNT(T1.OrderID) AS NUMBER
FROM Orders T1 JOIN Customer T2 ON T1.CustomerID = T2.CustomerID
GROUP BY T1.CustomerID,T2.CustomerName 
HAVING COUNT(T1.OrderID)=
(SELECT MAX (MX)
FROM(SELECT COUNT(OrderID) AS MX,CustomerID
FROM Orders
GROUP BY CustomerID) A)
--Exercise 8
SELECT T1.orderID,T1.ProductID,T2.ProductName,T2.selling_price, T1.buying_qty,T3.CategoryName
FROM  Product T2 
			JOIN OrderDetail T1 ON T1.ProductID = T2.ProductID
			JOIN Category T3 on T2.CatagoryID = T3.CategoryID
--Exercise 9			
SELECT T1.orderID,T1.ProductID,T2.ProductName,T2.selling_price, T1.buying_qty
FROM OrderDetail T1 JOIN Product T2 On T1.ProductID = T2.ProductID 
WHERE T1.orderID in (SELECT T3.OrderID
						FROM Orders T3 JOIN Customer T4 on T3.CustomerID = T4.CustomerID
						WHERE T4.CustomerName Like'%Abolrous%')
--Exercise 10
SELECT T1.orderID,T1.ProductID,T2.ProductName,T2.selling_price, T1.buying_qty,T3.CategoryName
FROM  Product T2 
			JOIN OrderDetail T1 ON T1.ProductID = T2.ProductID
			JOIN Category T3 on T2.CatagoryID = T3.CategoryID
WHERE T1.ProductID IN (SELECT ProductID FROM Orders T4 JOIN OrderDetail T5 ON T4.orderID = T5.orderID WHERE DAY(T4.OrderDate)=30 AND MONTH(T4.OrderDate)= 8 AND YEAR(T4.OrderDate)=2018)
--
SELECT T2.ProductName
FROM OrderDetail T1 JOIN Product T2 On T1.ProductID = T2.ProductID 
WHERE T1.orderID in (SELECT OrderID FROM Orders WHERE CustomerID='CUS01')
--
SELECT T2.CategoryName,SUM(T3.buying_qty)
FROM Product T1 JOIN Category T2 ON T1.CatagoryID = T2.CategoryID
				JOIN OrderDetail T3 ON T1.ProductID = T3.ProductID
GROUP BY T2.CategoryName
--SELECT SUM(buying_qty) FROM OrderDetail
SELECT AVG(selling_price) FROM Product
--
SELECT * 
FROM Product
WHERE selling_price > (SELECT AVG(selling_price) FROM Product AS A)
ORDER BY  selling_price DESC
--
SELECT T2.CustomerName
FROM Orders T1 JOIN Customer T2 ON T1.CustomerID = T2.CustomerID
WHERE MONTH(T1.OrderDate)=08 AND YEAR(T1.OrderDate)=2018