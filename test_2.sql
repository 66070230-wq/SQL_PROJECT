select job_title_short,
company_id,
job_location
from january_jobs

UNION

SELECT job_title_short,
company_id,
job_location
from february_jobs

select job_title_short,
company_id,
job_location
FROM january_jobs

UNION ALL

SELECT job_title_short,
company_id,
job_location
from february_jobs

UNION ALL

SELECT job_title_short,
company_id,
job_location
FROM march_jobs


SELECT * from january_jobs

UNION ALL 

SELECT * FROM february_jobs

UNION ALL 

SELECT * FROM march_jobs

------------------------------------------------

SELECT job_title from january_jobs

UNION

SELECT job_title FROM february_jobs

UNION

SELECT job_title FROM march_jobs

------------------------------------------------------

SELECT job_location from january_jobs

UNION

SELECT job_location FROM february_jobs

UNION

SELECT job_location FROM march_jobs

---------------------------------------------

SELECT job_title_short,
job_title,
job_location
FROM january_jobs
WHERE job_title_short = 'Data Engineer'

UNION ALL

SELECT job_title_short,
job_title,
job_location
FROM february_jobs
WHERE job_title_short = 'Data Engineer'

UNION ALL

SELECT job_title_short,
job_title,
job_location
FROM march_jobs
WHERE job_title_short = 'Data Engineer'

------------------------------------------

SELECT 'January' as month_name,
count(job_id)
FROM january_jobs

UNION ALL

SELECT 'February' as month_name,
count(job_id)
FROM february_jobs

UNION ALL

SELECT 'March' as month_name,
count(job_id)
FROM march_jobs

------------------------------------------

SELECT job_title_short,
job_location,
'January' as source_month
FROM january_jobs
WHERE job_title_short like '%Data%'

UNION ALL

SELECT job_title_short,
job_location,
'February' as source_month
FROM february_jobs
WHERE job_title_short like '%Data%'

UNION ALL

SELECT job_title_short,
job_location,
'March' as source_month
FROM march_jobs
WHERE job_title_short like '%Data%'

-------------------------------------------------

SELECT 'January' as month_name,
count(job_id) as data_engineer_count
FROM january_jobs
WHERE job_title_short = 'Data Engineer'

UNION ALL

SELECT 'February' as month_name,
count(job_id) as data_engineer_count
FROM february_jobs
WHERE job_title_short = 'Data Engineer'

UNION ALL

SELECT 'March' as month_name,
count(job_id) as data_engineer_count
FROM march_jobs
WHERE job_title_short = 'Data Engineer'

---------------------------------------------------

SELECT distinct job_title_short,
job_location
FROM january_jobs

UNION

SELECT distinct job_title_short,
job_location
FROM february_jobs

UNION

SELECT distinct job_title_short,
job_location
FROM march_jobs

-------------------------------------------------

SELECT job_title_short,
job_title,
job_location,
'January' as source_month
FROM january_jobs
WHERE job_location IN ('New York', 'Seattle')

UNION ALL

SELECT job_title_short,
job_title,
job_location,
'February' as source_month
FROM february_jobs
WHERE job_location IN ('New York', 'Seattle')

UNION ALL

SELECT job_title_short,
job_title,
job_location,
'March' as source_month
FROM march_jobs
WHERE job_location IN ('New York', 'Seattle')
order by job_location

