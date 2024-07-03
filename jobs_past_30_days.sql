-----------------JOBS PAST 30 DAYS-----------------START


WITH job_stats AS (
 SELECT
   DATE(creation_time) AS job_date,
   job_type,
   COUNT(*) AS query_count,
   COUNT(DISTINCT user_email) AS user_count,
   MIN(total_bytes_processed) / (1024 * 1024 * 1024) AS min_gb_processed,
   MAX(total_bytes_processed) / (1024 * 1024 * 1024) AS max_gb_processed,
   AVG(total_bytes_processed) / (1024 * 1024 * 1024) AS avg_gb_processed,
   APPROX_QUANTILES(total_bytes_processed / (1024 * 1024 * 1024), 2)[OFFSET(1)] AS median_gb_processed,
   SUM(total_bytes_processed) / (1024 * 1024 * 1024) AS total_gb_processed,
   MIN(total_bytes_billed) / (1024 * 1024 * 1024) AS min_gb_billed,
   MAX(total_bytes_billed) / (1024 * 1024 * 1024) AS max_gb_billed,
   AVG(total_bytes_billed) / (1024 * 1024 * 1024) AS avg_gb_billed,
   APPROX_QUANTILES(total_bytes_billed / (1024 * 1024 * 1024), 2)[OFFSET(1)] AS median_gb_billed,
   SUM(total_bytes_billed) / (1024 * 1024 * 1024) AS total_gb_billed,
   MIN(total_slot_ms) / (1000 * 60 * 60) AS min_slot_utilization_hours,
   MAX(total_slot_ms) / (1000 * 60 * 60) AS max_slot_utilization_hours,
   AVG(total_slot_ms) / (1000 * 60 * 60) AS avg_slot_utilization_hours,
   APPROX_QUANTILES(total_slot_ms / (1000 * 60 * 60), 2)[OFFSET(1)] AS median_slot_utilization_hours,
   SUM(total_slot_ms) / (1000 * 60 * 60) AS total_slot_utilization_hours
 FROM
   `panoply-880-0110627aced8.region-us.INFORMATION_SCHEMA.JOBS`
 WHERE
   creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
 GROUP BY
   job_date, job_type
)
SELECT
 job_date,
 job_type,
 query_count,
 user_count,
 min_gb_processed,
 max_gb_processed,
 avg_gb_processed,
 median_gb_processed,
 total_gb_processed,
 min_gb_billed,
 max_gb_billed,
 avg_gb_billed,
 median_gb_billed,
 total_gb_billed,
 min_slot_utilization_hours,
 max_slot_utilization_hours,
 avg_slot_utilization_hours,
 median_slot_utilization_hours,
 total_slot_utilization_hours
FROM
 job_stats
ORDER BY
 job_date, job_type;


-----------------JOBS PAST 30 DAYS-----------------END
