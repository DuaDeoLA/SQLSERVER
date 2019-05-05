USE [StrongHold]
--a.	Create a non-clustered index on columns CName of the Customer table. Ensure that the intermediate and leaf levels of the index pages are 25% empty

CREATE NONCLUSTERED INDEX IX_Customer_CName
    ON Customer(Cname)
	WITH (FILLFACTOR = 75, pad_index = ON)
--b.	Create view named Order_info that contains the 
--Customer code, Customer Name, Phone no, Order date, Item Code, Quantity for all the orders.
GO
CREATE VIEW Order_info
AS
(
SELECT	T1.Ccode,T3.CName,T3.Cphone,T1.OrderDate,T2.Icode,T2.Qty
FROM OrderMaster AS T1
	JOIN OrderDetails AS T2 ON T1.OrderNo =T2.OrderNo
	JOIN Customer AS T3 ON T1.Ccode =T3.Ccode)
GO
SELECT * FROM Order_info

--c.Write a stored procedure named Process_counter that displays the 
--square values of numbers starting from 5, in descending order. When the number reaches a value 2, an error should be raised, and no more square values should be displayed.
GO
CREATE PROCEDURE Process_counter
AS
BEGIN
	DECLARE @DEM INT =5;
	WHILE @DEM>2 
		BEGIN
			PRINT  @DEM *@DEM
			SELECT	@DEM = @DEM-1
					END

	PRINT 'ERRO'
END

EXEC Process_counter
