use SELL_MANAGE;
--1	Display full information of products
select P.ProductID, P.ProductName [Name], P.selling_price Selling_price, C.CategoryName CategoryName 
from Product P
	join Category C on C.CategoryID = P.CatagoryID

--2 Display all of products which belong to category “Mountain Frames”
select P.ProductID, P.ProductName [Name], P.selling_price Selling_price 
from Product P
	join Category C on C.CategoryID = P.CatagoryID
where C.CategoryName = 'Mountain Frames'

--3 Display information of orders created in September, 2018
select O.OrderID, C.CustomerID, C.CustomerName, C.Tel, O.OrderDate, O.deliveryDate DeliveryDate
from Orders O
	join Customer C on C.CustomerID = O.CustomerID
where datepart(mm, O.OrderDate) = 9 and datepart(yy, O.OrderDate) = 2018

--4 Display order details of all orders. They contain name and selling price of each products. 
select O.*, P.ProductName, P.selling_price SellingPrice, buying_qty BuyingQTY, P.selling_price*buying_qty TotalPrice
from OrderDetail as OD
	join Orders O on O.OrderID = OD.orderID
	join Product P on P.ProductID = OD.ProductID

--5	Display orders of customer whose name is “Sam Abolrous”
select O.*
from Orders O
	join Customer C on C.CustomerID = O.CustomerID
where C.CustomerName = 'Sam Abolrous'

--6	Display products which have the max price in the list.
select * from Product
where selling_price = (select max(selling_price) from Product)

--7 Display the customers have the most number of orders.
with countOrder as
(
	select CustomerID, count(OrderID) as countOrder from Orders
	group by CustomerID
)
select * from Customer 
where CustomerID = 
	(
		select CustomerID from countOrder 
		where countOrder = (select max(countOrder) from countOrder)
	)

--8 Display full information of order details: 
--	Order ID, ProductName, category name, selling price, buying quantity
select o.orderID, p.ProductName, c.CategoryName, p.selling_price, o.buying_qty
from OrderDetail o
	join Product p on p.ProductID = o.ProductID
	join Category c on c.CategoryID = p.CatagoryID

--	10.	Display information of orders which were sold for customers whose name contain “Abolrous” characters. 
select o.*
from Orders o
	join Customer c on c.CustomerID = o.CustomerID
where c.CustomerName like '%Abolrous%'

--	11.	Display information of products which were sold in “30/08/2018”.
select p.* 
from OrderDetail od
	join orders o on o.OrderID = od.orderID
	join Product p on p.ProductID = od.ProductID
where o.deliveryDate = '2018/08/30'

--	12.	Display names of products which customer ‘CUS01’ bought.
select p.ProductName from Product p
	join OrderDetail od on od.ProductID = p.ProductID
	join Orders o on o.OrderID = od.orderID
where o.CustomerID = 'CUS01'

--	13.	 Display total quantity of products which sold for every product category.
select c.CategoryName, count (p.ProductID) as QuantitySoldProducts
from OrderDetail od
	join Orders o on o.OrderID = od.orderID
	join Product p on p.ProductID = od.ProductID
	join Category c on c.CategoryID = p.CatagoryID
group by c.CategoryName

-- 14.	Display products which have the price greater than price average of all products.
select * from Product
where selling_price > (select AVG(selling_price) from Product)

-- 15.	Display names of customers who bought products in  August, 2018
select c.CustomerName
from Orders o
	join Customer c on c.CustomerID = o.CustomerID
where DATEPART(mm, o.OrderDate) = 8 and DATEPART(yy, o.OrderDate) = 2018