USE classicmodels;

-- The following query uses the HAVING clause with the COUNT 
-- function to get the customers who placed more than four orders:
SELECT 
  customerName, 
  COUNT(*) order_count 
FROM 
  orders 
  INNER JOIN customers using (customerNumber) 
GROUP BY 
  customerName 
HAVING 
  COUNT(*) > 4 
ORDER BY 
  order_count;

