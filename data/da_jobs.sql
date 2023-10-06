-- 1.	How many rows are in the data_analyst_jobs table?
SELECT COUNT (*)
FROM data_analyst_jobs;

--a: 1793

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT * 
FROM  data_analyst_jobs
LIMIT 10;


--a: ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';

--a: 21

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN' 
OR location = 'KY';

--a: 27

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT COUNT(title)
FROM data_analyst_jobs
WHERE location = 'TN' 
	AND star_rating > 4;
	
--a: 3

-- 5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT (*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--a: 151

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY state
ORDER BY avg_rating DESC;
 
 --a: NE 4.19999

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT (DISTINCT title)
FROM data_analyst_jobs;

--a: 881

-- 8.	How many unique job titles are there for California companies?
SELECT COUNT (DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

--a: 230

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, AVG(star_rating) AS avg_star_rating, review_count as total_reviews
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
	AND company IS NOT NULL
	AND review_count > 5000
GROUP BY company;
	
--a: 40

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, AVG(star_rating) AS avg_star_rating, review_count as total_reviews
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
	AND company IS NOT NULL
	AND review_count > 5000
GROUP BY company
ORDER BY avg_star_rating DESC;

--a: 6 way tie???

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT title
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

--a: 1636

SELECT COUNT (DISTINCT title)
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

--a: 754

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT LIKE '%_nalyst%'
	AND title NOT LIKE '%_nalytics%'
	AND title NOT LIKE '%ANALYST%'
	AND title NOT LIKE '%ANALYTICS%';

--a: 4. They contain the word Tableau

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 

SELECT COUNT(DISTINCT title) AS job_count, domain AS industry
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND skill LIKE '%SQL%'
GROUP BY domain;

--  - Disregard any postings where the domain is NULL. 
SELECT COUNT(DISTINCT title) AS job_count, domain AS industry
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND skill LIKE '%SQL%'
	AND domain IS NOT NULL
GROUP BY domain;

--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
SELECT COUNT(DISTINCT title) AS job_count, domain AS industry
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND skill LIKE '%SQL%'
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY job_count DESC;

--   - Which 4 industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

--a: 
-- 42	"Internet and Software"
-- 40	"Health Care"
-- 38	"Banks and Financial Services"
-- 31	"Consulting and Business Services"

--what are those Retail jobs? 
SELECT *
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND skill LIKE '%SQL%'
	AND domain = 'Retail';