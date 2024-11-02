RAISERROR ('Full script run!', 16, 1)
RETURN

-------------------DB Setup Check-------------------
IF (DB_ID('Demo_QS') IS NULL)
BEGIN
    RAISERROR('Run setup script first to create database', 16, 1)
END
-------------------/DB Setup Check-------------------


-------------------Show State of DMVs-------------------
USE Demo_QS
GO

	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;
-------------------/Show State of DMVs-------------------


-------------------Current Exec Plan-------------------
--ENABLE ACTUAL EXEC PLAN

--Same query as original demo
SELECT *
FROM dbo.Tbl1 t1
CROSS JOIN dbo.Tbl1 t2
WHERE t1.ID > 10
	AND t1.Val LIKE '%s';
-------------------/Current Exec Plan-------------------


-------------------Cause New Plan-------------------
--Wipe table to change future exec plans
DELETE FROM dbo.Tbl1;

--Same query as original demo
SELECT *
FROM dbo.Tbl1 t1
CROSS JOIN dbo.Tbl1 t2
WHERE t1.ID > 10
	AND t1.Val LIKE '%s';
-------------------/Cause New Plan-------------------


-------------------Force Plan-------------------
--Show new plan in QS
	SELECT [DMV] = 'PLAN', * FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;

--Force our old plan, just for fun
EXEC sys.sp_query_store_force_plan @query_id = 6, @plan_id = 7;

	SELECT [DMV] = 'PLAN', qsp.plan_id, qsp.query_id, qsp.query_plan_hash, qsp.is_forced_plan FROM sys.query_store_plan qsp;
	SELECT [DMV] = 'QUERY', * FROM sys.query_store_query qsq;
	SELECT [DMV] = 'QUERY_TEXT', * FROM sys.query_store_query_text qsqt;
-------------------/Force Plan-------------------


-------------------Verify Force-------------------
--TURN ON ACTUAL EXEC PLAN!!

--Same query that we forced back to previous plan
SELECT *
FROM dbo.Tbl1 t1
CROSS JOIN dbo.Tbl1 t2
WHERE t1.ID > 10
	AND t1.Val LIKE '%s';
-------------------/Verify Force-------------------
