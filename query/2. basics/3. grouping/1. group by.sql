/*
	FROM > WHERE > GROUP BY > SELECT > DISTINCT > ORDER BY > LIMIT
    > The SQL standard does not allow you to use an alias in 
    the GROUP BY clause whereas MySQL supports this.

- The GROUP BY clause groups rows into summary rows based on column 
values or expressions. It returns one row for each group and reduces 
the number of rows in the result set.
- In practice, you often use the GROUP BY clause with aggregate functions 
such as SUM, AVG, MAX, MIN, and COUNT. The aggregate function that appears 
in the SELECT clause provides the information for each group.
*/
USE classicmodels;



-- 1. If you want to group the order statuses, you can use the 
-- GROUP BY clause with the status column in the following query:
SELECT 
  status 
FROM 
  orders 
GROUP BY 
  status;



-- 2. The output shows that the GROUP BY clause returns unique occurrences 
-- of the values in the status columns.
-- It works like the DISTINCT operator, as demonstrated in the following query:
SELECT 
  DISTINCT status 
FROM 
  orders;



-- An aggregate function calculates a set of rows and returns a single value.
-- 3. to obtain the number of orders in each status, you can use the 
-- COUNT function with the GROUP BY clause as follows:
SELECT 
  status, 
  COUNT(*) 
FROM 
  orders 
GROUP BY 
  status;



-- 4. To get the total amount of all orders by status, you join the 
-- orders table with the orderdetails table and use the SUM function 
-- to calculate the total amount:
SELECT 
  status, 
  SUM(quantityOrdered * priceEach) AS amount 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
GROUP BY 
  status;



-- 5. Similarly, the following query returns the order numbers 
-- and the total amount of each order.
SELECT 
  orderNumber, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orderdetails 
GROUP BY 
  orderNumber;



-- 6. In addition to columns, you can group rows by expressions. 
-- The following query calculates the total sales for each year:
-- *NOTE*: in MySQL, we can use ALIAS in GROUP BY (YEAR(orderDate) AS year)
SELECT 
  YEAR(orderDate) AS year, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
WHERE 
  status = 'Shipped' 
GROUP BY 
  YEAR(orderDate);



-- 7. uses the HAVING clause to select the total sales of the years after 2003.
SELECT 
  YEAR(orderDate) AS year, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
WHERE 
  status = 'Shipped' 
GROUP BY 
  year 
HAVING 
  year > 2003;



-- 8. The following query returns the year, order status, 
-- and the total order for each combination of year and order status 
-- by grouping rows into groups:
SELECT 
  YEAR(orderDate) AS year, 
  status, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
GROUP BY 
  year, 
  status 
ORDER BY 
  year;



-- 9. The following query is not valid in SQL standard:
SELECT 
  YEAR(orderDate) AS orderYear, 
  COUNT(orderNumber) 
FROM 
  orders 
GROUP BY 
  orderYear;



-- If you use the GROUP BY clause in the SELECT statement 
-- without using aggregate functions, the GROUP BY clause behaves like the DISTINCT clause.
-- 10. The following statement uses the GROUP BY clause to select 
-- the unique states of customers from the customers table.
SELECT 
  state 
FROM 
  customers 
GROUP BY 
  state;



-- 11. You can achieve a similar result by using the DISTINCT clause:
SELECT 
  DISTINCT state 
FROM 
  customers;


/*
- Notice that MySQL 8.0 or later removed the implicit sorting for 
the GROUP BY clause. Therefore, if you are using earlier versions, 
you will find that the result set with the GROUP BY clause is sorted.
*/