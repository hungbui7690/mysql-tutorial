-- value = value1 OR value = value2 OR value = value3 OR ...
-- IN (value1, value2, value3, ...)

SELECT 1 IN (1,2,3);
SELECT 4 IN (1,2,3);

SELECT NULL IN (1,2,3);
SELECT 0 IN (1 , 2, 3, NULL);
SELECT NULL IN (1 , 2, 3, NULL);



-- 1. find the offices located in the USA and France:
SELECT 
    officeCode, 
    city, 
    phone, 
    country
FROM
    offices
WHERE
    country IN ('USA' , 'France');
    
    
    
-- 2. can also get the same result with the OR operator like this: 
SELECT 
    officeCode, 
    city, 
    phone
FROM
    offices
WHERE
    country = 'USA' OR country = 'France';
    
  
  
-- 3. NOT IN
SELECT 1 NOT IN (1,2,3); -- 0
SELECT 0 NOT IN (1,2,3); -- 1
SELECT NULL NOT IN (1,2,3); -- NULL


-- NOT (value = value1 OR value = value2 OR value = value3)
-- value <> value1 AND value <> value2 AND value <> value3



-- 4. find the offices that are not located in France and the USA:
SELECT 
    officeCode, 
    city, 
    phone
FROM
    offices
WHERE
    country NOT IN ('USA' , 'France')
ORDER BY 
    city;

    
    
    
    
    
    
    
    
    
    
    
    