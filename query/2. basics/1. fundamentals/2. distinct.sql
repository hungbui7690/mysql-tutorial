-- FROM > WHERE > SELECT > DISTINCT > ORDER BY

USE classicmodels;



-- 1. find all unique last names
SELECT 
    DISTINCT lastname
FROM
    employees
ORDER BY 
    lastname;
    
    
    
-- 2. When you specify a column that has NULL values 
-- in the DISTINCT clause, the DISTINCT clause will 
-- keep only one NULL value because it considers 
-- all NULL values are the same.
SELECT DISTINCT state
FROM customers;



--  3. multiple distinct: get a unique combination 
-- of city and state
SELECT DISTINCT
    state, city
FROM
    customers
WHERE
    state IS NOT NULL
ORDER BY 
    state, 
    city;
    
    
