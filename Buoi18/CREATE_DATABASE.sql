USE master
DROP DATABASE IF EXISTS [StrongHold]
CREATE DATABASE [StrongHold] 
 ON  PRIMARY 
( NAME = N'StrongHold', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\StrongHold.mdf' , SIZE = 8192KB , MAXSIZE = 102400KB , FILEGROWTH = 2048KB )
 LOG ON 
( NAME = N'StrongHold_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\StrongHold_log.ldf' , SIZE = 8192KB , MAXSIZE = 51200KB , FILEGROWTH = 1024KB )
GO
--
USE [StrongHold]
CREATE TYPE Ordertype FROM char(10) NOT NULL
GO
--
GO
DROP TABLE IF EXISTS [Customer]
CREATE TABLE [Customer]
(
	Ccode Char(3),
	CName Char(50),
	Caddress VarChar(100) NOT NULL DEFAULT(''),
	Cphone Char(15) DEFAULT(''),
	CONSTRAINT PK_Cphone PRIMARY KEY (Ccode)
)
GO
DROP TABLE IF EXISTS [Item]
CREATE TABLE [Item]
(
	ICode	Char(15),
	Iname	Char(50) NOT NULL,
	Rate	numeric(10,2) NOT NULL DEFAULT(0),
	CONSTRAINT PK_ICode PRIMARY KEY (ICode),
	CONSTRAINT CHECK_Rate CHECK( Rate >0)
)
GO
DROP TABLE IF EXISTS [OrderMaster]
CREATE TABLE [OrderMaster]
(
	OrderNo	Ordertype,
	OrderDate	Datetime NOT NULL DEFAULT(GETDATE()),
	Ccode	Char(3),
	CONSTRAINT PK_OrderNo PRIMARY KEY (OrderNo),
	CONSTRAINT FK_OrderMaster_Customer FOREIGN KEY (Ccode) REFERENCES Customer(Ccode)
)
GO
DROP TABLE IF EXISTS [OrderDetails]
CREATE TABLE [OrderDetails]
(
	
	OrderNo	Ordertype,
	SrNo	Bigint,
	Icode	Char(15),
	Qty	Int,
	CONSTRAINT PK_SrNo PRIMARY KEY (SrNo),
	CONSTRAINT FK_OrderDetails_OrderMaster FOREIGN KEY (OrderNo) REFERENCES OrderMaster(OrderNo),
	CONSTRAINT FK_OrderDetails_Item FOREIGN KEY (Icode) REFERENCES Item(Icode)

)
GO
ALTER TABLE ITEM
ADD CONSTRAINT CHECK_ICODE CHECK(SUBSTRING(Icode,1,1) = 'S' OR SUBSTRING(Icode,1,1) = 'R')

GO
INSERT [dbo].[Customer] ([Ccode], [CName], [Caddress], [Cphone]) VALUES (N'GHL', N'Great Holidays Ltd.                               ', N'1, Lydia''s Avenue, Durham-41', N'115-72-43      ')
INSERT [dbo].[Customer] ([Ccode], [CName], [Caddress], [Cphone]) VALUES (N'TLT', N'Travelite Ltd.                                    ', N'22, Rodeo Drive, Manhattan-11', N'null           ')
INSERT [dbo].[Customer] ([Ccode], [CName], [Caddress], [Cphone]) VALUES (N'ULS', N'United Luggage Services                           ', N'14, Park Avenue, NY-27', N'123-56-34      ')
INSERT [dbo].[Item] ([ICode], [Iname], [Rate]) VALUES (N'RKSK-B         ', N'Rucksacks-Brown                                   ', CAST(450.00 AS Numeric(10, 2)))
INSERT [dbo].[Item] ([ICode], [Iname], [Rate]) VALUES (N'RKSK-T         ', N'Rucksacks-Tan                                     ', CAST(500.00 AS Numeric(10, 2)))
INSERT [dbo].[Item] ([ICode], [Iname], [Rate]) VALUES (N'STCS-24-S-DB   ', N'Suitcase 24'''', Soft, Dark Brown                   ', CAST(1575.00 AS Numeric(10, 2)))
INSERT [dbo].[Item] ([ICode], [Iname], [Rate]) VALUES (N'STCS-28-S-B    ', N'Suitcase 28'''', Soft, Blue                         ', CAST(1790.00 AS Numeric(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderNo], [SrNo], [Icode], [Qty]) VALUES (N'0083/98   ', 1, N'RKSK-T         ', 100)
INSERT [dbo].[OrderDetails] ([OrderNo], [SrNo], [Icode], [Qty]) VALUES (N'0083/98   ', 2, N'STCS-24-S-DB   ', 100)
INSERT [dbo].[OrderDetails] ([OrderNo], [SrNo], [Icode], [Qty]) VALUES (N'0256/99   ', 3, N'STCS-24-S-DB   ', 50)
INSERT [dbo].[OrderDetails] ([OrderNo], [SrNo], [Icode], [Qty]) VALUES (N'0703/99   ', 4, N'RKSK-T         ', 70)
INSERT [dbo].[OrderDetails] ([OrderNo], [SrNo], [Icode], [Qty]) VALUES (N'0703/99   ', 5, N'STCS-24-S-DB   ', 30)
INSERT [dbo].[OrderDetails] ([OrderNo], [SrNo], [Icode], [Qty]) VALUES (N'0704/99   ', 6, N'RKSK-T         ', 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [SrNo], [Icode], [Qty]) VALUES (N'0856/99   ', 7, N'RKSK-T         ', 120)
INSERT [dbo].[OrderMaster] ([OrderNo], [OrderDate], [Ccode]) VALUES (N'0083/98   ', CAST(N'1998-12-30T00:00:00.000' AS DateTime), N'TLT')
INSERT [dbo].[OrderMaster] ([OrderNo], [OrderDate], [Ccode]) VALUES (N'0256/99   ', CAST(N'1999-10-06T00:00:00.000' AS DateTime), N'ULS')
INSERT [dbo].[OrderMaster] ([OrderNo], [OrderDate], [Ccode]) VALUES (N'0703/99   ', CAST(N'1999-10-15T00:00:00.000' AS DateTime), N'TLT')
INSERT [dbo].[OrderMaster] ([OrderNo], [OrderDate], [Ccode]) VALUES (N'0704/99   ', CAST(N'1999-10-15T00:00:00.000' AS DateTime), N'ULS')
INSERT [dbo].[OrderMaster] ([OrderNo], [OrderDate], [Ccode]) VALUES (N'0856/99   ', CAST(N'1999-10-09T00:00:00.000' AS DateTime), N'TLT')
