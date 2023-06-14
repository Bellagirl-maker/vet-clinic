 CREATE TABLE animals (
 id int GENERATED ALWAYS AS IDENTITY,
 name varchar (50),
 date_of_birth date,
 escape_attempts INTEGER,
 neutered boolean,
 weight_kg decimal,
 );
 
 ALTER TABLE animals ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
full_name VARCHAR(255),
age INT,
PRIMARY KEY(id)
);

CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	name VARCHAR(255),
	PRIMARY KEY(id)
);

ALTER TABLE animals ADD PRIMARY KEY (id);
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

