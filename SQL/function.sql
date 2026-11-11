SELECT AVG(actual_min)
FROM orders
WHERE statust = 'done'

WITH r AS
( 
SELECT region,count(*) as n, AVG(actual_min) as a
FROM orders
WHERE statust = 'done'
GROUP BY region
)
SELECT AVG(a) as simple_avg,
    SUM(n*a) / SUM(n) as weighted_avg
FROM r; 


