USE EastIndiaCompany
SELECT DB_NAME()
/*
SQL Server me View ek virtual table hoti hai.
Isme actual data store nahi hota, balki ek saved SQL query store hoti hai.
*/
/*
view syntax
CREATE VIEW VIEWNAME
AS 
SELECT etc
*/

-- create view

CREATE VIEW TECHDATA
AS
SELECT * FROM premimumCustomer 

ALTER VIEW TECHDATA  --update view
AS
SELECT * FROM premimumCustomer
WHERE department = 'Tech'

SELECT * FROM TECHDATA
SELECT * FROM sys.views  -- check all views

EXEC sp_helptext 'TECHDATA' -- check view stored query

CREATE VIEW average_Department_salary
AS
SELECT department, AVG(salary) AS [avergage0-Salary/Dept] FROM premimumCustomer GROUP BY department

SELECT * FROM average_Department_salary

CREATE VIEW avergage_salary_completeDetail_Department
AS
SELECT * FROM premimumCustomer p WHERE salary > (SELECT AVG(salary) FROM premimumCustomer pc WHERE pc.department = p.department ) --corelated subquery

SELECT * FROM avergage_salary_completeDetail_Department

-- DROP VIEW
DROP VIEW average_Department_salary

EXEC sp_help 'premimumCustomer'

--------------------------STORED ROUTINE----------------------------------
/*
An SQL statement or a set of SQL Statement that can be stored on database server which can be call no. of times.
SQL Server me Stored Procedure (SP) ek saved SQL program hota hai.
Isme multiple SQL statements save kar sakte ho.
Jab chahiye tab execute kar sakte ho.
Note: stored procedure ma compiled code store hota hai query ka 
STORED PROCEDURE SE CRUD OPERATION KAR SAKTE HAI
*/


CREATE PROCEDURE insert_procedure_PC
AS
BEGIN
INSERT INTO premimumCustomer(fname,lname,email,job_title,department,salary,city,managerId)
VALUES('Montu','Kharb','montudeveloper420@gmail.com','Dist-exe','Development',520000,'Bengaluru',520)
END

EXEC insert_procedure_PC -- single time run hogi duplicate restriction hai table par
SELECT * FROM premimumCustomer
EXEC sp_help 'premimumCustomer'

--dynamic insertion using system procedure
CREATE PROCEDURE insert_dynamic_data
 -- global variable declaration in procedure
  @fName VARCHAR(50),
  @lName VARCHAR(50),
  @email VARCHAR(100),
  @job_title VARCHAR(100),
  @department VARCHAR(100),
  @salary INT,
  @city VARCHAR(100),
  @managerID INT

AS
BEGIN
INSERT INTO premimumCustomer(fname,lname,email,job_title,department,salary,city,managerId)
    VALUES(@fName,@lName,@email,@job_title,@department,@salary,@city,@managerID)
END

SELECT * FROM sys.procedures -- check how many procedures compiled in dbms

EXEC sp_helptext 'insert_dynamic_data' -- return procedure query code 

-- insert data using system procedure in premimumCustomer Table
EXEC insert_dynamic_data 'Rahul','Gandhi','Raga01@gmail.com','Future Prime Minister','Supreme Leader',500000,'New Delhi',502

-- update data using system prcedure with confirmation
CREATE PROCEDURE update_dynamic_data_email_column
--variables
@employeeId INT,
@newData VARCHAR(100),
@result VARCHAR(100) OUTPUT
AS
BEGIN
  UPDATE premimumCustomer
  SET email = @newData
  WHERE emp_id = @employeeId
  SELECT * FROM premimumCustomer WHERE emp_id = @employeeId 
  SELECT @result = CONCAT('User-FullName',': ',fname,' ',lname) FROM premimumCustomer WHERE emp_id = @employeeId
END

DROP PROCEDURE update_dynamic_data_email_column

DECLARE @Result VARCHAR(100);
DECLARE @emailArgument VARCHAR(60) = 'dynamic@gmail.com';
EXEC update_dynamic_data_email_column 103,@emailArgument,@result OUTPUT
PRINT @Result

DECLARE @N INT = 1;
WHILE @N <= 10
    BEGIN
      PRINT @N
      SET @N += 1 -- always use set
      -- SELECT @N += 2
    END


-- BREAK, CONTINUE, RETURN 

DECLARE @NUM INT = 1;

WHILE @NUM <= 20
BEGIN

    IF @NUM = 13
      BEGIN
        BREAK;
        END

    IF @NUM % 2 = 0
    BEGIN
        SET @NUM += 1;
        CONTINUE;
    END
    PRINT @NUM
    SET @NUM += 1;
END

Declare @OTP INT = FLOOR(RAND() * 300 + 100)
PRINT CASE 
    WHEN @OTP >=150 AND @OTP <= 200 THEN 'NUMBER BETWEEN 150 AND 200' 
    WHEN @OTP >200 THEN 'TOO MUCH HIGH NUMBER'
    ELSE 'BELOW THEN 150 NUMBER'
END + '|' + -- RESULT SEPRATOR BOTH CASE ARE RUTURN VALUE 
CASE
WHEN @OTP >= 300 THEN 'SECOND CASE RUN OTP GREATER THAN 300'
ELSE 'UNDER 300'
END

-- USER DEFINED FUNCTIONS
-- A User-Defined Function is a reusable SQL object created by the user to perform a specific task and return a value.
-- two types 1 scaler function return single value , 2 table valued function return a table. ,3 inline table valued function ( ITVF ) RETURN table

/*
METHOD SYNTAX
CREATE METHOD METHODNAME
( @variables int etc)
RETURNS return_type
AS
RETURN / BEGIN END -- Operations
*/

CREATE FUNCTION totalSumFun
( @INPUT INT )
RETURNS INT
AS
    BEGIN 

        RETURN @INPUT + @INPUT

    END
 -- dbo stands for database owner. A schema acts like a folder inside your database to organize objects like tables, views, and stored procedures
 select dbo.totalSumFun(10)

CREATE FUNCTION fullTableResult()
RETURNS TABLE
AS
RETURN 
  SELECT * FROM premimumCustomer


SELECT * FROM dbo.fullTableResult()

SELECT ABS(-10) AS ABSOLUTEVALUE;
SELECT SQRT(25) AS [SQRT OF 25];
SELECT POWER(2,3) AS [POWER OF 2];

--------NUMERIC FUNCTION--------------
SELECT ABS(-25) AS Result;
SELECT ABS(-5000) AS RefundAmount;

----CEILING-------(return uppper value)-----
SELECT CEILING(12.3) AS [CEILING_Result];
-----FLOOR (return lower value)-----
SELECT FLOOR(23.9) AS [floor];
-------ROUND()------------
SELECT ROUND(23.38567,2)AS [ROUND_Result]; 

---------POWER-----------
SELECT POWER(2,3) AS Pow;
--------SQRT-----------
SELECT SQRT(25) AS SquareRoot;

--------RAND-----------
SELECT RAND() AS RandomNumber;

--------PI-------------
SELECT PI() AS PIValue;

--------SIGN-----------
SELECT SIGN(25) AS PositiveNumber;
SELECT SIGN(-25) AS NegativeNumber;
SELECT SIGN(0) AS ZeroNumber;

--------------------------------------------------
---------------- SPACE ----------------
SELECT 'Hello'
+ SPACE(5)
+ 'World' AS SpaceExample;
---------------- REPLICATE ----------------
SELECT REPLICATE('*',10) AS Stars;
---------------- STUFF ----------------
SELECT STUFF('HelloWorld',6,5,'SQL') AS StuffExample;
---------------- PATINDEX ----------------
SELECT fname + ' ' + lname,
PATINDEX('%a%',fname) AS PositionPattern
FROM premimumCustomer;
---------------- FORMAT ----------------
SELECT FORMAT(GETDATE(),'dd-MM-yyyy') AS FormattedDate;

--------------------------------------------------

---------------- DATE FUNCTIONS ----------------
---------------- GETDATE ----------------
SELECT GETDATE() AS CurrentDateTime;
---------------- CURRENT_TIMESTAMP ----------------
SELECT CURRENT_TIMESTAMP AS CurrentTimeStamp;
---------------- SYSDATETIME ----------------
SELECT SYSDATETIME() AS SystemDateTime;
---------------- DAY ----------------
SELECT
OrderDate,
DAY(OrderDate) AS OrderDay
FROM Orders;
---------------- MONTH ----------------
SELECT
OrderDate,
MONTH(OrderDate) AS OrderMonth
FROM Orders;
---------------- YEAR ----------------
SELECT
OrderDate,
YEAR(OrderDate) AS OrderYear
FROM Orders;
---------------- DATEPART ----------------
SELECT
OrderDate,
DATEPART(YEAR,OrderDate) AS YearPart,
DATEPART(MONTH,OrderDate) AS MonthPart,
DATEPART(DAY,OrderDate) AS DayPart
FROM Orders;
---------------- DATENAME ----------------
SELECT
OrderDate,
DATENAME(MONTH,OrderDate) AS MonthName,
DATENAME(WEEKDAY,OrderDate) AS DayName
FROM Orders;
---------------- DATEADD ----------------
SELECT
OrderDate,
DATEADD(DAY,7,OrderDate) AS After7Days
FROM Orders;
--------------------------------------------
SELECT
OrderDate,
DATEADD(MONTH,1,OrderDate) AS After1Month
FROM Orders;
---------------- DATEDIFF ----------------
SELECT
OrderDate,
DATEDIFF(DAY,OrderDate,GETDATE()) AS DaysDifference
FROM Orders;
-----------------------------------------------
SELECT
OrderDate,
DATEDIFF(MONTH,OrderDate,GETDATE()) AS MonthDifference
FROM Orders;
---------------- EOMONTH ----------------
SELECT
OrderDate,
EOMONTH(OrderDate) AS EndOfMonth
FROM Orders;
---------------- ISDATE ----------------
SELECT ISDATE('2025-05-10') AS ValidDate;

SELECT ISDATE('Hello') AS InvalidDate;

---------------- FORMAT ----------------
SELECT
FORMAT(GETDATE(),'dd-MM-yyyy') AS DateFormat1,

FORMAT(GETDATE(),'dd/MM/yyyy') AS DateFormat2,

FORMAT(GETDATE(),'MMMM') AS MonthName,

FORMAT(GETDATE(),'dddd') AS DayName;

---------------- CAST ----------------
SELECT
CAST(GETDATE() AS DATE) AS OnlyDate;
------------------------------------------------
SELECT
CAST(123.456 AS INT) AS IntegerValue;
--------------------------------CONVERT -----------------------------
SELECT
CONVERT(VARCHAR,GETDATE(),103) AS BritishFormat;
------------------------------------------------

SELECT
CONVERT(VARCHAR,GETDATE(),108) AS OnlyTime;
SELECT
CONVERT(VARCHAR,GETDATE(),107) AS DateStyle107;

/*
ON DELETE CASCADE Kya Hai

Ye FOREIGN KEY constraint ka feature hai.

Jab parent table se row delete hoti hai,
to child table ki related rows bhi automatically delete ho jati hain.
*/

/*
CREATE TABLE orders (
    ord_id INT IDENTITY(1,1) PRIMARY KEY, -- Use IDENTITY(1,1)
    date DATE,
    amount DECIMAL(10, 2),
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id) ON DELETE CASCADE -- means dependent table ka data bhi delete kar de ga
);

*/
/*
SQL Server me Trigger ek special stored procedure hoti hai jo automatically run hoti hai jab:

INSERT
UPDATE
DELETE

event hota hai.

Aap manually trigger execute nahi karte.
*/


CREATE TABLE FactoryEmp
(
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT
);
/*
trigger syntax
CREATE TRIGGER triggername
ON tableName
AFTER INSERT/UPDATE/DELETE/etc
AS
BEGIN 
--do operation like print or insert backup document
END
*/
CREATE TRIGGER trg_InsertEmployee
ON FactoryEmp --table name
AFTER INSERT-- trigger run point
AS
BEGIN
    PRINT 'NEW EMPLOYEE INSERTED';
END
    
INSERT INTO FactoryEmp
VALUES(2,'Vishal',50000);

SELECT * FROM FactoryEmp

DROP TRIGGER trg_InsertEmployee

