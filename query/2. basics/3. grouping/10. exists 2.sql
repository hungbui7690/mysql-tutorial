-- ## INSERT EXISTS example
-- Suppose that you want to archive customers who don’t have any sales 
-- orders in a separate table. To do this, you use these steps:

-- 1. create a new table for archiving the customers by copying 
-- the structure from the customers table:
CREATE TABLE customers_archive 
LIKE customers;

-- 2. insert customers who do not have any sales orders 
-- into the customers_archive table using the following INSERT statement.
INSERT INTO customers_archive
SELECT * 
FROM customers
WHERE NOT EXISTS( 
   SELECT 1 FROM orders
   WHERE orders.customernumber = customers.customernumber
);

-- 3. query data from the customers_archive table to verify the 
-- insert operation.
SELECT * FROM customers_archive;



-- //////////////////////////////
-- ## DELETE EXISTS example
-- One final task in archiving the customer data is to delete 
-- the customers that exist in the customers_archive table from 
-- the customers table.

-- To do this, you use the EXISTS operator in WHERE clause of the DELETE statement as follows:
DELETE FROM customers
WHERE EXISTS( 
    SELECT 1 
    FROM customers_archive a
    WHERE a.customernumber = customers.customerNumber);