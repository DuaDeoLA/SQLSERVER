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