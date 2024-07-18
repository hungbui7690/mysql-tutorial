/*
	The percentage ( % ) wildcard matches any string of zero or more characters.
	The underscore ( _ ) wildcard matches any single character.
*/


-- 1. find employees whose first names start with the letter a:
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    firstName LIKE 'a%';



-- 2. find employees whose last names end with the 
-- literal string "on" e.g., Patterson, Thompson:
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    lastName LIKE '%on';
    


-- To check if a string contains a substring, 
-- you can use the percentage ( % ) wildcard 
-- at the beginning and the end of the substring.
-- 3. find all employees whose last names contain the substring "on":
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    lastname LIKE '%on%';



-- 4.  find employees whose first names start with the 
-- letter T , end with the letter m, and contain any 
-- single character between e.g., Tom , Tim
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    firstname LIKE 'T_m';
    


-- 5. search for employees whose last names don’t 
-- start with the letter B, you can use the 
-- "NOT LIKE" operator
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    lastName NOT LIKE 'B%';



-- ESCAPE CHARACTER
-- 6. find products whose product codes contain the 
-- string _20 , you can use the pattern %\_20% with 
-- the default escape character (\)
SELECT 
    productCode, 
    productName
FROM
    products
WHERE
    productCode LIKE '%\_20%';



-- 7. Alternatively, you can specify a different 
-- escape character e.g., $ using the "ESCAPE" clause:
SELECT 
    productCode, 
    productName
FROM
    products
WHERE
    productCode LIKE '%$_20%' ESCAPE '$';

