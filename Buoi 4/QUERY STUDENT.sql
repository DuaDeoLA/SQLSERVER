--
USE BUOI4
GO
--3.1
ALTER TABLE STAFF
ADD PHONENO char(15)
GO
--3.2
ALTER TABLE STAFF
 ADD CHECK (PHONENO LIKE '0%')
 GO
--3.3
INSERT INTO STAFF VALUES(11,'Mary','D01','Mgr',1,4500,NULL,'0123456');
--SELECT * FROM STAFF
--DROP TABLE STAFF
ALTER TABLE STAFF
DROP CONSTRAINT CK__STAFF__PHONENO__398D8EEE ;
ALTER TABLE STAFF
DROP COLUMN PHONENO 
GO
--3.5
ALTER TABLE DEPARTMENT
ADD UNIQUE (MgrNo);
--3.6
UPDATE DEPARTMENT SET MgrNo=9 WHERE DeptNo ='D01';