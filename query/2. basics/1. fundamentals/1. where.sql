-- FROM > WHERE > SELECT > ORDER BY

USE classicmodels;



-- 1. find all employees whose job titles 
-- are Sales Rep
SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobtitle = 'Sales Rep';
    
    

-- 2. find employees whose job titles are Sales Rep 
-- and office codes are 1: AND
SELECT 
    lastname, 
    firstname, 
    jobtitle,
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' AND 
    officeCode = 1;
    
    
    
-- 3. finds employees whose job title is Sales Rep 
-- or employees who locate the office with 
-- office code 1: OR
SELECT 
    lastName, 
    firstName, 
    jobTitle, 
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' OR 
    officeCode = 1
ORDER BY 
    officeCode, 
    jobTitle;
    
    
    
-- 4. finds employees who are located in offices 
-- whose office code is from 1 to 3: BETWEEN
SELECT 
    firstName, 
    lastName, 
    officeCode
FROM
    employees
WHERE
    officeCode BETWEEN 1 AND 3
ORDER BY officeCode;



-- 5. finds the employees whose last names 
-- end with the string 'son': LIKE
SELECT 
    firstName, 
    lastName
FROM
    employees
WHERE
    lastName LIKE '%son'
ORDER BY firstName;



--  6. find employees who are located in the offices 
-- with the codes 1, 2, and 3: IN
SELECT 
    firstName, 
    lastName, 
    officeCode
FROM
    employees
WHERE
    officeCode IN (1 , 2, 3)
ORDER BY 
    officeCode;
    
    
    
--  7. find all employees who don't have manager (reportedTo): IS NULL
SELECT 
    lastName, 
    firstName, 
    reportsTo
FROM
    employees
WHERE
    reportsTo IS NULL;
    


-- 8. find all employees who are not the Sales Rep: <> or !=
SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobtitle != 'Sales Rep';
    
    
