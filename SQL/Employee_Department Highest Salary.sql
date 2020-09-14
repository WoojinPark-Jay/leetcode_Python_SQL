## Write a SQL query to find employees who have the highest salary in each of the departments

## Solution1
select t.d_name as Department,e1.Name as Employee,e1.Salary
from
(select d.Name as d_name, d.Id as d_id,max(e.Salary) as max_salary
from Employee e, Department d
where e.DepartmentId=d.Id
group by d_name) as t left join Employee e1
on e1.DepartmentId=t.d_id
where t.max_salary=e1.Salary

## Solution2 
SELECT 
    d.Name AS Department, e.Name AS Employee, e.Salary AS Salary
FROM 
    Employee AS e, Department AS d
WHERE 
    e.DepartmentID = d.Id
    AND
    e.Salary = (SELECT 
                    MAX(Salary) 
               FROM 
                    Employee
               WHERE
                    DepartmentId = d.Id)
