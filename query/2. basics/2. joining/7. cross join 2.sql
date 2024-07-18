
CREATE DATABASE IF NOT EXISTS salesdb;
USE salesdb;

-- The table products contains the product master data 
-- that includes product id, product name, and sales price.
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(13,2 )
);

-- The table stores contains the stores where the products are sold.
CREATE TABLE stores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100)
);

-- The table sales contains the products that are sold 
-- in a particular store by quantity and date.
CREATE TABLE sales (
    product_id INT,
    store_id INT,
    quantity DECIMAL(13 , 2 ) NOT NULL,
    sales_date DATE NOT NULL,
    PRIMARY KEY (product_id , store_id),
    FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_id)
        REFERENCES stores (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Suppose that we have three products iPhone, iPad 
-- and Macbook Pro which are sold in two stores North and South.
INSERT INTO products(product_name, price)
VALUES('iPhone', 699),
      ('iPad',599),
      ('Macbook Pro',1299);
INSERT INTO stores(store_name)
VALUES('North'),
      ('South');
INSERT INTO sales(store_id,product_id,quantity,sales_date)
VALUES(1,1,20,'2017-01-02'),
      (1,2,15,'2017-01-05'),
      (1,3,25,'2017-01-05'),
      (2,1,30,'2017-01-02'),
      (2,2,35,'2017-01-05');



-- 1. Fifth, the following statement returns the total sales 
-- for each product in each store:
SELECT 
    store_name,
    product_name,
    SUM(quantity * price) AS revenue
FROM
    sales
        INNER JOIN
    products ON products.id = sales.product_id
        INNER JOIN
    stores ON stores.id = sales.store_id
GROUP BY store_name , product_name; 



/*
- Now, what if you wish to determine which store had no sales 
of a particular product? The previously mentioned statement is 
unable to address this query.
- To solve the problem, you can use the CROSS JOIN clause.
- Sixth, use the CROSS JOIN clause to get the combination of 
all stores and products:
*/
SELECT 
    store_name, product_name
FROM
    stores AS a
        CROSS JOIN
    products AS b;



-- Next, join the result of the query above with a query that 
-- returns the total of sales by store and product:
SELECT 
    b.store_name,
    a.product_name,
    IFNULL(c.revenue, 0) AS revenue
FROM
    products AS a
CROSS JOIN
    stores AS b
LEFT JOIN
    (SELECT 
        stores.id AS store_id,
        products.id AS product_id,
        store_name,
            product_name,
            ROUND(SUM(quantity * price), 0) AS revenue
    FROM
        sales
    INNER JOIN products ON products.id = sales.product_id
    INNER JOIN stores ON stores.id = sales.store_id
    GROUP BY stores.id, products.id, store_name , product_name) AS c ON c.store_id = b.id
        AND c.product_id= a.id
ORDER BY b.store_name;

/*
	By using the CROSS JOIN clause this way, you can answer a wide range 
of questions e.g., find the sales revenue by salesman, month even if 
the salesman has no sales in a particular month.
*/