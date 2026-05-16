-- List down EXISTING DATABASES we can write query small case or upper case select or SELECT both are same prefer Upper Case SELECT for easy reading purpose
-- two way to show all databases in ms sql server
-- sp_databases = is a system stored procedure used to display information about databases in sql server. Means already sql server ka ander saved SQL code like a function.
-- 1st EXEC = Execute means run procedure, sp = stored procedure, EXEC = procedure/function executer

EXEC sp_databases

-- 2nd sys.databases = is a system catalog view that stores information about all databases in SQL Server.
-- SQL Server apni khud ki information bhi store karta hai.
-- Us information ko access karne ke liye system views hote hain.
-- sys.databases unhi me se ek hai.
-- sys = system schema, databases = database info
-- Note: Both of them used but sys.databases more used then sp_databases sys.databases provide filter and other specification

SELECT * FROM sys.databases
SELECT * from sys.tables
-- creating a db
CREATE DATABASE SCHOOL
CREATE DATABASE Temp
CREATE DATABASE Testing


-- Selecting a Data Base using use
USE SCHOOL
USE TEMP  -- there are no error throw from name conflicts TEMP == temp,Temp all are same case insensitive
-- db_name() is a system funtion that return the name of current database.
SELECT DB_NAME()

-- delete database normal case ma delete ho zata hai agar use ma na ho to forcefully delete karne ka liya phele single user connection alter karo.
-- ALL current users ko forcefully hata deta hai
-- GO = ye eak seprator hai query ko block ma run karta ha phele first line then go if status ok then next line of query

-- DROP DATABASE Testing
/*
ALTER DATABASE Testing
SET SINGLE_USER -- data base ko single Connection Mode
WITH ROLLBACK IMMEDIATE -- Remove all current session and users
GO -- query seprator
DROP DATABASE Testing
*/
/*
CRUD OPERATION 
CREATE, READ, UPDATE, DELETE
What is Table = A Table is collection of related data held in a table format within a database.
*/

-- Creating a table
CREATE TABLE Students(
 id INT,
 name VARCHAR(100),
 age INT,
 grade INT)

-- Check Tables using system procedure sp_help 'tablename'
EXEC sp_help 'Students' --return table structure 

--alternate of sp_help best for detailed use view 
SELECT * FROM sys.all_columns -- sys.columns is a catalog view that stores metadata about table columns.
WHERE object_id = OBJECT_ID('Students') -- OBJECT_ID is a method return any table,database,view/object ki unique objectid

/*
SQL server internally apni table ki information bhi store kart hai isko views se check kar sakta hai example
*/

SELECT * FROM sys.tables  -- return tables


SELECT COUNT(*) FROM sys.tables  -- return total no of tables method 1 most comman used

-- second way to check how many tables in database using system procedure
USE SCHOOL 
GO
EXEC sp_tables  -- Note Better for Not used this system procedure prefer always views return table detail list


-- insert SINGLE data in tables

INSERT INTO Students (id,name,age,grade)
VALUES (1,'Sachin',21,12)

-- insert MULTIPLE data in table
INSERT INTO Students -- INSERT INTO Students (id,name,age,grade) if insert data all field then no need to declare table column name
VALUES (2,'Montu',23,17),(3,'Vishal',22,17)

INSERT INTO Students (id,name,age,grade)
VALUES (4,'Baburaow',49,13)

-- Read Tables
SELECT * FROM Students

-- Read table column only
SELECT name FROM Students

-- update table single column
UPDATE Students
SET name = 'Baburaow'
WHERE id = 3


-- update table multiple column
UPDATE Students
SET name = 'Vishal', age = 23, grade=17
WHERE id = 1

-- Delete table data
DELETE FROM Students
WHERE id=4

-- Delete Complete Table There are two way 1 TRUNCATE
TRUNCATE TABLE Students -- best for use to delete entire table data auto clean counter start to 1 
-- second way to delete table data using Delete

DELETE FROM Students
WHERE 1=1  -- 1 = 1 means all data delete but ye auto clean nahi kare ga next item whi se start hoga jaha last item tha

-- Search baburao name and grade both
SELECT name,grade FROM Students
WHERE age = 49

