CREATE DATABASE HANGKHONG

USE HANGKHONG
-- Create table Employees
DROP TABLE IF EXISTS [dbo].CHUYENBAY 
CREATE TABLE CHUYENBAY 
(
	MaCB char(5),
	GaDi varchar(50),
	GaDen varchar(50),
	DoDai int,
	GioDi time,
	GioDen time,
	ChiPhi int,
	CONSTRAINT PK_MaCB
    PRIMARY KEY(MaCB)
)