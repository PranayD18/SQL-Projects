/*
https://www.youtube.com/watch?v=X6i1WMx0vnY

Write a SQL query to find all couple of trade for same stock that happened in the range of 10 seconds and having the price difference by more than 10%
Output result should also list the % of price difference between 2 stocks

*/

Create Table AB_Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
)

Insert into AB_Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
Insert into AB_Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
Insert into AB_Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
Insert into AB_Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
Insert into AB_Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
Insert into AB_Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)

select * from AB_Trade_tbl

select 
a.TRADE_ID  AS Trade1,
b.TRADE_ID  AS Trade2,
a.Trade_Timestamp  AS Trade1_orderTime,
b.Trade_Timestamp AS Trade2_orderTime,
a.Price AS Trade1_Price,
b.Price AS Trade2_Price,
abs(1.0*(a.Price-b.price)/a.price)*100 AS PriceDiff,
DATEDIFF(SECOND,a.Trade_Timestamp,b.Trade_Timestamp) AS Secondsdiff
from AB_Trade_tbl a
join AB_Trade_tbl b 
ON 1=1 -- a.Trade_Stock=b.Trade_Stock
where a.TRADE_ID!=b.TRADE_ID and a.Trade_Timestamp<b.Trade_Timestamp
and DATEDIFF(SECOND,a.Trade_Timestamp,b.Trade_Timestamp)<=10