/*
- The EXISTS operator is a boolean operator that returns either true or false. 
- The EXISTS operator is often used to test for the existence of rows returned 
by the subquery.
- If the subquery returns at least one row, the EXISTS operator returns true, 
otherwise, it returns false.
- In addition, the EXISTS operator terminates further processing immediately 
once it finds a matching row, which can help improve the performance of the query.
- Note that you can use SELECT *, SELECT column, SELECT a_constant, or anything in 
the subquery. The results are the same because MySQL ignores the select list that 
appeared in the SELECT clause.
*/


-- 1. The following statement uses the EXISTS operator to find the customer 
-- who has at least one order:
SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE EXISTS(
	SELECT 1
	FROM orders
	WHERE orders.customernumber = customers.customernumber);



-- 2. The following example uses the NOT EXISTS operator to find 
-- customers who do not have any orders:
SELECT 
    customerNumber, 
    customerName
FROM customers
WHERE NOT EXISTS( 
	SELECT 1 FROM orders
	WHERE orders.customernumber = customers.customernumber);



-- ## UPDATE EXISTS examples
-- 3. Suppose that you have to update the phone extensions of 
-- the employees who work at the office in San Francisco.
-- The following statement finds employees who work at the 
-- office in San Franciso:
SELECT 
    employeenumber, 
    firstname, 
    lastname, 
    extension
FROM employees
WHERE EXISTS( 
	SELECT 1 FROM offices
	WHERE 
		city = 'San Francisco' AND 
        offices.officeCode = employees.officeCode);



-- 4. This example adds the number 1 to the phone extension of 
-- employees who work at the office in San Francisco:
UPDATE employees 
SET extension = CONCAT(extension, '1')
WHERE EXISTS( 
	SELECT 1 FROM offices
	WHERE 
		city = 'San Francisco' AND
		offices.officeCode = employees.officeCode);





