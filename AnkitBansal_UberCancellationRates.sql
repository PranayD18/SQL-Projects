/*
https://www.youtube.com/watch?v=EjzhMv0E_FE&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=7

Trips and users

Write a SQL query to find the cancellation rate of requests with banned users (both client and users must not be banned) each day between "2013-10-01" and "2013-10-03".
Round cancellation rate to two decimal points.

the cancellation rate is computed by dividing the number of cancelled (by client or driver) requests with unbanned users by the total number of request with unbanned users of that day
*/

Create table  UberTrips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table UberUsers (users_id int, banned varchar(50), role varchar(50));

Truncate table UberTrips;
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into UberTrips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');

Truncate table UberUsers;
insert into UberUsers (users_id, banned, role) values ('1', 'No', 'client');
insert into UberUsers (users_id, banned, role) values ('2', 'Yes', 'client');
insert into UberUsers (users_id, banned, role) values ('3', 'No', 'client');
insert into UberUsers (users_id, banned, role) values ('4', 'No', 'client');
insert into UberUsers (users_id, banned, role) values ('10', 'No', 'driver');
insert into UberUsers (users_id, banned, role) values ('11', 'No', 'driver');
insert into UberUsers (users_id, banned, role) values ('12', 'No', 'driver');
insert into UberUsers (users_id, banned, role) values ('13', 'No', 'driver');


-- Query

select * from UberTrips
select * from UberUSers

select * from UberTrips t
INNER JOIN UberUSers c on c.users_id=t.client_id
INNER JOIN UberUSers d on d.users_id=t.driver_id
where c.banned='No' and d.banned='No'

WITH CTE AS (
select request_at,
count(1) AS Total_Trips,
COUNT(CASE WHEN status IN ('cancelled_by_client','cancelled_by_driver') THEN 1 ELSE null END) AS Cancelled_Trips
from UberTrips t
INNER JOIN UberUSers c on c.users_id=t.client_id
INNER JOIN UberUSers d on d.users_id=t.driver_id
where c.banned='No' and d.banned='No'
Group BY request_at
) SELECT *,
 Round((1.0*Cancelled_Trips/Total_Trips)*100,2) AS cancellation_Rate
 FROM CTE