-----------------TABLES COUNT AND SIZES-----------------START
WITH dataset_table_info AS (
 SELECT
   TABLE_CATALOG AS project_id,
   TABLE_SCHEMA AS dataset_id,
   TABLE_NAME AS table_name,
   TOTAL_ROWS AS row_count,
   TOTAL_PHYSICAL_BYTES / (1024 * 1024 * 1024) AS physical_size_gb,
   TOTAL_LOGICAL_BYTES / (1024 * 1024 * 1024) AS logical_size_gb
 FROM
   `{projectId}.region-us.INFORMATION_SCHEMA.TABLE_STORAGE`
),
physical_size_stats AS (
 SELECT
   dataset_id,
   physical_size_gb,
   ROW_NUMBER() OVER (PARTITION BY dataset_id ORDER BY physical_size_gb) AS rn,
   COUNT(*) OVER (PARTITION BY dataset_id) AS cnt
 FROM
   dataset_table_info
),
logical_size_stats AS (
 SELECT
   dataset_id,
   logical_size_gb,
   ROW_NUMBER() OVER (PARTITION BY dataset_id ORDER BY logical_size_gb) AS rn,
   COUNT(*) OVER (PARTITION BY dataset_id) AS cnt
 FROM
   dataset_table_info
),
row_count_stats AS (
 SELECT
   dataset_id,
   row_count,
   ROW_NUMBER() OVER (PARTITION BY dataset_id ORDER BY row_count) AS rn,
   COUNT(*) OVER (PARTITION BY dataset_id) AS cnt
 FROM
   dataset_table_info
),
table_stats AS (
 SELECT
   dataset_id,
   COUNT(table_name) AS table_count,
   MIN(physical_size_gb) AS min_physical_size_gb,
   MAX(physical_size_gb) AS max_physical_size_gb,
   AVG(physical_size_gb) AS avg_physical_size_gb,
   SUM(physical_size_gb) AS total_physical_size_gb,
   MIN(logical_size_gb) AS min_logical_size_gb,
   MAX(logical_size_gb) AS max_logical_size_gb,
   AVG(logical_size_gb) AS avg_logical_size_gb,
   SUM(logical_size_gb) AS total_logical_size_gb,
   MIN(row_count) AS min_rows,
   MAX(row_count) AS max_rows,
   AVG(row_count) AS avg_rows,
   SUM(row_count) AS total_rows
 FROM
   dataset_table_info
 GROUP BY
   dataset_id
),
physical_median AS (
 SELECT
   dataset_id,
   APPROX_QUANTILES(physical_size_gb, 2)[OFFSET(1)] AS median_physical_size_gb
 FROM
   dataset_table_info
 GROUP BY
   dataset_id
),
logical_median AS (
 SELECT
   dataset_id,
   APPROX_QUANTILES(logical_size_gb, 2)[OFFSET(1)] AS median_logical_size_gb
 FROM
   dataset_table_info
 GROUP BY
   dataset_id
),
row_count_median AS (
 SELECT
   dataset_id,
   APPROX_QUANTILES(row_count, 2)[OFFSET(1)] AS median_rows
 FROM
   dataset_table_info
 GROUP BY
   dataset_id
)
SELECT
 ts.dataset_id,
 ts.table_count,
 ts.min_physical_size_gb,
 ts.max_physical_size_gb,
 ts.avg_physical_size_gb,
 pm.median_physical_size_gb,
 ts.total_physical_size_gb,
 ts.min_logical_size_gb,
 ts.max_logical_size_gb,
 ts.avg_logical_size_gb,
 lm.median_logical_size_gb,
 ts.total_logical_size_gb,
 ts.min_rows,
 ts.max_rows,
 ts.avg_rows,
 rm.median_rows,
 ts.total_rows
FROM
 table_stats ts
JOIN
 physical_median pm ON ts.dataset_id = pm.dataset_id
JOIN
 logical_median lm ON ts.dataset_id = lm.dataset_id
JOIN
 row_count_median rm ON ts.dataset_id = rm.dataset_id
ORDER BY
 ts.dataset_id;


-----------------TABLES COUNT AND SIZES-----------------END
