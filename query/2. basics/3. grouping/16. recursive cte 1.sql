/*
- a recursive Common Table Expression (CTE) is a named temporary 
result set that references itself in the recursive member, enabling 
the hierarchical traversal or iteration over data until a specified 
termination condition is met.

	WITH RECURSIVE cte_name AS (
		initial_query  -- anchor member
		UNION ALL
		recursive_query -- recursive member that references to the CTE name
	)
	SELECT * FROM cte_name;

- The recursive member must not contain the following constructs:
	Aggregate functions e.g., MAX, MIN, SUM, AVG, COUNT, etc.
	GROUP BY clause
	ORDER BY clause
	LIMIT clause
	DISTINCT
*/
/*
- The recursive member must not contain the following constructs:
	Aggregate functions e.g., MAX, MIN, SUM, AVG, COUNT, etc.
	GROUP BY clause
	ORDER BY clause
	LIMIT clause
	DISTINCT
*/

-- example
WITH RECURSIVE cte_count (n) 
AS (
      SELECT 1 -- anchor member
      UNION ALL
      SELECT n + 1 -- recursive member
      FROM cte_count 
      WHERE n < 3 -- termination condition
    )
SELECT n 
FROM cte_count;

