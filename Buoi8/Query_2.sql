USE ST_EXAM
INSERT INTO APTECHSTUDENT VALUES('SV01','VU THI ANH THI','FEMALE');
WITH APTECHSTUDENTTemp(RollNo,FullName,Gender)
AS (Select * from APTECHSTUDENT)
SELECT * FROM APTECHSTUDENTTemp

INSERT INTO APTECHSTUDENT VALUES('SV02','HOANG GIA KHANH','MALE');
WITH APTECHSTUDENTTemp(RollNo,FullName,Gender)
AS (Select * from APTECHSTUDENT)
SELECT * FROM APTECHSTUDENTTemp

INSERT INTO APTECHSTUDENT VALUES('SV50','NGUYEN VAN NAM MUOI','MALE');
WITH APTECHSTUDENTTemp(RollNo,FullName,Gender)
AS (Select * from APTECHSTUDENT)
SELECT * FROM APTECHSTUDENTTemp

INSERT INTO APTECHSTUDENT VALUES('SV51','NGUYEN THI MUOI MOT','FEMALE');
WITH APTECHSTUDENTTemp(RollNo,FullName,Gender)
AS (Select * from APTECHSTUDENT)
SELECT * FROM APTECHSTUDENTTemp

DECLARE @ST_TABLE TABLE (RollNo char(30) ,FullName varchar(30) ,Gender varchar(6));
--Insert from  STUDENT
INSERT INTO @ST_TABLE (RollNo,FullName,Gender)
SELECT Rollno,StuName,Gender FROM STUDENT
--Insert from AptechStudent
INSERT INTO @ST_TABLE (RollNo,FullName,Gender)
SELECT * FROM APTECHSTUDENT
--Query
SELECT * FROM @ST_TABLE
SELECT * FROM STUDENT


SELECT Rollno,StuName,Gender FROM STUDENT AS T1
UNION
SELECT RollNo,FullName,Gender From APTECHSTUDENT AS T2


SELECT * FROM APTECHSTUDENT