/*1.	Tìm ngày sinh và địa chỉ của nhân viên có tên là “Nguyen Bao Hung”.
--2.	Tìm tên và địa chỉ của các nhân viên làm việc trong phòng “Nghien cuu”.
--3.	Với mỗi dự án được triển khai tại “Go Vap”, cho biết mã dự án, mã phòng quản lý và tên, địa chỉ, ngày sinh của người trưởng phòng.
--4.	Với mỗi nhân viên, cho biết họ, tên của nhân viên và họ, tên của người giám sát nhân viên đó.
--5.	Cho biết thông tin của tất cả các nhân viên.
6.	Cho biết các mức lương riêng biệt của các nhân viên.
7.	Liệt kê tất cả các nhân viên có địa chỉ thuộc quận “Phu Nhuan”.
8.	Tìm tất cả các nhân viên sinh vào thập niên 1950.
9.	Cho biết kết quả lương mới của các nhân viên tham gia dự án “San pham X” neu nhu họ được tăng thêm 10% lương.
10.	Cho biết các nhân viên của phòng số 5 có mức lương từ 30.000 đến 50.000.
11.	Cho biết danh sách các nhân viên và các dự án mà họ tham gia, sắp xếp tăng dần theo mã phòng, trong mỗi phòng sắp xếp theo họ và tên với thứ tự alphabe.
12.	Cho biết họ tên các nhân viên không có người giám sát.
13.	Cho biết họ tên của nhân viên có thân nhân cùng tên và cùng giới tính với nhân viên đó.
14.	Cho biết họ tên các nhân viên tham gia tất cả các dự án do phòng số 5 quản lý.
15.	Cho biết họ tên các nhân viên không có thân nhân.
16.	Cho biết họ tên các trưởng phòng có ít nhất một thân nhân.
17.	Cho biết mã số các nhân viên tham gia vào dự án số 1, số 2 hoặc số 3.
18.	Tính tổng lương của tất cả các nhân viên, mức lương cao nhất, mức lương thấp nhất và mức lương trung bình.
19.	Tính tổng lương của các nhân viên phòng “Nghien cuu”, mức lương cao nhất, mức lương thấp nhất và mức lương trung bình của phòng này.
20.	Cho biết tổng số nhân viên của phòng “Nghien cuu”.
21.	Có bao nhiêu mức lương riêng biệt trong cơ sở dữ liệu.
22.	Với mỗi phòng, cho biết mã số phòng, tổng số nhân viên và mức lương trung bình của phòng.
23.	Với mỗi dự án, cho biết mã số dự án, tên dự án và tổng số nhân viên tham gia dự án đó.
 
24.	Với mỗi dự án có nhiều hơn hai nhân viên tham gia, cho biết mã số, tên và tổng số nhân viên của dự án đó.
25.	Với mỗi dự án, cho biết mã số dự án, tên dự án và tổng số nhân viên của phòng số 5 tham gia vào dự án đó.
26.	Với mỗi phòng có nhiều hơn năm nhân viên, cho biết mã số phòng và tổng số nhân viên có mức lương cao hơn 40.000 của phòng đó.
27.	Với mỗi phòng có mức lương trung bình lớn hơn 30.000, cho biết tên phòng và tổng số nhân viên của phòng đó.
28.	Với mỗi phòng có mức lương trung bình lớn hơn 30.000, cho biết tên phòng và tổng số nhân viên là nam của phòng đó
*/
USE DB_COMPANY

SELECT * FROM PHONGBAN
WHERE MaDA=1