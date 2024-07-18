/*
- A derived table is a virtual table returned from a SELECT statement. 
- A derived table is similar to a temporary table, but using a derived 
table in the SELECT statement is much simpler than a temporary table 
because it does not require creating a temporary table.
- The term derived table and subquery is often used interchangeably. 
When a stand-alone subquery is used in the FROM clause of a SELECT statement, 
it is also called a derived table.
- *NOTE* Every derived table must have its own alias.
*/


-- 1. gets the top five products by sales revenue in 2003
SELECT 
    productCode, 
    ROUND(SUM(quantityOrdered * priceEach)) sales
FROM orderdetails
INNER JOIN orders USING (orderNumber)
WHERE YEAR(shippedDate) = 2003
GROUP BY productCode
ORDER BY sales DESC
LIMIT 5;



-- 2. You can use the result of this query as a derived table 
-- and join it with the products table as follows:
SELECT 
    productName, sales
FROM
    (SELECT 
        productCode, 
        ROUND(SUM(quantityOrdered * priceEach)) sales
    FROM orderdetails
    INNER JOIN orders USING (orderNumber)
    WHERE YEAR(shippedDate) = 2003
    GROUP BY productCode
    ORDER BY sales DESC
    LIMIT 5) top5products2003
INNER JOIN products USING (productCode);



-- 3. we can also use INNER JOIN to join 3 tables
-- and get the same result
SELECT 
    productName, 
    ROUND(SUM(quantityOrdered * priceEach)) sales
FROM orderdetails
INNER JOIN orders USING (orderNumber)
INNER JOIN products USING (productCode)
WHERE YEAR(shippedDate) = 2003
GROUP BY productCode
ORDER BY sales DESC
LIMIT 5;




/*
- Suppose you have to classify the customers who bought products 
in 2003 into 3 groups: platinum, gold, and silver. And you need to 
know the number of customers in each group with the following conditions:
	+ Platinum customers who have orders with a volume greater than 100K.
	+ Gold customers who have orders with a volume between 10K and 100K.
	+ Silver customers who have orders with a volume of less than 10K.
*/
-- 4. To form this query, you first need to put each customer into the 
-- respective group using CASE expression and GROUP BY clause as follows:
SELECT 
    customerNumber,
    ROUND(SUM(quantityOrdered * priceEach)) sales,
    (CASE
        WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
        WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
        WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
    END) customerGroup
FROM orderdetails
INNER JOIN orders USING (orderNumber)
WHERE YEAR(shippedDate) = 2003
GROUP BY customerNumber;



-- 5. Then, you can use this query as the derived table and 
-- perform grouping as follows:
SELECT 
    customerGroup, 
    COUNT(cg.customerGroup) AS groupCount
FROM
    (SELECT 
        customerNumber,
		ROUND(SUM(quantityOrdered * priceEach)) sales,
		(CASE
			WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
			WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
			WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
		END) customerGroup
    FROM orderdetails
    INNER JOIN orders USING (orderNumber)
    WHERE YEAR(shippedDate) = 2003
    GROUP BY customerNumber) cg
GROUP BY cg.customerGroup;    




