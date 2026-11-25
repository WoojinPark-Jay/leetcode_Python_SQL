with compared as (
  select sale_id, region, amount,
  lag(amount) over ( 
    partition by region order by sale_id 
  ) as prev_amount
  from sales
) 
select sale_id, region, amount, prev_amount, amount - prev_amount as change 
from compared
order by sale_id;

SELECT sale_id, region, amount,
       LEAD(amount) OVER (
           PARTITION BY region ORDER BY sale_id
       ) AS next_amount
FROM sales
ORDER BY sale_id;



-- LAG (값, 몇_행_전, 해당_행이_없을_때_반환값)
-- LEAD(값, 몇_행_후, 해당_행이_없을_때_반환값)
-- 첫 번째 인자 revenue: 이동한 행에서 어떤 값을 가져올지 정해요.
-- 두 번째 인자 2: 몇 행 이동할지 정해요. 생략하면 1입니다.
-- 세 번째 인자 0: 이동할 행이 없으면 무엇을 반환할지 정해요. 

SELECT month, revenue,
       LAG(revenue)        OVER (ORDER BY month) AS prev_1,
       LAG(revenue, 2)     OVER (ORDER BY month) AS prev_2,
       LAG(revenue, 2, 0)  OVER (ORDER BY month) AS prev_2_or_zero,
       LEAD(revenue, 1, 0) OVER (ORDER BY month) AS next_1_or_zero
FROM monthly
ORDER BY month;


| month | revenue | prev_1 | prev_2 | prev_2_or_zero | next_1_or_zero |
| ----- | ------- | ------ | ------ | -------------- | -------------- |
| 8월    | 150     | NULL   | NULL   | 0              | 200            |
| 9월    | 200     | 150    | NULL   | 0              | 160            |
| 10월   | 160     | 200    | 150    | 150            | 240            |
| 11월   | 240     | 160    | 200    | 200            | 0              |
