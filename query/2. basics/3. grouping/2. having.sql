/*
- The HAVING clause is used with the GROUP BY clause 
to filter the groups based on a specified condition.
- The HAVING clause allows you to apply a condition to 
the groups returned by the GROUP BY clause and only 
include groups that meet the specified condition.
*/

-- FROM > WHERE > GROUP BY > HAVING > SELECT > DISTINCT > ORDER BY > LIMIT
-- > In MySQL, we can also use ALIAS in HAVING as well 



-- 1. The following uses the GROUP BY clause to get order numbers, 
-- the number of items sold per order, and total sales for each from 
-- the orderdetails table:
SELECT 
  ordernumber, 
  SUM(quantityOrdered) AS itemsCount, 
  SUM(priceeach * quantityOrdered) AS total 
FROM 
  orderdetails 
GROUP BY 
  ordernumber;



-- 2. Now, you can find which order has total sales greater than 1000 
-- by using the HAVING clause as follows:
SELECT 
  ordernumber, 
  SUM(quantityOrdered) AS itemsCount, 
  SUM(priceeach * quantityOrdered) AS total 
FROM 
  orderdetails 
GROUP BY 
  ordernumber 
HAVING 
  total > 1000;




-- It’s possible to form a complex condition in the HAVING clause 
-- using logical operators such as OR and AND.
-- 3. The following example uses the HAVING clause to find orders that 
-- have total amounts greater than 1000 and contain more than 600 items:
SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM
    orderdetails
GROUP BY ordernumber
HAVING 
    total > 1000 AND 
    itemsCount > 600;




-- 4. Suppose that you want to find all orders that already shipped 
-- and have a total amount greater than 1500, you can join the orderdetails 
-- table with the orders table using the INNER JOIN clause and apply a condition 
-- on status column and total aggregate as shown in the following query:
SELECT 
    a.ordernumber, 
    status, 
    SUM(priceeach*quantityOrdered) total
FROM
    orderdetails a
INNER JOIN orders b 
    ON b.ordernumber = a.ordernumber
GROUP BY  
    ordernumber, 
    status
HAVING 
    status = 'Shipped' AND 
    total > 1500;

/*
- The HAVING clause is only useful when you use it with the GROUP BY clause 
to generate the output of the high-level reports.
- For example, you can use the HAVING clause to answer questions like finding 
the number of orders this month, this quarter, or this year that have a total 
amount greater than 10K.
*/