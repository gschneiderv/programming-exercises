
#I will defineda table to hold information about a person

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


