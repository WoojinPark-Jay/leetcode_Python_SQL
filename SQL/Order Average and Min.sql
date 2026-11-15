SELECT region,
       COUNT(*) n_orders,
       ROUND(100.0*SUM(CASE
                           WHEN actual_min>promised_min THEN 1
                           ELSE 0
                       END)/COUNT(*), 1) late_pct,
       ROUND(AVG(actual_min), 1) avg_min
FROM orders
WHERE status='done'
GROUP BY region
ORDER BY region;
