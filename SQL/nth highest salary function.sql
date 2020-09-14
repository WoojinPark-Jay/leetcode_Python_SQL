##nth highest salary function


CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M = N-1;
    RETURN(
        SELECT DISTINCT SALARY
        FROM EMPLOYEE
        GROUP BY SALARY
        ORDER BY SALARY DESC LIMIT 1 OFFSET M);
END