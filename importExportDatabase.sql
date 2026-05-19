use EastIndiaCompany
/* syntax
BACKUP DATABASE databaseName
TO DISK = 'path + databasename.bak'
WITH FORMAT, -- overwrites existing backup file if it exits,creates new if not
NAME = 'Full Backup of EastIndiaCompany'; -- A description for the backup

*/
--note avoid this type path desktop,documents,onedrive premission issue error

BACKUP DATABASE EastIndiaCompany
TO DISK = 'E:\SQL SERVER BACKUP\EastIndiaCompany.bak'
WITH FORMAT, -- new backup media
INIT, -- overwrites existing backup file if it exits,creates new if not
NAME = 'Full Backup of EastIndiaCompany', -- A description for the backup
STATS = 10 --progress percentage

BACKUP DATABASE SCHOOL
TO DISK = 'E:\SQL SERVER BACKUP\SCHOOL.bak'
WITH FORMAT, -- new backup media
INIT, -- overwrites existing backup file if it exits,creates new if not
NAME = 'Full Backup of SCHOOL', -- A description for the backup
STATS = 10 --progress percentage

BACKUP DATABASE Temp
TO DISK = 'E:\SQL SERVER BACKUP\Temp.bak'
WITH FORMAT, -- new backup media
INIT, -- overwrites existing backup file if it exits,creates new if not
NAME = 'Full Backup of Temp', -- A description for the backup
STATS = 10 --progress percentage


-- Restore and import Database

restore filelistonly
from disk ='E:\SQL SERVER BACKUP\EastIndiaCompany.bak'

RESTORE DATABASE EastIndiaCompany

FROM DISK = 'C:\SQLBackups\EastIndiaCompany.bak';


/*
PART 2 → RESTORE / IMPORT DATABASE
12. Restore Kya Hota Hai

.bak file se database wapas create karna.

13. Simple Restore Query
RESTORE DATABASE EastIndiaCompany

FROM DISK = 'C:\SQLBackups\EastIndiaCompany.bak';
14. Common Problem

Agar DB already exist karti hai:

database already exists
15. Existing DB Replace Restore
RESTORE DATABASE EastIndiaCompany

FROM DISK = 'C:\SQLBackups\EastIndiaCompany.bak'

WITH REPLACE;
16. Single User Mode Problem

Kabhi DB connections open hote hain.

Error:

database is in use

Fix:

ALTER DATABASE EastIndiaCompany

SET SINGLE_USER

WITH ROLLBACK IMMEDIATE;

Then restore:

RESTORE DATABASE EastIndiaCompany

FROM DISK = 'C:\SQLBackups\EastIndiaCompany.bak'

WITH REPLACE;

Then:

ALTER DATABASE EastIndiaCompany

SET MULTI_USER;
17. Restore With Different Database Name

Suppose backup file ka DB name different hai.

Example
RESTORE DATABASE NewCompanyDB

FROM DISK = 'C:\SQLBackups\EastIndiaCompany.bak';
18. File Path Problem

Error:

Logical file name incorrect

First check logical names:

RESTORE FILELISTONLY

FROM DISK = 'C:\SQLBackups\EastIndiaCompany.bak';
19. Advanced Restore
RESTORE DATABASE EastIndiaCompany

FROM DISK = 'C:\SQLBackups\EastIndiaCompany.bak'

WITH
MOVE 'EastIndiaCompany'
TO 'C:\SQLData\EastIndiaCompany.mdf',

MOVE 'EastIndiaCompany_log'
TO 'C:\SQLData\EastIndiaCompany_log.ldf',

REPLACE;

*/

-- bulk inset databse
BULK INSERT TableName
FROM 'C:\Path\To\Your\File\data.csv'
WITH (
    FORMAT = 'CSV', -- Specify the format
    FIELDTERMINATOR = ',', -- Specify the column delimiter (comma for CSV)
    ROWTERMINATOR = '\n', -- Specify the row delimiter (newline)
    FIRSTROW = 2 -- Skip the header row if it exists
);
