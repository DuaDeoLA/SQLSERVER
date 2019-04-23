CREATE VIEW vwPersonDetails
AS
SELECT
COALESCE(p.Title, ' ') AS Title
,p.[FirstName]
,COALESCE(p.MiddleName, ' ') AS MiddleName
,p.[LastName]
,e.[JobTitle]
FROM [HumanResources].[Employee] e
INNER JOIN [Person].[Person] p
ON p.[BusinessEntityID] = e.[BusinessEntityID]
GO

select * from vwProductInfo
exec sp_helptext vwPersonDetails
---
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber,Name,SafetyStockLevel,
ReOrderPoint
FROM Production.Product
WHERE SafetyStockLevel <=1000
WITH CHECK OPTION;
GO
--
UPDATE vwProductInfo SET SafetyStockLevel= 999
WHERE ProductID=321
--
