CREATE DATABASE EastIndiaCompany --create data base
USE EastIndiaCompany  -- Select Current data base

SELECT DB_NAME()  -- return current used db name

create TABLE employee
(
  empId INT IDENTITY(1,1),
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone DECIMAL(10,0) UNIQUE NOT NULL,
  jobTitle VARCHAR(50) NOT NULL,
  department VARCHAR(100) NOT NULL DEFAULT 'General',
  basicpay DECIMAL(12,2) DEFAULT 30000.00,
  hra INT DEFAULT 500,
  totalSalary DECIMAL(14,2),
  city VARCHAR(50),
  CONSTRAINT PrimaryKey_empId PRIMARY KEY (empId),
)

SELECT * FROM sys.all_columns
WHERE object_id = OBJECT_ID('employee') -- return table stucture using a catalog view 

EXEC sp_help 'employee' -- return table structure in details

SELECT top 20 * FROM employee ORDER BY totalSalary Desc


INSERT INTO employee
(name,email,phone,jobTitle,department,basicpay,hra,totalSalary,city)

VALUES
('Aarav Sharma','aarav.sharma1@example.com',9876543201,'Director','Management',180000,5000,185000,'Mumbai'),
('Diya Patel','diya.patel2@example.com',9876543202,'Lead Engineer','Tech',120000,4000,124000,'Bengaluru'),
('Rohan Mehra','rohan.mehra3@example.com',9876543203,'Software Engineer','Tech',85000,3000,88000,'Bengaluru'),
('Priya Singh','priya.singh4@example.com',9876543204,'HR Manager','Human Resources',95000,3500,98500,'Mumbai'),
('Arjun Kumar','arjun.kumar5@example.com',9876543205,'Data Scientist','Tech',110000,4000,114000,'Hyderabad'),
('Ananya Gupta','ananya.gupta6@example.com',9876543206,'Marketing Lead','Marketing',90000,3000,93000,'Delhi'),
('Vikram Reddy','vikram.reddy7@example.com',9876543207,'Sales Executive','Sales',75000,2500,77500,'Mumbai'),
('Sameera Rao','sameera.rao8@example.com',9876543208,'Software Engineer','Tech',88000,3000,91000,'Pune'),
('Ishaan Verma','ishaan.verma9@example.com',9876543209,'Recruiter','Human Resources',65000,2000,67000,'Mumbai'),
('Kavya Joshi','kavya.joshi10@example.com',9876543210,'Product Designer','Design',92000,3000,95000,'Bengaluru'),

('Zain Khan','zain.khan11@example.com',9876543211,'Sales Manager','Sales',115000,4000,119000,'Delhi'),
('Nisha Desai','nisha.desai12@example.com',9876543212,'Jr. Data Analyst','Tech',70000,2500,72500,'Hyderabad'),
('Aditya Nair','aditya.nair13@example.com',9876543213,'Marketing Analyst','Marketing',68000,2200,70200,'Delhi'),
('Fatima Ali','fatima.ali14@example.com',9876543214,'Sales Executive','Sales',78000,2500,80500,'Mumbai'),
('Kabir Shah','kabir.shah15@example.com',9876543215,'DevOps Engineer','Tech',105000,3500,108500,'Pune');

;WITH Numbers AS
(
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 200
)

INSERT INTO employee
(
    name,
    email,
    phone,
    jobTitle,
    department,
    basicpay,
    hra,
    totalSalary,
    city
)

SELECT
    CONCAT('Employee ', n),
    CONCAT('employee', n, '@example.com'),
    9000000000 + n,
    CASE n % 5
        WHEN 0 THEN 'Software Engineer'
        WHEN 1 THEN 'HR Manager'
        WHEN 2 THEN 'Data Analyst'
        WHEN 3 THEN 'Sales Executive'
        ELSE 'Marketing Lead'
    END,

    CASE n % 4
        WHEN 0 THEN 'Tech'
        WHEN 1 THEN 'Human Resources'
        WHEN 2 THEN 'Sales'
        ELSE 'Marketing'
    END,

    30000 + (n * 100),

    2000,

    (30000 + (n * 100)) + 2000,

    CASE n % 5
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Pune'
        WHEN 3 THEN 'Hyderabad'
        ELSE 'Bengaluru'
    END

FROM Numbers
OPTION (MAXRECURSION 200);

