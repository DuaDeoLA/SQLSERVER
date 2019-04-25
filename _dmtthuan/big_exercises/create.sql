/*
	use master
	drop  database QLHangKhong
	go
*/

USE [master]
CREATE DATABASE [QLHangKhong]
GO
USE [QLHangKhong]
-----------------------------
/*
	ChuyenBay(MaCB, GaDi, GaDen, DoDai, GioDi, GioDen, ChiPhi) mô tả thông tin về chuyến bay. 
	Mỗi chuyến bay có một mã số duy nhất, đường bay, giờ đi và giờ đến. 
	Thông tin về đường bay được mô tả bởi ga đi, ga đến, độ dài đường bay và chi phí phải trả cho phi công.
*/
CREATE TABLE [ChuyenBay] (
    [MaCB]   CHAR(5)     PRIMARY KEY,
    [GaDi]   VARCHAR(50) NOT NULL,
    [GaDen]  VARCHAR(50) NOT NULL,
    [DoDai]  INT         NOT NULL,
    [GioDi]  TIME        NOT NULL,
    [GioDen] TIME,
    [ChiPhi] INT         NOT NULL)
GO
/*
	MayBay(MaMB, Loai, TamBay) mô tả thông tin về máy bay. 
	Mỗi máy bay có một mã số duy nhất, tên phân loại và tầm bay 
	là khoảng cách xa nhất máy bay có thể bay mà không cần tiếp nhiên liệu. 

	**Một máy bay chỉ có thể thực hiện các chuyến bay có độ dài đường bay nhỏ hơn tầm bay của máy bay đó.
*/
CREATE TABLE [MayBay] (
    [MaMB]   INT         PRIMARY KEY,
    [Loai]   VARCHAR(50) NOT NULL,
    [TamBay] INT         NOT NULL, )
GO
/*
	NhanVien(MaNV, Ten, Luong) mô tả thông tin về nhân viên phi hành đoàn gồm phi công và tiếp viên. 
	Mỗi nhân viên có một mã số duy nhất, tên và mức lương.
*/
CREATE TABLE [NhanVien] (
    [MaNV]  CHAR(9)     PRIMARY KEY,
    [Ten]   VARCHAR(50) NOT NULL,
    [Luong] INT         NOT NULL DEFAULT 0)
GO
/*
	ChungNhan(MaNV, MaMB) mô tả thông tin về khả năng điều khiển máy bay của phi công. 
	Nếu nhân viên là phi công thì nhân viên đó có chứng chỉ chứng nhận có thể lái một loại máy bay nào đó. 
	Một phi công chỉ có thể lái một chuyến bay nếu như phi công đó được chứng nhận có khả năng lái loại máy bay 
	có thể thực hiện chuyến bay đó.
*/
CREATE TABLE [ChungNhan] (
    [MaCN] INT     IDENTITY PRIMARY KEY,
    [MaNV] CHAR(9) NOT NULL REFERENCES [NhanVien] ([MaNV]),
    [MaMB] INT     NOT NULL REFERENCES [MayBay] ([MaMB]))
GO
----------------------------------
INSERT [ChuyenBay] VALUES ('VN216', 'SGN', 'DIN', 4170, CAST('10:30:00' AS TIME), CAST('14:20:00' AS TIME), 262)
INSERT [ChuyenBay] VALUES ('VN254', 'SGN', 'HUI', 8765, CAST('18:40:00' AS TIME), CAST('20:00:00' AS TIME), 781)
INSERT [ChuyenBay] VALUES ('VN269', 'HAN', 'CXR', 1262, CAST('14:10:00' AS TIME), CAST('15:50:00' AS TIME), 202)
INSERT [ChuyenBay] VALUES ('VN276', 'DAD', 'CXR', 1283, CAST('09:00:00' AS TIME), CAST('12:00:00' AS TIME), 203)
INSERT [ChuyenBay] VALUES ('VN280', 'SGN', 'HPH', 11979, CAST('06:00:00' AS TIME), CAST('08:00:00' AS TIME), 1279)
INSERT [ChuyenBay] VALUES ('VN315', 'HAN', 'DAD', 134, CAST('11:45:00' AS TIME), CAST('13:00:00' AS TIME), 112)
INSERT [ChuyenBay] VALUES ('VN317', 'HAN', 'UIH', 827, CAST('15:00:00' AS TIME), CAST('16:15:00' AS TIME), 190)
INSERT [ChuyenBay] VALUES ('VN320', 'SGN', 'DAD', 2798, CAST('06:00:00' AS TIME), CAST('07:10:00' AS TIME), 221)
INSERT [ChuyenBay] VALUES ('VN338', 'SGN', 'BMV', 4081, CAST('15:25:00' AS TIME), CAST('16:25:00' AS TIME), 375)
INSERT [ChuyenBay] VALUES ('VN374', 'HAN', 'VII', 510, CAST('11:40:00' AS TIME), CAST('13:25:00' AS TIME), 120)
INSERT [ChuyenBay] VALUES ('VN375', 'VII', 'CXR', 752, CAST('14:15:00' AS TIME), CAST('16:00:00' AS TIME), 181)
INSERT [ChuyenBay] VALUES ('VN431', 'SGN', 'CAH', 3693, CAST('05:55:00' AS TIME), CAST('06:55:00' AS TIME), 236)
INSERT [ChuyenBay] VALUES ('VN440', 'SGN', 'BMV', 4081, CAST('18:30:00' AS TIME), CAST('19:30:00' AS TIME), 426)
INSERT [ChuyenBay] VALUES ('VN464', 'SGN', 'DLI', 2002, CAST('07:20:00' AS TIME), CAST('08:05:00' AS TIME), 225)
INSERT [ChuyenBay] VALUES ('VN474', 'PXU', 'PQC', 1586, CAST('08:40:00' AS TIME), CAST('11:20:00' AS TIME), 102)
INSERT [ChuyenBay] VALUES ('VN476', 'UIH', 'PQC', 485, CAST('09:15:00' AS TIME), CAST('11:50:00' AS TIME), 117)
INSERT [ChuyenBay] VALUES ('VN651', 'DAD', 'SGN', 2798, CAST('19:30:00' AS TIME), CAST('08:00:00' AS TIME), 221)
INSERT [ChuyenBay] VALUES ('VN741', 'HAN', 'PXU', 395, CAST('06:30:00' AS TIME), CAST('08:30:00' AS TIME), 120)
GO

INSERT [MayBay] VALUES (154, 'Tupolev 154', 6565)
INSERT [MayBay] VALUES (319, 'Airbus A319', 2888)
INSERT [MayBay] VALUES (320, 'Airbus A320', 4168)
INSERT [MayBay] VALUES (340, 'Airbus A340 - 300', 11392)
INSERT [MayBay] VALUES (727, 'Boeing 727', 2406)
INSERT [MayBay] VALUES (737, 'Boeing 737 - 800', 5413)
INSERT [MayBay] VALUES (747, 'Boeing 747 - 400', 13488)
INSERT [MayBay] VALUES (757, 'Boeing 757 - 300', 6416)
INSERT [MayBay] VALUES (767, 'Boeing 767 - 400ER', 10360)
INSERT [MayBay] VALUES (777, 'Boeing 777 - 300', 10306)
GO

INSERT [NhanVien] VALUES ('011564812', 'Ton Van Quy', 153972)
INSERT [NhanVien] VALUES ('141582651', 'Doan Thi Mai', 178345)
INSERT [NhanVien] VALUES ('142519864', 'Nguyen Thi Xuan Dao', 227489)
INSERT [NhanVien] VALUES ('159542516', 'Le Van Ky', 48250)
INSERT [NhanVien] VALUES ('242518965', 'Tran Van Son', 120433)
INSERT [NhanVien] VALUES ('248965255', 'Tran Thi Ba', 43723)
INSERT [NhanVien] VALUES ('254099823', 'Nguyen Thi Quynh', 24450)
INSERT [NhanVien] VALUES ('269734834', 'Truong Tuan Anh', 289950)
INSERT [NhanVien] VALUES ('274878974', 'Mai Quoc Minh', 99890)
INSERT [NhanVien] VALUES ('287321212', 'Duong Van Minh', 48090)
INSERT [NhanVien] VALUES ('310454876', 'Ta Van Do', 212156)
INSERT [NhanVien] VALUES ('310454877', 'Tran Van Hao', 33546)
INSERT [NhanVien] VALUES ('348121549', 'Nguyen Van Thanh', 32899)
INSERT [NhanVien] VALUES ('355548984', 'Tran Thi Hoai An', 212156)
INSERT [NhanVien] VALUES ('356187925', 'Nguyen Vinh Bao', 44740)
INSERT [NhanVien] VALUES ('390487451', 'Le Van Luat', 212156)
INSERT [NhanVien] VALUES ('489221823', 'Bui Quoc Chinh', 23980)
INSERT [NhanVien] VALUES ('489456522', 'Nguyen Thi Quy Linh', 127984)
INSERT [NhanVien] VALUES ('548977562', 'Le Van Quy', 84476)
INSERT [NhanVien] VALUES ('550156548', 'Nguyen Thi Cam', 205187)
INSERT [NhanVien] VALUES ('552455318', 'La Que', 101745)
INSERT [NhanVien] VALUES ('552455348', 'Bui Thi Dung', 92013)
INSERT [NhanVien] VALUES ('567354612', 'Quan Cam Ly', 256481)
INSERT [NhanVien] VALUES ('574489457', 'Bui Van Lap', 20)
GO

INSERT [ChungNhan] VALUES ('567354612', 747)
INSERT [ChungNhan] VALUES ('567354612', 737)
INSERT [ChungNhan] VALUES ('567354612', 757)
INSERT [ChungNhan] VALUES ('567354612', 777)
INSERT [ChungNhan] VALUES ('567354612', 767)
INSERT [ChungNhan] VALUES ('567354612', 727)
INSERT [ChungNhan] VALUES ('567354612', 340)
INSERT [ChungNhan] VALUES ('552455318', 737)
INSERT [ChungNhan] VALUES ('552455318', 319)
INSERT [ChungNhan] VALUES ('552455318', 747)
INSERT [ChungNhan] VALUES ('552455318', 767)
INSERT [ChungNhan] VALUES ('390487451', 340)
INSERT [ChungNhan] VALUES ('390487451', 320)
INSERT [ChungNhan] VALUES ('390487451', 319)
INSERT [ChungNhan] VALUES ('274878974', 757)
INSERT [ChungNhan] VALUES ('274878974', 767)
INSERT [ChungNhan] VALUES ('355548984', 154)
INSERT [ChungNhan] VALUES ('310454876', 154)
INSERT [ChungNhan] VALUES ('142519864', 747)
INSERT [ChungNhan] VALUES ('142519864', 757)
INSERT [ChungNhan] VALUES ('142519864', 777)
INSERT [ChungNhan] VALUES ('142519864', 767)
INSERT [ChungNhan] VALUES ('142519864', 737)
INSERT [ChungNhan] VALUES ('142519864', 340)
INSERT [ChungNhan] VALUES ('142519864', 320)
INSERT [ChungNhan] VALUES ('269734834', 747)
INSERT [ChungNhan] VALUES ('269734834', 737)
INSERT [ChungNhan] VALUES ('269734834', 340)
INSERT [ChungNhan] VALUES ('269734834', 757)
INSERT [ChungNhan] VALUES ('269734834', 777)
INSERT [ChungNhan] VALUES ('269734834', 767)
INSERT [ChungNhan] VALUES ('269734834', 320)
INSERT [ChungNhan] VALUES ('269734834', 319)
INSERT [ChungNhan] VALUES ('269734834', 727)
INSERT [ChungNhan] VALUES ('269734834', 154)
INSERT [ChungNhan] VALUES ('242518965', 737)
INSERT [ChungNhan] VALUES ('242518965', 757)
INSERT [ChungNhan] VALUES ('141582651', 737)
INSERT [ChungNhan] VALUES ('141582651', 757)
INSERT [ChungNhan] VALUES ('141582651', 767)
INSERT [ChungNhan] VALUES ('011564812', 737)
INSERT [ChungNhan] VALUES ('011564812', 757)
INSERT [ChungNhan] VALUES ('574489457', 154)
GO