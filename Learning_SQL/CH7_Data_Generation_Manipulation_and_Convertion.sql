USE sakila;

/*
Working with String Data

CHAR: values up 255 characters. Holds fixed-length, blank-padded strings.
VARCHAR: values up 65.535 characters. Holds variable-length strings.
TEXT: up 4GB in data size. Holds very large variable-length strings

there are 2 modes:
 *) 'strict mode'--> give an exception ('error') when number of characters is bigger than its max.
 *) 'ANSI mode' --> the string will be truncated when the lenght is bigger than the max.
 
A)String Manipulation

 2 types: functions that return numbers and those that returns strings
 
 1) length()
 2) position()to find the position at which the strin 'xx' appears in a column, locate() is similar but except that it allows an optional 3rd param
 	to define the search's start position.
 3) strcmp(str1, str2) to compare between 2 strings,result is: 
 			-1 if the str1 comes before the str2 in sort order
 			 0 if the strs are identical (str1=str2)
 			 1 if str1 comes after str2 in sort order
 4) LIKE could also be used to compare 2 strings in the SELECT clause, and it returns 0 (false) or 1 (true)
 5) REGEXP operator (ex:to retrieve all the category names along with an expression thata returns 1 if the names ends in 'y' or 0 otherwise).

and those that return strings:

 6)