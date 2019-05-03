
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
