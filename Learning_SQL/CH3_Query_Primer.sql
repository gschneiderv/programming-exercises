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

/*3) Temporary tables 
# these tables (volatile or temporary) look like permanent tables but any data inserted into a temporary table will disappear at some point
# (generally at the end of a transaction or when de DB session is closed): ex: show how actors whose last names start with 'J' can be 
#stored temporary:
 */  
CREATE TEMPORARY TABLE actors_J
 (actor_id smallint(5),
 first_name varchar(45),
 last_name varchar(45)
 );

INSERT INTO actors_J
(SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%');

/*To check info inserted: */
SELECT * 
FROM  actors_J;
/*imp: these 7 rows will disappear after the session is closed.*/

/*4) Views (is a "Virtual table")
def: a view is a query that is stored in the data dictionary. It looks and acts like a table but hasnt data associated. When you issue a query against a view, your query is merged with the view definition to create a final query to be executed:
ex: a view definition that queries the employee table and includes 4 of the available columns
So, why i need it? various reasons but for ex: to hide columns from users and to simplify complex database designs
*/
CREATE VIEW	 cust_vw AS
(SELECT customer_id,
		first_name,
		last_name,
		active
FROM customer);

SELECT first_name,
	last_name,
	active
FROM cust_vw 
WHERE active = 0;

/* Linking tables (JOIN), see Chapter 5 and 10, here an ex: */

SELECT c.first_name,
	c.last_name,
	time(r.rental_date) AS rental_time
FROM customer c
INNER JOIN rental r
ON  c.customer_id  = r. customer_id 
WHERE date(r.rental_date) = '2005-06-14';

/*GROUP BY and HAVING clauses , Chapter 8: full description
ex: Lets find all the customers who have rented 40 or more films. How to think it?
write a query that group all rentals by customer, count the number of rentals for each customer and then 
return  ONLY the customers whose rental_count >= 40 */

SELECT c.first_name,
	c.last_name,
	COUNT(r.customer_id) AS rental_count
FROM customer c
INNER JOIN rental r 
ON c.customer_id = r.customer_id 
GROUP BY c.first_name ,c.last_name  
HAVING rental_count >= 40;

/*ORDER BY..
it can be sorted by Ascending, descending or using a number refering the place where a column appear in the SELECT clause 
ex: */
SELECT c.first_name,
	c.last_name,
	time(r.rental_date) AS rental_time
FROM customer c
INNER JOIN rental r
ON  c.customer_id  = r. customer_id 
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 3 desc;

/*Test You Knowledge

#Exercise 3-1
# Retrieve the actor ID, first Name, and the last name for all actors. Sort by last name and then first name.
*/
SELECT 
	actor_id,	
	first_name,
	last_name
FROM actor a 
ORDER BY 3,2;

/*Exercise 3-2
Retrieve the actor ID, first Name, and the last name for all actors whose last name equals 'WILLIAMS' or  'DAVIS'.
*/
SELECT 
	actor_id,
	first_name,
	last_name 
FROM actor a 
WHERE last_name ='WILLIAMS' or last_name ='DAVIS';

/*Exercise 3-3
write a query against the rental table that returns the IDs of the customers who rented a film on July 5, 2005
(use the r.rental_date column, and you can use the date() function to ignore the time component)
Include a single row for each distinct customer ID
*/
SELECT DISTINCT customer_id 
FROM rental r
WHERE date(r.rental_date) = '2005-07-05'
ORDER BY 1 ;

/*Exercise 3-4
Fill the blanks for the multitable query to achieve the following results:
SELECT 
	c.email,
	r.return_date
FROM customer c 
INNER JOIN rental <1> 
ON c.customer_id  = <2>
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY <3> <4> ;
*/
SELECT 
	c.email,
	r.return_date 
FROM customer c 
INNER JOIN rental r 
ON c.customer_id  = r.customer_id 
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 2 DESC;