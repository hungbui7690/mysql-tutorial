

-- 1. join the table customers with the table employees.
-- Left Table: employees
-- Right Table: customers
-- If a row from the table employees has no matching row 
-- from the table customers , the RIGHT JOIN uses NULL for the customerNumber column.
SELECT 
    employeeNumber, 
    customerNumber
FROM
    customers
RIGHT JOIN employees 
    ON salesRepEmployeeNumber = employeeNumber
ORDER BY 
	employeeNumber;



-- 2. find employees who are not in charge of any customers:
SELECT 
    employeeNumber, 
    customerNumber
FROM
    customers
RIGHT JOIN employees ON 
	salesRepEmployeeNumber = employeeNumber
WHERE customerNumber is NULL
ORDER BY employeeNumber;

