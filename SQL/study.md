# TUTORIAL

## NOT Operator
The NOT operator is used in the WHERE clause to return all records that DO NOT match the specified criteria. 
It reverses the result of a condition from true to false and vice-versa.

The following SQL selects all customers that are NOT from Spain:
```sql
SELECT * FROM Customers
WHERE NOT Country = 'Spain';

```

## The NOT LIKE Operator
The NOT LIKE operator is used in the WHERE clause to exclude rows that match a specified character pattern.

There are two wildcards often used in conjunction with the NOT LIKE operator:
- A percent sign % - represents zero, one, or multiple characters
- A underscore sign _ - represents a single character

The following SQL selects all customers that do NOT start with the letter "A":
```sql
SELECT * FROM Customers
WHERE CustomerName NOT LIKE "A%"L
```
