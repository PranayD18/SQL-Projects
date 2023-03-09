
---//----
SELECT DISTINCT date(transaction_date), 
        sum(case when type='deposit' then amount else -1*amount end) 
            over (partition by extract(month from transaction_date) order by date(transaction_date) )
FROM [Merchant Transaction];
 
  order by transaction_date;

select *  From [Merchant Transaction];


------//-----------------------------------------------------------//-----------

https://www.youtube.com/watch?v=8glk10JlvKE&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=43

--Double Self Join in SQL

--Write a SQL Query to list emp name with their manager and senior manager names

--script:
create table AnkitBansal_Emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into AnkitBansal_Emp 
values 
  (1, 'Ankit', 100,10000, 4, 39),
  (2, 'Mohit', 100, 15000, 5, 48),
  (3, 'Vikas', 100, 12000,4,37),
  (4, 'Rohit', 100, 14000, 2, 16),
  (5, 'Mudit', 200, 20000, 6,55),
  (6, 'Agam', 200, 12000,2, 14),
  (7, 'Sanjay', 200, 9000, 2,13),
  (8, 'Ashish', 200,5000,2,12),
  (9, 'Mukesh',300,6000,6,51),
  (10, 'Rakesh',500,7000,6,50);

  select * from AnkitBansal_Emp

  select a.emp_id as emp_id,
  a.emp_name as emp_name,
  b.emp_name as manager_name,
  c.emp_name as senior_manager
  from AnkitBansal_Emp a
  join AnkitBansal_Emp b on a.manager_id=b.emp_id
  join AnkitBansal_Emp c on b.manager_id=c.emp_id;


  ----/// where manager's salary is more than Senior manager's

    select a.emp_id as emp_id,
  a.emp_name as emp_name,
  b.emp_name as manager_name,
  c.emp_name as senior_manager
  from AnkitBansal_Emp a
  join AnkitBansal_Emp b on a.manager_id=b.emp_id
  join AnkitBansal_Emp c on b.manager_id=c.emp_id;