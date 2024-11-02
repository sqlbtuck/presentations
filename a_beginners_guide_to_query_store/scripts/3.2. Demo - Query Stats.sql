RAISERROR ('Full script run!', 16, 1)
RETURN

-------------------DB Setup Check-------------------
IF (DB_ID('Demo_QS') IS NULL)
BEGIN
    RAISERROR('Run setup script first to create database', 16, 1)
END
-------------------/DB Setup Check-------------------


-------------------QS Data Check-------------------
IF NOT EXISTS (SELECT 1 FROM Demo_QS.sys.query_store_runtime_stats qsrs)
BEGIN
    RAISERROR('No QS data.  Run Script 3.1. before this demo to populate data.', 16, 1)
END
-------------------/QS Data Check-------------------


-------------------DMV Review-------------------
USE Demo_QS
GO

SELECT * FROM sys.query_store_runtime_stats_interval qsrsi;
SELECT * FROM sys.query_store_runtime_stats qsrs;
SELECT * FROM sys.query_store_wait_stats qsws;
