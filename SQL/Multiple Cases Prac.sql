select id,
  case when score is null then "unknown" 
       when score >= 90 then 'a'
       else 'b'
       end as "grade"
from score

  
select id,
  coalesce ( bonus,0) as "bonus",
  100.0 * wins / nullif(attemps,0) as "pct"
from metris 
order by id


select id, n/d as "integer_ration",
  rounc(cast(n as real) / d, 3) as "real_ratio"
from ratios


select count(*) as "n_rows",
    count(value) as "n_values",
    count (distinct value) as "n_unique",
    sum(value) as "total",
    round(avg(value),2) as "mean",
    min(value) as "lo"
from measures


SELECT customer_id,
       SUM(CASE WHEN status = 'done' THEN 1 ELSE 0 END)
         AS completed_orders,
       SUM(CASE WHEN status = 'done' THEN amount ELSE 0 END)
         AS completed_revenue
FROM orders
GROUP BY customer_id
HAVING SUM(CASE WHEN status = 'done' THEN 1 ELSE 0 END) >= 1
   AND SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) = 0
ORDER BY customer_id;

--
count(*) filter(where type ='buy')
count(case when type = 'buy' then 1 else 0 end) 



