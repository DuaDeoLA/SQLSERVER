
--1.	Tìm ngày sinh và địa chỉ của nhân viên có tên là “Nguyen Bao Hung”.
USE DB_COMPANY

SELECT NgSinh,Diachi
FROM NHANVIEN
WHERE Ho like 'Nguyen' AND Dem like 'Bao' AND Ten like 'Hung'
--2.	Tìm tên và địa chỉ của các nhân viên làm việc trong phòng “Nghien cuu”.
SELECT Ten,Diachi
FROM NHANVIEN T1
	JOIN PHONGBAN T2 ON T1.MaPhong = T2.MaPB
WHERE T2.TenPB = 'Nghien cuu'
--3.	Với mỗi dự án được triển khai tại “Go Vap”, cho biết mã dự án, mã phòng quản lý và tên, địa chỉ, ngày sinh của người trưởng phòng.

SELECT MaDA,PhQuanly,Ten,Diachi,NgSinh
FROM PHONGBAN T1 
	JOIN DUAN T2 ON  T2.PhQuanly =  T1.MaPB
	JOIN NHANVIEN T3 ON T1.TrPhong = T3.MaNV
WHERE Diadiem like 'Go Vap' 
--4.	Với mỗi nhân viên, cho biết họ, tên của nhân viên và họ, tên của người giám sát nhân viên đó.
SELECT T1.MaNV,T1.Ten,T1.MaGSat,T2.Ten
FROM NHANVIEN T1
	JOIN NHANVIEN T2 ON T1.MaGSat =T2.MaNV
--5.	Cho biết thông tin của tất cả các nhân viên.
SELECT *
FROM NHANVIEN
--6.	Cho biết các mức lương riêng biệt của các nhân viên.
SELECT MaNV, CONCAT(Ho,' ',Dem,' ',Ten) as HoTen,Luong
FROM NHANVIEN
--7.	Liệt kê tất cả các nhân viên có địa chỉ thuộc quận “Phu Nhuan”.
SELECT MaNV, CONCAT(Ho,' ',Dem,' ',Ten) as HoTen,Diachi
FROM NHANVIEN
WHERE Diachi LIKE '%Phu Nhuan%'
--8.	Tìm tất cả các nhân viên sinh vào thập niên 1950.
SELECT MaNV, CONCAT(Ho,' ',Dem,' ',Ten) as HoTen,NgSinh
FROM NHANVIEN
WHERE YEAR(NgSinh) BETWEEN 1950 AND 1960
--9.	Cho biết kết quả lương mới của các nhân viên tham gia dự án “San pham X” neu nhu họ được tăng thêm 10% lương.

SELECT T1.MaNV, Luong*1.1 as 'Luong moi'
FROM THAMGIA AS T1 
	JOIN DUAN AS T2 ON T1.MaDA =T2.MaDA
	JOIN NHANVIEN AS T3 ON T1.MaNV = T3.MaNV
WHERE T2.TenDA LIKE 'San pham X'
--10.Cho biết các nhân viên của phòng số 5 có mức lương từ 30.000 đến 50.000.
SELECT MaNV, CONCAT(Ho,' ',Dem,' ',Ten) AS 'Ho ten'
FROM NHANVIEN T1 
	JOIN PHONGBAN T2 ON T1.MaPhong = T2.MaPB
WHERE T2.MaPB=5 AND T1.Luong BETWEEN 30000 AND 50000
--11.	Cho biết danh sách các nhân viên và các dự án mà họ tham gia, sắp xếp tăng dần theo mã phòng, trong mỗi phòng sắp xếp theo họ và tên với thứ tự alphabe.
SELECT T1.MaNV,T3.Ho,T3.Ten,MaPhong
FROM THAMGIA AS T1 
	JOIN DUAN AS T2 ON T1.MaDA =T2.MaDA
	JOIN NHANVIEN AS T3 ON T1.MaNV = T3.MaNV
ORDER BY MaPhong,T3.Ho,T3.Ten
--12.	Cho biết họ tên các nhân viên không có người giám sát.
--UPDATE NHANVIEN SET MaGSat = NULL WHERE MaNV='888665555'
SELECT *
FROM NHANVIEN
WHERE MaGSat IS NULL
--13.	Cho biết họ tên của nhân viên có thân nhân cùng tên và cùng giới tính với nhân viên đó.
SELECT Ten,GTinh
FROM NHANVIEN
INTERSECT
SELECT TenTN,GTinh
FROM THANNHAN
--14.	Cho biết họ tên các nhân viên tham gia tất cả các dự án do phòng số 5 quản lý.

SELECT COUNT(*)
FROM DUAN
WHERE PhQuanly=5

SELECT MaNV,COUNT(T1.MaDA)
FROM THAMGIA T1 
	JOIN DUAN T2 ON T1.MaDA = T2.MaDA
WHERE T2.PhQuanly=5
GROUP BY MaNV
HAVING COUNT(T1.MaDA)=(SELECT COUNT(*)
FROM DUAN
WHERE PhQuanly=5) 
--15.	Cho biết họ tên các nhân viên không có thân nhân.
SELECT MaNV
FROM NHANVIEN
EXCEPT
SELECT MaNV
FROM THANNHAN
--16.	Cho biết họ tên các trưởng phòng có ít nhất một thân nhân.
SELECT DISTINCT CONCAT(T2.Ho,' ',T2.Dem,' ',T2.Ten) as HoTen
FROM PHONGBAN T1
	JOIN NHANVIEN T2 ON T1.TrPhong=T2.MaNV
	JOIN THANNHAN T3 ON T1.TrPhong=T3.MaNV
--17.	Cho biết mã số các nhân viên tham gia vào dự án số 1, số 2 hoặc số 3.
SELECT DISTINCT MaNV
FROM THAMGIA T1 
	JOIN DUAN T2 ON T1.MaDA = T2.MaDA
WHERE T1.MaDA IN (1,2,3)
--18 Tính tổng lương của tất cả các nhân viên, mức lương cao nhất, mức lương thấp nhất và mức lương trung bình.
SELECT SUM(Luong) as 'Tong luong',Max(Luong) as 'Luong cao nhan',Min(Luong) as 'Luong thap nhat',Avg(Luong) as 'Luong trung binh'
FROM NHANVIEN
--19.Tính tổng lương của các nhân viên phòng “Nghien cuu”, mức lương cao nhất, mức lương thấp nhất và mức lương trung bình của phòng này.
SELECT SUM(Luong) as 'Tong luong',Max(Luong) as 'Luong cao nhan',Min(Luong) as 'Luong thap nhat',Avg(Luong) as 'Luong trung binh'
FROM NHANVIEN AS T1
	JOIN PHONGBAN AS T2 ON T1.MaPhong = T2.MaPB
WHERE T2.TenPB='Nghien cuu'
--20.	Cho biết tổng số nhân viên của phòng “Nghien cuu”.
SELECT MaPhong,COUNT(MaNV) AS 'So nhan vien'
FROM NHANVIEN
GROUP BY MaPhong
--21.	Có bao nhiêu mức lương riêng biệt trong cơ sở dữ liệu.
SELECT Luong
FROM NHANVIEN
GROUP BY Luong
ORDER BY Luong DESC
--22.Với mỗi phòng, cho biết mã số phòng, tổng số nhân viên và mức lương trung bình của phòng.
SELECT MaPhong,COUNT(MaNV) as 'Tong so NV',AVG(Luong) as 'Luong'
FROM NHANVIEN
GROUP BY MaPhong
--23.	Với mỗi dự án, cho biết mã số dự án, tên dự án và tổng số nhân viên tham gia dự án đó.

SELECT T1.MaDA,TenDA,Count(T2.MaNV) AS 'TONG SO NHAN VIEN'
FROM DUAN AS T1
	JOIN THAMGIA AS T2 ON T1.MaDA = T2.MaDA
GROUP BY T1.MaDA,TenDA

--24.	Với mỗi dự án có nhiều hơn hai nhân viên tham gia, cho biết mã số, tên và tổng số nhân viên của dự án đó.
SELECT T1.MaDA,TenDA,Count(T2.MaNV) AS 'TONG SO NHAN VIEN'
FROM DUAN AS T1
	JOIN THAMGIA AS T2 ON T1.MaDA = T2.MaDA
GROUP BY T1.MaDA,TenDA
HAVING Count(T2.MaNV)>2
--25.	Với mỗi dự án, cho biết mã số dự án, tên dự án và tổng số nhân viên của phòng số 5 tham gia vào dự án đó.

SELECT T2.MaDA,T2.TenDA,COUNT(T1.MaNV)
FROM THAMGIA AS T1
	JOIN DUAN AS T2 ON T1.MaDA=T2.MaDA
	JOIN NHANVIEN T3 ON T1.MaNV =T3.MaNV
WHERE T3.MaPhong=5
GROUP BY T2.MaDA,T2.TenDA
--26.	Với mỗi phòng có nhiều hơn năm nhân viên, cho biết mã số phòng và tổng số nhân viên có mức lương cao hơn 40.000 của phòng đó.
GO
WITH   DS_PHONG
AS
( SELECT MaPB,COUNT(MaNV) AS 'SOLUONG'
FROM PHONGBAN AS T1
	JOIN NHANVIEN AS T2 ON T1.MaPB=T2.MaPhong
GROUP BY MaPB
HAVING COUNT(MaNV)>3)
SELECT MaPB,COUNT(*)
FROM DS_PHONG  AS T1
	JOIN NHANVIEN AS T2 ON T1.MaPB=T2.MaPhong
WHERE T2.Luong>20000
GROUP BY MaPB
--27.	Với mỗi phòng có mức lương trung bình lớn hơn 30.000, cho biết tên phòng và tổng số nhân viên của phòng đó.
SELECT MaPhong,COUNT(MaNV) as 'Tong so nhan vien'
FROM NHANVIEN AS T1
	JOIN PHONGBAN AS T2 ON T1.MaPhong=T2.MaPB
GROUP BY MaPhong
HAVING AVG(Luong)>30000
--28.	Với mỗi phòng có mức lương trung bình lớn hơn 30.000, cho biết tên phòng và tổng số nhân viên là nam của phòng đó
SELECT MaPhong,COUNT(MaNV) as 'Tong so nhan vien nam'
FROM NHANVIEN AS T1
	JOIN PHONGBAN AS T2 ON T1.MaPhong=T2.MaPB
WHERE T1.GTinh IN ('m','M')
GROUP BY MaPhong
HAVING AVG(Luong)>30000
