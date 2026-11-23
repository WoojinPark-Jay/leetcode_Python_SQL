select id,
  case when score is null then "unknown" 
       when score >= 90 then 'a'
       else 'b'
       end as " grade
from score
order by id 


select id, 
  coalesce ( bonus,0) as " bonus,
  100.0 * wins / nullif(attemps,0) as "pct"
from metris 
order by id


select id, n/d as "integer_ration",
  rounc(cast(n as real) / d, 3) as "real_ratio"
from ratios
