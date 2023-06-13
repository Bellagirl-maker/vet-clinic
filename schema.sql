 CREATE TABLE animals (
 id int GENERATED ALWAYS AS IDENTITY,
 name varchar (50),
 date_of_birth date,
 escape_attempts INTEGER,
 neutered boolean,
 weight_kg decimal,
 primary key(id)
 );
 
 ALTER TABLE animals ADD COLUMN species VARCHAR(50);
