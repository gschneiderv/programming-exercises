DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS favorite_food;
#I will define a table to hold information about a person

# STEP 1: 'Design'
#discuss: types of info that describes a person: Name, Eye Color, Birth date, Address, Favorite Foods

#STEP 2: 'Refinement'
#objetive: NORMALIZATION to ensure that there are no duplicates(other than FK) or compound coloumns in the database design
#			define primary key(PK): person_id   ---> it guarantees uniqueness and will be the foreign key(FK) in the favourite_table

#STEP 3: 'Building SQL Schema Statements'

CREATE TABLE person
(person_id SMALLINT UNSIGNED,
 fname VARCHAR(20),
 lname VARCHAR(20),
 eye_color ENUM('BR','BL','GR'),
 birth_date DATE,
 street VARCHAR(20),
 city VARCHAR(20),
 state VARCHAR(20),
 country VARCHAR(20),
 postal_code VARCHAR(20),
 CONSTRAINT pk_person PRIMARY KEY (person_id)
);
# IMP! NULL: could be 'Not applicable'/ 'Unknown'/ 'Empty set' 

# to make sure the new table exists, use the "describe" command to see the table:
desc person;

#Now I create favorite_food table (because a person could have more than one favorite food), FK will be importante to relationate both tables
CREATE TABLE favorite_food
(person_id SMALLINT UNSIGNED,
 food VARCHAR(20),
 CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
 CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
 REFERENCES person (person_id)
 );

#IMP! 1)this table has a 'two columns'primary key: (person_id, food) 
#	  2) contains the values of the person_id column in the favorite_food table to include only values found in the person table. (FK)


#PK: it's better to use the 'autoincrement' feature (it will appear in the 'Extra' column. So, I will ALTER the table, BUT atte!! 
#first I need to disable de FK constraint on the favorite_table and the  re-enable the constraints when finished:
set foreign_key_checks = 0;
ALTER TABLE person 
MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
set foreign_key_checks =1;

DESC person;

#INSERTING DATA

INSERT INTO person
	(person_id, fname, lname, eye_color, birth_date)
VALUES (null, 'William', 'Turner', 'BR', '1972-05-27');
#To see the data just added:
SELECT person_id,
	   fname,
	   lname,
	   eye_color,
	   birth_date
FROM person;
WHERE person_id = 1;
 #it also coul be WHERE lname ='Turner';

 
 # NOTE: birth_date added is a string, al long as I match the required format, MySQL will convert the string to a date. 

#'William Turner has 3 favorite foods' so:

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'pizza'),
	   (1, 'cookies'),
	   (1, 'nachos');

 #to check, using ORDER BY clause to tell the server how to sort the data returned by the query:
SELECT	person_id ,
		food 
FROM favorite_food ff  
WHERE person_id = 1
ORDER BY food;

#Add othe person:
INSERT INTO person
	(person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
VALUES (null, 'Susan', 'Smith', 'BL', '1975-11-02', '23 Mapple St.', 'Arlinton', 'VA', 'USA', '20220');

#To see the data just added:
SELECT person_id,
	   fname,
	   lname,
	   eye_color,
	   birth_date,
	   street,
	   city,
	   state,
	   country,
	   postal_code
FROM person;

#Updating data for person_id =1 ('William'), using upsTE command

UPDATE person 
SET street = '1225 Tremont St.',
	city = 'Boston',
	state = 'MA',
	country = 'USA', 
	postal_code  = '02138'
WHERE person_id = 1;

# NOTE:  I could update more than one row, using: WHERE person_id < 10

#Deleting data (ex: person #2)

DELETE FROM person 
WHERE person_id = 2;

#NOTE: more than 1 row could be deteled using WHERE clause, and all rows could be deleted if the WHERE clause is omitted.

#COMMON MISTAKES:
# Nonunique PK : this error could appear if a write a number for the 'person_id' column that is repeated.
# Nonexisting FK: you can't insert a number of person_id in favorite_table that doesn't exist in person table. 
# Column Value Violations: if a column is restricted to some values, you can't insert a differente that is not an option (ex: color_eyes)
# Invalid Date conversions: you can't write a string (a date) which is not in the format expected, ex: in birth_date will not match 'DEC-21-1980'
# But, you can use str_to_date function to specify which format string to use:
UPDATE person
SET birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
WHERE person_id =1; 


