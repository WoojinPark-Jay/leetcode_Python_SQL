SELECT d.Name Department, e.Name Employee, e.Salary
FROM Employee e 
JOIN Department d 
ON e.DepartmentId = d.Id
WHERE 3 > (SELECT COUNT(DISTINCT(e2.Salary)) 
                  FROM Employee e2 
                  WHERE e2.Salary > e.Salary 
                  AND e.DepartmentId = e2.DepartmentId
                  );
