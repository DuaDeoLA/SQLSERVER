-- Ques 3:
USE [QLHangKhong]
GO

--	26.	Tìm các nhân viên không phải là phi công.
SELECT [nv].* FROM [NhanVien] AS [nv] LEFT OUTER JOIN [ChungNhan] AS [cn] ON [cn].[MaNV] = [nv].[MaNV] WHERE [cn].[MaNV] IS NULL
GO

--	27.	Cho biết mã số của các nhân viên có lương cao nhất.
SELECT [MaNV] FROM [NhanVien] WHERE [Luong] = (SELECT MAX([Luong]) FROM [NhanVien])
GO

--	28.	Cho biết tổng số lương phải trả cho các phi công.
SELECT SUM([nv].[Luong]) AS [TongLuong] FROM [NhanVien] AS [nv] JOIN [ChungNhan] AS [cn] ON [cn].[MaNV] = [nv].[MaNV]
GO

--	29.	Tìm các chuyến bay có thể được thực hiện bởi tất cả các loại máy bay Boeing.\
DECLARE @SoMB INT = (SELECT COUNT([MaMB]) FROM [MayBay] WHERE [Loai] LIKE 'Boeing%')
SELECT *
FROM [ChuyenBay]
WHERE [MaCB] IN (SELECT [cb].[MaCB]
                 FROM [ChuyenBay] AS [cb], [MayBay] AS [mb]
                 WHERE [cb].[DoDai] < [mb].[TamBay] AND [mb].[Loai] LIKE 'Boeing%'
                 GROUP BY [cb].[MaCB]
                 HAVING COUNT([mb].[MaMB]) = @SoMB)
GO

--	30.	Cho biết mã số của các máy bay có thể được sử dụng để thực hiện chuyến bay từ Sài Gòn (SGN) đến Huế (HUI).
SELECT [cb].[MaCB] FROM [ChuyenBay] AS [cb], [MayBay] AS [mb] WHERE [cb].[DoDai] < [mb].[TamBay] AND [cb].[GaDi] = 'SGN' AND [cb].[GaDen] = 'HUI'
GO

--	31.	Tìm các chuyến bay có thể được lái bởi các phi công có lương lớn hơn 100,000.
WITH [TB]
AS (SELECT [TamBay]
    FROM [NhanVien] AS [nv]
        JOIN [ChungNhan] AS [cn] ON [cn].[MaNV] = [nv].[MaNV]
        JOIN [MayBay] AS [mb] ON [mb].[MaMB] = [cn].[MaMB]
    WHERE [nv].[Luong] > 100000)
SELECT DISTINCT [ChuyenBay].* FROM [ChuyenBay], [TB] WHERE [DoDai] < [TamBay]
GO

--	32.	Cho biết tên các phi công có lương nhỏ hơn chi phí thấp nhất của đường bay từ Sài Gòn (SGN) đến Buôn Mê Thuộc (BMV).
SELECT [Ten]
FROM [NhanVien]
WHERE [MaNV] IN (SELECT DISTINCT [nv].[MaNV] FROM [NhanVien] AS [nv] JOIN [ChungNhan] AS [cb] ON [cb].[MaNV] = [nv].[MaNV]) AND [Luong] < (SELECT MIN([ChiPhi]) FROM [ChuyenBay] WHERE [GaDi] = 'SGN' AND [GaDen] = 'BMV')

--	33.	Cho biết mã số của các phi công có lương cao nhất.
WITH [PhiCong]
AS (SELECT [MaNV], [Luong] FROM [NhanVien] WHERE [MaNV] IN (SELECT DISTINCT [MaNV] FROM [ChungNhan]))
SELECT [MaNV] FROM [PhiCong] WHERE [Luong] = (SELECT MAX([Luong]) FROM [PhiCong])
GO

--	34.	Cho biết mã số của các nhân viên có lương cao thứ nhì.
SELECT [MaNV], [Luong] INTO [PhiCong] FROM [NhanVien] WHERE [MaNV] IN (SELECT DISTINCT [MaNV] FROM [ChungNhan])

DECLARE @MaNV INT = (SELECT [MaNV] FROM [PhiCong] WHERE [Luong] = (SELECT MAX([Luong]) FROM [PhiCong]))
DELETE [PhiCong] WHERE [MaNV] = @MaNV

SELECT [MaNV] FROM [PhiCong] WHERE [Luong] = (SELECT MAX([Luong]) FROM [PhiCong])
DROP TABLE [PhiCong]
GO

--	35.	Cho biết mã số của các nhân viên có lương cao thứ nhất hoặc thứ nhì.
WITH [XHLuong]
AS (SELECT RANK() OVER (ORDER BY [Luong] DESC) AS [Hang], [MaNV] FROM [NhanVien])
SELECT [MaNV] FROM [XHLuong] WHERE [Hang] IN (1, 2)
GO

--	36.	Cho biết tên và lương của các nhân viên không phải là phi công và 
--	có lương lớn hơn lương trung bình của tất cả các phi công.
SELECT [MaNV], [Luong] INTO [PhiCong] FROM [NhanVien] WHERE [MaNV] IN (SELECT DISTINCT [MaNV] FROM [ChungNhan])

SELECT [Ten], [Luong] FROM [NhanVien] WHERE [MaNV] NOT IN (SELECT [MaNV] FROM [PhiCong]) AND [Luong] > (SELECT AVG([Luong]) FROM [PhiCong])

DROP TABLE [PhiCong]
GO

--	37.	Cho biết tên các phi công có thể lái các máy bay có tầm bay lớn hơn 4,800km 
--	nhưng không có chứng nhận lái máy bay Boeing.
WITH [PhiCong] AS
(
	SELECT [cn].[MaNV], [Loai]
	FROM [ChungNhan] cn JOIN [MayBay] mb ON [mb].[MaMB] = [cn].[MaMB]
),
KhongLaiBoeing AS
(
	SELECT DISTINCT [MaNV] FROM [PhiCong]
	WHERE [MaNV] NOT IN (SELECT DISTINCT [MaNV] FROM [PhiCong] WHERE [Loai] LIKE 'Boeing%')
)
SELECT [Ten] FROM [NhanVien] nv, [KhongLaiBoeing] khonglai WHERE [nv].[MaNV] = [khonglai].[MaNV]
GO

--	38.	Cho biết tên các phi công lái ít nhất 3 loại máy bay có tầm bay xa hơn 3200km.
WITH [PhiCong] AS
(
	SELECT [cn].[MaNV]
	FROM [ChungNhan] cn JOIN [MayBay] mb ON [mb].[MaMB] = [cn].[MaMB]
	WHERE [mb].[TamBay] > 3200
	GROUP BY [cn].[MaNV]
	HAVING COUNT([mb].[Loai]) >= 3
)
SELECT [Ten] FROM [NhanVien], [PhiCong] WHERE [PhiCong].[MaNV] = [NhanVien].[MaNV]
GO