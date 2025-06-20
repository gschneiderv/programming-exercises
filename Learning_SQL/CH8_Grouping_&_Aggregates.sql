USE sakila;

/*
Group by clause to group the rental data by customer ID (distinct) and countt how many films each customer rented
*/
SELECT 
	customer_id,
	COUNT(rental_id) 
FROM rental r 
GROUP BY customer_id; 
