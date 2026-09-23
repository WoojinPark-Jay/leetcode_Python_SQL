# TUTORIAL

## NOT Operator
The NOT operator is used in the WHERE clause to return all records that DO NOT match the specified criteria. 
It reverses the result of a condition from true to false and vice-versa.
The following SQL selects all customers that are NOT from Spain:
```sql
SELECT * FROM Customers
WHERE NOT Country = 'Spain';
```

