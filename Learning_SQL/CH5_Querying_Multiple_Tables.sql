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
