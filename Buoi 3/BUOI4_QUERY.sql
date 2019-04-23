USE BUOI4
--1.1
SELECT * FROM STAFF
GO
--1.2
SELECT ID,Name,Dept,Job
FROM STAFF
WHERE Salary>5000
--1.3
SELECT ID,Name,Dept,Job,0.05*Salary as 'Yearly Bonus'
FROM STAFF
WHERE Salary>5000
--1.4
WITH StaffBonus(ID,Name,Dept,Job,YearlyBonus)
AS
(
SELECT ID,Name,Dept,Job,0.05*Salary as 'YearlyBonus'
FROM STAFF
WHERE Salary>5000
)
SELECT * FROM StaffBonus
--SELECT INTO
SELECT ID,Name,Dept,Job,0.05*Salary as 'Yearly Bonus' INTO StaffBonus
FROM STAFF
WHERE Salary>5000
SELECT * FROM StaffBonus
--1.4
SELECT Name,Dept
FROM STAFF
WHERE [Name] like 'S%'
--1.5
SELECT count(Name),Dept,DeptName
FROM STAFF T1, DEPARTMENT T2
WHERE T1.Dept=T2.DeptNo
GROUP BY Dept,DeptName
SELECT * FROM DEPARTMENT
--1.6
SELECT count(*),sum(salary),Dept,DeptName
FROM STAFF T1, DEPARTMENT T2
WHERE T1.Dept=T2.DeptNo
GROUP BY Dept,DeptName
HAVING count(*)>2
--1.7
SELECT * 
FROM STAFF
WHERE Years>5 and Salary=5000

--1.8
SELECT * 
FROM STAFF
ORDER BY Salary
--1.9
SELECT TOP 5 * 
FROM STAFF
ORDER BY Salary DESC
--1.10
SELECT  DISTINCT Dept
FROM STAFF