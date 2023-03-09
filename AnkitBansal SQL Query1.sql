
-- Ankit Bansal's Youtube videos

CREATE DATABASE SQLPractice;

--script:

--Ankit Bansal https://www.youtube.com/watch?v=dOLBRfwzYcU&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E
--Olympic Gold Medals Problem | SQL Online Interview Question | Data Analytics | 2 Solutions

CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events;

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

SELECT TOP (1000) [ID]
,[event]
,[YEAR]
,[GOLD]
,[SILVER]
,[BRONZE]
FROM [SQLPractice].[dbo].[events]


-- Write a query to find player with no of gold medals won by them only for players who won only gold medals.

-- Solution 1
Select 
GOLD AS Player,
Count(1) AS Count_Gold
FROM  [SQLPractice].[dbo].[events]
WHERE GOLD NOT IN 

    (SELECT SILVER FROM  [SQLPractice].[dbo].[events] 
     UNION ALL 
     SELECT BRONZE FROM  [SQLPractice].[dbo].[events])

Group by GOLD
ORDER BY Count_Gold DESC

-- Solution 2
WITH CTE AS (

    Select GOLD AS Player, 'GOLD' as Type from [SQLPractice].[dbo].[events]
    UNION ALL
    Select SILVER AS Player, 'SILVER' as Type from [SQLPractice].[dbo].[events]
    UNION ALL
    Select BRONZE AS Player, 'BRONZE' as Type from [SQLPractice].[dbo].[events]
)
    SELECT Player,
    Count(1) AS Count_Gold
    FROM CTE
    GROUP BY  Player
    HAVING Count(DISTINCT Type)=1 and MAX([Type])='GOLD'
    ORDER BY Count_Gold DESC



--https://www.youtube.com/watch?v=FZ0GCcnIIWA&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=2
--find difference between 2 dates excluding weekends and public holidays  . Basically we need to find business days between 2 given dates using SQL. 

script:
create table tickets
    (
    ticket_id varchar(10),
    create_date date,
    resolved_date date
    );
delete from tickets;

insert into tickets values
    (1,'2022-08-01','2022-08-03')
    ,(2,'2022-08-01','2022-08-12')
    ,(3,'2022-08-01','2022-08-16');

create table holidays
    (
    holiday_date date
    ,reason varchar(100)
    );
delete from holidays;

insert into holidays values
    ('2022-08-11','Rakhi'),
    ('2022-08-15','Independence day');












    ----------a SQL interview problem where we need to find number of employees inside the hospital.
    https://www.youtube.com/watch?v=oGYinDMDfnA&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=3


    script:
create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

Select * from hospital

--Method1:
WITH CTE AS (
Select emp_id,
MAX(CASE WHEN action='in' then time end) as intime,
MAX(CASE WHEN action='out' then time end) as outtime
from hospital
Group by emp_id) 
SELECT emp_id,intime,outtime from CTE
where intime>outtime OR Outtime IS NULL




Link - https://www.youtube.com/watch?v=PE5MZW1CxOI&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=4
-- https://www.youtube.com/watch?v=PE5MZW1CxOI&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=4
Find most popular room type :

create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

delete from airbnb_searches;

insert into airbnb_searches values
    (1,'2022-01-01','entire home,private room')
    ,(2,'2022-01-02','entire home,shared room')
    ,(3,'2022-01-02','private room,shared room')
    ,(4,'2022-01-03','private room')
;

select * from airbnb_searches;

select *  from airbnb_searches
CROSS APPLY string_split(filter_room_types,',')

select value as Room_Type, COUNT(1) as RoomSearched from airbnb_searches
CROSS APPLY string_split(filter_room_types,',')
Group by Value
ORDER by RoomSearched DESC



--- https://www.youtube.com/watch?v=TvqKpz9RO-A&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=5

-- Write a SQL code to find out all employees whose salary is same in department

CREATE TABLE [emp_salary]
(
    [emp_id] INTEGER  NOT NULL,
    [name] NVARCHAR(20)  NOT NULL,
    [salary] NVARCHAR(30),
    [dept_id] INTEGER
);

delete from emp_salary

INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');


select * from emp_salary Order by dept_id;

select dept_id,salary,count(1) from emp_salary
group by dept_id,salary;

select dept_id,salary from emp_salary
group by dept_id,salary
HAVING count(1)>1;


--salary is same in department
WITH CTE AS (
    select dept_id,salary from emp_salary
    group by dept_id,salary
    HAVING count(1)>1
) 
    SELECT a.* FROM emp_salary a 
    INNER JOIN CTE b 
    on a.dept_id=b.dept_id and a.salary=b.salary;


--salary is not same in department
WITH CTE AS (
    select dept_id,salary from emp_salary
    group by dept_id,salary
    HAVING count(1)=1
) 
    SELECT a.* FROM emp_salary a 
    INNER JOIN CTE b 
    on a.dept_id=b.dept_id and a.salary=b.salary;

-- https://www.youtube.com/watch?v=5Ighj_2PGV0
--There are many advance concepts wrt aggregations and we will cover everything possible.

CREATE TABLE [dbo].[int_orders](
 [order_number] [int] NOT NULL,
 [order_date] [date] NOT NULL,
 [cust_id] [int] NOT NULL,
 [salesperson_id] [int] NOT NULL,
 [amount] [float] NOT NULL
) ON [PRIMARY]
GO

INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (30, CAST(N'1995-07-14' AS Date), 9, 1, 460)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (10, CAST(N'1996-08-02' AS Date), 4, 2, 540)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (40, CAST(N'1998-01-29' AS Date), 7, 2, 2400)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (50, CAST(N'1998-02-03' AS Date), 6, 7, 600)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (60, CAST(N'1998-03-02' AS Date), 6, 7, 720)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (70, CAST(N'1998-05-06' AS Date), 9, 7, 150)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (20, CAST(N'1999-01-30' AS Date), 4, 8, 1800)

SELECT * FROM int_orders

SELECT salesperson_id,order_date,order_number,amount from int_orders

SELECT salesperson_id, 
    AVG(amount) as avg,
    SUM(amount) as total,
    min(amount) as minSales,
    max(amount) as maxSales,
    count(1) as SalesCount
    from int_orders
group by salesperson_id
order by salesperson_id

SELECT salesperson_id,order_date,order_number,amount ,
sum(amount) OVER(partition by salesperson_id) AS accumulated_Sales
from int_orders
order by salesperson_id 

SELECT salesperson_id,order_date,order_number,amount ,
sum(amount) OVER(order by order_date) AS accumulated_Sales
from int_orders
order by salesperson_id 

SELECT salesperson_id,order_date,order_number,amount ,
sum(amount) OVER(partition by salesperson_id order by order_date) AS accumulated_Sales
from int_orders
order by salesperson_id 

SELECT salesperson_id,order_date,order_number,amount ,
sum(amount) OVER(order by order_date rows between 1 preceding and current row) AS accumulated_Sales
from int_orders
order by salesperson_id

SELECT salesperson_id,order_date,order_number,amount ,
sum(amount) OVER(order by order_date rows between 1 preceding and 1 following) AS accumulated_Sales
from int_orders
order by salesperson_id

SELECT salesperson_id,order_date,order_number,amount ,
sum(amount) OVER(order by order_date rows between unbounded preceding and current row) AS accumulated_Sales
from int_orders
order by salesperson_id





-------
-- https://www.youtube.com/watch?v=7W7B0y5WsaQ&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=11
--Print Highest and Lowest Salary Employees in Each Department

create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);

delete from employee;

insert into employee values 
    ('Siva',1,30000),
    ('Ravi',2,40000),
    ('Prasad',1,50000),
    ('Sai',2,20000)

SELECT * FROM employee order by dep_id,salary;


WITH CTE AS (
    SELECT dep_id,
    max(salary) as MaxSalary,
    min(salary) as MinSalary
    From employee
    group by dep_id
) SELECT e.dep_id,
        MAX(CASE when salary=MaxSalary THEN emp_name else null end) as Max_sal_employee,
        MAX(CASE when salary=MinSalary THEN emp_name else null end) as Min_sal_employee
  FROM employee e
  INNER JOIN CTE on e.dep_id=cte.dep_id
  GROUP BY e.dep_id




--- https://www.youtube.com/watch?v=ougF0bhY424
-- Aggregation and Window Functions Together in a Single SQL | Advance SQL

SELECT * FROM Orders

SELECT distinct Category, [Sub-Category], [Product Name]
FROM Orders
Order by Category, [Sub-Category], [Product Name]

SELECT distinct Category, [Sub-Category], SUM(Sales) As TotalSales
FROM Orders
GROUP BY Category, [Sub-Category]
Order by Category, [Sub-Category]

SELECT distinct Category, [Product Name], ROUND(SUM(Sales),2) As TotalSales
FROM Orders
GROUP BY Category, [Product Name]
Order by Category, TotalSales

--Top 3 Products in each Category

WITH CTE AS (
    SELECT  Category, [Product Name], ROUND(SUM(Sales),2) As TotalSales
    FROM Orders
    GROUP BY Category, [Product Name]
    --Order by Category, TotalSales 
    ) 
SELECT * FROM
    (SELECT * , 
    RANK() OVER(partition by Category Order by TotalSales Desc) AS Rn
    FROM CTE ) 
TableA Where Rn<=3

---without CTE query

SELECT * FROM
    (SELECT Category, 
            [Product Name],
            ROUND(SUM(Sales),2) As TotalSales,
            RANK() OVER(partition by Category Order by SUM(Sales) Desc) AS Rn
    FROM Orders
    GROUP BY Category, [Product Name] ) 
TableA Where Rn<=3

---- Date Time

SELECT  DATEPART(year,[Order Date]) AS OrderYear,
        ROUND(SUM(Sales),2) As TotalSales
FROM Orders
GROUP BY  DATEPART(year,[Order Date]);

WITH SalesYear AS (
    SELECT  DATEPART(year,[Order Date]) AS OrderYear,
            ROUND(SUM(Sales),2) As TotalSales
    FROM Orders
    GROUP BY  DATEPART(year,[Order Date])
) Select *,
LAG(TotalSales,1,0) OVER( ORDER BY OrderYear) AS PrevYear_Sales,
LAG(TotalSales,1,0) OVER( ORDER BY OrderYear) AS CurrYear_Sales
FROM SalesYear
Order by OrderYear




-- https://www.youtube.com/watch?v=lxFQ0RgyEcA&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=12

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);

insert into call_start_logs 
values
    ('PN1','2022-01-01 10:20:00'),
    ('PN1','2022-01-01 16:25:00'),
    ('PN2','2022-01-01 12:30:00'),
    ('PN3','2022-01-02 10:00:00'),
    ('PN3','2022-01-02 12:30:00'),
    ('PN3','2022-01-03 09:20:00');


create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);

insert into call_end_logs 
values
    ('PN1','2022-01-01 10:45:00'),
    ('PN1','2022-01-01 17:05:00'),
    ('PN2','2022-01-01 12:55:00'),
    ('PN3','2022-01-02 10:20:00'),
    ('PN3','2022-01-02 12:50:00'),
    ('PN3','2022-01-03 09:40:00');


select *,
ROW_NUMBER() OVER(partition by phone_number order by start_time) as rn
from call_start_logs;

select *,
ROW_NUMBER() OVER(partition by phone_number order by end_time) as rn
from call_end_logs;



SELECT 
S.rn AS Rank,
S.phone_number AS phone_number,
S.start_time AS start_time,
E.end_time AS end_time,
DATEDIFF(MINUTE,S.start_time,E.end_time) AS Call_Duration
FROM
    (select *, ROW_NUMBER() OVER(partition by phone_number order by start_time) as rn from call_start_logs) S 
    INNER JOIN
    (select *,ROW_NUMBER() OVER(partition by phone_number order by end_time) as rn from call_end_logs) E
ON S.phone_number=E.phone_number AND S.rn=E.rn;



SELECT
rn AS RANK,
phone_number,
MIN(Call_Time)  AS start_time,
MAX(Call_Time)  AS end_time,
DATEDIFF(MINUTE,MIN(Call_Time),MAX(Call_Time)) AS Call_Duration
FROM
    (
    select phone_number,start_time AS Call_Time, ROW_NUMBER() OVER(partition by phone_number order by start_time) as rn from call_start_logs
    UNION ALL
    select phone_number,end_time AS Call_Time, ROW_NUMBER() OVER(partition by phone_number order by end_time) as rn from call_end_logs
    ) A
GROUP BY phone_number,rn
ORDER BY start_time





---- https://www.youtube.com/watch?v=TgKmfAV2pw8&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=7


create table adobe_transactions
(
customer_id varchar(10),
product VARCHAR(255),
revenue int
);

insert into adobe_transactions
VALUES
    ('123','Photoshop',50),
    ('123','Illustrator',200),
    ('123','Premier Pro',100),
    ('234','After Effects',150),
    ('234','Premier Pro',100),
    ('234','Illustrator',200),
    ('678','Photoshop',50),
    ('678','Premier Pro',100),
    ('678','After Effects',150);


select customer_id,sum(revenue) AS Total from adobe_transactions
where customer_id IN (select customer_id from adobe_transactions where product='Photoshop')
and product!='Photoshop'
GROUP by customer_id
order by customer_id


select * from employee









/* Populate the column with last non null value
https://www.youtube.com/watch?v=Xh0EevUOWF0&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=39
*/

script:
create table brands 
(
category varchar(20),
brand_name varchar(20)
);

insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');

WITH CTE1 AS (
select *,
ROW_NUMBER() OVER(ORDER by (Select 1)) AS RN
from brands
)
, CTE2 AS (
SELECT *,
LEAD(RN,1,99) OVER(ORDER by RN) AS RN_Next
FROM CTE1 WHERE category IS NOT NULL
) SELECT CTE2.Category,
CTE1.brand_name
FROM CTE2
INNER JOIN CTE1 ON CTE1.RN>=CTE2.RN  AND CTE1.RN <= CTE2.RN_Next-1
