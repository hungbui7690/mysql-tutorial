-- ## EXISTS operator vs. IN operator
-- 1. To find the customer who has placed at least one order, 
-- you can use the IN operator as shown in the following query:
SELECT 
    customerNumber, 
    customerName
FROM customers
WHERE customerNumber IN (
	SELECT customerNumber
	FROM orders);
    
    

-- 2. Let’s compare the query that uses the IN operator with the one 
-- that uses the EXISTS operator by using the EXPLAIN statement.
-- **NOTE** we can use query here 
--   > or we can go to Query Menu > Explain Current Query (Ctrl + Alt + X)
EXPLAIN ANALYZE SELECT 
    customerNumber, 
    customerName
FROM customers
WHERE EXISTS( 
	SELECT 1 FROM orders
	WHERE orders.customernumber = customers.customernumber);
    

EXPLAIN ANALYZE SELECT customerNumber, customerName
FROM customers
WHERE customerNumber IN (
	SELECT customerNumber
	FROM orders);
    
    
    
/*
- The query that uses the EXISTS operator is much faster than 
the one that uses the IN operator.
- The reason is that the EXISTS operator works based on the 
“at least found” principle. The EXISTS stops scanning the table 
when a matching row is found.
- On the other hand, when the IN operator is combined with a 
subquery, MySQL must process the subquery first and then use the 
result of the subquery to process the whole query.
- The general rule of thumb is that if the subquery contains a large 
volume of data, the EXISTS operator provides better performance.
- However, the query that uses the IN operator will perform faster if 
the result set returned from the subquery is very small.
*/
-- 3. For example, the following statement uses the IN operator to 
-- select all employees who work at the office in San Francisco.
SELECT 
    employeenumber, 
    firstname, 
    lastname
FROM employees
WHERE officeCode IN 
	(SELECT officeCode
	FROM offices
	WHERE offices.city = 'San Francisco');
/*
- It is a little bit faster than the query that uses the 
EXISTS operator that we mentioned in the first example. 
*/


-- //////////////////////////////
-- Some methods to Analyze 
EXPLAIN SELECT customerNumber, customerName
FROM customers
WHERE customerNumber IN (
	SELECT customerNumber
	FROM orders);
    
EXPLAIN FORMAT=json SELECT customerNumber, customerName
FROM customers
WHERE customerNumber IN (
	SELECT customerNumber
	FROM orders);
    
EXPLAIN FORMAT=tree SELECT customerNumber, customerName
FROM customers
WHERE customerNumber IN (
	SELECT customerNumber
	FROM orders);
    
EXPLAIN ANALYZE SELECT customerNumber, customerName
FROM customers
WHERE customerNumber IN (
	SELECT customerNumber
	FROM orders);