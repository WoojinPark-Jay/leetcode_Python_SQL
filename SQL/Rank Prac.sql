-- RANK는 같은 정렬값에 같은 순위를 주지만 다음 순위에 동점 행 수만큼 공백이 생깁니다. 
-- 점수가 100,100,80이면 RANK는 1,1,3입니다. DENSE_RANK는 서로 다른 값의 순서를 세므로 1,1,2가 됩니다.



select name, score
  rank() over (order by score DESC) as rnk
from scores
order by score DESC, name ;


with r as (
  select *, dense_rank() over (order by score desc) as rk
)
select name, score
from r
where rk <= 2
order by score desc, name ; 


SELECT region, id, revenue, orders,
       DENSE_RANK() OVER (
        partition by region 
        order by revenue desc,
                 orders desc
       ) AS performance_level
FROM shops
ORDER BY region, performance_level, id;


