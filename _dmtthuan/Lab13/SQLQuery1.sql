use NORTHWND
go

-- 1. Create function named TotalAmount to display amount of money have to pay for the order. OrderID is the input parameter.
create function dbo.TotalAmount (@OrderID int)
	returns money
as begin
	return (select sum(UnitPrice*Quantity - Discount*UnitPrice*Quantity) from [Order Details] where OrderID = @OrderID)
end 
go

select OrderID, dbo.TotalAmount(OrderID) as 'Amount of money have to pay' from Orders
go

-- 2.	Create function named NumberOfCustomer to return how many customers from the Country. Country is the parameter.
-- Call the function to check the result.
create function dbo.NumberOfCustomer(@Country nvarchar(15))
	returns int
as begin
	return (select count(CustomerID) from Customers where Country = @Country)
end 
go

select Country, dbo.NumberOfCustomer(Country) as 'Number of customers from the country' from Customers
group by Country
go

-- 3. Create a function to return list of products which have sum of selling quantity greater than 1000. 
-- Information of products includes: ProductID, ProductName, UnitPrice, TotalSelling
-- Call the function to check the result.
create function dbo.SellingQuantityGreater1000()
returns table as return
(
	select p.ProductID, p.ProductName, p.UnitPrice
	from [Order Details] od
		join Products p on p.ProductID = od.ProductID
	group by p.ProductID, p.ProductName, p.UnitPrice
	having sum(od.Quantity)>1000
)
Go

select * from dbo.SellingQuantityGreater1000()
go

-- 4. To calculate salary for salesmen, manager would like to know total amount of money each salesman have been sold. 
-- Write a function to display information as follow: EmployeeID, LastName, FirstName, TotalAmount 
create function dbo.TotalAmountOfMoney(@EmloyeeID int)
	returns money
as begin 
	return 
	(
		select sum(od.UnitPrice*od.Quantity - od.Discount*od.UnitPrice * od.Quantity)
		from Orders o join [Order Details] od on od.OrderID = o.OrderID 
		where o.EmployeeID = @EmloyeeID
	)
end
go

select EmployeeID, LastName, FirstName, dbo.TotalAmountOfMoney(EmployeeID) TotalAmount
from Employees
go

-- 5. Write a function to display infomation of product having the highest selling quantity in the specific month. 
create function dbo.HighestSellingQuantity(@month int)
returns table as return
(
	with TotalQuantity as
	(
		select od.ProductID, sum(od.Quantity) Quantity
		from Products p 
			join [Order Details] od on od.ProductID = p.ProductID
			join Orders o on o.OrderID = od.OrderID
		where datepart(mm,o.OrderDate) = @month
		group by od.ProductID
	)
	select * from Products 
	where ProductID = (select ProductID from TotalQuantity where Quantity = (select max(Quantity) from TotalQuantity))
)
go

select * from dbo.HighestSellingQuantity(3)

-- 6. Drop function TotalAmount.
drop function dbo.TotalAmount
go

-- 7. Display list of orders with the number of detail for each Order.
create function dbo.NumberOfDetail(@orderID int)
	returns int
as begin 
	return
	(
		select count(o.OrderID)
		from Orders o
			join [Order Details] od on od.OrderID = o.OrderID
		where o.OrderID = @orderID
	)
end
go

select *, dbo.NumberOfDetail(OrderID) NumberOfDetail from Orders
go

-- 8. Write a query to display CategoryId, CategoryName, ProductName, Amount of money has been sold 
-- and ranks of the products in each Category which are ordered by amount in descending order.

select p.CategoryId, c.CategoryName, p.ProductName,	sum(dbo.TotalAmount(od.OrderID)) 'Amount of money has been sold',
	RANK() over (partition by p.CategoryId order by sum(dbo.TotalAmount(od.OrderID)) desc) 'Rank'
from [Order Details] od
	join Products p on p.ProductID = od.ProductID
	join Categories c on c.CategoryID = p.CategoryID
group by p.CategoryId, c.CategoryName, p.ProductName
go