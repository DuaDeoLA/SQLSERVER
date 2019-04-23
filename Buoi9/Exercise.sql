USE SELL_MANAGE
--A
CREATE VIEW cus_order_vw  AS
SELECT T1.OrderID,T1.CustomerID,T2.CustomerName,T1.OrderDate,T1.deliveryDate
FROM Orders T1 JOIN Customer T2 ON T1.CustomerID = T2.CustomerID
--B 
SELECT TOP 3 * 
FROM cus_order_vw 
ORDER BY CustomerName
--C
ALTER VIEW cus_order_vw AS
SELECT T1.OrderID,T2.CustomerName,T1.OrderDate,T1.deliveryDate
FROM Orders T1 JOIN Customer T2 ON T1.CustomerID = T2.CustomerID
--D
DROP VIEW cus_order_vw
--E
SELECT T1.orderID,T1.ProductID,T2.ProductName,T2.selling_price, T1.buying_qty,T3.CategoryName
FROM  Product T2 
			JOIN OrderDetail T1 ON T1.ProductID = T2.ProductID
			JOIN Category T3 on T2.CatagoryID = T3.CategoryID
WHERE (T1.ProductID IN (SELECT ProductID FROM Orders T4 JOIN OrderDetail T5 ON T4.orderID = T5.orderID WHERE  MONTH(T4.OrderDate)= 10)) AND T3.CategoryName='Mountain Bikes'
--
CREATE VIEW product_vw 
AS
SELECT * FROM Product ORDER BY ProductID
WHERE selling_price>20000000
WITH CHECK OPTION 
GO

INSERT INTO product_vw VALUES(300, 'Nouvo', 23000000,2)

UPDATE product_vw  SET selling_price=20000000 WHERE ProductName='Nouvo'

sp_helptext  product_vw
