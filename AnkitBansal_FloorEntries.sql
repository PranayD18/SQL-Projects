/*
https://www.youtube.com/watch?v=P6kNMyqKD0A&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=3

Floor Entries
*/

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')

select * from entries

select name,
count(1) as TotalVisit,
STRING_AGG(floor,',') AS Floor,
STRING_AGG(resources,',') AS resources
FROM entries
Group by name;

With TotalVisits AS (SELECT name, count(1) AS TotalVisits FROM entries group by name),

UniqueResources AS (select distinct name,resources from entries),
AggregatedResources AS (select name, STRING_AGG(resources,',') AS AggResources FROM UniqueResources group by name),

FloorVisits AS 
(
    Select name,
    floor,
    count(1) as no_visits,
    RANK() OVER(PARTITION by name order by count(1) Desc) as RN
    from entries
    group by name,floor
) 
    select fv.name,
    fv.floor as most_visited_floor,
    tv.TotalVisits,
    ar.AggResources
    FROM FloorVisits fv 
    INNER JOIN TotalVisits tv ON fv.name=tv.name
    INNER JOIN AggregatedResources ar on fv.name=ar.name
    where fv.RN=1