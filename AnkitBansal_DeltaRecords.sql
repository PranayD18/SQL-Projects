
-- SQL pre screening test problem. We need to identify delta records from a production table. We will go step by step to solve the problem.
-- https://www.youtube.com/watch?v=QHwHS4AMmQM&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=46


-- write a query that will return only new inserts into ORDER since the snapshot was taken (record is in ORDER, but not ORDER_COPY) OR only new DELETEs from ORDER since the snapshot was taken (record is in ORDER_COPY, but not ORDER)
-- The query should return the Primary Key (ORDER_ID) and a single character of "I" or "D"

create table tbl_orders (
order_id integer,
order_date date
);

insert into tbl_orders
values 
    (1,'2022-10-21'),
    (2,'2022-10-22'),
    (3,'2022-10-25'),
    (4,'2022-10-25');

select * into tbl_orders_copy from  tbl_orders;
select * from tbl_orders;

insert into tbl_orders
    values 
    (5,'2022-10-26'),
    (6,'2022-10-26');

delete from tbl_orders where order_id=1;

select * from tbl_orders_copy; 

select * from tbl_orders;

-- Query


select 
coalesce(o.order_id,c.order_id) as order_id,
CASE 
    WHEN o.order_id is null THEN 'I'
    WHEN c.order_id is null THEN 'D'
END as Flag
from tbl_orders o 
full outer join tbl_orders_copy c 
on o.order_id=c.order_id
where o.order_id IS NULL or c.order_id IS NULL