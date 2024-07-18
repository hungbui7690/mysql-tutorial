CREATE DATABASE mydb;
USE mydb;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees VALUES
    (1, 'John Doe', NULL),         -- CEO, no manager
    (2, 'Jane Smith', 1),          -- Manager, reports to CEO
    (3, 'Bob Johnson', 2),         -- Employee, reports to Jane Smith
    (4, 'Alice Brown', 2),         -- Employee, reports to Jane Smith
    (5, 'Charlie Davis', 3);       -- Employee, reports to Bob Johnson
    
    
-- Traverse the hierarchical data in the employees table using a recursive CTE:
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS level
    FROM employees
    WHERE manager_id IS NULL 
	
    UNION ALL
    
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        eh.level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id 
)
SELECT
    employee_id,
    employee_name,
    manager_id,
    level
FROM EmployeeHierarchy
ORDER BY level, employee_id;
    
    
    
    
    
    
    
    
    
    
    