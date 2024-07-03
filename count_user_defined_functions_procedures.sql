-----------------COUNT USER DEFINED FUNCTIONS AND PROCEDURES-----------------START


select
  routine_type,
  routine_body,
  count(*)
 from `{projectId}.region-us.INFORMATION_SCHEMA.ROUTINES`
 group by routine_type, routine_body


-----------------COUNT USER DEFINED FUNCTIONS AND PROCEDURES-----------------END
