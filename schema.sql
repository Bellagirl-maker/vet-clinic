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

CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	name VARCHAR(255),
	age INT,
	date_of_graduation date,
	PRIMARY KEY(id)
	);

CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets (id),
  species_id INTEGER REFERENCES species (id),
  PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
  vet_id INTEGER REFERENCES vets (id),
  animal_id INTEGER REFERENCES animals (id),
  visit_date DATE,
);


ALTER TABLE owners ADD COLUMN email VARCHAR(120);


CREATE INDEX visits_animal_id_idx ON visits (animal_id);
CREATE INDEX visits_vet_id_idx ON visits (vet_id);
CREATE INDEX owners_email_idx ON owners (email);






