/* 
Question : What are the top -paying data analyst jobs?
- Identify the top 10 highest paying Data Analyst roles that are available remotly
-- Focuses on job postings with specified salaries(remove nulls).
-- Why? Highlight the top paying opportunities for data analysts offering insights with company name
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    company_info.name
FROM
   job_postings_fact
LEFT JOIN company_dim AS company_info ON job_postings_fact.company_id = company_info.company_id
WHERE job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10

