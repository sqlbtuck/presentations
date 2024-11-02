-------------------Database Setup-------------------
USE [master]
GO

IF (DB_ID('Demo_QS') IS NOT NULL)
BEGIN
	ALTER DATABASE [Demo_QS] SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [Demo_QS];
END

CREATE DATABASE [Demo_QS]
GO

USE [Demo_QS]
GO

CREATE TABLE dbo.Tbl1 (ID INT NOT NULL, Val VARCHAR(100));
INSERT INTO dbo.Tbl1 (ID, Val)
SELECT ROW_NUMBER() OVER (ORDER BY o.object_id), LEFT(o.name, 5)
FROM sys.all_objects o
-------------------/Database Setup-------------------


-------------------QS Config-------------------
SELECT d.database_id, d.name, d.is_query_store_on
FROM sys.databases d
WHERE d.name = 'Demo_QS'

SELECT * FROM sys.database_query_store_options dqso;

--Open GUI

ALTER DATABASE [Demo_QS]
SET QUERY_STORE (
	DATA_FLUSH_INTERVAL_SECONDS = 60
	, INTERVAL_LENGTH_MINUTES = 1
	--Don't do this in practice!  For demo only!
);

SELECT dqso.flush_interval_seconds, dqso.interval_length_minutes
FROM sys.database_query_store_options dqso;
-------------------/QS Config-------------------
