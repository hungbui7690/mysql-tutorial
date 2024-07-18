-- The following statement creates a new table named sales 
-- that stores the order values summarized by product lines and years. 
-- The data comes from the products, orders, and orderDetails tables in 
-- the sample database.
CREATE TABLE sales 
SELECT
    productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine ,
    YEAR(orderDate);



-- 1. The following query returns all rows from the sales table:
SELECT * FROM sales;



-- 2. A grouping set is a set of columns to which you want to group
-- For ex, the following query creates a grouping set denoted by (productline)
SELECT 
    productline, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline;



-- 3. The following query creates an empty grouping set denoted by the ():
SELECT 
    SUM(orderValue) totalOrderValue
FROM
    sales;



-- 4. If you want to generate two or more grouping sets together 
-- in one query, you may use the UNION ALL operator as follows:
SELECT 
    productline, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline 
UNION ALL
SELECT 
    NULL, 
    SUM(orderValue) totalOrderValue
FROM
    sales;



/*
- Because the UNION ALL requires all queries to have the same 
number of columns, we added NULL in the select list of the second 
query to fulfill this requirement.
- The NULL in the productLine column identifies the total super-aggregate line.
- This query can generate the total order values by product lines and 
also the grand total row. However, it has two problems:
	> The query is quite lengthy.
	> The performance of the query may not be good since the database engine 
    has to internally execute two separate queries and combine the result sets into one.
- To fix these issues, you can use the ROLLUP clause.
*/

-- 5. The ROLLUP generates multiple grouping sets based on the columns 
-- or expressions specified in the GROUP BY clause. For example:
SELECT 
    productLine, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline WITH ROLLUP;

/*
- As clearly shown in the output, the ROLLUP clause generates not only 
the subtotals but also the grand total of the order values.
- If you have more than one column specified in the GROUP BY clause, 
the ROLLUP clause assumes a hierarchy among the input columns.
	> GROUP BY c1, c2, c3 WITH ROLLUP
		+ The ROLLUP assumes that there is the following hierarchy:
			c1 > c2 > c3
		+ It generates the following grouping sets:
			(c1, c2, c3)
			(c1, c2)
			(c1)
			()			
*/


-- 6. The ROLLUP generates the subtotal row every time the 
-- product line changes and the grand total at the end of the result.
SELECT 
    productLine, 
    orderYear,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline, -- productLine > orderYear
    orderYear 
WITH ROLLUP;



-- 7. If you reverse the hierarchy, for example:
SELECT 
    orderYear,
    productLine, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    orderYear,
    productline
WITH ROLLUP;
