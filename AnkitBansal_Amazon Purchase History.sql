
-- https://www.youtube.com/watch?v=FNUIqQbj_EE&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=48

create table purchase_history
(userid int
,productid int
,purchasedate date
);

SET DATEFORMAT dmy;

insert into purchase_history 
values
     (1,1,'23-01-2012')
    ,(1,2,'23-01-2012')
    ,(1,3,'25-01-2012')
    ,(2,1,'23-01-2012')
    ,(2,2,'23-01-2012')
    ,(2,2,'25-01-2012')
    ,(2,4,'25-01-2012')
    ,(3,4,'23-01-2012')
    ,(3,1,'23-01-2012')
    ,(4,1,'23-01-2012')
    ,(4,2,'25-01-2012');

-- Write a SQL query to find users who purchased different products on different dates
-- e.g. products purchased on any given day are not repeated on any other day

Select * from purchase_history


WITH OrderDetails AS (
    SELECT userid,
    COUNT(Distinct purchasedate) AS No_Of_dates,
    COUNT(productid) AS Count_Products,
    COUNT(DISTINCT productid) AS Count_Dist_Products
    from purchase_history
    Group by userid    
)
SELECT userid from OrderDetails 
WHERE No_Of_dates>1 and Count_Products=Count_Dist_Products;