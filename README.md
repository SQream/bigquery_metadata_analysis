# bigquery_metadata_analysis
This repo aims to facilitate SQream’s sales team to approach potential customers that currently use BigQuery analytics solution

TABLES COUNT AND SIZES
This query helps in understanding the storage and data distribution across different datasets within a BigQuery project. It provides insights into:
The number of tables per dataset.
Data size in gigabytes of the tables in dataset - physical and logical size in Gigabytes - min, max, avg, median per dataset.
The number of records in tables - min, max, avg, median per dataset

Relevant google documentation related to the main datasource INFORMATION_SCHEMA.TABLE_STORAGE : https://cloud.google.com/bigquery/docs/information-schema-table-storage

JOBS PAST 30 DAYS
This query provides a summary of query statistics over the past 30 days per query type, including:
Query count and user count per day and query type.
Minimum, maximum, average, median, and total gigabytes processed.
Minimum, maximum, average, median, and total gigabytes billed.
Minimum, maximum, average, median, and total slot utilization in hours.


Relevant google documentation related to the main datasource INFORMATION_SCHEMA.INFORMATION_SCHEMA.JOBS : https://cloud.google.com/bigquery/docs/information-schema-jobs

SLOTS RESERVATIONS
This query shows all existing reservations and editions.

Relevant google documentation related to the main datasource INFORMATION_SCHEMA.RESERVATIONS : https://cloud.google.com/bigquery/docs/information-schema-reservations


USER DEFINED PROCEDURES
This query shows all the existing user defined functions.

Relevant google documentation related to the main datasource INFORMATION_SCHEMA.ROUTINES : 
https://cloud.google.com/bigquery/docs/routines#sql_1


COUNT USER DEFINED FUNCTIONS AND PROCEDURES
This query shows the number of user defined functions and procedures and uses additional dimension - routine_type to show the type (language used) of the routine.

