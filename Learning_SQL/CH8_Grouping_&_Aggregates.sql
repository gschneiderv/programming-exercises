USE sakila;

/*
Group by clause to group the rental data by customer ID (distinct) and countt how many films each customer rented
*/
SELECT 
	customer_id,
	COUNT(rental_id) 
FROM rental r 
GROUP BY customer_id 
ORDER BY 2 DESC;

/*
Also can use COUNT(*), it means that count everything in the group.

 The filter to use wit Goup by clause is 'HAVING'  and goes after Group by clause (not use WHERE clause, it will give you an error) 
 
 
 */

