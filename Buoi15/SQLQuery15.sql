USE HANGKHONG
--1.Cho biết các chuyến bay đi ðà Lạt (DAD).
SELECT * 
FROM CHUYENBAY
WHERE GaDen='DAD'
GO
--2.Cho biết các loại máy bay có tầm bay lớn hơn 10,000km.
SELECT Hieu
FROM  MAYBAY
WHERE TamBay > 1000
GO
--3.Tìm các nhân viên có lương nhỏ hơn 10,000.
SELECT Ten
FROM [dbo].NHANVIEN
WHERE Luong>10000

--4.	Cho biết các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km.
SELECT MaCB
FROM CHUYENBAY
WHERE DoDai BETWEEN 8000 AND 10000
GO 
--5.	Cho biết các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuộc (BMV).
SELECT MaCB
FROM CHUYENBAY
WHERE GaDi='SGN' AND GaDen='BMV'
GO 
--6.Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN).
SELECT COUNT(MaCB) AS 'CHUYEN BAY SAI GON'
FROM CHUYENBAY
WHERE GaDi='SGN'
GO 
--7.	Có bao nhiêu loại máy báy Boeing.
SELECT COUNT(MaMB)
FROM MAYBAY
WHERE Hieu LIKE 'Boeing%'
--8.Cho biết tổng số lương phải trả cho các nhân viên.
SELECT SUM(Luong) AS 'TONG LUONG'
FROM NHANVIEN
--9.Cho biết mã số của các phi công lái máy báy Boeing.
SELECT MaNV
FROM CHUNGNHAN
WHERE MaMB in (SELECT MaMB
		FROM MAYBAY
		WHERE Hieu LIKE 'Boeing%')
--10.	Cho biết các nhân viên có thể lái máy bay có mã số 747.
SELECT MaNV
FROM CHUNGNHAN
WHERE MaMB='747'
--