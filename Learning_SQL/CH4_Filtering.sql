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
