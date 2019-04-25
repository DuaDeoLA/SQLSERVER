--Exercise 21
--1.	Create  separate  tables  to  store  student  details,  marks  details, employee details, salary details, and course details.
--2.	Create required columns in each table to store the relevant details.
--3.	Use appropriate data types for the columns to store the different type of data such as name, phone, email, salary, fees, and so on as per requirement.
--4.	Apply appropriate check constraints on the type of data to be stored in the respective columns.
--5.	Set the primary and foreign key constraints on appropriate columns to relate the relevant tables.
--6.	Insert  new  records  in  each  table  and  verify  that  all  the  check constraints are working properly.
--7.	Update and delete records in the table to ensure primary and foreign key constraints are working properly.
--8.	Identify columns that may hold null value and apply constraints accordingly.
--create STUDENT TABLE
CREATE DATABASE ST_EXAM
go
use [ST_EXAM]
CREATE TABLE [Student](
	[Rollno] [char](10) NOT NULL,
	[StuName] [varchar](30) NULL,
	[Gender] [varchar](10) NULL CHECK (Gender ='male' OR Gender ='female' ),
	[Address] [varchar](1000) NULL,
	PRIMARY KEY (Rollno)
	)

GO
--create SUBJECT TABLE
CREATE TABLE [Subject](
	[SubID] [char](10) NOT NULL,
	[SubName] [varchar](50) NOT NULL,
	[Theory] [int] NULL CHECK (Theory>=0),
	[Lab] [int] NULL CHECK (Lab>=0),
	PRIMARY KEY (SubID)
	) 

GO
--create EXAMMARK TABLE
CREATE TABLE [Exammark](
	[Rollno] [char](10) NOT NULL,
	[SubID] [char](10) NOT NULL,
	[Examtimes] [int] NOT NULL CHECK (Examtimes=1 or Examtimes=2 ),
	[Marks] [int] NULL CHECK (Marks>=0 and Marks<=100),	
    CONSTRAINT FK_RollnoEX FOREIGN KEY (Rollno)  REFERENCES STUDENT(Rollno),
    CONSTRAINT FK_SubIDEX FOREIGN KEY (SubID)  REFERENCES [SUBJECT](SubID),
	PRIMARY KEY ([Rollno],[SubID],[Examtimes])
	)

GO

--create DEPARTMENT TABLE
CREATE TABLE [Department](
	[DeptNo] [char](3) NOT NULL,
	[DeptName] [varchar](36) NOT NULL,
	[MgrNo] [smallint] NULL,
	[AdmrDept] [char](3) NOT NULL,	
	[Location] [char](16) NULL,	
	PRIMARY KEY (DeptNo),
    CONSTRAINT FK_AdmrDept FOREIGN KEY (AdmrDept)  REFERENCES [DEPARTMENT](DeptNo)
	)

GO
--create STAFF TABLE
CREATE TABLE [Staff](
	[ID] [smallint]NOT NULL,
	[Name] [varchar](9) NOT NULL,
	[Dept] [char](3) NOT NULL,
	[Job] [char](10) NULL,	
	[Years] [smallint] NULL,		
	[Salary] [Numeric](18,0) NULL default 100,		
	[Comm] [Numeric](7,2) NULL,
	PRIMARY KEY (ID),
    CONSTRAINT FK_Dept FOREIGN KEY (Dept)  REFERENCES [DEPARTMENT](DeptNo)
	)

GO



