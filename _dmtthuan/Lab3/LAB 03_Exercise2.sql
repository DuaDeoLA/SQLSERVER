USE ST_EXAM
INSERT INTO STUDENT VALUES('SV01','Lam Ngoc Dong Nhi','female','So 2 Hai Ba Trung, TPCT')
INSERT INTO STUDENT VALUES('SV02','Pham Dan Truong','male','Long Xuyen, An Giang')
INSERT INTO STUDENT VALUES('SV03','Ngo Kien Huy','male','Cai Be, Tien Giang')
INSERT INTO STUDENT VALUES('SV04','Ho Ngoc Ha','female','20/5 Tran Hung Dao, TPCT')

INSERT INTO SUBJECT VALUES('EPC','Logic Building with C',30,30)
INSERT INTO SUBJECT VALUES('HDJ','HTML, DHTML, JAVASCRIPT',25,30)
INSERT INTO SUBJECT VALUES('DWMX','DREAMWEAVER MX',20,22)
INSERT INTO SUBJECT VALUES('SQL','SQL SERVER 2015',20,30)

INSERT INTO EXAMMARK VALUES('SV01','EPC',1,40)
INSERT INTO EXAMMARK VALUES('SV01','HDJ',1,50)
INSERT INTO EXAMMARK VALUES('SV02','HDJ',1,20)
INSERT INTO EXAMMARK VALUES('SV02','HDJ',2,70)
INSERT INTO EXAMMARK VALUES('SV03','EPC',1,30)
INSERT INTO EXAMMARK VALUES('SV03','EPC',2,90)
INSERT INTO EXAMMARK VALUES('SV04','SQL',1,80)
--

--Exercise 2 
-- insert data

INSERT INTO [dbo].[department]
            ([deptno],
             [deptname],
             [mgrno],
             [admrdept])
VALUES      ('A00',
             'SPIFFY COMPUTER SERVICE DIV.',
             1,
             'A00')

INSERT INTO [dbo].[department]
            ([deptno],
             [deptname],
             [mgrno],
             [admrdept])
VALUES      ('B01',
             'PLANNING',
             3,
             'A00')

INSERT INTO [dbo].[department]
            ([deptno],
             [deptname],
             [mgrno],
             [admrdept])
VALUES      ('C01',
             'SALE',
             2,
             'B01')

INSERT INTO [dbo].[department]
            ([deptno],
             [deptname],
             [mgrno],
             [admrdept])
VALUES      ('D01',
             'DEVELOPMENT CENTER',
             10,
             'B01')

INSERT INTO [dbo].[department]
            ([deptno],
             [deptname],
             [mgrno],
             [admrdept])
VALUES      ('D11',
             'MANUFACTURING SYSTEMS',
             8,
             'B01')

INSERT INTO [dbo].[department]
            ([deptno],
             [deptname],
             [mgrno],
             [admrdept])
VALUES      ('D21',
             'ADMINISTRATION SYSTEMS',
             9,
             'D01') 
-- STAFF
INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (1,
             'Sanders',
             'A00',
             'Mgr',
             10,
             11000,
             NULL)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (2,
             'Pernal',
             'C01',
             'Mgr',
             7,
             6000,
             200)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (3,
             'Smith',
             'B01',
             'Mgr',
             8,
             8000,
             NULL)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (4,
             'O''Brien',
             'C01',
             'Sales',
             5,
             5000,
             150)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (5,
             'Hanes',
             'C01',
             'Sales',
             6,
             5000,
             150)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (6,
             'Rothman',
             'C01',
             'Sales',
             2,
             4000,
             120)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (7,
             'James',
             'C01',
             'Sales',
             3,
             4500,
             135)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (8,
             'Koonitz',
             'C01',
             'Analyst',
             3,
             4500,
             135)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (9,
             'Plotz',
             'C01',
             'Operator',
             2,
             4200,
             100)

INSERT INTO [dbo].[staff]
            ([id],
             [name],
             [dept],
             [job],
             [years],
             [salary],
             [comm])
VALUES      (10,
             'Ngan',
             'D01',
             'Clerk',
             1,
             3500,
             NULL) 