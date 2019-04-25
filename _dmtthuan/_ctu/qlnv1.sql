select * from nhanvien

select hoten, phai from nhanvien

select distinct luong from nhanvien

select * from nhanvien
order by maphong asc, luong desc

select hoten, luong, phucap, (luong+phucap)*12 as 'thunhap'
from nhanvien
order by 4 desc

select * from nhanvien
where hoten = 'Le Quynh Nhu'

select hoten, congviec from nhanvien
where phai = 'nam' and (maphong = 30 or maphong = 40)

select hoten, luong, phucap from nhanvien
where luong = 2 * phucap

select hoten from nhanvien
where lower(congviec)='thu ky'

select hoten from nhanvien
where maphong in (10, 30, 50)

select hoten from nhanvien
where phai = 'nu' and maphong not in (10, 30, 50)

select hoten, luong from nhanvien
where luong between 3500 and 4500

select hoten from nhanvien
where hoten like '% van %'

select * from nhanvien
where hoten like '%ao'

select * from nhanvien
where phucap is null

select hoten, luong from nhanvien
where phai = 'Nu' and (datepart(yyyy, getdate()) - datepart(yyyy, ngaysinh)) = 20 

select count(*) as sonv from nhanvien

select min(luong) as thapnha, max(luong) as caonhat, avg(luong) as trungbinh
from nhanvien

select sum(luong) as tongluong
from nhanvien
where maphong = 40

select count(*) as soluong, avg(luong) as trungbinh
from nhanvien
where phai = 'nu' and congviec = 'thu ky'

select min(phucap) as phucaptn
from nhanvien
where congviec like 'quan ly%'

select 
	maphong, 
	count(*) as sonv, 
	count(case when phai = 'nam' then manv end) as nam,
	count(case when phai = 'nu' then manv end) as nu
from nhanvien
group by maphong

select ph.maphong, ph.tenphong
from 
	nhanvien as nv, 
	phong as ph
where 
	nv.maphong = ph.maphong and
	nv.hoten = 'Le Quynh Nhu'
	
select nv.hoten, ph.tenphong
from 
	nhanvien as nv, 
	phong as ph
where 
	nv.maphong = ph.maphong

select * from tdonn

select nv.hoten, td.trinhdo
from 
	nhanvien as nv,
	tdonn as td,
	ngoaingu as nn
where 
	nv.manv = td.manv and
	nn.mann = td.mann and
	nn.tennn = 'anh van'

select ph.maphong, ph.tenphong, count(nv.manv) as sonv
from nhanvien as nv 
	right outer join phong as ph on nv.maphong = ph.maphong
group by ph.maphong, ph.tenphong

select nv.manv, nv.hoten
from nhanvien as nv
	left outer join tdonn as td on nv.manv = td.manv
where td.manv is null
group by nv.manv, nv.hoten