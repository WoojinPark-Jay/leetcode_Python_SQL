select a.player_id, a.first_login
from
(select player_id , event_date as first_login,
 dense_rank() over (partition by player_id order by event_date asc) as rnk 
 from Activity) a
where a.rnk =1
