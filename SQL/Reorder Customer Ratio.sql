WITH user_orders AS (
  SELECT user_id, COUNT(*) AS n_orders
  FROM orders
  GROUP BY user_id
)
SELECT
  ROUND(100.0 * SUM(CASE WHEN n_orders >= 2 THEN 1 ELSE 0 END)
        / COUNT(*), 1) AS repeat_rate_pct
FROM user_orders;



WITH user_orders AS (
  SELECT user_id, COUNT(*) AS n_orders
  FROM orders
  GROUP BY user_id
)
SELECT
  ROUND(100.0 * SUM(CASE WHEN n_orders >= 2 THEN 1 ELSE 0 END)
        / COUNT(*), 1) AS repeat_rate_pct
FROM user_orders;




-- orders table 
| order_id | user_id | order_date | amount |
| -------- | ------- | ---------- | ------ |
| O1       | U1      | 2026-10-10 | 30     |
| O2       | U1      | 2026-10-25 | 40     |
| O3       | U1      | 2026-11-01 | 50     |
| O4       | U2      | 2026-10-11 | 20     |
| O5       | U3      | 2026-10-12 | 15     |
| O6       | U3      | 2026-10-20 | 25     |
| O7       | U4      | 2026-10-13 | 10     |
| O8       | U5      | 2026-10-14 | 60     |




