-------------------Runtime Data for next demo-------------------
USE Demo_QS
GO

SELECT *
FROM dbo.Tbl1 t3
CROSS JOIN dbo.Tbl1 t4
WHERE t4.ID > 10
	AND t4.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t3
CROSS JOIN dbo.Tbl1 t4
WHERE t4.ID > 10
	AND t4.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t5
LEFT OUTER JOIN dbo.Tbl1 t6 ON t5.Val = t6.Val
WHERE t5.ID > 10
	AND t6.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t5
LEFT OUTER JOIN dbo.Tbl1 t6 ON t5.Val = t6.Val
WHERE t5.ID > 10
	AND t6.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t5
LEFT OUTER JOIN dbo.Tbl1 t6 ON t5.Val = t6.Val
WHERE t5.ID > 10
	AND t6.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t7
LEFT OUTER JOIN dbo.Tbl1 t8 ON t7.Val = t8.Val
	AND t7.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t7
LEFT OUTER JOIN dbo.Tbl1 t8 ON t7.Val = t8.Val
	AND t7.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t7
LEFT OUTER JOIN dbo.Tbl1 t8 ON t7.Val = t8.Val
	AND t7.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t7
LEFT OUTER JOIN dbo.Tbl1 t8 ON t7.Val = t8.Val
	AND t7.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t7
LEFT OUTER JOIN dbo.Tbl1 t8 ON t7.Val = t8.Val
	AND t7.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t7
LEFT OUTER JOIN dbo.Tbl1 t8 ON t7.Val = t8.Val
	AND t7.Val LIKE '%s';

SELECT *
FROM dbo.Tbl1 t7
LEFT OUTER JOIN dbo.Tbl1 t8 ON t7.Val = t8.Val
	AND t7.Val LIKE '%s';