USE northwind
GO

SET NOCOUNT ON;

DECLARE @ProductID int
	,@ProductName nvarchar(40)
	,@SupplierID int
	,@CategoryID int
	,@QuantityPerUnit nvarchar(20)
	,@UnitPrice money
	,@UnitsInStock smallint
	,@UnitsOnOrder smallint
	,@ReorderLevel smallint
	,@Discountinued bit;
PRINT '-------- Vendor Products Report --------';  
--Declare Cursor
DECLARE ProductCursor CURSOR FOR   
SELECT * 
FROM Products
 --Open and fetch all row on table 
OPEN ProductCursor

IF @@ROWCOUNT >0
	BEGIN
		FETCH NEXT FROM ProductCursor INTO				@ProductID
														,@ProductName
														,@SupplierID 
														,@CategoryID
														,@QuantityPerUnit 
														,@UnitPrice 
														,@UnitsInStock 
														,@UnitsOnOrder 
														,@ReorderLevel 
														,@Discountinued;
	
	END

