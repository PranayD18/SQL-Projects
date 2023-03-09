
/*
The Pareto principle states that for many outcomes, roughly 80% of consequences comes from 20% of causes

here - 80% sales comes from 20% of products or services
*/

  With ProductWiseSales AS (
  select 
  [Product ID],
  SUM([Sales]) AS ProductSales
  FROM [SQLPractice].[dbo].[Orders]
  Group by [Product ID]
  ) 
  , RunningSales AS (SELECT [Product ID],
		ProductSales,		
		SUM(ProductSales) OVER(ORDER BY ProductSales desc rows between unbounded preceding and 0 preceding) AS RunningSales,
		SUM(ProductSales) OVER() AS TotalSales,
		0.8*(SUM(ProductSales) OVER()) AS [80% Sales]
		FROM ProductWiseSales)

		SELECT [Product ID],
			   ProductSales,	
			   RunningSales
		FROM RunningSales where RunningSales<=[80% Sales]


/*
https://www.youtube.com/watch?v=9Kh7EnZlhUg&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=13
Product recommendation. Just the basic type (“customers who bought this also bought…”). That, in its simplest form, is an outcome of basket analysis. 
In this video we will learn how to find products which are most frequently bought together using simple SQL. Based on the history ecommerce website can recommend products to new user.
*/

WITH CTE1 AS (
select distinct
[Order ID]
,[Customer ID]
,[Product ID]
FROM [SQLPractice].[dbo].[Orders]
) 

SELECT 
--o1.[Order ID],
o1.[Product ID] AS P1,
o2.[Product ID] AS P2,
count(1) AS Purchase_Freq
FROM CTE1 o1
INNER JOIN CTE1 o2 on o1.[Order ID]=o2.[Order ID]
WHERE 
--o1.[Order ID]='CA-2018-100678' and
 o1.[Product ID]!=o2.[Product ID] and o1.[Product ID]<o2.[Product ID]
 group by o1.[Product ID],o2.[Product ID]
 Order by count(1) desc