/*
https://www.youtube.com/watch?v=WrToXXN7Jb4&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=10

Grouping Dates

*/

use SQLPractice;

create table AB_tasks (
date_value date,
state varchar(10)
);

insert into AB_tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')

select * from AB_tasks;


WITH GroupDates AS (
select *,
row_number() OVER(PARTITION BY state order by date_value) AS RN,
DATEADD(day,-1*(row_number() OVER(PARTITION BY state order by date_value)),date_value) as GroupDate 
from AB_tasks
), FinalTable AS (
SELECT GroupDate,
state,
MIN(date_value) AS StartDate,
Max(date_value) AS EndDate
FROM GroupDates
GRoup by GroupDate,state
) 
SELECT StartDate,
EndDate,
State
From FinalTable
Order by GroupDate