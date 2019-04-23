CREATE  DATABASE SELL_MANAGE;
GO
USE  SELL_MANAGE;
CREATE TABLE Customer(
CustomerID char(10) PRIMARY KEY,
CustomerName varchar(50),
Tel nchar(15) not null,
Address varchar(100) not null,
)
CREATE TABLE Category(
CategoryID char(10) PRIMARY KEY,
CategoryName varchar(50),
)
CREATE TABLE Orders(
 OderID int PRIMARY KEY,
 CustomerID char(10) references  Customer(CustomerID),
 oderDate datetime,
 deliveryDate  datetime
)