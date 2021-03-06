USE QLCT

--1
SELECT CN.MSCN, CN.HOTENCN, CTR.TENCT
FROM CONGNHAN CN
	LEFT OUTER JOIN THAMGIA TG ON TG.MSCN = CN.MSCN
	LEFT JOIN CONGTRINH CTR ON CTR.STTCT = TG.STTCT

--2
SELECT CN.MSCN, CN.HOTENCN
FROM CONGNHAN CN
	LEFT OUTER JOIN THAMGIA TG ON TG.MSCN = CN.MSCN
	LEFT JOIN CONGTRINH CTR ON CTR.STTCT = TG.STTCT
WHERE CTR.TENCT IS NULL

--3
SELECT CTR.STTCT, CTR.TENCT, COUNT(TG.MSCN) SOCN
FROM CONGTRINH CTR
	LEFT OUTER JOIN THAMGIA TG ON TG.STTCT = CTR.STTCT
GROUP BY CTR.STTCT, CTR.TENCT

--4
SELECT CN.MSCN, CN.HOTENCN, COUNT(TG.STTCT) SOCTTG
FROM CONGNHAN CN
	LEFT OUTER JOIN THAMGIA TG ON TG.MSCN = CN.MSCN
GROUP BY CN.MSCN, CN.HOTENCN

--5
SELECT KTS.HOTENKTS, KTS.NOITN
FROM KIENTRUCSU KTS
	LEFT OUTER JOIN THIETKE TK ON TK.MSKTS = KTS.MSKTS
WHERE TK.STTCT IS NULL

--6
SELECT CTR.TENCT
FROM CONGTRINH CTR
	LEFT OUTER JOIN THIETKE TK ON TK.STTCT = CTR.STTCT
WHERE MSKTS IS NULL
GO

--7
CREATE PROC TONGKINHPHI_THEO_TINHTHANH
AS BEGIN
	SELECT TINHTHANH, SUM(KINHPHI) KINHPHI FROM CONGTRINH
	GROUP BY TINHTHANH
END
GO
--EXEC TONGKINHPHI_THEO_TINHTHANH

--8
CREATE PROC KINHPHI_NHONHAT_TINHTHANH
	@TINHTHANH NVARCHAR(15)
AS BEGIN
	SELECT MIN(KINHPHI) KINHPHI FROM CONGTRINH WHERE TINHTHANH = @TINHTHANH
END
GO
--EXEC KINHPHI_NHONHAT_TINHTHANH 'Can Tho'

--9
CREATE FUNCTION DEMSO_KTS() RETURNS INT
AS BEGIN
	RETURN (SELECT COUNT(MSKTS) FROM THIETKE)
END
GO

DECLARE @SOKTS INT
EXEC @SOKTS = DEMSO_KTS
PRINT 'TONG SO KIEN TRUC SU: ' + STR(@SOKTS) + ' KIEN TRUC SU'
GO

--10
CREATE FUNCTION DEMSO_KTS_TINHTHANH(@TINHTHANH NVARCHAR(15)) RETURNS INT
AS BEGIN
	DECLARE @SOKTS INT;
	WITH SLKTS AS
	(	
		SELECT CTR.TINHTHANH, COUNT(TK.MSKTS) SOKTS
		FROM THIETKE TK
			JOIN CONGTRINH CTR ON CTR.STTCT = TK.STTCT
		GROUP BY CTR.TINHTHANH
	)
	SELECT @SOKTS = SOKTS FROM SLKTS WHERE TINHTHANH = @TINHTHANH
	RETURN @SOKTS
END
GO

DECLARE @SOKTS INT
DECLARE @TINHTHANH NVARCHAR(15) = N'CAN THO'
EXEC @SOKTS = DEMSO_KTS_TINHTHANH @TINHTHANH
PRINT 'TONG SO KIEN TRUC SU TINH THANH ' + @TINHTHANH + ': ' + STR(@SOKTS) + ' KIEN TRUC SU'