--1. Write a query that returns a list of all the unique values in the 'country' field.
SELECT DISTINCT country
FROM ksprojects; 

--2. How many unique values are there for the main_category field? What about for the category field?
--The answer is: 15 and 158. 
SELECT COUNT(DISTINCT main_category), COUNT(DISTINCT category)
FROM ksprojects; 

--3. Get a list of all the unique combinations of main_category and category fields, sorted A to Z by main_category.
SELECT DISTINCT main_category, category 
FROM ksprojects
ORDER BY main_category; 

--4. How many unique categories are in each main_category?
SELECT COUNT(DISTINCT category) AS number_unique_category, main_category
FROM ksprojects 
GROUP BY main_category; 

--5. Write a query that returns the average number of backers per main_category, rounded to the nearest whole number and sorted from high to low.
SELECT ROUND(AVG(backers), 0) AS avg_backers, main_category
FROM ksprojects
GROUP BY main_category
ORDER BY avg_backers DESC; 

--6. Write a query that shows, for each category, how many campaigns were successful and the average difference per project between dollars pledged and the goal.
SELECT category, COUNT(*), AVG(usd_pledged-goal) AS avg_diff
FROM ksprojects
GROUP BY category, state
HAVING state='successful'; 

--7. Write a query that shows, for each main category, how many projects had zero backers for that category and the largest goal amount for that category (also for projects with zero backers).
SELECT main_category, COUNT(*)
FROM ksprojects
GROUP BY main_category, backers, goal
HAVING backers=0 AND goal=MAX(goal);

--8. For each category, find the average USD per backer, and return only those results for which the average USD per backer is < $50, sorted high to low. Hint: Division by NULL is not possible, so use NULLIF to replace NULLs with 0 in the average calculation.
SELECT main_category, AVG(usd_pledged/NULLIF(backers,0)) AS avg_usd_per_backer
FROM ksprojects
GROUP BY main_category
HAVING AVG(usd_pledged/NULLIF(backers,0)) < 50
ORDER BY avg_usd_per_backer DESC; 

--9. Write a query that shows, for each main_category, how many successful projects had between 5 and 10 backers.
SELECT main_category, COUNT(*)
FROM ksprojects
GROUP BY main_category, state, backers
HAVING state='successful' AND backers IN (5,10); 

--10. Get a total of the amount ‘pledged’ for each type of currency grouped by its respective currency. Sort by ‘pledged’ from high to low.
SELECT currency, SUM(pledged) as total_pledged
FROM ksprojects 
GROUP BY currency
ORDER BY total_pledged DESC; 

--11. Excluding Games and Technology records in the main_category field, return the total of all backers for successful projects by main_category where the total was more than 100,000. Sort by main_category from A to Z.
SELECT main_category, SUM(backers) AS total_backers
FROM ksprojects
WHERE main_category NOT IN ('games', 'technology')
GROUP BY main_category, state 
HAVING state='successful' AND SUM(backers)>100000
ORDER BY main_category; 