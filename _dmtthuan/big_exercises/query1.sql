USE [QLHangKhong]
GO
--	1.	Cho biết các chuyến bay đi ðà Lạt (DAD).
SELECT * FROM [ChuyenBay] WHERE [GaDen] = 'DAD'

--	2.	Cho biết các loại máy bay có tầm bay lớn hơn 10,000km.
SELECT * FROM [MayBay] WHERE [TamBay] > 10000

--	3.	Tìm các nhân viên có lương nhỏ hơn 10,000.
SELECT * FROM [NhanVien] WHERE [Luong] < 10000

--	4.	Cho biết các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km.
SELECT * FROM [ChuyenBay] WHERE 8000 < [DoDai] AND [DoDai] < 10000

--	5.	Cho biết các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuộc (BMV).
SELECT * FROM [ChuyenBay] WHERE [GaDi] = 'SGN' AND [GaDen] = 'BMV'

/*
6.	Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN).
7.	Có bao nhiêu loại máy báy Boeing.
8.	Cho biết tổng số lương phải trả cho các nhân viên.
9.	Cho biết mã số của các phi công lái máy báy Boeing.
10.	Cho biết các nhân viên có thể lái máy bay có mã số 747.
11.	Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái.
12.	Cho biết mã số của các phi công vừa lái được Boeing vừa lái được Airbus.
13.	Cho biết các loại máy bay có thể thực hiện chuyến bay VN280.
14.	Cho biết các chuyến bay có thể được thực hiện bởi máy bay Airbus A320.
15.	Cho biết tên của các phi công lái máy bay Boeing.
16.	Với mỗi loại máy bay có phi công lái cho biết mã số, loại máy báy và tổng số phi công có thể lái loại máy bay đó.
17.	Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A. Cho biết các đường bay nào có thể đáp ứng yêu cầu này.
*/