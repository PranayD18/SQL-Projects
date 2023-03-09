/*
https://www.youtube.com/watch?v=i_ljK9gmstY&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=14

Amazon prime subscription rate logic in SQL. here is the problem statement:

Given the following two tables, return the fraction of users, rounded to two decimal places,
who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up
*/

create table AmazonPrimeUsers
(
user_id integer,
name varchar(20),
join_date date
);
insert into AmazonPrimeUsers
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table AmazonPrimeEvents
(
user_id integer,
type varchar(10),
access_date date
);

insert into AmazonPrimeEvents values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));

select * from AmazonPrimeUsers
select * from AmazonPrimeEvents

WITH CTE1 AS (
select u.*,
e.type,
e.access_date,
DATEDIFF(day,u.join_date,e.access_date) AS No_Days
from AmazonPrimeUsers u
left join AmazonPrimeEvents e
on u.user_id=e.user_id and e.type='P'
where u.user_id in (select user_id from AmazonPrimeEvents where [type]='Music') 
) SELECT 
count(distinct user_id) AS total_users,
count(CASE WHEN No_Days<=30 THEN 1 ELSE NULL END) AS Joined_30Days,
ABS(1.0*count(CASE WHEN No_Days<=30 THEN 1 ELSE NULL END)/count(distinct user_id))*100 AS Perc
FROm CTE1