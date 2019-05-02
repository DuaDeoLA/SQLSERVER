--Ques 4
use QLHangKhong
go

--	39.	Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số loại máy bay mà nhân viên đó có thể lái.
select  nv.MaNV, nv.Ten, count(cn.MaMB) as SoMB
from NhanVien nv
	left outer join ChungNhan cn on cn.MaNV = nv.MaNV
group by nv.MaNV, nv.Ten

--	40.	Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số loại máy bay Boeing mà nhân viên đó có thể lái.
select nv.MaNV, nv.Ten, count(case when mb.Loai like 'Boeing%' then cn.MaMB end) as SoMB
from NhanVien nv
	left outer join ChungNhan cn on cn.MaNV = nv.MaNV
	left outer join MayBay mb on mb.MaMB = cn.MaMB
group by nv.MaNV, nv.Ten

--	41.	Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công có thể lái loại máy bay đó
select mb.MaMB, Loai, count(cn.MaNV) as SoNV
from MayBay mb 
	left outer join ChungNhan cn on cn.MaMB = mb.MaMB
group by mb.MaMB,Loai

--	42.	Với mỗi loại máy bay cho biết loại máy bay và tổng số chuyến bay không thể thực hiện bởi loại máy bay đó.
select mb.MaMB, mb.Loai, count(cb.MaCB) as SoCB
from MayBay mb 
	join ChuyenBay cb on cb.DoDai >= mb.TamBay
group by mb.MaMB, mb.Loai

--	43.	Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công có lương lớn hơn 100,000 có thể lái loại máy bay đó.
select  cn.MaMB, mb.Loai, count(cn.MaNV) as SoPC
from ChungNhan cn
	join NhanVien nv on nv.MaNV = cn.MaNV
	join MayBay mb on mb.MaMB = cn.MaMB
where nv.Luong > 100000
group by cn.MaMB, mb.Loai

--	44.	Với mỗi loại máy bay có tầm bay trên 3200km, cho biết tên của loại máy bay và lương trung bình của các phi công có thể lái loại máy bay đó.
select  cn.MaMB, mb.Loai, avg(nv.Luong) as LuongTB
from ChungNhan cn
	join NhanVien nv on nv.MaNV = cn.MaNV
	join MayBay mb on mb.MaMB = cn.MaMB
where mb.TamBay > 3200
group by cn.MaMB, mb.Loai

--	45.	Với mỗi loại máy bay cho biết loại máy bay và tổng số nhân viên không thể lái loại máy bay đó.
declare @SoNV int = (Select count(MaNV) from NhanVien)
select  mb.MaMB, mb.Loai, @SoNV - count(cn.MaNV) as SoNV
from MayBay mb
	left outer join ChungNhan cn on cn.MaMB = mb.MaMB
group by mb.MaMB, mb.Loai
go

--	46.	Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công không thể lái loại máy bay đó.
declare @SoNV int = (Select count(distinct MaNV) from ChungNhan)
select  mb.MaMB, mb.Loai, @SoNV - count(cn.MaNV) as SoNV
from MayBay mb
	left outer join ChungNhan cn on cn.MaMB = mb.MaMB
group by mb.MaMB, mb.Loai

--	47.	Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số chuyến bay xuất phát từ Sài Gòn mà nhân viên đó có thể lái.
select * from 
48.	Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số chuyến bay xuất phát từ Sài Gòn mà nhân viên đó không thể lái.
49.	Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó có thể lái.
50.	Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó không thể lái.
51.	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy bay không thể thực hiện chuyến bay đó.
52.	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy bay có thể thực hiện chuyến bay đó.
53.	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số nhân viên không thể lái chuyến bay đó.
54.	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số phi công không thể lái chuyến bay đó.
