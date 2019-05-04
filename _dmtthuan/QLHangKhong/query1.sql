-- Ques 1:
USE [QLHangKhong]
GO

--	1.	Cho biết các chuyến bay đi ðà Lạt (DAD).
SELECT * FROM [ChuyenBay] WHERE [GaDen] = 'DAD'
GO

--	2.	Cho biết các loại máy bay có tầm bay lớn hơn 10,000km.
SELECT * FROM [MayBay] WHERE [TamBay] > 10000
GO

--	3.	Tìm các nhân viên có lương nhỏ hơn 10,000.
SELECT * FROM [NhanVien] WHERE [Luong] < 10000
GO

--	4.	Cho biết các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km.
SELECT * FROM [ChuyenBay] WHERE 8000 < [DoDai] AND [DoDai] < 10000
GO

--	5.	Cho biết các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuộc (BMV).
SELECT * FROM [ChuyenBay] WHERE [GaDi] = 'SGN' AND [GaDen] = 'BMV'
GO

--	6.	Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN).
SELECT COUNT([MaCB]) AS [SoCB] FROM [ChuyenBay] WHERE [GaDi] = 'SGN'
GO

--	7.	Có bao nhiêu loại máy báy Boeing.
SELECT COUNT([MaMB]) AS [SoMB] FROM [MayBay] WHERE [Loai] LIKE 'Boeing%'
GO

--	8.	Cho biết tổng số lương phải trả cho các nhân viên.
SELECT SUM([Luong]) AS [TongLuong] FROM [NhanVien]
GO

--	9.	Cho biết mã số của các phi công lái máy báy Boeing.
SELECT DISTINCT [cn].[MaNV] FROM [ChungNhan] AS [cn] JOIN [MayBay] AS [mb] ON [mb].[MaMB] = [cn].[MaMB] WHERE [mb].[Loai] LIKE 'Boeing%'

--	10.	Cho biết các nhân viên có thể lái máy bay có mã số 747.
SELECT [nv].[MaNV], [nv].[Ten]
FROM [ChungNhan] AS [cn]
    JOIN [NhanVien] AS [nv] ON [nv].[MaNV] = [cn].[MaNV]
    JOIN [MayBay] AS [mb] ON [mb].[MaMB] = [cn].[MaMB]
WHERE [mb].[MaMB] = 747
GO

--	11.	Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái.
SELECT DISTINCT [mb].[MaMB]
FROM [ChungNhan] AS [cn]
    JOIN [NhanVien] AS [nv] ON [nv].[MaNV] = [cn].[MaNV]
    JOIN [MayBay] AS [mb] ON [mb].[MaMB] = [cn].[MaMB]
WHERE [nv].[Ten] LIKE 'Nguyen%'
GO

--	12.	Cho biết mã số của các phi công vừa lái được Boeing vừa lái được Airbus.
SELECT DISTINCT [cn].[MaNV]
FROM [ChungNhan] AS [cn]
    JOIN [MayBay] AS [mb] ON [mb].[MaMB] = [cn].[MaMB]
WHERE 
	[mb].[Loai] LIKE 'Boeing%' AND 
	[cn].[MaNV] IN 
	(
		SELECT DISTINCT [cn].[MaNV] 
		FROM [ChungNhan] AS [cn] 
			JOIN [MayBay] AS [mb] ON [mb].[MaMB] = [cn].[MaMB]
		WHERE [mb].[Loai] LIKE 'Airbus%'
	)
GO

--	13.	Cho biết các loại máy bay có thể thực hiện chuyến bay VN280.
SELECT [Loai] FROM [MayBay] WHERE [TamBay] > (SELECT [DoDai] FROM [ChuyenBay] WHERE [MaCB] = 'VN280')
GO

--	14.	Cho biết các chuyến bay có thể được thực hiện bởi máy bay Airbus A320.
SELECT * FROM [ChuyenBay] WHERE [DoDai] < (SELECT [TamBay] FROM [MayBay] WHERE [Loai] LIKE 'Airbus A320%')
GO

--	15.	Cho biết tên của các phi công lái máy bay Boeing.
SELECT [Ten] FROM [NhanVien] WHERE [MaNV] IN
(
	SELECT DISTINCT [cn].[MaNV]
	FROM [ChungNhan] cn	
		JOIN [MayBay] mb ON [mb].[MaMB] = [cn].[MaMB]
	WHERE [mb].[Loai] LIKE 'Boeing%'
)
GO

--	16.	Với mỗi loại máy bay có phi công lái cho biết mã số, loại máy báy và tổng số phi công có thể lái loại máy bay đó.
SELECT [cn].[MaMB], [mb].[Loai], COUNT([cn].[MaNV]) AS SoNV
FROM [ChungNhan] cn
	JOIN [MayBay] mb ON [mb].[MaMB] = [cn].[MaMB]
GROUP BY [cn].[MaMB], [mb].[Loai]
GO

--	17.	Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A. Cho biết các đường bay nào có thể đáp ứng yêu cầu này.
SELECT 
	[A].[MaCB] AS MaCBDi,
	[B].[MaCB] AS MaCBVe
FROM [ChuyenBay] AS [A],[ChuyenBay] AS [B]
WHERE [A].[GaDi] = [B].[GaDen] AND [A].[GaDen] = [B].[GaDi]
ORDER BY MaCBDi
GO