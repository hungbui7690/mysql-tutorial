-- The INNER JOIN matches each row in one table 
-- with every row in other tables 
-- and allows you to query rows 
-- that contain columns from both tables.
/*
	These 2 are same
	- USING(orderNumber)
    - ON t1.orderNumber = t2.orderNumber
*/


-- 1. 
SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products t1
INNER JOIN productlines t2 
    ON t1.productline = t2.productline;



-- 2. returns the order number, order status, 
-- and total sales from the orders and 
-- orderdetails tables using the 
-- INNER JOIN clause with the GROUP BY clause:
SELECT 
    t1.orderNumber,
    t1.status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders t1
INNER JOIN orderdetails t2 
    ON t1.orderNumber = t2.orderNumber
GROUP BY t1.orderNumber;



-- 3. uses two INNER JOIN clauses to join 
-- three tables: orders, orderdetails, and products:
SELECT 
    orderNumber,
    orderDate,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
FROM
    orders
INNER JOIN
    orderdetails USING (orderNumber)
INNER JOIN
    products USING (productCode)
ORDER BY 
    orderNumber, 
    orderLineNumber;
    
    
    
-- 4. uses three INNER JOIN clauses to 
-- query data from the four tables above:
SELECT 
    orderNumber,
    orderDate,
    customerName,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
FROM
    orders
INNER JOIN orderdetails 
    USING (orderNumber)
INNER JOIN products 
    USING (productCode)
INNER JOIN customers 
    USING (customerNumber)
ORDER BY 
    orderNumber, 
    orderLineNumber;
    
    
    
-- 5. In addition to the equal operator (=), 
-- you can use other operators such as greater than ( >), 
-- less than ( <), and not-equal ( <>) operator 
-- to form the join condition.
/* The following query uses a less-than ( <) join to 
 find the sales price of the product whose code 
 is S10_1678 that is less than the manufacturer’s 
 suggested retail price (MSRP) for that product. */
 SELECT 
    orderNumber, 
    productName, 
    msrp, 
    priceEach
FROM
    products p
INNER JOIN orderdetails o 
   ON p.productcode = o.productcode
      AND p.msrp > o.priceEach
WHERE
    p.productcode = 'S10_1678';
 