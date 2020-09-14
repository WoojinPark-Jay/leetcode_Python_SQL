## DENSE_RANK( ) OVER([ query_partition_clause ] order_by_clause)
## Write a SQL query to rank scores.
SELECT Score, DENSE_RANK() OVER (ORDER BY Score DESC) Rank
FROM Scores;
