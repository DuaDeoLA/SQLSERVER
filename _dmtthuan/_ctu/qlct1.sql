--1
select ctr.tenct, ctr.diachict
from congtrinh as ctr
	join chuthau cth on cth.msct = ctr.msct
where cth.tenthau = 'Hong Xuan Truong'

--2
select cth.tenthau, cth.diachithau
from congtrinh as ctr
	join chuthau cth on cth.msct = ctr.msct
where ctr.tinhthanh = 'Can Tho'
group by cth.tenthau, cth.diachithau

--3
select kts.hotenkts, kts.noitn
from kientrucsu as kts
	join thietke as tk on tk.mskts = kts.mskts
	join congtrinh as ctr on ctr.sttct = tk.sttct
where ctr.tenct = 'Khach san Quoc Te' and ctr.tinhthanh = 'Can Tho'

--4
select cn.hotencn, datepart(yy,cn.ngaysinh) as namsinhcn, cn.phai
from congnhan as cn
	join thamgia as tg on tg.mscn = cn.mscn
	join congtrinh as ctr on ctr.sttct = tg.sttct
	join chuthau as cth on cth.msct = ctr.msct 
where 
	(cn.chuyenmon = 'han' or cn.chuyenmon = 'dien') and
	cth.tenthau = 'Le Van Son'
	
--5
select cn.hotencn, tg.songay
from congnhan as cn
	join thamgia as tg on tg.mscn = cn.mscn
	join congtrinh as ctr on ctr.sttct = tg.sttct
where 
	ctr.tenct = 'Khach san Quoc Te' and ctr.tinhthanh = 'Can Tho' and
	tg.ngaytg between '1994-12-15' and '1994-12-31'
	
--6
select ctr.tenct, ctr.diachict
from congtrinh as ctr
	join thamgia as tg on tg.sttct = ctr.sttct
	join congnhan as cn on cn.mscn = tg.mscn
where 
	cn.hotencn = 'Nguyen Hong Van' and
	tg.ngaytg <= '1994-12-18' and
	dateadd(dd,tg.songay, tg.ngaytg) >= '1994-12-18'
	
--7
select kts.hotenkts, datepart(yy, kts.ngaysinh) as namsinhkts
from kientrucsu as kts
	join thietke as tk on tk.mskts = kts.mskts
	join congtrinh as ctr on ctr.sttct = tk.sttct
where kts.noitn = 'TP HCM' and ctr.kinhphi > 400

--8
select cn.hotencn, cn.chuyenmon
from congnhan as cn
	join thamgia as tg on tg.mscn = cn.mscn
	join thietke as tk on tk.sttct = tg.sttct
	join kientrucsu as kts on kts.mskts = tk.mskts
where kts.hotenkts = 'Nguyen Anh Thu'

--9
select chu.tenchu
from chunhan as chu
	join congtrinh as ctr on ctr.msch = chu.msch
	join thietke as tk on tk.sttct = ctr.sttct
	join kientrucsu as kts on kts.mskts = tk.mskts
	join chuthau as cth on cth.msct = ctr.msct
where
	kts.hotenkts = 'Nguyen Anh Thu' and
	cth.tenthau = 'Hoang Cong Binh'
	
--10
select ctr.tenct
from congtrinh as ctr
	join thietke as tk on tk.sttct = ctr.sttct
	join kientrucsu as kts on kts.mskts = tk.mskts
where kts.noitn = 'TP HCM'