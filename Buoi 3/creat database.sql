CREATE DATABASE SPTIStudentsManagement;
go
--
DROP DATABASE SPTIStudentsManagement;
go
--
CREATE DATABASE SPTIStudentsManagement
ON PRIMARY
(NAME=N'SPTIStudentsManagement',FILENAME=N'D:\SPTIStudentsManagement.mdf',SIZE=10MB,MAXSIZE=UNLIMITED,FILEGROWTH=1MB)
LOG ON
(NAME=N'SPTIStudentsManagement_Log',FILENAME=N'D:\SPTIStudentsManagement_Log.ldf',SIZE=3MB,MAXSIZE=2048GB,FILEGROWTH=10%)
--
ALTER DATABASE SPTIStudentsManagement
MODIFY NAME = StudentsManagement

--
ALTER DATABASE StudentsManagement
SET AUTO_SHRINK ON

--
ALTER DATABASE StudentsManagement
ADD FILEGROUP SMFileGroup

--
ALTER DATABASE StudentsManagement
ADD FILE
(NAME=N'StudentsManagement',FILENAME='D:\StudentsManagement.ndf')
TO FILEGROUP SMFileGroup

--
CREATE DATABASE StudentsManagement_Snapshot ON
(NAME=N'StudentsManagement',FILENAME='D:\StudentsManagement.ss'),
(NAME=N'SPTIStudentsManagement',FILENAME='D:\SPTIStudentsManagement.ss')
AS SNAPSHOT OF StudentsManagement