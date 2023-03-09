
-- https://www.youtube.com/watch?v=eayyD51fIVY&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=47

create table drivers
    (
    id varchar(10), 
    start_time time, 
    end_time time, 
    start_loc varchar(10), 
    end_loc varchar(10)
    );
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

-- Write a SQL query to find out total rides and profitable rides for each driver
--- profit ride is when the end location of current ride is same as start location of next ride
SELECT * from drivers

--- using lead functions
SELECT id, 
COUNT(1) as Total_rides,
SUM(CASE WHEN end_loc=Next_start_loc then 1 else 0 end) as profit_rides 
FROM (
    SELECT *,
    LEAD(start_loc,1) OVER(PARTITION by id order by start_time asc) as Next_start_loc
    from drivers ) A 
Group by id

--- using self join

With rides as (
    SELECT *,
    row_number() OVER (PARTITION by id order by start_time asc) as rn 
    from drivers
)  
SELECT 
r1.id,
count(1) as total_rides,
count(r2.id) as profit_rides
from rides r1
left join rides r2
on r1.id=r2.id and r1.end_loc=r2.start_loc
and r1.rn+1=r2.rn
group by r1.id