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

## The SQL INSERT INTO Statement
The INSERT INTO statement is used to insert new records in a table.
It is possible to write the INSERT INTO statement in two ways:

### Syntax 1
Specify both the column names and the values to be inserted:


INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

### Syntax 2
If you insert values for ALL the columns of the table, you can omit the column names.
However, the order of the values must be in the same order as the columns in the table:

INSERT INTO table_name
VALUES (value1, value2, value3, ...);

Insert Data Only in Specific Columns
Here we insert values only in some specific columns of the table.

The following SQL inserts a new record - but only inserts data in the "CustomerName", "City", and "Country" columns (CustomerID will be updated automatically):
```sql
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');
```

## UPDATE Table
The UPDATE statement is used to update or modify one or more records in a table.

UPDATE Syntax
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;
```
- Note: Be careful when updating records in a table! Notice the WHERE clause in the UPDATE statement. The WHERE clause specifies which record(s) that should be updated. If you omit the WHERE clause, all records in the table will be updated!


## The SQL DELETE Statement
The DELETE statement is used to delete existing records in a table.


DELETE Syntax
```sql
DELETE FROM table_name WHERE condition;

--The following SQL deletes the customer "Alfreds Futterkiste" from the "Customers" table:
DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';

--To delete the table completely, use the DROP TABLE statement:
DROP TABLE Customers;
```


## SELECT TOP and ORDER BY
Add the ORDER BY keyword when you want to sort the result, and return the first 3 records of the sorted result.

Sort the result reverse alphabetically by CustomerName, and return the first 3 records:
Syntax
```sql
SELECT TOP 3 *
FROM Customers
ORDER BY CustomerName DESC;
```


## Higher Than Average
To list all records with a higher price than average, we can use the AVG() function in a sub query:

Return all products with a higher price than the average price:

Syntax
```sql
SELECT *
FROM PRODUCTS
WHERE PRICE > (SELECT AVG(PRICE) FROM PRODUCTS)
```
