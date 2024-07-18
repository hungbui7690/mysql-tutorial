
SELECT 15 BETWEEN 10 AND 20; -- return true / 1
SELECT 15 BETWEEN 20 AND 30; -- return false / 0



-- 1. find products whose buy prices between 90 and 100:
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice BETWEEN 90 AND 100;



-- 2. uses the greater than or equal (>=) 
-- and less than or equal to ( <= ) operators 
-- instead of the BETWEEN operator to get the same result:
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice >= 90 AND buyPrice <= 100;



-- 3. find the products whose buy prices 
-- are not between $20 and $100, you use 
-- the NOT BETWEEN operator as follows:
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice NOT BETWEEN 20 AND 100;



-- 4. can rewrite the query above using the 
-- less than (<), greater than (>), and the 
-- logical operator (OR) like this:
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice < 20 OR buyPrice > 100;



-- 5. returns the orders with the required dates 
-- between 01/01/2003 to 01/31/2003:
SELECT 
   orderNumber,
   requiredDate,
   status
FROM 
   orders
WHERE 
   requireddate BETWEEN 
     CAST('2003-01-01' AS DATE) AND 
     CAST('2003-01-31' AS DATE);

/* we use the CAST() to cast the literal string '2003-01-01' into a DATE value */

