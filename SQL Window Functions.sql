create table EmployeeNew
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into EmployeeNew values(101, 'Mohan', 'Admin', 4000);
insert into EmployeeNew values(102, 'Rajkumar', 'HR', 3000);
insert into EmployeeNew values(103, 'Akbar', 'IT', 4000);
insert into EmployeeNew values(104, 'Dorvin', 'Finance', 6500);
insert into EmployeeNew values(105, 'Rohit', 'HR', 3000);
insert into EmployeeNew values(106, 'Rajesh',  'Finance', 5000);
insert into EmployeeNew values(107, 'Preet', 'HR', 7000);
insert into EmployeeNew values(108, 'Maryam', 'Admin', 4000);
insert into EmployeeNew values(109, 'Sanjay', 'IT', 6500);
insert into EmployeeNew values(110, 'Vasudha', 'IT', 7000);
insert into EmployeeNew values(111, 'Melinda', 'IT', 8000);
insert into EmployeeNew values(112, 'Komal', 'IT', 10000);
insert into EmployeeNew values(113, 'Gautham', 'Admin', 2000);
insert into EmployeeNew values(114, 'Manisha', 'HR', 3000);
insert into EmployeeNew values(115, 'Chandni', 'IT', 4500);
insert into EmployeeNew values(116, 'Satya', 'Finance', 6500);
insert into EmployeeNew values(117, 'Adarsh', 'HR', 3500);
insert into EmployeeNew values(118, 'Tejaswi', 'Finance', 5500);
insert into EmployeeNew values(119, 'Cory', 'HR', 8000);
insert into EmployeeNew values(120, 'Monica', 'Admin', 5000);
insert into EmployeeNew values(121, 'Rosalin', 'IT', 6000);
insert into EmployeeNew values(122, 'Ibrahim', 'IT', 8000);
insert into EmployeeNew values(123, 'Vikram', 'IT', 8000);
insert into EmployeeNew values(124, 'Dheeraj', 'IT', 11000);
COMMIT;


select * from EmployeeNew

select *,
--MAX(Salary) OVER(Partition by DEPT_Name) AS Max_Salary,
ROW_NUMBER() OVER(Partition by DEPT_Name Order by Salary) AS RN
--RANK() OVER() AS Rank
FROM EmployeeNew


-- Fetch only first 2 employees from every dept to join the company
	
select * FROM (
	select *,
	ROW_NUMBER() OVER(Partition by DEPT_Name Order by emp_ID) AS RN
	FROM EmployeeNew
) A
Where A.RN <3



-- Fetch top 3 employees in each department earning tyhe max salary

select * FROM (
	select *,
	RANK() OVER(Partition by DEPT_Name Order by Salary DESC) AS Rank,
	Dense_RANK() OVER(Partition by DEPT_Name Order by Salary DESC) AS DenseRank
	FROM EmployeeNew
) A
Where A.Rank <3


--- Fetch a query to display if an employee salary is higher, lower or equal to the previous employee salary in every dept

With T1 AS (
    select *,
	LAG(salary) OVER(Partition by DEPT_Name Order by emp_ID ASC) AS Prev_Emp_Salary	
	FROM EmployeeNew
	) 
	SELECT *,
	CASE    
			WHEN salary<Prev_Emp_Salary then 'Less than Previous employee' 
			WHEN salary>Prev_Emp_Salary then 'higher than Previous employee' 
			WHEN salary=Prev_Emp_Salary then 'Same as Previous employee' 	
	END
	From T1


-- 
	select *,
	FIRST_VALUE(emp_Name) OVER(Partition by DEPT_NAME Order by Salary DESC) as HighestSalariedEmp,

	LAST_VALUE(emp_Name) 
		OVER(Partition by DEPT_NAME Order by Salary DESC
		range between unbounded preceding and unbounded following
		) as LowestSalariedEmp
  
	FROM EmployeeNew;
	
-- Alternate way

	select *,
	FIRST_VALUE(emp_Name) OVER W as HighestSalariedEmp,
	LAST_VALUE(emp_Name) OVER W as LowestSalariedEmp,
	FROM EmployeeNew
	window W AS (Partition by DEPT_NAME Order by Salary DESC
				range between unbounded preceding and unbounded following
				)
		