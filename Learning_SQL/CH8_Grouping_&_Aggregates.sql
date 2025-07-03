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

 The filter to use witH Goup by clause is 'HAVING'  and goes after Group by clause (not use WHERE clause, it will give you an error) 
*/
 SELECT  
 		customer_id,
		COUNT(*)
 FROM rental r
 GROUP BY 1
 HAVING COUNT(*) >=40;

/*
Aggregate functions:

max() --> returns the maximum within set, ignore nulls

min() --> returns the minimum value within set, ignore nulls

avg() --> returns the average value across a set, ignore nulls

sum() --> returns the sum of the value across a set

count() --> returns the number of values in a set, imp!! COUNT(*)--> not ignores the nulls, while COUNT(val) ignores nulls 

*/

SELECT 
	MAX(amount),
	MIN(amount),
	AVG(amount),
	SUM(amount),
	COUNT(amount)
FROM payment p ;

/*
if i want to apply to each customer: i have to use group by clause
With the inclusion of this clause the server knows to group together rows having the same value in the customer_id column first and then
apply the five aggregates functions
 */	
SELECT customer_id ,
	MAX(amount),
	MIN(amount),
	AVG(amount),
	SUM(amount),
	COUNT(amount)
FROM payment p 
GROUP BY customer_id ;

/* 
 Counting DISTINCT values
 
*/
SELECT 
	COUNT(customer_id) AS num_rows,
	COUNT(DISTINCT customer_id) AS num_customers
FROM payment p ;

/*
Using expressions

 Ex: Find the maximum number of days between when a film was rented and subsequently returned.
 */

SELECT 	
	MAX(DATEDIFF(return_date ,rental_date)) 
FROM rental r; 

/*
HOW NULLs are handled--> see def of fuctions above

Generating Groups --

Ex of common calculations:
** Generating totals for a geographic region(sales, ex)
** Finding outliers (ex: top salesperson for 2020)
** Determining frequencies, such as the number of films rented in each month

