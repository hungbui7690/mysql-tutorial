/*
- EXCEPT operator allows you to retrieve rows from one query 
that do not appear in another query.
- EXCEPT will compare the result of query1 with the result set 
of query2 and return the rows of the result set of query1 that 
do not appear in the result set of query2.
- To use the EXCEPT operator, the query1 and query2 need to follow these rules:
	+ The order and the number of columns in the select list of the 
    queries must be the same.
	+ The data types of the corresponding columns must be compatible.
*/


DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1 (
    id INT PRIMARY KEY
);
CREATE TABLE t2 (
    id INT PRIMARY KEY
);
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);


-- 1. use the EXCEPT operator to find rows that appear in the 
-- table t1 but do not appear in the table t2:
SELECT id FROM t1
EXCEPT
SELECT id FROM t2;
-- The EXCEPT operator returns the row 1 that appears in the first 
-- result set but does not appear in the second result set.



-- 2. The following query uses the EXCEPT operator to find the first 
-- names that appear in the customers table but do not appear in the 
-- employees table:
SELECT firstName
FROM employees
EXCEPT
SELECT contactFirstName
FROM customers;



-- 3. get the first names that appear in the employees table but 
-- do not appear in the customers table and sort the first names 
-- alphabetically:
SELECT firstName
FROM employees
EXCEPT
SELECT contactFirstName
FROM customers
ORDER BY firstName;



-- 4. The following example uses the EXCEPT operator with the ALL 
-- option to retain duplicate first names in the result set:
SELECT firstName
FROM employees
EXCEPT ALL
SELECT contactFirstName
FROM customers
ORDER BY firstName;
-- In the result set, the first name Gerard appears twice.

/*
- Use the MySQL EXCEPT operator to retrieve rows from one 
result set that do not appear in another result set.
- EXCEPT DISTINCT removes duplicates while the EXCEPT ALL 
retains the duplicates.
- The EXCEPT operator uses the DISTINCT option by default.
*/