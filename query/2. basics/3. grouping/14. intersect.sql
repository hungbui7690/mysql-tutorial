/*
- how to use INTERSECT operator to find the common rows of multiple queries.
	> INTERSECT similar to INNER JOIN, but with DISTINCT
    > INTERSECT = INTERSECT + DISTINCT
		+ if we want to use INNER JOIN > we could change to INNER JOIN + GROUP BY/DISTINCT
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


-- 1. The following example uses the INTERSECT operator to get 
-- a result set that contains the rows common to both t1 and t2 tables:
SELECT id FROM t1 INTERSECT SELECT id FROM t2;



-- 2. The query is equivalent to the following query that uses the 
-- DISTINCT explicitly:
SELECT id FROM t1
INTERSECT DISTINCT
SELECT id FROM t2;



-- 3. The following query uses the INTERSECT operator to find the 
-- common first names of customers and employees:
SELECT firstName
FROM employees 
INTERSECT
SELECT contactFirstname
FROM customers;



-- 4. find the common first names of employees and customers 
-- and sort them in ascending order:
SELECT firstName
FROM employees 
INTERSECT
SELECT contactFirstname
FROM customers
ORDER BY firstName;



-- 5. finds the common first names of employees and customers 
-- and retains the duplicates:
SELECT firstName
FROM employees 
INTERSECT ALL
SELECT contactFirstname
FROM customers
ORDER BY firstName;

/*
- Use the MySQL INTERSECT operator to find the rows 
that are common to multiple query results.
- Use INTERSECT DISTINCT to remove the duplicates from 
the result sets and INTERSECT ALL to retain the duplicates.
- The INTERSECT operator uses DISTINCT by default.
*/
