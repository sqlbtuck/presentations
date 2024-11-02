RAISERROR ('Full script run!', 16, 1)
RETURN

-------------------DB Setup Check-------------------
IF (DB_ID('Demo_QS') IS NULL)
BEGIN
    RAISERROR('Run setup script first to create database', 16, 1)
END
-------------------/DB Setup Check-------------------


-------------------Clear QS-------------------
ALTER DATABASE Demo_QS SET QUERY_STORE CLEAR ALL;
-------------------/Clear QS-------------------


-------------------Queries-------------------
USE Demo_QS
GO

--Show DMVs empty
	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;

--Trivial Query 1
SELECT * FROM dbo.Tbl1;

--Trivial Query 2
SELECT *
FROM dbo.Tbl1
WHERE ID > 10;

--Show DMVs still empty.  Why?
	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;

--First captured query
SELECT *
FROM dbo.Tbl1 t1
CROSS JOIN dbo.Tbl1 t2
WHERE t1.ID > 10
	AND t1.Val LIKE '%s';

--Show query in QS
	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;

--Same query, qsq updates times
SELECT *
FROM dbo.Tbl1 t1
CROSS JOIN dbo.Tbl1 t2
WHERE t1.ID > 10
	AND t1.Val LIKE '%s';

--Show query in QS
	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', qsq.query_id, qsq.query_text_id, qsq.query_hash, qsq.initial_compile_start_time, qsq.last_compile_start_time, qsq.last_execution_time FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;

--Change predicate slightly for new row
SELECT *
FROM dbo.Tbl1 t1
CROSS JOIN dbo.Tbl1 t2
WHERE t1.ID > 10
	AND t1.Val LIKE '%b';

--Show query in QS
	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;

--Build an index to change our exec plan
CREATE CLUSTERED INDEX [IXC_Tbl1_ID] ON [dbo].[Tbl1] (ID);

--Same query, different exec plan
SELECT *
FROM dbo.Tbl1 t1
CROSS JOIN dbo.Tbl1 t2
WHERE t1.ID > 10
	AND t1.Val LIKE '%s';

--Show query in QS
	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;
-------------------/Queries-------------------

--RUN QUERY DATA SCRIPT!