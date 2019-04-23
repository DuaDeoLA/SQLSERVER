create database BUOI4
create table STUDENT
(Rollno	Char(10) Primary key,
StuName	Varchar(30)	Not null,
Gender	Varchar(10)	Not null check(Gender in('male','female')),
Address	Varchar(100),	
);
create table SUBJECT
(
SubID Char(10) Primary key,
SubName	Varchar(50)	NOT NULL,
Theory Int	check(Theory>0),
Lab	Int	check(Lab>0),
);
create table EXAMMARK
(
Rollno Char(10) references STUDENT(Rollno),
SubID Char(10) references SUBJECT(SubID),
Examtimes Int check(Examtimes in(1,2)),
Marks Int check(Marks between 0 and 100),
);

create table DEPARTMENT
(
DeptNo Char(3) Primary key,
DeptName varchar(36) Not null,
MgrNo Smallint Not null,
AdmrDept char (3) Not null references DEPARTMENT(DeptNo),
Location char (16)
);
create table STAFF
(
ID Smallint Primary key,
Name Varchar(9) Not null,
Dept Char(3) Not null references DEPARTMENT(DeptNo),
Job	Char(10),	
Years Smallint,	
Salary Numeric(18,0) Default 100,
Comm Numeric(7,2)	
);
insert into DEPARTMENT(DeptNo,DeptName,MgrNo,AdmrDept) values('A00','SPIFFY COMPUTER SERVICE DIV.',1,'A00')
insert into DEPARTMENT(DeptNo,DeptName,MgrNo,AdmrDept) values('B01','PLANNING',3,'A00')
insert into DEPARTMENT(DeptNo,DeptName,MgrNo,AdmrDept) values('C01','SALE',2,'B01')
insert into DEPARTMENT(DeptNo,DeptName,MgrNo,AdmrDept) values('D01','DEVELOPMENT CENTER',10,'B01')
insert into DEPARTMENT(DeptNo,DeptName,MgrNo,AdmrDept) values('D11','MANUFACTURING SYSTEMS',8,'B01')
insert into DEPARTMENT(DeptNo,DeptName,MgrNo,AdmrDept) values('D21','ADMINISTRATION SYSTEMS',9,'D01')


