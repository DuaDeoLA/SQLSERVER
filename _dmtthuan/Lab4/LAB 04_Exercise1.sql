use ST_EXAM
select * from STAFF

select id, [name], dept, job from STAFF
where Salary > 5000

select id, [name], dept, salary, salary*0.05 as bonus into StaffBonus
from Staff

select [name], dept 
from Staff
where [name] like 's%'

select Dept, count(*) as 'Number of Staff' from Staff
group by Dept

select * from Staff
where Years > 5 and Salary = 5000

select * from Staff 
order by Salary

select top (5) * from Staff 
order by Salary desc

select Dept from Staff 
group by Dept
/*select distinct Dept
from Staff */