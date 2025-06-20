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
6) concat(): to build words that include accented characters( ex in chap 3) or append additional character to stored strings using UPDATE
 	ex: UPDATE table_name
 		SET column_name = CONCAT(column_name, 'but now it is longer')
 7) insert() to add or replace characters in the middle of a string. it has 4 arguments: 
 	A) original string
 	B) position at which to start
 	C) number of characters to replace: it allows to insert (with a C=0) or replace
 	D) replacement string
	
	exs: SELECT INSERT('goodbye world', 9, 0,'cruel') --> 'goodbye cruel world'
		 SELECT INSERT('goodbye world', 1, 7, 'hello') --> 'hello world' 

 8) substring('str1', position where to start to extract, number of caracters to extract)  to extract a substring from  a string
 	
 	ex: SELECT SUBSTRING('goodbye cruel world', 9, 5) --> 'cruel'
 	
Working with numeric data

Controlling number precision:
1) ceil() to round up to the closest integer. ex:CEIL(72.000001) --> 73
2) floor() to round down to the closest integer ex: FLOOR( 72.99999) --> 72
3) round(number, quantity of decimals i want) ex: ROUND(72.0909, 1) --> 72.1 
4) truncate(number, quantity of decimals i want) BUT without rounding, ex: TRUNCATE(72.0909, 1) --> 72.0

 3 y 4 allows negative 2nd parameter, it means round(17, -1) --> 20 ,while truncate(17, -1) --> 10. its useful to sell products in packs.
 
 Handling Signed Data
 
 UNSIGNED means that is not allowed to work with NEGATIVE NUMBERS
 
 sign(column) to return in a new column : 1 (if the column has positive number), 0 ( if the number is zero) or -1 (negative number)
 abs(column) to return in a new column the absolute number of each row (without sign) 
 
 Working with Temporal Data
 
 A) Dealing with Time Zones (24 imaginary sections :P)
 
GMT: 'Greewich Mean Time', the zero is in England.. 
UTC: 'Coordinated Universal Time', based on an atomic clock (or to be more precise, average time of 200 atomic clocks in 50 locationss worldwide.

my SQL has 2 modes settings: @@session.time_zone and @@global.time_zone --> 'SYSTEM' value tells that server is using time zone setting from server 
on which the database resides. 
    
 So, it cloud be change if the database is in NY for example, by:
 SET time_zone = 'Europe/Zurich';
 
 types:
 
 		date : YYYY-MM-DD
 
	 	datetime: YYYY-MM-DD HH:MM:SS
 
 		timestamp: YYYY-MM-DD HH:MM:SS
 
 		time: YYYY-MM-DD HHH:MM:SS
 
 To add a datetime, you can insert and string as 'YYYY-MM-DD HH:MM:SS' and server will convert it automatically.
 
 **String To Date Convertions
 
 cast('value in str form' AS TYPE (I will to convert)),moreover if any nonnumerica character are found in the string(a letter), 
 the conversion halts without an error and return only the number, exs:
 
 SELECT CAST('2009-09-17 15:30:00' AS DATETIME); ---> 2009-09-17 15:30:00
 
 SELECT CAST('2009-09-17  AS DATE) date_fields,
 		CAST('15:30:00' AS TIME) time_fields;     
 		
 ** Functions to generate dates

str_to_date(string, define the format to convert: see 'Table 7-4'): if data is not in correct format to use CAST(), ex:

 	UPDATE rental
 	SET return_date = STR_TO_DATE('September q7, 2019', '%M %d %y')
 	WHERE rental =99999;
 	
current() to return the SYSTEM clock: CURRENT_DATE() / CURRENT_TIME() /CURRENT_TIMESTAMP() 	  
 
 ** Temporal functions that return dates
 
 date_add() --> allows to add any kind of interval (ex: days, months, years) to a specified date to generate to another date
 
 				ex: SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAYS) .. for the 2nd argument, see Table 7-5 'Common interval types' 
 
 last_day() to find the last day of month, always return a DATE , ex: SELECT LAST_DAY('2019-09-17') --> 2019-09-30 . its very useful for february ajaj
 
 ** Temporal functions that return strings:

 dayname() to determine which day of the week a crtain date falls on
				ex: SELECT DAYNAME('2019-09-18') --> 'Wednesday'

extract() its a general way to extract info from a date.
				ex: SELECT EXTRACT(YEAR FROM '2019-09-18 22:19:05') ---> '2019'

** Temporal functions that return numbers

datediff() to determine the number of full interval between 2 dates (could be days, months or years). This function ignores the time of day
			in its arguments. Even if they are included, setting it to one second until midnight for the 1st date and to one second after 
			midnight for the 2nd date, those times will have no effect on the calculation. changing the arg will give a negative number(-74)
				ex: SELECT DATEDIFF('2019-09-18', '2019-06-21') ---> 74

**Test you knowledge**

Exercise 7-1

Write a query that returns the 17th through 25th characters of the string 'Please find the substring in this string'

SELECT SUBSTRING('Please find the substring in this string', 17, 9) --> 'substring'

Exercise 7-2

Write a query that returns the absolute value and sing(-1, 0 or 1) of the number  -25.76823. Also return the number rounded to the nearest
hundredth

SELECT ABS(-25.76823),
	   SIGN(-25.76823),
	   ROUND(-25.76823, 2)

Exercise 7-3

Write a query to return just the month portion of the current date

SELECT MONTH(CURRENT_DATE()) --->6

it also csn be use EXTRACT(MONTH FROM CURRENT_DATE())
