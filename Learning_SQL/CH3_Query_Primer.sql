/*
Query clauses:
SELECT : Determines which columns to include in the query's result set
FROM: Identifies the tables from which to retrieve data and how the tables should be joined.
WHERE: Filters out unwanted data.
GROUP BY: Use to group rows together by common column values
HAVING: Filters out unwanted groups.
ORDER BY: Sorts the rows of the final result set by one or more columns
*/
/*Column Aliases*/
SELECT language_id, 
	'COMMON' AS language_usage,
	language_id * 3.1415927 AS lang_pi_value,
	UPPER(name) AS language_name 
FROM language;

/* Removing duplicates: using DISTINCT keyword after SELECT */

SELECT DISTINCT actor_id  
FROM film_actor fa 
ORDER BY actor_id;

/* 
NOTE: Generating a distinct set of results requires the data to be sorted, which can be time consuming for large result sets. 
	   Dont fall into the trap of using distinct just to be sure there are no duplicates; instead, take the time to undestand the data
	   you are working with so that you will know whether duplicates are possible.

TABLES (all types may be included in a query's FROM clause)
1) Permanent tables (created using CREATE TABLE statement)
2) Derived tables (subquery-generated within another query)
*/
SELECT 
    concat(cust.last_name,', ', cust.first_name) AS full_name
FROM 
    (SELECT first_name, 
    	last_name
    FROM customer
    WHERE first_name = 'JESSIE') AS cust;