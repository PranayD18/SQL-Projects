/*
https://www.youtube.com/watch?v=IQ4n4n-Y9z8&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=8

write a SQL query to find the winner in every group

winenr in each group is the player who scored the maximum total points within the group. Incase of a tie, the lowest player_id wins
*/


create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

select * from players;

select * from matches;

with player_scores AS
(
select distinct first_player as player_id, first_score as score from matches
union all
select distinct second_player as player_id, second_score as score from matches
), final_scores AS 
(
select 
p.group_id,
s.player_id,
SUM(score) AS score 
from player_scores s
inner join players p ON p.player_id=s.player_id
group by s.player_id,p.group_id
--order by p.group_id
) 
select *,
rank() OVER(PARTITION by group_id order by score desc,player_id asc) AS RN 
from final_scores
 
