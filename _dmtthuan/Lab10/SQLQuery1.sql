use SELL_MANAGE
go

-- a. Create a stored procedure named Cust_Proc that will list all customers
-- which do not have telephone.

create proc Cust_Proc 
as begin
	select * from Customer where Tel is null
end
go

-- b. Create a stored procedure named PriceIncrease that will increment the selling price
-- of all items by 10 percent.

create proc PriceIncrease 
as begin
	update product set selling_price += (selling_price * 10 / 100)
end
go

-- c. Execute the stored procedure Cust_Proc and PriceIncrease.

exec Cust_Proc 
exec PriceIncrease

-- d. Now, view the definition of the PriceIncrease stored procedure 
-- by using sp_helptext system stored procedure.

sp_helptext PriceIncrease

-- e. Create a stored procedure named stockupdate 
-- that will update stock of given item by a given quantity.
 
alter table product add stock int
go

create proc stockupdate
	@item int , @quantity int
as begin
	update product set stock = @quantity where ProductID = @item; 
end
go

-- f. Create a stored procedure to update delivery date of given order. 
-- If delivery date is less than order date in order then display error message. 
-- Otherwise, procedure will update delivery date of that order. 

create proc updateDeliveryDate
	@orderID int , @deliveryDate datetime
as begin
	declare @orderDate datetime;
	select @orderDate = OrderDate from Orders where OrderID = @orderID;
	if (@deliveryDate < @orderDate)
		print 'Uppdate error! Delivery date is less than orderDate in order';  
	else 
		update Orders set deliveryDate = @deliveryDate where OrderID = @orderID;
end
go

-- g. Modify the PriceIncrease stored procedure 
-- such that it additionally returns the number of rows updated. 
-- (Hint: using @@ROWCOUNT)

alter proc PriceIncrease
as begin
	update product set selling_price += (selling_price * 10 / 100);
	select @@ROWCOUNT 'Number of rows updated';
end
go

-- h. Modify the Cust_Proc stored procedure 
-- such that it calls the PriceIncrease stored procedure within it.

alter proc Cust_Proc
as begin
	select * from Customer where Tel is null
	exec PriceIncrease
end
go

-- i. Remove all the stored procedures that were created so far.
Declare @procName varchar(max) 
Declare cur Cursor For Select [name] From sys.objects where type = 'p' 
Open cur 
Fetch Next From cur Into @procName 
While @@fetch_status = 0 
Begin 
 Exec('drop procedure ' + @procName) 
 Fetch Next From cur Into @procName 
End
Close cur 
Deallocate cur 

declare @numrow int = (select count(name) from sys.objects where type='p')
declare @i int = 1;
while (@i <= @numrow)
begin
	declare @name varchar(128)
	with nameProc as
	(
		Select ROW_NUMBER() OVER (ORDER BY [name]) AS id, [name] From sys.objects where type='p'
	)	
	select @name = [name] from nameProc where id = @i;
	
	Execute('drop procedure ' + @name) 
	set @i = @i + 1;
end