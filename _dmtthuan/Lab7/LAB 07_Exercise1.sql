USE ST_EXAM
GO

SELECT ST.Rollno, ST.StuName, SJ.SubID, EM.Examtimes, EM.Marks
FROM Exammark AS EM
	JOIN Student AS ST ON ST.Rollno = EM.Rollno
	JOIN Subject AS SJ ON SJ.SubID = EM.SubID	

SELECT ST.Rollno, SJ.SubID, SJ.SubName, EM.Examtimes, EM.Marks
FROM Exammark AS EM
	JOIN Student AS ST ON ST.Rollno = EM.Rollno
	JOIN Subject AS SJ ON SJ.SubID = EM.SubID	

SELECT ST.Rollno, ST.StuName, SJ.SubID,  SJ.SubName, EM.Examtimes, EM.Marks
FROM Exammark AS EM
	JOIN Student AS ST ON ST.Rollno = EM.Rollno
	JOIN Subject AS SJ ON SJ.SubID = EM.SubID	

SELECT * FROM Student

SELECT DISTINCT ST.* 
FROM Student AS ST
	JOIN Exammark AS EM ON ST.Rollno = EM.Rollno

SELECT *
FROM Student 
WHERE Rollno NOT IN 
	(
		SELECT ST.Rollno
		FROM Student AS ST
			JOIN Exammark AS EM ON ST.Rollno = EM.Rollno
	)

