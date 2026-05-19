USE EAStIndiaCompany
SELECT DB_NAME()

SELECT * FROM sys.tables

EXEC sp_help 'premimumCustomer'

-- Aggregate function start

SELECT COUNT(*) AS Total_emp FROM premimumCustomer -- total number return
SELECT MAX(salary) AS MaxValue FROM premimumCustomer -- Max value
SELECT MIN(salary) AS MinValue FROM premimumCustomer -- Min value
SELECT SUM(salary) AS [Total SUM] FROM premimumCustomer -- Total SUM 
SELECT AVG(salary) AS Average FROM premimumCustomer -- Average value


-- COUNT how many emp in every department
SELECT department,city, COUNT(emp_id) AS total_emp FROM premimumCustomer
GROUP BY department,city

-- find number of employee each city
SELECT city ,COUNT(emp_id) AS [Total employee] FROM premimumCustomer
GROUP BY city;
exec sp_help 'premimumCustomer'
SELECT * FROM premimumCustomer
-- find average salary in each department
SELECT department, AVG(salary) AS averageSalaryInDept FROM premimumCustomer GROUP BY department 

SELECT department, AVG(salary) AS avgSAlary FROM premimumCustomer GROUP BY department

-- find the employe where salary is greateher than department avarage salary 
SELECT * FROM premimumCustomer WHERE salary > (SELECT AVG(salary) FROM premimumCustomer );

--find department with more than 2 employe 
SELECT department, COUNT(emp_id) AS COUNT FROM premimumCustomer GROUP BY department HAVING COUNT(emp_id) > 2 --Note with GROUP BY use always HAVING instead of where clause

--find department with total salary above 300000
SELECT department, SUM(salary) AS totalSalary FROM premimumCustomer GROUP BY department HAVING SUM(salary) > 300000;

-- GROUP BY Rollup is an extension of the GROUP BY clause that generates subtotals and a grand total for a set of columns.
SELECT ISNULL(department,'GRAND TOTAL') AS department, SUM(salary) AS [total Salary] FROM premimumCustomer GROUP BY ROLLUP(department)

-- find number of employee in each department
SELECT department, COUNT(emp_id) AS [Total employee/Dep] FROM premimumCustomer GROUP BY department;

-- find lowest,maximum,total salary paying in each department
SELECT department, MIN(salary) AS [minimum Salary],MAX(salary) AS [maximum Salary],SUM(salary) AS [Total Salary] 
FROM premimumCustomer GROUP BY department 

/*
 The subquery runs first and gives a result.
 The main query (outer query) then uses that result.
*/

--find highest pay employee name
SELECT * FROM premimumCustomer WHERE salary = (SELECT MAX(salary) FROM premimumCustomer)

SELECT * FROM premimumCustomer

/*
Single Row Subquery => where, Having
Multiple Row Subquery => IN,ANY,ALL
Correlated Subquery => where, Select Note: Depend outer query
Nested Subquery 
Scalar Subquery
EXISTS Subquery
NOT EXISTS Subquery
*/

--1. single row subquery used with [ where , having ]
SELECT * FROM premimumCustomer WHERE salary > (SELECT AVG(salary) FROM premimumCustomer) -- found employee whose salaries are above average.

-- 2. Multiple Row SubQuery { in means a or b, any means koi bhi eak , all means ferfect true both side like and operation }
SELECT * FROM premimumCustomer WHERE salary IN ( SELECT salary FROM premimumCustomer WHERE salary > 120000 )
SELECT * FROM premimumCustomer WHERE salary  > ANY ( SELECT salary FROM premimumCustomer WHERE salary >= 80000 )

-- 3. Correlated subquery inner query outer query par depend karti hai 
-- outer query ki har row ka liya inner query run hoti hai 

-- find employee by minimum salary in each department
SELECT * FROM premimumCustomer p WHERE salary = (SELECT MIN(salary) FROM premimumCustomer WHERE department = p.department)

-- 4.Nested subQuery means subquery ka ander eak or subquery
SELECT * FROM premimumCustomer WHERE department = (SELECT department FROM premimumCustomer WHERE salary >= (SELECT MAX(salary) FROM premimumCustomer))

--5.Scalar subquery mostly select clause ma use hoti hai single value return karti hai example
SELECT fname,lname,salary,(SELECT CONVERT(DECIMAL( 12,2 ), AVG(salary) ) FROM premimumCustomer) AS [AVERAGE SALARY] FROM premimumCustomer

--6.EXISTS subquery check karta hai row exist karti hai ya nahi
SELECT * FROM premimumCustomer P WHERE EXISTS (SELECT 1 FROM premimumCustomer WHERE department = P.department )

SELECT *
FROM premimumCustomer P
WHERE NOT EXISTS
(
   SELECT 1
   FROM premimumCustomer 
   WHERE Department = P.department
   AND Salary > 70000
)
