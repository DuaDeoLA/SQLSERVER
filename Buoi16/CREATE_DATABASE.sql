--CREATE DATABASE
DROP DATABASE IF EXISTS DB_COMPANY
CREATE DATABASE DB_COMPANY
--CREATE TABLE
USE DB_COMPANY

--CREATE TABKE PHONGBAN
DROP TABLE IF EXISTS PHONGBAN
CREATE TABLE PHONGBAN
(
	MaPB INT,
	TenPB varchar(30),
	TrPhong char(9),
	NgNhanChuc date,
	CONSTRAINT PK_MaPB  PRIMARY KEY (MaPB),
)
GO

DROP TABLE IF EXISTS TRUSO_PHONG
CREATE TABLE TRUSO_PHONG
(
	MaPhong int,
	Truso varchar(20),
	CONSTRAINT PK_Maphong PRIMARY KEY (MaPhong,Truso),
	CONSTRAINT FK_TRUSO_PHONGBAN FOREIGN KEY (MaPhong) REFERENCES PHONGBAN(MaPB)
)
GO
--CREATE TABLE NHAN VIEN 
DROP TABLE IF EXISTS NHANVIEN
CREATE TABLE NHANVIEN 
( 
	MaNV char(9),
	Ho varchar(15),
	Dem varchar(20),
	Ten varchar(15),
	Diachi varchar(70),
	NgSinh date,
	GTinh char(1),
	Luong int,
	MaGSat char(9),
	MaPhong int,
	CONSTRAINT PK_NHANVIEN PRIMARY KEY(MaNV),
	CONSTRAINT CHECK_GTINH CHECK(GTinh in ('M', 'F', 'm','f')),
	CONSTRAINT FK_NHANVIEN_PHONGBAN FOREIGN KEY (MaPhong) REFERENCES PHONGBAN(MaPB),
	
)
GO

DROP TABLE IF EXISTS DUAN
CREATE TABLE DUAN
(
	MaDA int,
	TenDA varchar(30),
	Diadiem varchar(40),
	PhQuanly int,
	CONSTRAINT PK_DUAN PRIMARY KEY (MaDA)

)
--CREATE TABLE THAMGIA
DROP TABLE IF EXISTS THAMGIA
CREATE TABLE THAMGIA
(
	MaNV char(9),
	MaDA int,
	SoGio real,
	CONSTRAINT PK_THAMGIA PRIMARY KEY (MaNV,MaDA),
	CONSTRAINT FK_THAMGIA_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
	CONSTRAINT FK_THAMGIA_DUAN FOREIGN KEY (MaDA) REFERENCES DUAN(MaDA)
)
--CREATE TABLE THANNHAN
DROP TABLE IF EXISTS THANNHAN
CREATE TABLE THANNHAN
(
	MaNV char(9),
	TenTN varchar(50),
	GTINH char(1),
	NgSinh date,
	Quanhe varchar(10),
	CONSTRAINT PK_THANNHAN PRIMARY KEY (MaNV,TenTN),
	CONSTRAINT FK_THANNHAN_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)
