## Write a SQL query to find all numbers that appear at least three times consecutively.

/* Write your T-SQL query statement below */
SELECT T.Num as ConsecutiveNums
FROM(
    SELECT A.Num
    FROM Logs A 
    LEFT JOIN Logs B ON A.Id = B.Id-1
    LEFT JOIN Logs C ON B.Id = C.Id-1
    WHERE A.Num = B.Num AND B.Num = C.Num) T
    
