 CREATE TABLE animals (
 id int GENERATED ALWAYS AS IDENTITY,
 name varchar (50),
 date_of_birth date,
 neutered boolean,
 weight_kg decimal,
 primary key(id)
 );
