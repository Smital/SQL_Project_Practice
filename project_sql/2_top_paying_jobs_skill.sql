/* 
Question : What skills are required for the top- paying data analyst jobs?
-- Use the top 10 highest-paying data analyst jobs from first query
-- Add the specific skills required for those roles
-- Why? It provides a  detailed look at which high- paying jobs demand certain skills,
 helping job seekers understand which skills to develop that align with top salaries
*/

-- SELECT
--     jobs_info.job_id,
--     jobs_info.job_title,
--     jobs_info.job_location,
--     jobs_info.job_schedule_type,
--     jobs_info.salary_year_avg,
--     skill_to_job.skill_id,
--     skills_info.skills
-- FROM
--    job_postings_fact AS jobs_info
-- INNER JOIN skills_job_dim AS skill_to_job ON jobs_info.job_id = skill_to_job.job_id
-- INNER JOIN skills_dim AS skills_info ON skill_to_job.skill_id = skills_info.skill_id
-- WHERE job_title_short = 'Data Analyst' AND
--     job_location = 'Anywhere' AND
--     salary_year_avg IS NOT NULL
-- ORDER BY
--     salary_year_avg DESC
-- LIMIT 10

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        company_info.name AS company_name
    FROM
    job_postings_fact
    LEFT JOIN company_dim AS company_info ON job_postings_fact.company_id = company_info.company_id
    WHERE job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
     top_paying_jobs.*,
     skills 
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
      salary_year_avg DESC;

-- Key Insights
/*1. SQL is the #1 Skill
SQL appeared in every job posting (100%).
This confirms that SQL remains the most important skill for data analysts because it is used for:
Querying databases
Data extraction
Reporting
Data validation

2. Python is Nearly Essential
Python appeared in 87.5% of postings.
Most common Python-related skills:
Pandas
NumPy
Jupyter

3. Visualization Skills Are Highly Valued
Visualization tools appeared frequently:
Tableau (75%)
Power BI (25%)
Companies want analysts who can transform data into dashboards and business insights.

4. Cloud Skills Are Becoming Important
Cloud platforms appeared multiple times:
Azure
AWS
Snowflake
Databricks
This indicates that modern analysts increasingly work with cloud-based data warehouses and analytics platforms.

5. Traditional Excel Skills Still Matter
Excel appeared in 37.5% of postings.
Even with advanced tools, Excel remains important for:
Ad hoc analysis
Reporting
Business communication
*/