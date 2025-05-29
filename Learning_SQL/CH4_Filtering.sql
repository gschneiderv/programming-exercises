USE sakila;

/*Multiple Conditions evaluation (using logical operators as 'or', 'and', 'not', etc..)

# Building a condition
#A condition is made up of one or more expressions combined with one or more operators. 
#-->An expression can be any of the following:
#A number
#A column in a tabler or a view.
#A string literal, such as 'Maple Street'
#A built-in functionm, such as concat('Learning', ' ', 'SQL')
#A subquery
#A list of expressions, such as ('Boston', 'New York', 'Chicago')

#--> The operator used within conditions include:
# Comparision operators, such as =,!=, <, >, <>, like, in, between
# Arithmetic operators, such as +, -, *, /

#--Equality conditions: 'column = expression' . Ex: in a JOIN ON or within  the  WHERE clause
#--Inequality conditions: 'column <> expression'. EX: in WHERE clause filter for a limit number.
#These both conditions are usually used when modifying data. 
#ex: lets say that the movie rental company has a policy of removing old account rows once per a year. the task is to remove the rows
# from the rental table was in 2004:
*/
DELETE FROM rental r
WHERE year(rental_date) = 2004;

/*ex2: remove any rows where the rental date was not  in 2005 or 2006: */

DELETE FROM rental r
where year(rental_date)<> 2005 or year(rental_date) <> 2006;

/*
Range conditions: with < > or ('BETWEEN', 'AND') with 2 separate conditions which first cond has to be the lower limit and 2nd the upper one. 
both limits are inclusive. If I not put the date() function it just will return until 2005-06-16 00:00:00, which means (688-364),almost half of the rows.
*/
SELECT customer_id ,
		rental_date
FROM rental r
WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16';

/*
BETWEEN , AND: can be used with strings, for ex: if you want to search customers whose last name are between 'FA' and 'FR'
*/
SELECT 
	last_name ,
	first_name  
FROM customer c 
WHERE last_name BETWEEN 'FA' AND 'FRZ'; # Addinf 'Z' will ensure all last name that beggins with 'FR' are included
 
/
*Membership conditions
#'IN'operator can be used instead of 2 conditions separated with an 'or' operator:
*/
SELECT 
	title,
	rating 
FROM film f
WHERE rating IN ('G', 'PG');

/*
Subqueries
EX: suppoding that all films in which title have 'PET' string, it means a film would be safe for family viewing. Is it possible to execute 
a sunquery against the film table to retrieve all ratings associated with these films and the retrieve all films having any of these ratings:
*/
SELECT title ,
	rating
FROM film f 
WHERE rating IN (SELECT rating  FROM film f WHERE title LIKE '%PET%');

/*
'NOT IN' could be use as the same way of obtain the 372 rows but the range would be ('PG-13', 'R', 'NC-17')
*/

/*
Matching conditions:
ex:find all customers whose last name begins with 'Q'
*/
SELECT last_name,
	first_name 
FROM customer c 
WHERE LEFT(last_name, 1) = 'Q';

/*
LEFT is called 'built-in function'
*/

/*
Using Wildcards characters (_ ,%) to identify partial string matches. It is use with 'LIKE' operator.
 _ : exactly 1 character ; % : Any numberof characters (including 0)
*/
SELECT last_name ,
	first_name 
FROM customer  
WHERE last_name LIKE '_A_T%S';

SELECT last_name ,
	first_name 
FROM customer c 
WHERE last_name LIKE 'Y%' or last_name LIKE '%M' or last_name LIKE '%AS%';

/*
Regular expressions 
Ex: Find all teh customers whose last name starts with Q or Y
*/
SELECT last_name ,
		first_name 
FROM customer c 
WHERE last_name REGEXP '^[QY]';

/*
NULL
Remember!
--> An expression can BE null, but it can never EQUAL null.
--> Two nulls are never equal to each other.

ex: Find all films that were never returned.
*/
SELECT rental_id ,
		customer_id 
FROM rental r 
WHERE return_date IS NULL;  

/*
Also, 'IS NOT NULL' operator can be used, in this example to find all the fims returned.
*/
SELECT 
	rental_id ,
	customer_id ,
	return_date 
FROM rental r  
WHERE return_date IS NULL OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01'; 
