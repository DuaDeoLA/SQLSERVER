use sell_manage
-- a.	Create a non-clustered index IX_ProName on Productname column of Product table. 
-- Ensure that the intermediate and leaf levels of index pages are 25% empty by setting the fill factor value.

if exists (select name from sys.indexes where name = 'IX_ProName')
	drop index IX_ProName on Product
create nonclustered index IX_ProName on Product(ProductName) 
with fillfactor = 25

-- b. Create composite index IX_Cus on address and tel columns of Customer table.

if exists (select name from sys.indexes where name = 'IX_Cus')
	drop index IX_Cus on Customer
create nonclustered index IX_Cus on Customer([address], tel)

-- c. View all the indexes that have been created on Product table using the sp_helpindex.

sp_helpindex Product

-- d. Create a non-clustered index IX_CategoName on CategoryName column of Category table, 
-- so that while the index is being created,
-- the table and the indexes can be used for queries and data modification.
-- Hint: Using with (online=on)

if exists (select name from sys.indexes where name = 'IX_CategoName')
	drop index IX_CategoName on Category
create nonclustered index IX_CategoName on Category(CategoryName) with (online=on)

-- e. Alter and rebuild the index IX_CategoName created on Category table, 
-- so that the table and indexes cannot be used for queries and data modification.
-- Hint: Using with (online=off)

alter index IX_CategoName on Category rebuild with (online=off)

-- f. Drop index IX_CategoName on Category table using the drop statement.

drop index IX_CategoName on Category

-----------------------------------------------------------
-- a. Declare cursor named ProductCusor including all rows and all columns in the Product table. 
-- b. Open and fetch all rows of ProductCusor cursor. 
-- c. Close and deallocate ProductCusor cursor.

declare  @id char(10), @name varchar(50), @price int, @catagory char(10)
declare ProductCusor cursor 
scroll for 
select ProductID, ProductName, selling_price, CatagoryID from Product
open ProductCusor
--fetch next from ProductCusor into @id, @name, @price, @catagory
select @@cursor_rows
close ProductCusor
deallocate ProductCusor;  




if @@rowcount > 0
begin	
	fetch next from ProductCusor into @id, @name, @price, @catagory
	while @@fetch_status = 0
	begin		
		print ' ad'
		--print convert(varchar(10),@id) + '	' + convert(varchar(100),@name) + '	' + convert(varchar(10),@price) + '	' + convert(varchar(10),@catagory)
		fetch next from ProductCusor into @id, @name, @price, @catagory
	end
end
close ProductCusor
deallocate ProductCusor;  
set nocount off

d.	Using Northwind database to create a SCROLL cursor named SuppliersCursor which contains all suppliers from ‘UK’ and ‘USA’. 
Open and display the first and the last rows from cursor.
Close and deallocate SuppliersCursor cursor.
