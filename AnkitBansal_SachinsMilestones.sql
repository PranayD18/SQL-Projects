/*Sachin Tendulkar's milestone matches ie: when he completed 100, 5000, 10000 runs.  We will make dynamic query to add more milestone.*/
-- Create Milestone number,milestone_runs, milestone innings,milestone_matchNo
https://www.youtube.com/watch?v=7LufPVm01NQ&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=38

WITH CTE1 AS (
select Match,
Innings,
Runs,
CAST(match_date as date) as MatchDate,
sum(runs) OVER(ORDER by Match rows BETWEEN unbounded preceding and current row) as RollingSum
from [SQLPractice].[dbo].[Sachin_scores]
) , CTE2 AS (

    select 1 as Milestone_Number, 1000 as Milestone_Runs
    union all
    select 2 as Milestone_Number, 5000 as Milestone_Runs
    union all
    select 3 as Milestone_Number, 10000 as Milestone_Runs
    union all
    select 4 as Milestone_Number, 15000 as Milestone_Runs
)

SELECT 
    Milestone_Number,
    Milestone_Runs,
    Min(Match) as Milestone_Match,
    Min(Innings) AS Milestone_Innings
FROM CTE2
INNER JOIN CTE1 on RollingSum>=Milestone_Runs
Group by Milestone_Number,Milestone_Runs
Order by Milestone_Number
