/*
- A subquery is a query nested within another query such as 
SELECT, INSERT, UPDATE or DELETE. 
- Also, a subquery can be nested within another subquery.
- A MySQL subquery is called an inner query whereas the query 
that contains the subquery is called an outer query.
*/


-- 1. For example, the following query uses a subquery to 
-- return the employees who work in the offices located in the USA.
SELECT lastName, firstName
FROM employees
WHERE officeCode IN (
	SELECT officeCode
	FROM offices
	WHERE country = 'USA');
		
            
         
-- ## subquery in the WHERE clause
-- 2. the following query returns the customer who has the 
-- highest payment.
SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM payments
WHERE amount = (SELECT MAX(amount) FROM payments);
    
    

-- ## subquery with comparison operators
-- 3. find customers whose payments are greater than the 
-- average payment using a subquery:
SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM payments
WHERE amount > (
	SELECT AVG(amount)
	FROM payments);



-- ## subquery with IN and NOT IN operators
-- 4. find the customers who have not placed any orders:
SELECT customerName
FROM customers
WHERE customerNumber NOT IN (
	SELECT DISTINCT customerNumber
	FROM orders);    
    
    

-- ## subquery in the FROM clause
-- 5. The following subquery finds the maximum, minimum, 
-- and average number of items in sale orders:
SELECT 
    MAX(items), 
    MIN(items), 
    FLOOR(AVG(items))
FROM 
    (SELECT 
        orderNumber, COUNT(orderNumber) AS items
    FROM orderdetails
    GROUP BY orderNumber) AS lineitems;



-- ## correlated subquery
-- 6. In the previous examples, you notice that a subquery 
-- is independent. It means that you can execute the subquery 
-- as a standalone query, for example:
SELECT 
    orderNumber, 
    COUNT(orderNumber) AS items
FROM orderdetails
GROUP BY orderNumber;

/*
 - Unlike a standalone subquery, a correlated subquery is a subquery 
that uses the data from the outer query. In other words, a correlated 
subquery depends on the outer query. A correlated subquery is evaluated 
once for each row in the outer query.
*/

-- 7. The following example uses a correlated subquery to select 
-- products whose buy prices are greater than the average buy price 
-- of all products in each product line.
SELECT 
    productname, 
    buyprice
FROM products p1
WHERE buyprice > (
	SELECT AVG(buyprice)
	FROM products
	WHERE productline = p1.productline);
        
/*
- In this example, both the outer query and correlated subquery 
reference the same products table. Therefore, we need to use a 
table alias p1 for the products table in the outer query.
- Unlike a regular subquery, you cannot execute a correlated 
subquery independently like this. If you do so, MySQL doesn’t 
know the p1 table and will issue an error.
- For each row in the products (or p1) table, the correlated 
subquery needs to execute once to get the average buy price of 
all products in the productline of that row.
- If the buy price of the current row is greater than the average 
buy price returned by the correlated subquery, the query includes 
the row in the result set.
*/


-- ## subquery with EXISTS and NOT EXISTS
-- 8. The following query finds sales orders whose total values 
-- are greater than 60K.
SELECT 
    orderNumber, 
    SUM(priceEach * quantityOrdered) total
FROM orderdetails
INNER JOIN orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000;



-- 9. You can use the query above as a correlated subquery 
-- to find customers who placed at least one sales order with 
-- a total value greater than 60K by using the EXISTS operator:
SELECT 
    customerNumber, 
    customerName
FROM customers
WHERE EXISTS( 
	SELECT orderNumber, SUM(priceEach * quantityOrdered)
	FROM orderdetails
	INNER JOIN orders USING (orderNumber)
	WHERE customerNumber = customers.customerNumber
	GROUP BY orderNumber
	HAVING SUM(priceEach * quantityOrdered) > 60000);
	