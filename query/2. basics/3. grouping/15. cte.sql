/*
- CTE === COMMON TABLE EXPRESSION
- Similar to a derived table, a common table expression (CTE) 
is not stored as an object and lasts only during the query execution.
- Unlike a derived table, a common table expression (CTE) can be 
self-referencing (in the case of a recursive CTE) or referenced multiple 
times within the same query. Moreover, a CTE offers enhanced readability 
and performance compared to a derived table.

	WITH cte_name (column_list) AS (
		query
	) 
	SELECT * FROM cte_name;
    
    -  if you don’t specify column_list, the CTE will inherit the column 
    names from the result of the query.
*/


-- 1. First, define a CTE with the name customers_in_usa 
-- that stores the customer name and state of customers in the USA. 
-- The defining query retrieves data from the customers table.
-- 	  Second, select the customers located in California from the CTE.
WITH customers_in_usa AS (
    SELECT customerName, state
    FROM customers
    WHERE country = 'USA'
) SELECT customerName
 FROM customers_in_usa
 WHERE state = 'CA'
 ORDER BY customerName;



-- ## Getting top sales using a CTE
-- 2. The following example uses a CTE to retrieve the 
-- top 5 sales representatives based on their total sales 
-- in the year 2003:
WITH topsales2003 AS (
    SELECT 
        salesRepEmployeeNumber employeeNumber,
        SUM(quantityOrdered * priceEach) sales
    FROM orders
	INNER JOIN orderdetails USING (orderNumber)
    INNER JOIN customers USING (customerNumber)
    WHERE YEAR(shippedDate) = 2003
		AND status = 'Shipped'
    GROUP BY salesRepEmployeeNumber
    ORDER BY sales DESC
    LIMIT 5
)
SELECT 
    employeeNumber, 
    firstName, 
    lastName, 
    sales
FROM employees
JOIN topsales2003 USING (employeeNumber);



-- ## multiple CTEs
-- 3. The following example uses multiple CTEs to map the 
-- customers with their respective sales representatives:
WITH salesrep AS (
    SELECT 
        employeeNumber,
        CONCAT(firstName, ' ', lastName) AS salesrepName
    FROM employees
    WHERE jobTitle = 'Sales Rep'
), 
customer_salesrep AS (
    SELECT 
        customerName, salesrepName
    FROM customers
	INNER JOIN salesrep ON employeeNumber = salesrepEmployeeNumber
)
SELECT *
FROM customer_salesrep
ORDER BY customerName;



-- ## Joining two CTEs example
-- 4. The following example is creating two CTEs and joining them 
-- to get the Sales Representatives located in the USA, including 
-- their office information:
WITH e AS (
  SELECT * 
  FROM employees 
  WHERE jobTitle = 'Sales Rep'
), 
o AS (
  SELECT * 
  FROM offices 
  WHERE country = 'USA'
) 
SELECT 
  firstName, 
  lastName, 
  city, 
  state, 
  postalCode 
FROM e 
INNER JOIN o USING (officeCode);

