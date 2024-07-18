/*
- In MySQL, the GROUP BY clause organizes rows into groups. 
When you combine the GROUP BY clause with the COUNT function, 
you will get both the groups and the number of items in each group.
- To filter the groups based on the number of items in each group, 
you use the HAVING clause and the COUNT function.
*/

-- First, create a new table of sales that has three columns 
-- sale_id, product_name, and sale_amount:
CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    sale_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(id)
);

-- Second, insert some rows into the sales table:
INSERT INTO sales (product_name, sale_amount)
VALUES
    ('Product A', 100.50),
    ('Product B', 75.25),
    ('Product A', 120.75),
    ('Product C', 50.00),
    ('Product B', 90.80);

-- Third, count the number of sales per product:
SELECT product_name, COUNT(id)
FROM sales
GROUP BY product_name;



-- To find which product had one sale, you use the HAVING 
-- clause with the COUNT function as follows:
SELECT 
  product_name, 
  COUNT(id) 
FROM 
  sales 
GROUP BY 
  product_name 
HAVING 
  COUNT(id) = 1;



-- Similarly, you can find the products that had more than 
-- one sale by using the operator > in the HAVING clause:
SELECT 
  product_name, 
  COUNT(id) 
FROM 
  sales 
GROUP BY 
  product_name 
HAVING 
  COUNT(id) > 1;

