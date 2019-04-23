-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF OBJECT_ID ( 'Cust_Proc', 'P' ) IS NOT NULL   
    DROP PROCEDURE Cust_Proc ;  
GO  
CREATE PROCEDURE Cust_Proc
	
AS
BEGIN
	SELECT * FROM Customer
	WHERE Tel IS NULL
END
GO

EXEC Cust_Proc
--
IF OBJECT_ID ( 'PriceIncrease', 'P' ) IS NOT NULL   
    DROP PROCEDURE PriceIncrease ;  
GO 
CREATE PROCEDURE PriceIncrease	
AS
BEGIN
	UPDATE Product SET selling_price= selling_price*1.1
END
GO
EXEC PriceIncrease	

--
sp_helptext 'PriceIncrease'	

ALTER TABLE Product
ADD  stock int;
-- 
DROP PROCEDURE stockupdate
CREATE PROCEDURE stockupdate
@item char(10), @stock int
AS
BEGIN
	UPDATE Product set stock=@stock where ProductID=@item
END
GO
EXECUTE stockupdate '1', 100;  

--
DROP PROCEDURE updateDelivery
CREATE PROCEDURE updateDelivery
@OrderID int, @Deliverydate datetime
AS
BEGIN
	DECLARE @OrderDate datetime;
	SELECT @OrderDate = OrderDate from Orders where OrderID=@OrderID
	IF @Deliverydate > @OrderDate
		UPDATE Orders SET deliveryDate=@Deliverydate where OrderID=@OrderID
	ELSE
	PRINT N'Deliverydate Must Great than OrderDate '; 
END
GO
EXECUTE updateDelivery 1, '2017-11-04 00:00:00.000';  
--
ALTER PROCEDURE PriceIncrease	
AS
BEGIN
	UPDATE Product SET selling_price= selling_price*1.1
	PRINT 'This is Increase Price to 10% in ' +convert(varchar(100),@@ROWCOUNT)  + ' row';
END
GO
EXEC PriceIncrease	
--
ALTER PROCEDURE Cust_Proc
	
AS
BEGIN
	SELECT * FROM Customer
	WHERE Tel IS NULL
	EXEC PriceIncrease
	PRINT 'Done!!!'
END
GO
EXEC Cust_Proc
--
select * 
  from SELL_MANAGE.information_schema.routines 
 where routine_type = 'PROCEDURE'