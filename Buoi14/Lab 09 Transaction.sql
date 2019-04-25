
--1.	Implicit transactions
CREATE TABLE A (COLI INT, COL2 CHAR(10) )
SET IMPLICIT_TRANSACTIONS ON 
	INSERT INTO A VALUES (1, 'A')
	INSERT INTO A VALUES (2, 'B')
	SELECT count(*) FROM A 
	ROLLBACK TRANSACTION 
	INSERT INTO A VALUES (3, 'C')
	SELECT count(*) FROM A 
	COMMIT TRANSACTION 
SET IMPLICIT_TRANSACTIONS OFF
--2.	Explicit transactions
use Northwind
BEGIN TRAN Tran2 
	SELECT productid, ProductName, UnitPrice 
	FROM Products WHERE CategoryID = 1 
	UPDATE Products 
	SET UnitPrice=UnitPrice+15 
	WHERE CategoryID = 1 
COMMIT TRAN 
SELECT productid, productname, UnitPrice 
FROM Products WHERE categoryID=1 
--3.	Using Rollback Transaction

use Northwind
SELECT PRODUCTID,PRODUCTNAME, UNITPRICE 
		FROM PRODUCTS 
		WHERE UNITPRICE=14 
UPDATE PRODUCTS 
		SET UNITPRICE=UNITPRICE+16 
		WHERE UNITPRICE=14 
IF @@ROWCOUNT>0
BEGIN 
	SELECT PRODUCTID,PRODUCTNAME, UNITPRICE 
	FROM PRODUCTS WHERE UNITPRICE =30 
	SELECT 'TRANSACTION IS ROLLED BACK ' 
ROLLBACK TRAN 
END
SELECT PRODUCTID, PRODUCTNAME, UNITPRICE 
FROM PRODUCTS WHERE UNITPRICE=30
--4.	Isolaton Levels
delete dbo.Item
CREATE TABLE dbo.Item (id INT, NAME VARCHAR(50))
INSERT INTO dbo.Item SELECT 1,'a'
INSERT INTO dbo.Item SELECT 2,'b'
INSERT INTO dbo.Item SELECT 3,'c'
SELECT * FROM dbo.Item
--	READ UNCOMMITTED
--Specifies that statements can read rows that have been modified by other transactions but not yet committed
--Example 1
--transaction 1
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN
UPDATE dbo.Item
	SET name = 'x'
	WHERE id>2
WAITFOR DELAY '00:00:10' --wait for 10 seconds
ROLLBACK
SELECT * FROM dbo.Item
--transaction 2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT * FROM dbo.Item
--	READ COMMITTED
--Specifies that statements cannot read data that has been modified but not committed by other transactions.
--Example 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
UPDATE dbo.Item
	SET name = 'x'
	WHERE id>2
WAITFOR DELAY '00:00:10' --wait for 10 seconds
ROLLBACK
SELECT * FROM dbo.Item
--transaction 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SELECT * FROM dbo.Item


--Example 2
--tran 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT * FROM dbo.Item
WAITFOR DELAY '00:00:10' --wait for 10 seconds
SELECT * FROM dbo.Item
COMMIT

--tran2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Item SELECT 5,'e'

--REPEATABLE READ
--Specifies that statements cannot read data that has been modified but not yet committed by other transactions 
--and that no other transactions can modify data that has been read by the current transaction until 
--the current transaction completes.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT * FROM dbo.Item
WAITFOR DELAY '00:00:10' --wait for 10 seconds
SELECT * FROM dbo.Item
COMMIT
--tran2

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
UPDATE dbo.Item
SET name = 'x'
WHERE id>2
SELECT * FROM item
--SERIALIZABLE
--Specifies the following:
--•	Statements cannot read data that has been modified but not yet committed by other transactions.
--•	No other transactions can modify data that has been read by the current transaction until the current transaction completes.
--•	Other transactions cannot insert new rows with key values that would fall in the range of keys read by any statements in the current transaction until the current transaction completes.
--Example 3
--tran 1
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
	SELECT * FROM dbo.Item
	WAITFOR DELAY '00:00:10' --wait for 10 seconds
	SELECT * FROM dbo.Item
COMMIT	
-- tran 2
INSERT INTO dbo.Item SELECT 4,'d'
SELECT * FROM dbo.Item
--SNAPSHOT



