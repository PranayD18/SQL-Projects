/*
https://www.youtube.com/watch?v=MpAMjtvarrc&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=2

This video is about finding new and repeat customers .using SQL. In this video we will learn following concepts:
how to approach complex query step by step
how to use CASE WHEN with SUM
how to use common table expression (CTE)
*/

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);

select * from customer_orders

WITH CTE AS (select 
customer_id,
MIN(Order_date) as First_Order,
MAX(Order_date) as Recent_Order
FROM customer_orders
GRoup by customer_id
) SELECT distinct customer_orders.customer_id,
         --CTE.First_Order,
         --CTE.Recent_Order,
         --order_date,
         CASE WHEN First_Order=Recent_Order THEN 'New' Else 'Repeated' END AS CustomerType
         FROM customer_orders
         INNER JOIN CTE ON customer_orders.customer_id=CTE.customer_id
         ORDER BY (CASE WHEN First_Order=Recent_Order THEN 'New' Else 'Repeated' END)


--- Another approach based on Order Date

WITH FirstVisit AS (select 
customer_id,
MIN(Order_date) as First_Order
FROM customer_orders
GRoup by customer_id
), 
VisitFlags AS (SELECT c.*,
CASE WHEN First_Order=order_date THEN 1 else 0 end as FirstVisit_flag,
CASE WHEN First_Order!=order_date THEN 1 else 0 end as RepeatedVisit_flag
FROM customer_orders c 
INNER JOIN FirstVisit f on f.customer_id=c.customer_id
) SELECT order_date,
         SUM(FirstVisit_flag) AS New_customer,
         SUM(RepeatedVisit_flag) AS Repeat_Customer
         FROM VisitFlags
         GROUP BY order_date