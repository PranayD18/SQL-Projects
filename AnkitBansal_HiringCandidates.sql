/* A Company wants to hire new employees. The budget of the company is $70000.
The criteria for hiring are :
1. Keep hiring the senior with the smallest salary until you cannot hire any more seniors
2. Use the remaining budget to hire the junior with the smallest salary
3. Keep hiring the junior with the smallest salary until you cannot hire any more juniors

Write a SQL query to find the seniors and juniors hired under the mentioned criteria .*/

use SQLPractice;

create table candidates (
emp_id int,
experience varchar(20),
salary int
);

delete from candidates;

insert into candidates 
values
    (1,'Junior',10000),
    (2,'Junior',15000),
    (3,'Junior',40000),
    (4,'Senior',16000),
    (5,'Senior',20000),
    (6,'Senior',50000);

select * from candidates;

select *,
sum(salary) over(PARTITION by experience order by salary asc) as runningSalary
from candidates;

---if you have duplicate row with different emp_id
select *,
sum(salary) over(PARTITION by experience order by salary asc rows between unbounded preceding and current row) as runningSalary
from candidates;

--SET TotalBudget:=70000

With TotalSalary as (

    select *,
    sum(salary) over(PARTITION by experience order by salary asc) as runningSalary
    from candidates
), SeniorSelect AS 
    (select * from TotalSalary where experience='Senior' and runningSalary<=70000)
        
        select * from TotalSalary where experience='Junior' and runningSalary<=(70000-(select sum(salary) from SeniorSelect))

    union all

    select * from SeniorSelect

