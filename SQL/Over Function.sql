SELECT sale_id, region, amount,
       SUM(amount) OVER () AS all_total,
       SUM(amount) OVER (ORDER BY sale_id) AS running_total,
       SUM(amount) OVER (
           PARTITION BY region ORDER BY sale_id
       ) AS region_running_total
FROM sales
ORDER BY sale_id;


--
WITH ranked AS (
    SELECT sale_id, region, amount,
           ROW_NUMBER() OVER (
               PARTITION BY region
               ORDER BY amount DESC, sale_id
           ) AS rn
    FROM sales
)
SELECT sale_id, region, amount
FROM ranked
WHERE rn = 1
ORDER BY sale_id;


--ROW_NUMBER, RANK, DENSE_RANK의 차이

SELECT sale_id, region, amount,
       ROW_NUMBER() OVER (
           PARTITION BY region ORDER BY amount DESC, sale_id
       ) AS rn,
       RANK() OVER (
           PARTITION BY region ORDER BY amount DESC
       ) AS rnk,
       DENSE_RANK() OVER (
           PARTITION BY region ORDER BY amount DESC
       ) AS drnk
FROM sales
ORDER BY region, amount DESC, sale_id;

| sale_id | region | amount | rn | rnk | drnk |
| ------- | ------ | ------ | -- | --- | ---- |
| 1       | 서울     | 100    | 1  | 1   | 1    |
| 2       | 서울     | 100    | 2  | 1   | 1    |
| 3       | 서울     | 70     | 3  | 3   | 2    |
| 4       | 서울     | 40     | 4  | 4   | 3    |




