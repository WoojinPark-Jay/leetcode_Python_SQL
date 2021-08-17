SELECT name
FROM salesperson
WHERE
sales_id NOT IN (
    SELECT A.sales_id
    FROM orders A 
    LEFT JOIN 
    (SELECT com_id FROM company WHERE name='RED') B
    ON A.com_id = B.com_id
    WHERE B.com_id IS NOT NULL
    )
