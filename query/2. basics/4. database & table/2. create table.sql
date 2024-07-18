/*
- In MySQL, each table has a storage engine such as 
InnoDB or MyISAM. The ENGINE clause allows you to specify 
the storage engine of the table.
- If you don’t explicitly specify a storage engine, MySQL 
will use the default storage engine which is InnoDB.
*/


CREATE DATABASE testdb;
USE testdb;


-- ## Basic CREATE TABLE statement example
-- 1. The following example uses the CREATE TABLE statement 
-- to create a new table called tasks:
CREATE TABLE tasks (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE
);


-- 2. 
SHOW TABLES;


-- ## Creating a table with a foreign key example
-- 3. Suppose each task has a checklist. To store the checklists 
-- of tasks, you can create a new table called checklists as follows:
CREATE TABLE checklists(
  id INT, 
  task_id INT, 
  title VARCHAR(255) NOT NULL, 
  is_completed BOOLEAN NOT NULL DEFAULT FALSE, 
  PRIMARY KEY (id, task_id), -- this table has 2 primary keys
  FOREIGN KEY (task_id) -- setup foreign key
      REFERENCES tasks (id) 
      ON UPDATE RESTRICT 
      ON DELETE CASCADE
);
/*
	- The table checklists has a primary key that consists of 
two columns. Therefore, we need to use a table constraint to 
define the primary key:
        > PRIMARY KEY (id, task_id)
	- In addition, the task_id is the foreign key column that 
references the id column of the tasks table, therefore, we use 
a foreign key constraint to establish this relationship:		
        > FOREIGN KEY (task_id) 
			REFERENCES tasks (id) 
			ON UPDATE RESTRICT 
			ON DELETE CASCADE
*/



-- 4. the following statement creates a table called 
-- contacts to store contact data:
CREATE TABLE contacts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(320) NOT NULL
);
/*
- In this example, we assign the AUTO_INCREMENT attribute 
to the id column to set it as an auto-increment primary key.
- This means that when you insert a new row into the contacts 
table without providing a value for the id column, MySQL will 
automatically generate a unique number.
*/



-- 5. When inserting rows into the table with an AUTO_INCREMENT 
-- column, you don’t need to specify a value for that column. MySQL 
-- will automatically generate the value for you.
INSERT INTO contacts(name, email)
VALUES('John Doe', 'john.doe@mysqltutorial.org');
SELECT * FROM contacts;



-- 6. To get the AUTO_INCREMENT value that MySQL generated 
-- for the most recent insert, you use the LAST_INSERT_ID() function:
SELECT last_insert_id();



-- 7. To reset the AUTO_INCREMENT value, you use the ALTER TABLE statement:
ALTER TABLE contacts 
AUTO_INCREMENT = 1;

-- 8 Alternatively, you can delete all rows from the table and reset 
-- the AUTO_INCREMENT value simultaneously. 
-- To do that, you use the TRUNCATE TABLE statement:
TRUNCATE TABLE contacts;
SELECT * FROM contacts;



-- 9. The following example illustrates how to reset the value in 
-- the AUTO_INCREMENT column to an invalid value:
INSERT INTO contacts(name, email) 
VALUES
   ('John Doe', 'john.doe@mysqltutorial.org'),
   ('Jane Doe', 'jane.doe@mysqltutorial.org');
SELECT * FROM contacts;



-- 10. If you reset the AUTO_INCREMENT column to any number that 
-- is less than or equal to 2 using the ALTER TABLE statement, the 
-- operation will have no effects. For example:
ALTER TABLE contacts 
AUTO_INCREMENT = 1;



-- 11. Now, if you insert a new row into the contacts table, MySQL 
-- will use the next number 3 for the new row. For example:
INSERT INTO contacts(name, email) 
VALUES('Bob Climo', 'bob.climo@mysqltutorial.org');
SELECT * FROM contacts;



-- ## Adding an AUTO_INCREMENT column to an existing table
CREATE TABLE subscribers(
   email VARCHAR(320) NOT NULL UNIQUE
);

ALTER TABLE subscribers
ADD id INT AUTO_INCREMENT PRIMARY KEY;

