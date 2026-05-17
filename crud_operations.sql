SELECT * FROM employee  -- return all data from employee table

-- check how many tables in eastindiacompany db
SELECT * FROM sys.tables -- return all tables names

-- check customer table structure using system procedure best for detailed
EXEC sp_help 'customer'

TRUNCATE TABLE customer -- Delete all table data with cleaning indexer etc

-- decimal(38,0) Maximul precision decimal 38

INSERT INTO customer(cFirstName,cEmail,phoneNo)
VALUES ('Vishal','vishalsharma1@example.com',65765432),
('Diya Patel','diya.patel2@example.com',9876502),
('Rohan Mehra','rohan.mehra3@example.com',9873203),
('Priya Singh','priya.singh4@example.com',9873204),
('Arjun Kumar','arjun.kumar5@example.com',9873205),
('Ananya Gupta','ananya.gupta6@example.com',9543206),
('Vikram Reddy','vikram.reddy7@example.com',9543207),
('Sameera Rao','sameera.rao8@example.com',9873208),
('Ishaan Verma','ishaan.verma9@example.com',9543209),
('Kavya Joshi','kavya.joshi10@example.com',9843210),
('Zain Khan','zain.khan11@example.com',9876541),
('Nisha Desai','nisha.desai12@example.com',9843212),
('Aditya Nair','aditya.nair13@example.com',9843213),
('Fatima Ali','fatima.ali14@example.com',9876214),
('Kabir Shah','kabir.shah15@example.com',9876215)

SELECT * FROM customer

-- update data
UPDATE customer
SET cEmail = 'sachinkharb526@gmail.com', phoneNo = 816815029,cFirstName = 'Sachin' , cLastName = 'Kharb'
WHERE cId = 101

ALTER TABLE customer
ADD salary DECIMAL(14,2) DEFAULT 30000 NOT NULL

SELECT * FROM sys.objects where parent_object_id = OBJECT_ID('customer') -- return all constraint name

ALTER TABLE customer
DROP CONSTRAINT DF__customer__salary__70DDC3D8 --drop constraint


ALTER TABLE customer 
DROP COLUMN salary   -- drop salary column

-- delete database 
DELETE customer
WHERE cEmail = 'john@gmail.com'

-- find all employee
SELECT  COUNT(*) as Total FROM customer

SELECT * FROM customer ORDER BY cFirstName;

SELECT * FROM customer WHERE cFirstName LIKE '%VYA%' -- match in middle 
SELECT * FROM customer WHERE cFirstName LIKE '[SD]%' -- start with s or d
SELECT * FROM customer WHERE cFirstName LIKE '[^SD]%' -- not match starting S or D 
SELECT * FROM customer WHERE cFirstName LIKE '%A' -- end with A
SELECT * FROM customer WHERE cFirstName LIKE '_O%' -- start with second character O
SELECT * FROM customer WHERE cFirstName LIKE '__H%' -- start with Third character H


-- TOP select the first n row 
SELECT TOP(4) * FROM customer ORDER BY cFirstName
SELECT TOP(4) * FROM customer ORDER BY cFirstName DESC -- descending order

CREATE TABLE premimumCustomer (

    emp_id INT IDENTITY(101,1) PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    job_title VARCHAR(50) NOT NULL, 
    department VARCHAR(50),    
    salary DECIMAL(10,2) DEFAULT 30000.00,
    hire_date DATE NOT NULL DEFAULT CONVERT(DATe, GETDATE()),
    city VARCHAR(50)
);
GO

INSERT INTO premimumCustomer
(fname, lname, email, job_title, department, salary, hire_date, city)
VALUES
('Aarav', 'Sharma', 'aarav.sharma@example.com', 'Director', 'Management', 180000, '2019-02-10', 'Mumbai'),
('Diya', 'Patel', 'diya.patel@example.com', 'Lead Engineer', 'Tech', 120000, '2020-08-15', 'Bengaluru'),
('Rohan', 'Mehra', 'rohan.mehra@example.com', 'Software Engineer', 'Tech', 85000, '2022-05-20', 'Bengaluru'),
('Priya', 'Singh', 'priya.singh@example.com', 'HR Manager', 'Human Resources', 95000, '2019-11-05', 'Mumbai'),
('Arjun', 'Kumar', 'arjun.kumar@example.com', 'Data Scientist', 'Tech', 110000, '2021-07-12', 'Hyderabad'),
('Ananya', 'Gupta', 'ananya.gupta@example.com', 'Marketing Lead', 'Marketing', 90000, '2020-03-01', 'Delhi'),
('Vikram', 'Reddy', 'vikram.reddy@example.com', 'Sales Executive', 'Sales', 75000, '2023-01-30', 'Mumbai'),
('Sameera', 'Rao', 'sameera.rao@example.com', 'Software Engineer', 'Tech', 88000, '2023-06-25', 'Pune'),
('Ishaan', 'Verma', 'ishaan.verma@example.com', 'Recruiter', 'Human Resources', 65000, '2022-09-01', 'Mumbai'),
('Kavya', 'Joshi', 'kavya.joshi@example.com', 'Product Designer', 'Design', 92000, '2021-04-18', 'Bengaluru'),
('Zain', 'Khan', 'zain.khan@example.com', 'Sales Manager', 'Sales', 115000, '2019-09-14', 'Delhi'),
('Nisha', 'Desai', 'nisha.desai@example.com', 'Jr. Data Analyst', 'Tech', 70000, '2024-02-01', 'Hyderabad'),
('Aditya', 'Nair', 'aditya.nair@example.com', 'Marketing Analyst', 'Marketing', 68000, '2022-10-10', 'Delhi'),
('Fatima', 'Ali', 'fatima.ali@example.com', 'Sales Executive', 'Sales', 78000, '2022-11-22', 'Mumbai'),
('Kabir', 'Shah', 'kabir.shah@example.com', 'DevOps Engineer', 'Tech', 105000, '2020-12-01', 'Pune');

SELECT city FROM premimumCustomer GROUP BY city -- single column grouped

SELECT city,department FROM premimumCustomer GROUP BY city, department -- multi column grouped

-- check premimumCustomer Table constraints key name
SELECT* FROM sys.objects
WHERE parent_object_id = OBJECT_ID('premimumCustomer')

SELECT * FROM premimumCustomer WHERE department = 'TECH' AND job_title = 'SOFTWARE ENGINEER'; 

SELECT * FROM premimumCustomer WHERE department = 'SALES' OR job_title = 'SALES EXECUTIVE'; 

SELECT * FROM premimumCustomer WHERE department IN('MARKETING','TECH','SALES') -- return all employee which are working these departments

SELECT * FROM premimumCustomer WHERE department NOT IN('MARKETING','TECH','SALES') -- return all employee which are NOT working these departments

-- BOTH ARE RETURN SAME RESULT
SELECT fname,salary FROM premimumCustomer WHERE salary >= 50000 AND salary <= 80000
SELECT * FROM premimumCustomer WHERE salary BETWEEN 50000 AND 80000

/*
  CASE best for multiple condition using syntax

  CASE
    WHEN condition THEN return_value
    WHEN condition2 THEN return_value2
    ELSE return_value
  END
*/

SELECT fname,lname,email,salary,
CASE
  WHEN salary >=40000 AND salary <= 80000 THEN 'NORMAL EARNER'
  WHEN salary > 80000 AND salary <= 100000 THEN 'MEDIUM EARNER'
  WHEN salary > 100000 THEN 'HIGH EARNER'
  ELSE 'LOW EARNER'
END 
AS [Earning Category]
FROM premimumCustomer

SELECT COUNT(*) AS [invalid emp] FROM premimumCustomer WHERE fname IS NULL




