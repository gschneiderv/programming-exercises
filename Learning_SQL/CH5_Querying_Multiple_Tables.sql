USE sakila;

/*
JOIN :by default is an INNER JOIN
*/
SELECT
	c.first_name,
	c.last_name,
	a.address 
FROM customer c  
INNER JOIN address a 
ON c.address_id = a.address_id; 

/*
Another way but it is just use in specific situations, 'USING' clause could be used to join the tables
*/
SELECT 
	c.first_name,
	c.last_name,
	a.address 
FROM customer c 
INNER JOIN address a 
USING (address_id);

/*
Two conditions: 1 is a join condition and 2 is a filter condition.
*/
SELECT 
	c.first_name,
	c.last_name,
	a.address 
FROM customer c 
	INNER JOIN address a 
	ON c.address_id = a.address_id 
WHERE a.postal_code = 52137;

/*
impo!! Join conditions is inside FROM clause!
Joining 3 tables: 2 join types and 2 subclauses in the FROM clause:
*/
SELECT
	c.first_name ,
	c.last_name ,
	a.address ,
	c2.city 
FROM customer c                     /*if I switch the tables in the joins conditions, the result will be the same.*/x
	INNER JOIN address a 
	ON c.address_id = a.address_id 
	INNER JOIN city c2 
	ON a.city_id = c2.city_id 
;	

/*
Using Subqueries as Tables (instead of joining several tables simultaneously)
The following query joins the customer table to a subquery nagainst the address and city tables:
*/
SELECT 
	c.first_name,
	c.last_name ,
	ad.address,
	ad.city
FROM customer c  
	INNER JOIN (SELECT a.address, a.address_id,  c2.city
				FROM address a  
					INNER JOIN city c2 
					ON a.city_id = c2.city_id 
				WHERE a.district = 'California')AS ad
	ON c.address_id = ad.address_id;

/*
Using the Same Table Twice
Ex: Find all of the films in which 2 specific actors appear:
*/
SELECT f.title
FROM film f 
	INNER JOIN film_actor fa 
	ON f.film_id = fa.film_id
	INNER JOIN actor a 
	ON fa.actor_id = a.actor_id 
WHERE ((a.first_name = 'CATE' AND a.last_name = 'MCQUEEN')
	OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH'));

/*
If I want both actors in the same films, I have to use the tables film_actor and actors twice:
*/
SELECT f.title
FROM film f 
	INNER JOIN film_actor fa1 
	ON f.film_id = fa1.film_id
	INNER JOIN actor a1 
	ON fa1.actor_id = a1.actor_id 
	INNER JOIN film_actor fa2 
	ON f.film_id = fa2.film_id
	INNER JOIN actor a2 
	ON fa2.actor_id = a2.actor_id
WHERE ((a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
	AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH'));

/*
Self Joins
see en ex3 how it works
*/
/*Test You Knowledge

Exercise 5-1

Fill in the blanks (<#>) for the following query to obtain the results that follow: 

SELECT 
	c.first_name,
	c.last_name,
	a.address,
	ct.city
FROM customer c
	INNER JOIN <1>
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = <2>
WHERE a.distric = 'California';
*/

SELECT 
	c.first_name,
	c.last_name,
	a.address,
	ct.city
FROM customer c
	INNER JOIN address a
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = ct.city_id 
WHERE a.district  = 'California';

/*
Exercise 5-2

Write a query that returns the title of every film in which an actor with the first name JOHN appeared
*/

SELECT f.title
FROM film f 
	INNER JOIN film_actor fa  
	ON f.film_id = fa.film_id 
	INNER JOIN actor a 
	ON fa.actor_id = a.actor_id 
WHERE a.first_name = 'JOHN';

/*
Exercise 5-3

Construct a query that returns all addresses that are in the same city. 
You will need to join the address table to itself, and each row should include 2 different addresses
*/

SELECT 
	a1.address add1,
	a2.address add2,
	a1.city_id 
FROM address a1
	INNER JOIN address a2
	ON a1.city_id = a2.city_id 
WHERE  a1.address < a2.address ;