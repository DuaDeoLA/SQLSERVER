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
ALTER PROCEDURE Process_counter
AS
BEGIN
	DECLARE @DEM INT =5;
	WHILE @DEM>0
		BEGIN
		IF (@DEM <>2)
			PRINT  @DEM *@DEM
		ELSE
			PRINT 'ERR'
		SELECT	@DEM = @DEM-1
		END
END

EXEC Process_counter
--d.	Write a stored procedure named Dis_amount that 
--accepts Customer code, Order No as parameters and display item code, item name, amount of money customer have to pay for each item.
GO
SELECT	T3.ICode,T3.Iname,(T3.Rate * T1.Qty) AS 'Amount'
FROM [OrderDetails] AS T1
	JOIN [OrderMaster] AS T2 ON T1.OrderNo=T2.OrderNo
	JOIN [Item] AS T3 ON T1.Icode = T3.ICode
WHERE T2.OrderNo='0256/99' AND T2.Ccode ='ULS'

GO
ALTER PROCEDURE Dis_amount 
@OrderNo char(10),@Ccode char(3)
AS
BEGIN
			SELECT	T3.ICode,T3.Iname,(T3.Rate * T1.Qty) AS 'Amount'
			FROM [OrderDetails] AS T1
				JOIN [OrderMaster] AS T2 ON T1.OrderNo=T2.OrderNo
				JOIN [Item] AS T3 ON T1.Icode = T3.ICode
			WHERE T2.OrderNo=@OrderNo AND T2.Ccode =@Ccode 
END

EXECUTE Dis_amount '0256/99','ULS'
--Create an INSERT trigger on item table to ensure that the prices of new products are not greater than 5000.
GO
CREATE TRIGGER Insert_Item ON  [dbo].[Item]
FOR INSERT
AS
	IF (SELECT Rate FROM inserted)>5000
	BEGIN
		PRINT 'Prices must less than 5000'
		ROLLBACK TRANSACTION
	END
--CHECK
INSERT INTO Item VALUES('RKSK-C','Rucksacks-Brown', 5100);
GO
--f.	Create an UPDATE trigger named CheckingUpdate on 
--OrderDetails table that ensure that the existing quantity in the OrderDetails table is not modified to value less than 0.

CREATE TRIGGER CheckingUpdate ON [dbo].[OrderDetails]
FOR UPDATE
AS
IF (SELECT Qty from inserted) < 0
	BEGIN
		PRINT 'Value insert must greater than 0'
		ROLLBACK TRANSACTION
	END
UPDATE [dbo].[OrderDetails] SET Qty= -1  WHERE [OrderNo]= N'0856/99' AND [SrNo]= 7 AND [Icode]='RKSK-T         ';
--g.	Create DELETE trigger to ensure that when delete records in OrderMaster tables,
-- the records in related table are also deleted.
GO
ALTER TRIGGER OrderMaster_DeleteTrigger ON [OrderMaster]
INSTEAD OF DELETE
AS
	BEGIN
		DELETE  FROM OrderDetails WHERE OrderNo IN (SELECT OrderNo FROM deleted);
		DELETE  FROM [OrderMaster] WHERE OrderNo IN (SELECT OrderNo FROM deleted)
	END
DELETE FROM [OrderMaster] WHERE [OrderNo]='0083/98' 
--h.	Create DELETE trigger that will not allow more than 2 records to be deleted from the OrderMaster table. 
CREATE TRIGGER OrderMaster_Deletenum ON [OrderMaster]
FOR DELETE
AS
	IF ( SELECT COUNT(*) FROM deleted)>2
	BEGIN
		PRINT 'More than 2 record has been delete from table OrderMaster'
		ROLLBACK TRANSACTION
	END
--i.	Create a table named item_backup which has the same structure with the item table. 
--Create DELETE trigger on item table to ensure that when the records in the item table are deleted, they are inserted into item_backup.
DROP TABLE IF EXISTS [item_backup]
CREATE TABLE [item_backup]
(
	ICode	Char(15),
	Iname	Char(50) NOT NULL,
	Rate	numeric(10,2) NOT NULL DEFAULT(0),
	CONSTRAINT PK_ICode_bk PRIMARY KEY (ICode),
	CONSTRAINT CHECK_Rate_bk CHECK( Rate >0)
)
GO
ALTER TRIGGER backup_item ON [Item]
AFTER DELETE
AS
	BEGIN
		INSERT INTO [item_backup]  SELECT * FROM deleted
	END
INSERT INTO Item VALUES('RKSK-D','Rucksacks-Brown', 400);
DELETE FROM [Item] WHERE ICode = 'RKSK-D';
SELECT * FROM [item_backup]