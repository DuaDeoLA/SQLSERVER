-- Ques 2:
USE [QLHangKhong]
GO

-- 18.	Với mỗi ga có chuyến bay xuất phát từ đó cho biết có bao nhiêu chuyến bay khởi hành từ ga đó.
SELECT [GaDi], COUNT([MaCB]) AS [SoCB] FROM [ChuyenBay] GROUP BY [GaDi]
GO

--	19.	Với mỗi ga có chuyến bay xuất phát từ đó 
-- cho biết tổng chi phí phải trả cho phi công lái các chuyến bay khởi hành từ ga đó.
SELECT [GaDi], SUM([ChiPhi]) AS [TongChiPhi] FROM [ChuyenBay] GROUP BY [GaDi]
GO

--	20.	Với mỗi địa điểm xuất phát cho biết có bao nhiêu chuyến bay có thể khởi hành trước 12:00.
SELECT COUNT([MaCB]) AS [SoCB] FROM [ChuyenBay] WHERE DATEPART(hh, [GioDi]) < 12 GROUP BY [GaDi]
GO

--	21.	Cho biết mã số của các phi công chỉ lái được 3 loại máy bay
SELECT [MaNV] FROM [ChungNhan] GROUP BY [MaNV] HAVING COUNT([MaMB]) = 3
GO

--	22.	Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, 
--	cho biết mã số phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái.
SELECT [cn].[MaNV], MAX([mb].[TamBay]) AS [TamBayLonNhat]
FROM [ChungNhan] AS [cn]
    JOIN [MayBay] AS [mb] ON [mb].[MaMB] = [cn].[MaMB]
GROUP BY [cn].[MaNV]
HAVING COUNT([cn].[MaMB]) > 3
GO

--	23.	Với mỗi phi công cho biết mã số phi công và tổng số loại máy bay mà phi công đó có thể lái.
SELECT [MaNV], COUNT([MaMB]) AS [SoMB] FROM [ChungNhan] GROUP BY [MaNV]
GO

--	24.	Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất.
WITH [SoMB] AS (SELECT [MaNV], COUNT([MaMB]) AS [MB] FROM [ChungNhan] GROUP BY [MaNV])
SELECT [MaNV] FROM [SoMB] WHERE [MB] = (SELECT MAX([MB]) FROM [SoMB])
GO

--	25.	Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất.
WITH [SoMB] AS (SELECT [MaNV], COUNT([MaMB]) AS [MB] FROM [ChungNhan] GROUP BY [MaNV])
SELECT [MaNV] FROM [SoMB] WHERE [MB] = (SELECT MIN([MB]) FROM [SoMB])
GO