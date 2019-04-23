USE SELL_MANAGE
GO
--
CREATE NONCLUSTERED INDEX IX_Productname ON Product(ProductName) 
WITH( FILLFACTOR = 25);   
GO
--
CREATE INDEX IX_Cus ON Customer([Address],tel);
--
sp_helpindex 'Product'
--
CREATE NONCLUSTERED INDEX IX_CategoName ON Category(CategoryName)
WITH(ONLINE=ON);
GO
sp_helpindex 'Category'
--
ALTER INDEX IX_CategoName ON Category
REBUILD WITH (ONLINE=OFF);
GO

DROP INDEX IX_CategoName ON Category;
G0

