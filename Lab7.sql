/*******************************************************
Script: Lab4.txt
Author: Sujan Rokad
Date: Oct 3 2023
Authorship statement: I, Sujan Rokad, student number 000882948, certify
that this material is my original work. No other person's work has been
used without due acknowledgment and I have not made my work available to
anyone else.
********************************************************/
-- Setting NOCOUNT ON suppresses completion messages for each INSERT
SET NOCOUNT ON
-- Set date format to year, month, day
SET DATEFORMAT ymd;
-- Make the master database the current database
USE master
-- If database mydatabase exists, drop it
IF EXISTS (SELECT * FROM sysdatabases WHERE name = 'mydatabase')
BEGIN
ALTER DATABASE mydatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE mydatabase;
END
GO
-- Create the mydatabase database
CREATE DATABASE mydatabase;
GO
-- Make the mydatabase database the current database
USE mydatabase;

-- Create customers table
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(30),
category CHAR(1) CHECK (category IN ('C', 'R', 'F')),
credit_limit MONEY,
sales_ytd MONEY);

-- Create sales table
CREATE TABLE sales (
sales_id INT PRIMARY KEY,
sales_date DATE,
amount MONEY,
service_id INT FOREIGN KEY REFERENCES customers(customer_id));
GO
-- Insert customers records
INSERT INTO customers VALUES(200, 'Tom_Cuisine', 'C', 500.00, 100.00);
INSERT INTO customers VALUES(120, 'Lisa_Cafe', 'C', 900.34, 150.50);
INSERT INTO customers VALUES(400, 'Golden_Pizzeria', 'F', 800.00, 90.00);
INSERT INTO customers VALUES(3030, 'Walmart', 'R', 2000.00, 200.00);
INSERT INTO customers VALUES(2015, 'Subway', 'F', 1000.00, 160.00);
-- Insert sales records
INSERT INTO sales VALUES(1, '2023-08-01', 50.00, 3030); -- Month and day don't have to be 2 digits
INSERT INTO sales VALUES(2, '2023-08-02', 29.50, 200); -- But they typically are
INSERT INTO sales VALUES(3, '2023-08-03', 40.00, 2015);
INSERT INTO sales VALUES(4, '2023-08-04', 50.00, 3030);
INSERT INTO sales VALUES(5, '2023-08-05', 40.00, 120);
INSERT INTO sales VALUES(6, '2023-08-06', 20.50, 200);
INSERT INTO sales VALUES(7, '2023-08-07', 55.00, 120);
INSERT INTO sales VALUES(8, '2023-08-08', 45.00, 400);
INSERT INTO sales VALUES(9, '2023-08-09', 45.00, 400);
INSERT INTO sales VALUES(10, '2023-08-10', 60.00, 2015);
INSERT INTO sales VALUES(11, '2023-08-11', 60.00, 3030);
INSERT INTO sales VALUES(12, '2023-08-12', 40.00, 3030);
INSERT INTO sales VALUES(13, '2023-08-13', 50.00, 200);
INSERT INTO sales VALUES(14, '2023-08-14', 40.00, 2015);
INSERT INTO sales VALUES(15, '2023-08-15', 25.25, 120);
INSERT INTO sales VALUES(16, '2023-08-16', 20.00, 2015);
INSERT INTO sales VALUES(17, '2023-08-17', 30.00, 120);
GO
-- Verify inserts
CREATE TABLE verify (
table_name varchar(30),
actual INT,
expected INT);
GO
--CREATE INDEX STATEMENT
CREATE INDEX IX_customers_customer_name
ON customers (customer_name);
GO
INSERT INTO verify VALUES('customers', (SELECT COUNT(*) FROM customers),
5);
INSERT INTO verify VALUES('sales', (SELECT COUNT(*) FROM sales), 17);
PRINT 'Verification';
SELECT table_name, actual, expected, expected - actual discrepancy FROM
verify;
DROP TABLE verify;
GO
--CREATE VIEW, DISPLAYING credit_limit IS HIGHER THAN AVERAGE
CREATE VIEW high_end_customers
AS
SELECT SUBSTRING(customer_name, 1, 17) AS customer_name, credit_limit
FROM customers
WHERE credit_limit > (select AVG (credit_limit) FROM customers);
GO

/*******************************************************
Script: Lab7.txt
Author: Sujan Rokad
Date: Nov 14, 2023
Authorship statement: I, Sujan Rokad, student number 000882948, certify
that this material is my original work. No other person's 
work has been used without due acknowledgment and I have not made my 
work available to anyone else.
********************************************************/

--CREATE INSERT TRIGGER insert_trigger
CREATE TRIGGER insert_trigger
ON sales
AFTER INSERT
AS 
BEGIN
	UPDATE customers
	SET sales_ytd = sales_ytd + i.amount
	FROM customers
	JOIN inserted i ON customer_id = I.service_id
END
GO

--CREATE DELETE TRIGGER delete_trigger
CREATE TRIGGER delete_trigger
ON sales
AFTER DELETE
AS
BEGIN
	UPDATE customers
	SET sales_ytd = sales_ytd - d.amount
	FROM customers
	JOIN deleted d ON customer_id = D.service_id

END
GO

--CREATE UPDATE TRIGGER update_trigger
CREATE TRIGGER update_trigger
ON sales
AFTER UPDATE
AS 
BEGIN
	UPDATE customers
	SET sales_ytd = sales_ytd - d.amount + i.amount
	FROM customers
	JOIN deleted d ON customer_id = d.service_id
	JOIN inserted i ON customer_id = i.service_id
END
GO

-- Verification
PRINT 'Verify triggers'

PRINT 'Master Table Before Changes'
SELECT * FROM customers

INSERT INTO sales VALUES(18, '2023-11-12', 1200.00, 3030)
PRINT 'After INSERT'
SELECT * FROM customers

DELETE FROM sales
WHERE sales_id = 18
PRINT 'After DELETE'
SELECT * FROM customers

UPDATE sales SET amount = 1000 WHERE sales_id = 8
PRINT 'After UPDATE'
SELECT * FROM customers