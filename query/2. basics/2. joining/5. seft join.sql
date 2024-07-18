/*
	A self join allows you to join a table to itself.
    In practice, you use a self join to query hierarchical data 
such as displaying organization structure or comparing rows within the same table.    
*/


/* The table employees stores not only employees’ data 
but also the organization’s data. It uses the reportsto column 
to determine the manager id of an employee.
*/
-- 1. To obtain the entire organization structure, you can perform a 
-- self join on the employees table using the employeeNumber 
-- and reportsTo columns:
SELECT 
    CONCAT(m.lastName, ', ', m.firstName) AS Manager,
    CONCAT(e.lastName, ', ', e.firstName) AS 'Direct report'
FROM
    employees e
INNER JOIN employees m ON 
    m.employeeNumber = e.reportsTo
ORDER BY 
    Manager;



-- 2. The President is the employee who does not have any manager 
-- or value in the reportsTo column is NULL .
SELECT 
    IFNULL(CONCAT(m.lastname, ', ', m.firstname),
            'Top Manager') AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
LEFT JOIN employees m ON 
    m.employeeNumber = e.reportsto
ORDER BY 
    manager DESC;
    
    

-- 3. display a list of customers who are located in the same city
SELECT 
    c1.city, 
    c1.customerName, 
    c2.customerName
FROM
    customers c1
INNER JOIN customers c2 ON 
    c1.city = c2.city
    AND c1.customername > c2.customerName
ORDER BY 
    c1.city;

/*
	- c1.city = c2.city  makes sure that both customers 
    have the same city.
	- c1.customerName > c2.customerName ensures that the result 
    does not include the same customer.
*/

