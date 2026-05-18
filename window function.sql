USE EastIndiaCompany
SELECT DB_NAME()

/*
Window functions, also known as analytic functions allow you to perform calculations across a set of rows related to the current row. 
Defined by over() clause.
*/

SELECT ROW_NUMBER() OVER(ORDER BY emp_id) AS [SR.NO] , * FROM premimumCustomer

SELECT *,AVG(salary) OVER(partition by department) AS [Average salary By dep],DENSE_RANK() OVER(ORDER BY salary) AS [Rank] FROM premimumCustomer

/*
Window function = group jaisa calculation, but original rows ke saath.
Most common window functions:
ROW_NUMBER()
RANK()
DENSE_RANK()
SUM()
AVG()
MIN()
MAX()
COUNT()
LAG()
LEAD()
NOTE: Normally sum avg min max count are aggregate methods but we can use as a window funtion with over clasue usgage.
*/

SELECT *, SUM(salary) OVER(ORDER BY emp_id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS [RUNNING TOTAL] FROM premimumCustomer

/*
1 PRECEDING => PREVIOUS 1
2 PRECEDING => PREVIOUS 2
UNBOUNDED PRECEDING => START TO CURRENT ROW
CURRENT ROW => CURRENT ROW
UNBOUNDED FOLLOWING => CURRENT ROW TO END ROW
1 FOLLOWING => NEXT ROW 1
2 FOLLOWING => NEXT ROW 2
*/

-- running total 3
SELECT *, SUM(salary) OVER(ORDER BY emp_id ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING) AS [3 running total]  FROM premimumCustomer;

-- normal running total
SELECT *, CONVERT(decimal(12,2),AVG(salary) OVER(ORDER BY emp_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) AS [running total] FROM premimumCustomer;

-- LAG => previous row result ,LEAD => next row result 
-- syntax LAG(columnName,offset,defaultValue)

SELECT *, LAG(salary,1,0) OVER(ORDER BY emp_id ) AS [ Lag previous_result ], LEAD(salary,1,0) OVER(ORDER BY emp_id) AS [Lead previous_result]  FROM premimumCustomer;

-- First_value, Last_value,NTILE means grouping
SELECT * , FIRST_VALUE(salary) OVER(ORDER BY emp_id) AS [Minimum salary],LAST_VALUE(salary) OVER(ORDER BY emp_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS [Last Value] FROM premimumCustomer

-- Ntile
SELECT *, NTILE(4) OVER(ORDER BY salary) AS [ Group by Ntile] FROM premimumCustomer
