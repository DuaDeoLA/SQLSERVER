--/*
	use master
	drop  database QLHangKhong
	go
--*/

use master
create database QLHangKhong
go
use QLHangKhong
-----------------------------
/*
	ChuyenBay(MaCB, GaDi, GaDen, DoDai, GioDi, GioDen, ChiPhi) mô tả thông tin về chuyến bay. 
	Mỗi chuyến bay có một mã số duy nhất, đường bay, giờ đi và giờ đến. 
	Thông tin về đường bay được mô tả bởi ga đi, ga đến, độ dài đường bay và chi phí phải trả cho phi công.
*/
create table ChuyenBay
(
	MaCB	char(5)			primary key,
	GaDi	varchar(50)		not null,
	GaDen	varchar(50)		not null,
	DoDai	int				not null,
	GioDi	time			not null,
	GioDen	time,			
	ChiPhi	int				not null
)
go
/*
	MayBay(MaMB, Loai, TamBay) mô tả thông tin về máy bay. 
	Mỗi máy bay có một mã số duy nhất, tên phân loại và tầm bay 
	là khoảng cách xa nhất máy bay có thể bay mà không cần tiếp nhiên liệu. 

	**Một máy bay chỉ có thể thực hiện các chuyến bay có độ dài đường bay nhỏ hơn tầm bay của máy bay đó.
*/
create table MayBay
(
	MaMB	int				primary key,
	Loai	varchar(50)		not null,
	TamBay	int				not null,
)
go
/*
	NhanVien(MaNV, Ten, Luong) mô tả thông tin về nhân viên phi hành đoàn gồm phi công và tiếp viên. 
	Mỗi nhân viên có một mã số duy nhất, tên và mức lương.
*/
create table NhanVien
(
	MaNV	char(9)			primary key,
	Ten		varchar(50)		not null, 
	Luong	int				not null		default 0
)
go
/*
	ChungNhan(MaNV, MaMB) mô tả thông tin về khả năng điều khiển máy bay của phi công. 
	Nếu nhân viên là phi công thì nhân viên đó có chứng chỉ chứng nhận có thể lái một loại máy bay nào đó. 
	Một phi công chỉ có thể lái một chuyến bay nếu như phi công đó được chứng nhận có khả năng lái loại máy bay 
	có thể thực hiện chuyến bay đó.
*/
create table ChungNhan
(	
	MaCN	int	identity		primary key,
	MaNV	char(9)				not null references Nhanvien(MaNV), 
	MaMB	int					not null references MayBay(MaMB)
)
go
----------------------------------
INSERT [ChuyenBay] VALUES (N'VN216', N'SGN', N'DIN', 4170, CAST(N'10:30:00' AS Time), CAST(N'14:20:00' AS Time), 262)
INSERT [ChuyenBay] VALUES (N'VN254', N'SGN', N'HUI', 8765, CAST(N'18:40:00' AS Time), CAST(N'20:00:00' AS Time), 781)
INSERT [ChuyenBay] VALUES (N'VN269', N'HAN', N'CXR', 1262, CAST(N'14:10:00' AS Time), CAST(N'15:50:00' AS Time), 202)
INSERT [ChuyenBay] VALUES (N'VN276', N'DAD', N'CXR', 1283, CAST(N'09:00:00' AS Time), CAST(N'12:00:00' AS Time), 203)
INSERT [ChuyenBay] VALUES (N'VN280', N'SGN', N'HPH', 11979, CAST(N'06:00:00' AS Time), CAST(N'08:00:00' AS Time), 1279)
INSERT [ChuyenBay] VALUES (N'VN315', N'HAN', N'DAD', 134, CAST(N'11:45:00' AS Time), CAST(N'13:00:00' AS Time), 112)
INSERT [ChuyenBay] VALUES (N'VN317', N'HAN', N'UIH', 827, CAST(N'15:00:00' AS Time), CAST(N'16:15:00' AS Time), 190)
INSERT [ChuyenBay] VALUES (N'VN320', N'SGN', N'DAD', 2798, CAST(N'06:00:00' AS Time), CAST(N'07:10:00' AS Time), 221)
INSERT [ChuyenBay] VALUES (N'VN338', N'SGN', N'BMV', 4081, CAST(N'15:25:00' AS Time), CAST(N'16:25:00' AS Time), 375)
INSERT [ChuyenBay] VALUES (N'VN374', N'HAN', N'VII', 510, CAST(N'11:40:00' AS Time), CAST(N'13:25:00' AS Time), 120)
INSERT [ChuyenBay] VALUES (N'VN375', N'VII', N'CXR', 752, CAST(N'14:15:00' AS Time), CAST(N'16:00:00' AS Time), 181)
INSERT [ChuyenBay] VALUES (N'VN431', N'SGN', N'CAH', 3693, CAST(N'05:55:00' AS Time), CAST(N'06:55:00' AS Time), 236)
INSERT [ChuyenBay] VALUES (N'VN440', N'SGN', N'BMV', 4081, CAST(N'18:30:00' AS Time), CAST(N'19:30:00' AS Time), 426)
INSERT [ChuyenBay] VALUES (N'VN464', N'SGN', N'DLI', 2002, CAST(N'07:20:00' AS Time), CAST(N'08:05:00' AS Time), 225)
INSERT [ChuyenBay] VALUES (N'VN474', N'PXU', N'PQC', 1586, CAST(N'08:40:00' AS Time), CAST(N'11:20:00' AS Time), 102)
INSERT [ChuyenBay] VALUES (N'VN476', N'UIH', N'PQC', 485, CAST(N'09:15:00' AS Time), CAST(N'11:50:00' AS Time), 117)
INSERT [ChuyenBay] VALUES (N'VN651', N'DAD', N'SGN', 2798, CAST(N'19:30:00' AS Time), CAST(N'08:00:00' AS Time), 221)
INSERT [ChuyenBay] VALUES (N'VN741', N'HAN', N'PXU', 395, CAST(N'06:30:00' AS Time), CAST(N'08:30:00' AS Time), 120)
go

INSERT [MayBay] VALUES (154, N'Tupolev 154', 6565)
INSERT [MayBay] VALUES (319, N'Airbus A319', 2888)
INSERT [MayBay] VALUES (320, N'Airbus A320', 4168)
INSERT [MayBay] VALUES (340, N'Airbus A340 - 300', 11392)
INSERT [MayBay] VALUES (727, N'Boeing 727', 2406)
INSERT [MayBay] VALUES (737, N'Boeing 737 - 800', 5413)
INSERT [MayBay] VALUES (747, N'Boeing 747 - 400', 13488)
INSERT [MayBay] VALUES (757, N'Boeing 757 - 300', 6416)
INSERT [MayBay] VALUES (767, N'Boeing 767 - 400ER', 10360)
INSERT [MayBay] VALUES (777, N'Boeing 777 - 300', 10306)
go

INSERT [NhanVien] VALUES (N'011564812', N'Ton Van Quy', 153972)
INSERT [NhanVien] VALUES (N'141582651', N'Doan Thi Mai', 178345)
INSERT [NhanVien] VALUES (N'142519864', N'Nguyen Thi Xuan Dao', 227489)
INSERT [NhanVien] VALUES (N'159542516', N'Le Van Ky', 48250)
INSERT [NhanVien] VALUES (N'242518965', N'Tran Van Son', 120433)
INSERT [NhanVien] VALUES (N'248965255', N'Tran Thi Ba', 43723)
INSERT [NhanVien] VALUES (N'254099823', N'Nguyen Thi Quynh', 24450)
INSERT [NhanVien] VALUES (N'269734834', N'Truong Tuan Anh', 289950)
INSERT [NhanVien] VALUES (N'274878974', N'Mai Quoc Minh', 99890)
INSERT [NhanVien] VALUES (N'287321212', N'Duong Van Minh', 48090)
INSERT [NhanVien] VALUES (N'310454876', N'Ta Van Do', 212156)
INSERT [NhanVien] VALUES (N'310454877', N'Tran Van Hao', 33546)
INSERT [NhanVien] VALUES (N'348121549', N'Nguyen Van Thanh', 32899)
INSERT [NhanVien] VALUES (N'355548984', N'Tran Thi Hoai An', 212156)
INSERT [NhanVien] VALUES (N'356187925', N'Nguyen Vinh Bao', 44740)
INSERT [NhanVien] VALUES (N'390487451', N'Le Van Luat', 212156)
INSERT [NhanVien] VALUES (N'489221823', N'Bui Quoc Chinh', 23980)
INSERT [NhanVien] VALUES (N'489456522', N'Nguyen Thi Quy Linh', 127984)
INSERT [NhanVien] VALUES (N'548977562', N'Le Van Quy', 84476)
INSERT [NhanVien] VALUES (N'550156548', N'Nguyen Thi Cam', 205187)
INSERT [NhanVien] VALUES (N'552455318', N'La Que', 101745)
INSERT [NhanVien] VALUES (N'552455348', N'Bui Thi Dung', 92013)
INSERT [NhanVien] VALUES (N'567354612', N'Quan Cam Ly', 256481)
INSERT [NhanVien] VALUES (N'574489457', N'Bui Van Lap', 20)
go

SET IDENTITY_INSERT [dbo].[ChungNhan] ON 
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (1, N'567354612', 747)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (2, N'567354612', 737)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (3, N'567354612', 757)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (4, N'567354612', 777)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (5, N'567354612', 767)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (6, N'567354612', 727)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (7, N'567354612', 340)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (8, N'552455318', 737)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (9, N'552455318', 319)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (10, N'552455318', 747)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (11, N'552455318', 767)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (12, N'390487451', 340)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (13, N'390487451', 320)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (14, N'390487451', 319)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (15, N'274878974', 757)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (16, N'274878974', 767)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (17, N'355548984', 154)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (18, N'310454876', 154)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (19, N'142519864', 747)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (20, N'142519864', 757)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (21, N'142519864', 777)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (22, N'142519864', 767)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (23, N'142519864', 737)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (24, N'142519864', 340)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (25, N'142519864', 320)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (26, N'269734834', 747)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (27, N'269734834', 737)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (28, N'269734834', 340)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (29, N'269734834', 757)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (30, N'269734834', 777)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (31, N'269734834', 767)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (32, N'269734834', 320)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (33, N'269734834', 319)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (34, N'269734834', 727)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (35, N'269734834', 154)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (36, N'242518965', 737)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (37, N'242518965', 757)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (38, N'141582651', 737)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (39, N'141582651', 757)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (40, N'141582651', 767)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (41, N'011564812', 737)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (42, N'011564812', 757)
INSERT [ChungNhan] ([MaCN], [MaNV], [MaMB]) VALUES (43, N'574489457', 154)
SET IDENTITY_INSERT [dbo].[ChungNhan] OFF
go
