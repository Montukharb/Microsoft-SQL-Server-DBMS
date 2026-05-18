USE EastIndiaCompany
SELECT DB_NAME()

SELECT * FROM sys.tables
-- FIND CONSTRAINT NAME
SELECT * FROM  sys.objects
WHERE parent_object_id = OBJECT_ID('premimumCustomer')

/*
CTE (Common Table Expression) is a temporary
result set that you can define withing a query to simplify
complex sql statements
*/
/*
CTE ko:

temporary table ki tarah
readable query likhne ke liye
recursion ke liye
complex joins simplify karne ke liye

use karte ho.
*/

-- Find emp who earn more than their department's average salary

/*
 cte syntax

 with cte_name as
 (
 
 )

 use here how see ex= select * from cte_Name

*/

;WITH allEmpData AS ( SELECT * FROM premimumCustomer)
SELECT * FROM allEmpData  -- note only single use it is best for readable query like use sub query result

-- recurssion cte
;WITH numberCTC AS 
(
 SELECT 1 AS NUM
 UNION ALL
 SELECT NUM + 1
 FROM numberCTC
 WHERE NUM < 5
)

SELECT * FROM numberCTC

-- string functions
/*
CONCAT, CONCAT_WS
SUBSTRING
LEFT, RIGHT
LEN
UPPER, LOWER
TRIM, LTRIM, RTRIM
REPLACE
CHARINDEX
*/
SELECT CONCAT(fname,' ',lname) FROM premimumCustomer

SELECT CONCAT_WS('-',fname,lname) FROM premimumCustomer

SELECT fname, SUBSTRING(fname,1,3) FROM premimumCustomer

SELECT fname AS [orginal First Name],LEFT(fname,3) AS [first char] FROM premimumCustomer

;WITH ctcRecursion AS
(
 SELECT 1 AS NUM
 
 UNION ALL
 SELECT NUM + 1
 FROM ctcRecursion
 WHERE NUM < 10
)
SELECT * FROM ctcRecursion

SELECT fname AS [orginal First Name],RIGHT(fname,3) AS [Last char] FROM premimumCustomer

SELECT CHARINDEX('AS','THOMAS') AS CHARCTERINDEX
SELECT email, LEN(email) AS [LENGTH] FROM premimumCustomer

SELECT CONCAT_WS('-',fname,lname) AS originalName,REVERSE(REPLACE(fname,LEFT(fname,3),RIGHT(fname,3))) AS [Replaced Name With reverse] FROM premimumCustomer
SELECT TRIM('        DATA        ')
SELECT LTRIM('    HELLO DATALEFT DATALEFT2TIMES            ')
SELECT RTRIM('    HELLO DATARIGHT DATARIGHTT2TIMES            ')
SELECT TRIM('       HELLO DATALEFT DATALEFT2TIMES            ')

EXEC sp_help 'premimumCustomer'

SELECT * FROM sys.objects
WHERE parent_object_id = OBJECT_ID('premimumCustomer')


CREATE TABLE orders(
orderId INT IDENTITY(501,1) NOT NULL,
productName VARCHAR(100) NOT NULL,
price DECIMAL(12,2) NOT NULL,
empId INT NOT NULL,
orderDate DATE CONSTRAINT default_orderDate DEFAULT CONVERT(DATE,GETDATE()),
CONSTRAINT check_empId CHECK(empId > 100),
CONSTRAINT primaryKey_orderId PRIMARY KEY (orderId),
CONSTRAINT foreignKey_empId FOREIGN KEY (empId) REFERENCES premimumCustomer(emp_id)
)

INSERT INTO orders(productName,price,empId,orderDate) VALUES
('Laptop',64400,110,'2026-01-06'),
('Laptop',55000,101,'2025-01-03'),
('Mouse',799,102,'2025-01-04'),
('Keyboard',1499,103,'2025-01-05'),
('Monitor',12000,104,'2025-01-06'),
('Printer',8500,105,'2025-01-07'),
('Tablet',22000,106,'2025-01-08'),
('Speaker',3200,107,'2025-01-09'),
('Headphone',2500,108,'2025-01-10'),
('SSD',4800,109,'2025-01-11'),
('Pendrive',700,110,'2025-01-12'),

('Laptop',62000,111,'2025-01-13'),
('Mouse',999,112,'2025-01-14'),
('Keyboard',1800,113,'2025-01-15'),
('Monitor',15000,114,'2025-01-16'),
('Printer',9200,115,'2025-01-17'),

('Tablet',28000,101,'2025-01-18'),
('Speaker',4100,102,'2025-01-19'),
('Headphone',3500,103,'2025-01-20'),
('SSD',5400,104,'2025-01-21'),
('Pendrive',900,105,'2025-01-22'),

('Laptop',57000,106,'2025-01-23'),
('Mouse',850,107,'2025-01-24'),
('Keyboard',2200,108,'2025-01-25'),
('Monitor',13500,109,'2025-01-26'),
('Printer',7800,110,'2025-01-27'),

('Tablet',26000,111,'2025-01-28'),
('Speaker',3900,112,'2025-01-29'),
('Headphone',2900,113,'2025-01-30'),
('SSD',5100,114,'2025-02-01'),
('Pendrive',750,115,'2025-02-02'),

('Laptop',68000,101,'2025-02-03'),
('Mouse',1200,102,'2025-02-04'),
('Keyboard',2000,103,'2025-02-05'),
('Monitor',17000,104,'2025-02-06'),
('Printer',11000,105,'2025-02-07'),

('Tablet',30000,106,'2025-02-08'),
('Speaker',4500,107,'2025-02-09'),
('Headphone',4200,108,'2025-02-10'),
('SSD',6200,109,'2025-02-11'),
('Pendrive',950,110,'2025-02-12'),

('Laptop',53000,111,'2025-02-13'),
('Mouse',650,112,'2025-02-14'),
('Keyboard',1750,113,'2025-02-15'),
('Monitor',12500,114,'2025-02-16'),
('Printer',8800,115,'2025-02-17'),

('Tablet',24000,101,'2025-02-18'),
('Speaker',3600,102,'2025-02-19'),
('Headphone',2700,103,'2025-02-20'),
('SSD',4900,104,'2025-02-21'),
('Pendrive',820,105,'2025-02-22'),

('Laptop',71000,106,'2025-02-23'),
('Mouse',1350,107,'2025-02-24'),
('Keyboard',2400,108,'2025-02-25'),
('Monitor',18500,109,'2025-02-26'),
('Printer',12500,110,'2025-02-27'),

('Tablet',34000,111,'2025-02-28'),
('Speaker',5200,112,'2025-03-01'),
('Headphone',4600,113,'2025-03-02'),
('SSD',7200,114,'2025-03-03'),
('Pendrive',1100,115,'2025-03-04'),

('Laptop',59000,101,'2025-03-05'),
('Mouse',780,102,'2025-03-06'),
('Keyboard',1650,103,'2025-03-07'),
('Monitor',14000,104,'2025-03-08'),
('Printer',9100,105,'2025-03-09'),

('Tablet',25500,106,'2025-03-10'),
('Speaker',4000,107,'2025-03-11'),
('Headphone',3100,108,'2025-03-12'),
('SSD',5600,109,'2025-03-13'),
('Pendrive',870,110,'2025-03-14'),

('Laptop',76000,111,'2025-03-15'),
('Mouse',1450,112,'2025-03-16'),
('Keyboard',2600,113,'2025-03-17'),
('Monitor',21000,114,'2025-03-18'),
('Printer',13800,115,'2025-03-19'),

('Tablet',38000,101,'2025-03-20'),
('Speaker',6100,102,'2025-03-21'),
('Headphone',5200,103,'2025-03-22'),
('SSD',8100,104,'2025-03-23'),
('Pendrive',1300,105,'2025-03-24'),

('Laptop',61000,106,'2025-03-25'),
('Mouse',920,107,'2025-03-26'),
('Keyboard',1950,108,'2025-03-27'),
('Monitor',15500,109,'2025-03-28'),
('Printer',9800,110,'2025-03-29'),

('Tablet',29000,111,'2025-03-30'),
('Speaker',4700,112,'2025-03-31'),
('Headphone',3900,113,'2025-04-01'),
('SSD',6700,114,'2025-04-02'),
('Pendrive',980,115,'2025-04-03'),

('Laptop',83000,101,'2025-04-04'),
('Mouse',1600,102,'2025-04-05'),
('Keyboard',3100,103,'2025-04-06'),
('Monitor',24000,104,'2025-04-07'),
('Printer',15200,105,'2025-04-08');

/*
Cross Join
Inner Join
Left Join
Right Join
Full Join / Full Outer Join
*/
-- 1. cross join me table 1 * table 2 hota hai means first table ki each row second table ki each row ka sath combine hogi there are no condition allowed

SELECT * FROM premimumCustomer CROSS JOIN orders -- NOTE: Generally there are not used

-- 2. inner join matching id ka sath hi bond banaye ga
SELECT * FROM premimumCustomer P INNER JOIN orders O ON P.emp_id = O.empId 

-- 3. left join me first table ka data complete aye ga right side table ma aga koi data mismatch hua to null aye ga
SELECT * FROM premimumCustomer P LEFT JOIN orders O ON P.emp_id = O.orderId

-- 4. right join return all result right side if match or not when left side not match return null
SELECT * FROM premimumCustomer P RIGHT JOIN orders O ON P.emp_id = O.orderId

-- 4. full join dono tables ke saare records aate hain. Jahan match nahi hota wahan NULL.
SELECT * FROM premimumCustomer P FULL JOIN orders O ON P.emp_id = O.orderId

/*
Requirements:

Each SELECT must have the same number of columns.
Corresponding columns must have compatible data types.
Column names are taken from the first SELECT.

Union vs Union ALL
Union removes the duplicates from combined result

*/
EXEC sp_help 'premimumCustomer'
EXEC sp_help 'orders'


SELECT emp_id FROM premimumCustomer
UNION 
SELECT empId  FROM orders

SELECT emp_id FROM premimumCustomer
UNION all
SELECT empId  FROM orders

-- except remove duplicates from table one which is available in table 2 return unique result

SELECT emp_id FROM premimumCustomer
EXCEPT
SELECT orderId FROM orders order by emp_id

-- self join syntax left join jaise hi ISME self table ki another row ka data as a column show karna
SELECT P.fname,C.fname FROM premimumCustomer P
LEFT JOIN premimumCustomer C ON P.emp_id = C.managerId

ALTER TABLE premimumCustomer
ADD managerId INT

update premimumCustomer 
set managerId = emp_id
where managerId IS NULL

SELECT * FROM premimumCustomer