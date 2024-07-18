SELECT 
    select_list
FROM
    t1
LEFT JOIN t2 ON 
    join_condition;
    
/*
When you use the LEFT JOIN clause, the concepts of the 
left table (t1) and the right table (t2) come into play within the syntax.
- LEFT JOIN returns all rows from the left table, 
irrespective of whether a matching row from the right table exists or not.
- In the absence of a match, the columns of the row from the right table 
will be filled with NULL values.
*/


-- 1. find all customers and their corresponding orders:
--  The customers is the left table and orders is the right table.
--  The LEFT JOIN clause returns all customers including the customers 
-- who have no order. If a customer has no order, the values in the 
-- column orderNumber and status are NULL.
--  Both the customers and orders tables share the same 
-- column name ( customerNumber) in the join condition
SELECT
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
    customers c
LEFT JOIN orders o 
	USING(customerNumber);



-- 2. find customers without any orders:
-- right table is "orders" table 
-- if not match, return null > these are the customers
-- that not place any order
SELECT 
    c.customerNumber, 
    c.customerName, 
    o.orderNumber, 
    o.status
FROM
    customers c
LEFT JOIN orders o 
    ON c.customerNumber = o.customerNumber
WHERE
    orderNumber IS NULL;



-- 3. uses two LEFT JOIN clauses to join the three tables: 
-- employees, customers, and payments.
SELECT 
    lastName, 
    firstName, 
    customerName, 
    checkNumber, 
    amount
FROM
    employees
LEFT JOIN customers ON 
    employeeNumber = salesRepEmployeeNumber
LEFT JOIN payments ON 
    payments.customerNumber = customers.customerNumber
ORDER BY 
    customerName, 
    checkNumber;
    


-- 4. join orders with orderDetails
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails 
    USING (orderNumber)
WHERE
    orderNumber = 10123;



-- 5. In this case, the query returns all orders; 
-- However, only the order 10123 will have associated line items
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails d 
    ON o.orderNumber = d.orderNumber AND 
       o.orderNumber = 10123;


/*
- Notice that for INNER JOIN clause, the condition in the ON clause 
is equivalent to the condition in the WHERE clause.
- But for LEFT JOIN, it is different (ex4 vs ex5)
*/