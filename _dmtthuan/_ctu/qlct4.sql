USE QLCT
--1
SELECT DISTINCT KTS.HOTENKTS, KTS.NOITN
FROM KIENTRUCSU KTS
	JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
	JOIN CONGTRINH CTR ON CTR.STTCT = TK.STTCT
WHERE TINHTHANH IN 
(
	SELECT TINHTHANH FROM CHUTHAU CT
	JOIN CONGTRINH CTR ON CTR.MSCT = CT.MSCT
	WHERE TENTHAU = 'Hoang Cong Binh'
)

--2
SELECT CTR.STTCT, CTR.KINHPHI 
FROM CONGTRINH CTR
	JOIN THIETKE TK ON TK.STTCT = CTR.STTCT
	JOIN KIENTRUCSU KTS ON KTS.MSKTS = TK.MSKTS
WHERE KTS.NGAYSINH = (SELECT MIN(NGAYSINH) FROM KIENTRUCSU)

--3
SELECT KTS.MSKTS, KTS.HOTENKTS
FROM KIENTRUCSU KTS
	JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
	JOIN CONGTRINH CTR ON CTR.STTCT = TK.STTCT
	JOIN CHUNHAN CHU ON CHU.MSCH = CTR.MSCH
WHERE CHU.DIACHICHU = '101 Hai Ba Trung'

--4
SELECT DISTINCT KTS.MSKTS, KTS.HOTENKTS
FROM KIENTRUCSU KTS
	JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
	JOIN CONGTRINH CTR ON CTR.STTCT = TK.STTCT
	JOIN CHUTHAU CT ON CT.MSCT = CTR.MSCT
WHERE CT.MSCT IN
(
	SELECT CT.MSCT FROM CHUTHAU CT
		JOIN CONGTRINH CTR ON CTR.MSCT = CT.MSCT
	GROUP BY CT.MSCT
	HAVING COUNT(STTCT) >= 3
)

--5
SELECT MSCN, HOTENCN FROM CONGNHAN
WHERE MSCN IN
(
	SELECT CN.MSCN
	FROM CONGNHAN CN
		JOIN THAMGIA TG ON TG.MSCN = CN.MSCN
		JOIN CONGTRINH CTR ON CTR.STTCT = TG.STTCT
	GROUP BY CN.MSCN
	HAVING COUNT(CTR.TINHTHANH) >= 2
)
GO

--6
WITH TT AS
(
	SELECT CTR.TINHTHANH, COUNT(DISTINCT CN.MSCN) SOCN
	FROM CONGTRINH CTR
		JOIN THAMGIA TG ON TG.STTCT = CTR.STTCT
		JOIN CONGNHAN CN ON CN.MSCN = TG.MSCN
	GROUP BY CTR.TINHTHANH
)
SELECT TINHTHANH FROM TT WHERE SOCN = (SELECT MAX(SOCN) FROM TT)

--7
WITH TL AS
(
	SELECT CTR.TINHTHANH, TK.THULAO
	FROM KIENTRUCSU KTS 
		JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
		JOIN CONGTRINH CTR ON CTR.STTCT = TK.STTCT
	WHERE KTS.HOTENKTS = 'Le Kim Dung'
)
SELECT TINHTHANH FROM TL WHERE THULAO = (SELECT MIN(THULAO) FROM TL)

--8
SELECT DISTINCT KTS.HOTENKTS, CN.HOTENCN
FROM KIENTRUCSU KTS
	JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
	JOIN THAMGIA TG ON TG.STTCT = TK.STTCT
	JOIN CONGNHAN CN ON CN.MSCN = TG.MSCN
	
--9
SELECT DISTINCT KTS.HOTENKTS, CN.HOTENCN, CTR.TINHTHANH
FROM KIENTRUCSU KTS
	JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
	JOIN THAMGIA TG ON TG.STTCT = TK.STTCT
	JOIN CONGNHAN CN ON CN.MSCN = TG.MSCN
	JOIN CONGTRINH CTR ON CTR.STTCT = TG.STTCT

--10
SELECT DISTINCT KTS.HOTENKTS, CN.HOTENCN
FROM KIENTRUCSU KTS
	JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
	JOIN THAMGIA TG ON TG.STTCT = TK.STTCT
	JOIN CONGNHAN CN ON CN.MSCN = TG.MSCN
	JOIN CONGTRINH CTR ON CTR.STTCT = TG.STTCT
WHERE TK.THULAO < 0.05 * CTR.KINHPHI
