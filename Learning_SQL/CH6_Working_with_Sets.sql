USE sakila;

/*
The Union and Union all Operators
it allows to combine multiple data sets
difference: union--> sorts combined dataset and removes duplicates.
rows(union all) = rows(datasetA) + rows (datasetB)
*/
SELECT 
	'CUST' typ, #to show that comes from the customer table
	c.first_name ,
	c.last_name 
FROM customer c 	
UNION ALL (SELECT 
				'ACTR' typ, #to show that comes from the actor table
				a.first_name, 
				a.last_name 
			FROM actor a);
 
 /*
Other Operators:
-- intersect 
-- except
*/

/*Test You Knowledge

Exercise 6-1
If setA = {L M N O P}
   setB = {P Q R S T}
What sets are generated? by:

*)A  UNION  B ={L M N O P Q R S T}
*)A  UNION ALL B = {L M N O P P Q R S T}
*)A INTERSECT B = {P} 
*) A EXCEPT B ={L M N O}


		
Exercise 6-2 Y 6-3 (IDEM 6-2 + sort by last name)
Write a compound query that finds the first and last names of all actors and customers 
whose last name starts with L
*/
SELECT a.first_name , a.last_name 
FROM actor a
WHERE a.last_name LIKE 'L%'
UNION ALL 
SELECT c.first_name, c.last_name
FROM customer c 
WHERE  c.last_name LIKE 'L%'
ORDER BY last_name; 
