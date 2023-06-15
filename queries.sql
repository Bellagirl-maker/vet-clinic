SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT del_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT del_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name AS animal, owners.full_name AS owner_name
FROM animals JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell'
  AND s.name = 'Digimon';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester'
  AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- queries for join-tables
 SELECT a.name AS last_animal_seen
 FROM animals a
 JOIN visits v ON a.id = v.animal_id
 WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
 ORDER BY v.visit_date DESC
 LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits v
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

 SELECT v.name AS vet, s.name AS specialty
 FROM vets v LEFT JOIN specializations spec
 ON v.id = spec.vet_id
 LEFT JOIN species s ON s.id = spec.species_id;

 SELECT a.name
 FROM animals a
 JOIN visits v ON a.id = v.animal_id
 WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')   
 AND v.visit_date >= '2020-04-01'
 AND v.visit_date <= '2020-08-30';

SELECT a.name, COUNT(*) AS most_visits
FROM animals a JOIN visits vs
ON a.id = vs.animal_id
WHERE a.id = (
SELECT animal_id FROM visits GROUP BY animal_id ORDER BY COUNT(*) DESC LIMIT 1 ) GROUP BY a.name;

SELECT a.name AS first_visit
FROM animals a
JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY v.visit_date
LIMIT 1;

 SELECT * FROM animals
 FULL JOIN visits
 ON animals.id = visits.animal_id
 FULL JOIN vets
 ON vets.id = visits.vet_id
 WHERE visits.visit_date = (
 SELECT MAX(visit_date) from visits
 );

 SELECT (COUNT(*) -
 ( SELECT COUNT(*)
 FROM visits vs JOIN specializations spec ON vs.vet_id = spec.vet_id
 JOIN animals a ON a.species_id = spec.species_id AND vs.animal_id = a.id )
 ) AS visits FROM visits;

SELECT COUNT(*), s.name
FROM visits vs JOIN animals a ON a.id = vs.animal_id
JOIN species s ON a.species_id = s.id
WHERE vs.vet_id = 2
GROUP BY s.name
ORDER BY COUNT(*) DESC LIMIT 1;
 
  

