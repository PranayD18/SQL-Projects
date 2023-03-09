drop table billing;
create table billing
(
      customer_id               int
    , customer_name             varchar(1)
    , billing_id                varchar(5)
    , billing_creation_date     date
    , billed_amount             int
);

insert into billing values (1, 'A', 'id1', '10-10-2020', 100);
insert into billing values (1, 'A', 'id2', '11-11-2020', 150);
insert into billing values (1, 'A', 'id3', '12-11-2021', 100);
insert into billing values (2, 'B', 'id4', '10-11-2019', 150);
insert into billing values (2, 'B', 'id5', '11-11-2020', 200);
insert into billing values (2, 'B', 'id6', '12-11-2021', 250);
insert into billing values (3, 'C', 'id7', '01-01-2018', 100);
insert into billing values (3, 'C', 'id8', '05-01-2019', 250);
insert into billing values (3, 'C', 'id9', '06-01-2021', 300);


/*
Display avg billing for each customer between 2019 to 2021 , assume 0$ billing amount if nothing is billed for a particular year of that customer
*/


select * from billing;

with cte as
    (select customer_id,customer_name
    , sum(case when Year(billing_creation_date) = '2019' then billed_amount else 0 end)as bill_2019_sum
    , sum(case when  Year(billing_creation_date) = '2020' then billed_amount else 0 end) as bill_2020_sum
    , sum(case when  Year(billing_creation_date) = '2021' then billed_amount else 0 end) as bill_2021_sum
    , count(case when  Year(billing_creation_date) = '2019' then billed_amount else null end) as bill_2019_cnt
    , count(case when Year(billing_creation_date) = '2020' then billed_amount else null end) as bill_2020_cnt
    , count(case when  Year(billing_creation_date) = '2021' then billed_amount else null end) as bill_2021_cnt
    from billing
    group by customer_id,customer_name)
select customer_id, customer_name
, round((bill_2019_sum + bill_2020_sum + bill_2021_sum)/
    (  case when bill_2019_cnt = 0 then 1 else bill_2019_cnt end
     + case when bill_2020_cnt = 0 then 1 else bill_2020_cnt end
     + case when bill_2021_cnt = 0 then 1 else bill_2021_cnt end
    ),2)
from cte
order by 1;
