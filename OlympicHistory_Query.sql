/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[Name]
      ,[Sex]
      ,[Age]
      ,[Height]
      ,[Weight]
      ,[Team]
      ,[NOC]
      ,[Games]
      ,[Year]
      ,[Season]
      ,[City]
      ,[Sport]
      ,[Event]
      ,[Medal]
  FROM [SQLPractice].[dbo].[OlympicHistory]

  SELECT  DISTINCT
[NOC]
  FROM [SQLPractice].[dbo].[OlympicHistory] 
  ORDER BY Year
/*
  -- https://techtfq.com/blog/practice-writing-sql-queries-using-real-dataset

1.List of all these 20 queries mentioned below:
2.How many olympics games have been held?
3.List down all Olympics games held so far.
4.Mention the total no of nations who participated in each olympics game?
Which year saw the highest and lowest no of countries participating in olympics?
Which nation has participated in all of the olympic games?
Identify the sport which was played in all summer olympics.
Which Sports were just played only once in the olympics?
Fetch the total no of sports played in each olympic games.
Fetch details of the oldest athletes to win a gold medal.
Find the Ratio of male and female athletes participated in all olympic games.
Fetch the top 5 athletes who have won the most gold medals.
Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
List down total gold, silver and broze medals won by each country.
List down total gold, silver and broze medals won by each country corresponding to each olympic games.
Identify which country won the most gold, most silver and most bronze medals in each olympic games.
Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
Which countries have never won gold medal but have won silver/bronze medals?
In which Sport/event, India has won highest medals.
Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
 */

  /*  Query -6 :
 Identify the sport which was played in all summer olympics.
 Problem Statement: SQL query to fetch the list of all sports which have been part of every olympics.

 - 1. Find total number of summer Olympic games
 - 2. find for each sport , how many games where they played in
 - 3. Compare 1 & 2

  */

  WITH T1 AS 
  (
	  SELECT COUNT(distinct Games) AS Total_Games
	  FROM [SQLPractice].[dbo].[OlympicHistory] WHERE Season='Summer'
  ),
  T2 AS 
  (
	  SELECT DISTINCT Sport, Games
	  FROM [SQLPractice].[dbo].[OlympicHistory] WHERE Season='Summer' 
	  --Order by Games
  ),
  T3 AS 
  (
	  SELECT Sport, COUNT(Games) AS No_Of_Games
	  FROM T2
	  Group by Sport
		--Order by COUNT(Games) DESC
  ) 
  
  SELECT * FROM T3
  JOIN T1 ON Total_Games=No_Of_Games


  /* Query-7
  Which Sports were just played only once in the olympics.
  Problem Statement: Using SQL query, Identify the sport which were just played once in all of olympics.
  */

  WITH T1 AS (
  SELECT Sport,COUNT(distinct Games) AS No_Of_Games
  FROM [OlympicHistory]
  Group by Sport
  --Order by COUNT(Games) ASC
  Having Count(distinct Games)=1
  --Order by Sport
  ) , T2 AS (
  SELECT DISTINCT Sport, Games 
  FROM [OlympicHistory])

  SELECT T1.Sport ,Games
  From T2 
  INNER JOIN T1 ON T1.Sport=T2.Sport
  Order by T1.Sport


  /*
  Query-8. Fetch the total no of sports played in each olympic games.
  Problem Statement: Write SQL query to fetch the total no of sports played in each olympics.
  */

  WITH T1 AS (SELECT Distinct Games,Sport
  From OlympicHistory)
  SELECT Games,COUNT(1) FROM T1
  Group by Games
  Order by Games

  SELECT Games,COUNT(distinct Sport) AS No_Of_Games
  FROM [OlympicHistory]
  Group by Games
  Order by COUNT(distinct Sport) DESC


  /*
  11. Fetch the top 5 athletes who have won the most gold medals.
  Problem Statement: SQL query to fetch the top 5 athletes who have won the most gold medals.
  */

  SELECT * FROM OlympicHistory
  Where Medal='Gold'

  WITH T1 AS (SELECT Name, COUNT(1) AS Gold_Medals FROM OlympicHistory
  Where Medal='Gold'
  Group by Name
  --Order by COUNT(1) DESC
  ), 
  T2 AS (SELECT *,
    Dense_rank() Over(Order by Gold_Medals DESC) AS RN
	From T1
	--Order by Gold_Medals DESC
  )
  SELECT * FROM T2 where RN<=5

  /*
  14. List down total gold, silver and bronze medals won by each country.
  Problem Statement: Write a SQL query to list down the  total gold, silver and bronze medals won by each country.
  */

 WITH T1 AS (
  SELECT
  o.NOC,
  r.region AS Country,
  CASE WHEN Medal='Gold' THEN 1 ELSE 0 END AS Gold_Medals,
  CASE WHEN Medal='Silver' THEN 1 ELSE 0 END AS Silver_Medals,
  CASE WHEN Medal='Bronze' THEN 1 ELSE 0 END AS Bronze_Medals
  FROM OlympicHistory o
  JOIN [OlympicNocRegions] r on r.NOC=o.NOC
  where Medal<>'NA'
  ) ,
  T2 AS (SELECT Country,
  SUM(Gold_Medals) AS Gold,
  SUM(Silver_Medals) AS Silver,
  SUM(Bronze_Medals) AS Bronze
  FROM T1 Group by Country 
  )
  SELECT * FROM T2
  Order by Gold DESC ,Silver DESC,Bronze DESC

 /*
 15. List down total gold, silver and bronze medals won by each country corresponding to each olympic games.

Problem Statement: Write a SQL query to list down the  total gold, silver and bronze medals won by each country corresponding to each olympic games.
 */

  WITH T1 AS (
  SELECT
  o.NOC,
  o.Games AS Games,
  r.region AS Country,
  CASE WHEN Medal='Gold' THEN 1 ELSE 0 END AS Gold_Medals,
  CASE WHEN Medal='Silver' THEN 1 ELSE 0 END AS Silver_Medals,
  CASE WHEN Medal='Bronze' THEN 1 ELSE 0 END AS Bronze_Medals
  FROM OlympicHistory o
  JOIN [OlympicNocRegions] r on r.NOC=o.NOC
  where Medal<>'NA'
  ) ,
  T2 AS (SELECT Games,Country,
  SUM(Gold_Medals) AS Gold,
  SUM(Silver_Medals) AS Silver,
  SUM(Bronze_Medals) AS Bronze
  FROM T1 Group by Games,Country 
  )
  SELECT * FROM T2
  Order by Games ASC,Country,Gold DESC ,Silver DESC,Bronze DESC


  /*
  16. Identify which country won the most gold, most silver and most bronze medals in each olympic games.

  Problem Statement: Write SQL query to display for each Olympic Games, which country won the highest gold, silver and bronze medals.
  */

  WITH T1 AS (
  SELECT
  o.NOC,
  o.Games AS Games,
  r.region AS Country,
  CASE WHEN Medal='Gold' THEN 1 ELSE 0 END AS Gold_Medals,
  CASE WHEN Medal='Silver' THEN 1 ELSE 0 END AS Silver_Medals,
  CASE WHEN Medal='Bronze' THEN 1 ELSE 0 END AS Bronze_Medals
  FROM OlympicHistory o
  JOIN [OlympicNocRegions] r on r.NOC=o.NOC
  where Medal<>'NA'
  ) ,
  T2 AS (SELECT Games,Country,
  SUM(Gold_Medals) AS Gold,
  SUM(Silver_Medals) AS Silver,
  SUM(Bronze_Medals) AS Bronze
  FROM T1 Group by Games,Country 
  ),
  T3 AS (
  SELECT *,
  DENSE_RANK() OVER(Partition by Games Order by Gold DESC) AS Gold_RN,
  DENSE_RANK() OVER(Partition by Games Order by Silver DESC) AS Silver_RN,
  DENSE_RANK() OVER(Partition by Games Order by Bronze DESC) AS Bronze_RN
  FROM T2
  ), Max_Gold AS (SELECT DISTINCT Games,Country,Gold, (Country+' -'+STR(Gold)) AS Max_Gold FROM T3 where Gold_RN=1
  ), Max_Silver AS (SELECT DISTINCT Games,Country,Silver, (Country+' -'+STR(Silver)) AS Max_Silver FROM T3 where Silver_RN=1
  ), Max_Bronze AS (SELECT DISTINCT Games,Country,Bronze, (Country+' -'+STR(Bronze)) AS Max_Bronze FROM T3 where Bronze_RN=1
  )
	  SELECT DISTINCT g.Games,
			 Max_Gold,
			 Max_Silver,
			 Max_Bronze
	  FROM Max_Gold g
	  JOIN Max_Silver s on g.Games=s.Games
	  JOIN Max_Bronze b on g.Games=b.Games
	  ORder by Games

  