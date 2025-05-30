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