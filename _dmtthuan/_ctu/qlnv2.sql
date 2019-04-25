select hoten from nhanvien
where luong = (select max(luong) from nhanvien)

select hoten from nhanvien
where luong > all (select luong from nhanvien where maphong = 30)

select hoten from nhanvien
where manv = any (select truongphong from phong)

select hoten from nhanvien
where manv in (select truongphong from phong)

select a.hoten
from nhanvien as a
where exists 
(
	select hoten from nhanvien as b
	where a.manv <> b.manv and a.luong = b.luong and a.congviec = b.congviec
)

select p.maphong, p.tenphong, count (nv.manv) as nu into #Sonu
		from phong as p
			join nhanvien as nv on nv.maphong = p.maphong
		where nv.phai = 'nu'
		group by p.maphong, p.tenphong
select maphong, tenphong
from #Sonu
where nu = (select max(nu) from #Sonu)
drop table #Sonu

create view Sonu(maphong, tenphong, nu) as
	select p.maphong, p.tenphong, count (nv.manv) as nu
	from phong as p
		join nhanvien as nv on nv.maphong = p.maphong
	where nv.phai = 'nu'
	group by p.maphong, p.tenphong
go
select maphong, tenphong
from Sonu
where nu = (select max(nu) from Sonu)
drop view Sonu

select nv.manv
from nhanvien as nv
	join tdonn as td on td.manv = nv.manv
	join ngoaingu as nn on nn.mann = td.mann
where congviec = 'thu ky' or (nn.tennn = 'Tieng Anh' and td.trinhdo = 'B')

select nv.manv
from nhanvien as nv
	join tdonn as td on td.manv = nv.manv
	join ngoaingu as nn on nn.mann = td.mann
where congviec = 'thu ky' and nn.tennn = 'Tieng Anh' and td.trinhdo = 'B'

select ph.*, nv.congviec into #congviectrongphong
from phong as ph 
	join nhanvien as nv on nv.maphong = ph.maphong	

select * from #congviectrongphong
where 
	congviec = 'quan ly' and 
	maphong in (select maphong from #congviectrongphong
	where congviec = 'thu ky')
	
drop table #congviectrongphong