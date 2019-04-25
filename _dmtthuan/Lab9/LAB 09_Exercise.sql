use SELL_MANAGE
go
-- a.Create a view named cus_order_vw based on information from Customer and Orders table. 
-- The information that is to be included in th view is given below: 
-- OrderId, CustomerId, CustomerName, OrderDate, deliveryDate.
create view cus_order_vw
as
	select o.OrderID, o.CustomerID, c.CustomerName, o.OrderDate, o.deliveryDate
	from Orders o
		join Customer c on c.CustomerID = o.CustomerID
go

-- b.Test the view by displaying information from it. Display all the record in the view.
-- Display only the top 3 record in the view alphabetically sorted by Customer name.
select * from cus_order_vw
select top(3) * from cus_order_vw order by CustomerName
go

-- c.Change the view such as that the CustomerID is no longer visible in the view.
alter view cus_order_vw
as
	select o.OrderID, c.CustomerName, o.OrderDate, o.deliveryDate
	from Orders o
		join Customer c on c.CustomerID = o.CustomerID
go

-- d. Finally, assuming that the view is not proving useful and many managers have not
-- used it. Write the statements to remove the view.
drop view cus_order_vw
go

-- e. Create view named Product_Report_vw to report that 
-- how many motorbike of each category that shop man have sold in October?
create view Product_Report_vw
as
	select c.CategoryName, count(p.ProductID) Quantily
	from Product p
		join Category c on c.CategoryID = p.CatagoryID
		join OrderDetail od on od.ProductID = p.ProductID
		join Orders o on o.OrderID = od.orderID
	where datepart(mm, o.OrderDate) = 10
	group by c.CategoryID, c.CategoryName
go

-- f. Create view named product_vw, display all items which selling price over 20000000
-- The view will need to check for domain integrity by using ‘WITH CHECK OPTION’ option.
create view product_vw
as
	select * from Product p
	where selling_price > 20000000
	with check option
go

-- g. Modifying product_vw view the following:
-- Inserting a product into view with price is 23000000 with the following information:
-- 'SP07', 'Nouvo', 20, 23000000, 'MADE IN JAPAN, 115 CUBIC CENTIMETRES', 'ML02'
-- Altering view with price of the product named ‘JUPITER MX’ into 20000000.
insert product_vw values(999, 'Nouvo', 23000000, 20)
insert product_vw values(1000, 'Jupiter Mx', 20000000, 20)
select * from product_vw
select * from Product where ProductID = 999

-- h. Display the actual text for Product_Report_vw view.
sp_helptext Product_Report_vw