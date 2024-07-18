/*
	CROSS JOIN clause returns a Cartesian product of rows from the joined tables.  
*/

/*
	We’ll use a cross join to create a deck of 52 playing cards.
*/
-- First, create a table that stores suits:
CREATE TABLE suits (
    suit_id INT,
    suit_name VARCHAR(10)
);

-- Second, create a table to store ranks:
CREATE TABLE ranks (
    rank_id INT,
    rank_name VARCHAR(5)
);

-- Third, insert data into the suits and ranks table:
INSERT INTO suits (suit_id, suit_name) VALUES
    (1, 'Hearts'),
    (2, 'Diamonds'),
    (3, 'Clubs'),
    (4, 'Spades');
INSERT INTO ranks (rank_id, rank_name) VALUES
    (1, 'Ace'), (2, '2'), (3, '3'), (4, '4'),
    (5, '5'), (6, '6'), (7, '7'), (8, '8'),
    (9, '9'), (10, '10'), (11, 'Jack'), (12, 'Queen'),
    (13, 'King');
    


-- Finally, use a cross to combine the suits and ranks to create a deck of 52 playing cards:
SELECT 
  suit_name, 
  rank_name 
FROM 
  suits CROSS 
  JOIN ranks 
ORDER BY 
  suit_name, 
  rank_name;
