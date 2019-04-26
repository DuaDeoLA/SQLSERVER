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
--11.Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái.
SELECT	T1.MaMB,T2.Ten
FROM CHUNGNHAN AS T1
	JOIN NHANVIEN AS T2 ON T1.MaNV = T2.MaNV
WHERE T2.Ten LIKE 'Nguyen%'
--12.	Cho biết mã số của các phi công vừa lái được Boeing vừa lái được Airbus.
SELECT MaNV
FROM CHUNGNHAN
WHERE MaMB in (SELECT MaMB
		FROM MAYBAY
		WHERE Hieu LIKE 'Boeing%')
INTERSECT
SELECT MaNV
FROM CHUNGNHAN
WHERE MaMB in (SELECT MaMB
		FROM MAYBAY
		WHERE Hieu LIKE 'Airbus%')
--13.	Cho biết các loại máy bay có thể thực hiện chuyến bay VN280.

SELECT MaMB
FROM MAYBAY
WHERE TamBay > (SELECT DoDai
				FROM CHUYENBAY
				WHERE MaCB = 'VN280')

DECLARE @DODAI INT = (SELECT DoDai
				FROM CHUYENBAY
				WHERE MaCB = 'VN280');
SELECT MaMB
FROM MAYBAY
WHERE TamBay> @DODAI

--14.	Cho biết các chuyến bay có thể được thực hiện bởi máy bay Airbus A320.
SELECT MaCB
FROM CHUYENBAY 
WHERE DoDai < (SELECT TamBay FROM MAYBAY WHERE Hieu = 'Airbus A320')
--15.	Cho biết tên của các phi công lái máy bay Boeing.

SELECT DISTINCT T2.Ten
FROM CHUNGNHAN AS T1 
	JOIN NHANVIEN AS T2 ON T1.MaNV=T2.MaNV
WHERE MaMB in (SELECT MaMB
		FROM MAYBAY
		WHERE Hieu LIKE 'Boeing%')
--16.	Với mỗi loại máy bay có phi công lái cho biết mã số, loại máy báy và tổng số phi công có thể lái loại máy bay đó.

SELECT T1.MaMB,T2.Hieu,COUNT(MaNV) AS 'Amount'
FROM CHUNGNHAN AS T1 
	JOIN MAYBAY AS T2 ON T1.MaMB = T2.MaMB
GROUP BY T1.MaMB,T2.Hieu
--17.Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A. Cho biết các đường bay nào có thể đáp ứng yêu cầu này.
SELECT *
FROM CHUYENBAY AS T1
WHERE T1.GaDen IN (SELECT GaDi FROM CHUYENBAY) AND T1.GaDi IN(SELECT GaDen FROM CHUYENBAY)
--18.Với mỗi ga có chuyến bay xuất phát từ đó cho biết có bao nhiêu chuyến bay khởi hành từ ga đó.
SELECT GaDi,COUNT(MaCB)
FROM CHUYENBAY
GROUP BY GaDi
--19.	Với mỗi ga có chuyến bay xuất phát từ đó cho biết tổng chi phí phải trả cho phi công lái các chuyến bay khởi hành từ ga đó.
SELECT GaDi,SUM(ChiPhi)
FROM CHUYENBAY
GROUP BY GaDi
--20.	Tới mỗi địa điểm xuất phát cho biết có bao nhiêu chuyến bay có thể khởi hành trước 12:00.
SELECT GaDi,COUNT(MaCB) AS 'SO CHUYEN BAY'
FROM CHUYENBAY
WHERE GioDi> '12:00'
GROUP BY GaDi
--21.	Cho biết mã số của các phi công chỉ lái được 3 loại máy bay
SELECT MaNV
FROM CHUNGNHAN
GROUP BY MaNV
HAVING COUNT(MaMB)=3
--22.	Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, cho biết mã số phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái.
SELECT T1.MaNV,MAX(TamBay) as 'Tam bay lon nhat'
FROM CHUNGNHAN AS T1
		JOIN MAYBAY AS T2 ON T1.MaMB=T2.MaMB
GROUP BY T1.MaNV
HAVING COUNT(T1.MaMB)=3
--23.	Với mỗi phi công cho biết mã số phi công và tổng số loại máy bay mà phi công đó có thể lái.
SELECT MaNV,COUNT(MaMB) AS 'SO LOAI MAY BAY'
FROM CHUNGNHAN
GROUP BY MaNV
--24.	Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất.
SELECT MaNV
FROM CHUNGNHAN
GROUP BY MaNV
HAVING COUNT(MaMB) IN 
	(SELECT MAX(MAXNUM) 
	FROM (
			SELECT COUNT(MaMB) AS MAXNUM 
			FROM CHUNGNHAN
			 GROUP BY MaNV
		) AS A
	)
--25.	Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất.
SELECT MaNV
FROM CHUNGNHAN
GROUP BY MaNV
HAVING COUNT(MaMB) IN 
	(SELECT MIN(MAXNUM) 
	FROM (
			SELECT COUNT(MaMB) AS MAXNUM 
			FROM CHUNGNHAN
			 GROUP BY MaNV
		) AS A
	)
--26.	Tìm các nhân viên không phải là phi công.
GO
WITH PHICONG (MaNV)
AS
(
	SELECT MaNV
	FROM CHUNGNHAN
)
SELECT MaNV
FROM NHANVIEN
WHERE MaNV NOT IN (SELECT * FROM PHICONG)

--27.	Cho biết mã số của các nhân viên có lương cao nhất.

DECLARE @MAX_LUONG INT = (SELECT MAX(Luong)  FROM NHANVIEN)
SELECT MaNV
FROM NHANVIEN
WHERE Luong=@MAX_LUONG

--28.	Cho biết tổng số lương phải trả cho các phi công.
SELECT SUM(T2.Luong) AS 'SUM LUONG '
FROM CHUNGNHAN AS T1
	JOIN NHANVIEN AS T2 ON T1.MaNV =T2.MaNV
--29.	Tìm các chuyến bay có thể được thực hiện bởi tất cả các loại máy bay Boeing.
WITH BOEING
AS
(
	SELECT MaMB,TamBay
	FROM MAYBAY
	WHERE Hieu LIKE 'Boeing%'
)

SELECT DISTINCT MaCB
FROM CHUYENBAY,BOEING
WHERE DoDai < TamBay
