-- LIMIT vs OFFSET
-- LIMIT row_count OFFSET offset
-- FROM > WHERE > DISTINCT > SELECT > ORDER BY > LIMIT



-- 1. get the top five customers who have the highest credit:
SELECT 
    customerNumber, 
    customerName, 
    creditLimit
FROM
    customers
ORDER BY creditLimit DESC
LIMIT 5;



-- 2. can use in pagination 
-- get rows of page 1 which contains the 
-- first 10 customers sorted by the customer name:
SELECT 
    customerNumber, 
    customerName
FROM
    customers
ORDER BY customerName    
LIMIT 10;



-- 3. get the rows of the second page that include rows 11 – 20:
SELECT 
    customerNumber, 
    customerName
FROM
    customers
ORDER BY customerName    
LIMIT 10, 10;



/*
	To get the nth highest or lowest value, you use the following LIMIT clause:
    - LIMIT n-1, 1;
    - The clause LIMIT n-1, 1 returns 1 row starting at the row n.
*/
-- 4. finds the customer who has the second-highest credit:
SELECT 
    customerName, 
    creditLimit
FROM
    customers
ORDER BY 
    creditLimit DESC    
LIMIT 1,1;



-- 5. uses the LIMIT clause with the DISTINCT clause 
-- to return the first five unique states in the 
-- customers table
SELECT DISTINCT
    state
FROM
    customers
WHERE
    state IS NOT NULL
LIMIT 5;

