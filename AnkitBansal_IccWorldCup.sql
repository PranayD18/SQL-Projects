

/*
https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=1


*/

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

SELECT TEAM_Name,
       COUNT(1) as Matches_Played,
       SUM(WinFlag) as No_MatchesWon,
       (COUNT(1)-SUM(WinFlag)) as No_MatchesLose
FROM (
    SELECT
        Team_1 AS TEAM_Name,
        (CASE WHEN Team_1=winner then 1 else 0 end) AS WinFlag
    FROM icc_world_cup
    UNION ALL
    SELECT
        Team_2 AS TEAM_Name,
        (CASE WHEN Team_2=winner then 1 else 0 end) AS WinFlag
    FROM icc_world_cup
    )  A
    GROUP BY TEAM_Name
    ORDER BY No_MatchesWon DESC
