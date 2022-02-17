/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon';

select * from animals where date_of_birth >= '2016-01-01' and date_of_birth <= '2019-12-31';

select name as Animals_NeuteredLessEscapeAttempts from animals where neutered = true and escape_attempts < 3;

select date_of_birth  from animals where name in ('Agumon', 'Pikachu');

select name, escape_attempts from animals where weight_kg > 10.5;

select * from animals where neutered = true;

select * from animals where name != 'Gabumon';

select * from animals where weight_kg >= 10.4 and weight_kg <= 17.3;

/* Second Milestone */

/* Inside a transaction update the animals table by setting the 
species column to unspecified. 
Verify that change was made. Then roll back the change and verify 
that species columns went back to the state before transaction. */
begin;
    UPDATE animals SET species = 'unspecified';
rollback;

select * from animals;

/* Inside a transaction:
    - Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
    - Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
    - Commit the transaction.
    - Verify that change was made and persists after commit.
*/
begin;
    UPDATE animals SET species = 'digimon' where name like '%mon';
    UPDATE animals SET species = 'pokemon' where name is null;
commit;

select * from animals;

/* Inside a transaction delete all records in the animals table,
then roll back the transaction. 
After the roll back verify if all records in the animals table 
still exist.
*/
begin;
    DELETE FROM animals;
rollback;

select * from animals;

/* Inside a transaction:
    - Delete all animals born after Jan 1st, 2022.
    - Create a savepoint for the transaction.
    - Update all animals' weight to be their weight multiplied by -1.
    - Rollback to the savepoint
    - Update all animals' weights that are negative to be their weight multiplied by -1.
    - Commit transaction
*/
begin;
    DELETE FROM animals where date_of_birth > '2022-01-01';
    SAVEPOINT DEL_ONEANIMAL;
    UPDATE animals set weight_kg = weight_kg * -1;
    rollback to DEL_ONEANIMAL;
    UPDATE animals set weight_kg = weight_kg * -1 where weight_kg = -weight_kg;
commit;

/* Queries */
/* How many animals are there? */
select count(*) as HowManyAnimals from animals;

/* How many animals have never tried to escape? */
select count(*) as NeverTried2Escape from animals where escape_attempts = 0;

/* What is the average weight of animals? */
select avg(weight_kg) as AverageWeight from animals;

/* Who escapes the most, neutered or not neutered animals? */
select case when neutered = true then 'Neutered' else 'Non Neutered' end as answer, sum(escape_attempts) as SumEscapeAttempts from animals group by neutered order by neutered desc limit 1;

/* What is the minimum and maximum weight of each type of animal? */
select species, min(weight_kg) as MinPokemonWeight, max(weight_kg) as MaxPokemonWeight from animals group by species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
select species, avg(escape_attempts) as AverageEscapeAttempts from animals where (date_of_birth >= '1990-01-01' and date_of_birth <= '2000-12-31') group by species;

/* Third Milestone */

/* What animals belong to Melody Pond? */
select animals.name as animals_name, owners.full_name as owner from animals join owners on animals.owner_id=owners.id where full_name='Melody Pond';
/* List of all animals that are pokemon (their type is Pokemon). */
select animals.name as animal_name, species.name as species_type from animals join species on animals.species_id=species.id where species.name='Pokemon';
/* List all owners and their animals, remember to include those that don't own any animal. */
select full_name as Owner, animals.name as Animal_Name from owners left join animals on animals.owner_id=owners.id;
/* How many animals are there per species? */
select species.name as species, COUNT(animals.name) from animals inner join species ON species_id = species.id GROUP BY species.name;
/* List all Digimon owned by Jennifer Orwell. */
select animals.name as Digimon_Name from animals join owners on animals.owner_id=owners.id where owners.full_name='Jennifer Orwell';
/* List all animals owned by Dean Winchester that haven't tried to escape. */
select full_name, name from animals inner join owners on owner_id = owners.id where owners.full_name = 'Dean Winchester' and escape_attempts = 0;
/* Who owns the most animals? */
select owners.full_name as OwnsMostAnimals, COUNT(animals.name) as total_animals from owners join animals on animals.owner_id=owners.id group by owners.full_name order by total_animals desc;

/* Fourth Milestone*/

/* Who was the last animal seen by William Tatcher? */
select
  animals.name as animal,
  date_of_visit as date
from visits
inner join animals on animal_id = animals.id
where
date_of_visit = (
  select
    MAX(date_of_visit)
  from visits
  inner join vets on vet_id = vets.id
  where vets.name = 'William Thatcher'
);
/* How many different animals did Stephanie Mendez see? */
select
  animals.name as animal,
  count(animal_id) as visits
from visits
inner join vets on vet_id = vets.id
inner join animals on animal_id = animals.id
where vets.name = 'Stephanie Mendez'
group by animals.name;
/* List all vets and their specialties, including vets with no specialties. */
select
  vets.name as vet,
  species.name as specialty
from  specializations
right join vets on vet_id = vets.id
left join species on species_id = species.id;
/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
select
  animals.name,
  visits.date_of_visit
from
  visits
inner join animals on animals.id = animal_id
inner join vets on visits.vet_id = vets.id
where date_of_visit between '2020-04-01' and '2020-08-30'
and vets.name = 'Stephanie Mendez';
/* What animal has the most visits to vets? */
select
  animals.name as animal,
  count(animal_id) as visits
from visits
inner join animals on animal_id = animals.id
group by animals.name
order by visits desc;
/* Who was Maisy Smith's first visit? */
select
  animals.name as animal,
  date_of_visit as date
from visits
inner join animals
  on animal_id = animals.id
where
date_of_visit = (
  select
    MIN(date_of_visit)
  from visits
  inner join vets on vet_id = vets.id
  where vets.name = 'Maisy Smith');
/* Details for most recent visit: animal information, vet information, and date of visit. */
select
  a.id,
  a.name,
  a.date_of_birth,
  a.escape_attempts,
  a.neutered,
  a.weight_kg,
  s.name as species,
  o.full_name as owner,
  o.age as owner_age,
  v.name as vet,
  v.age as vet_age,
  v.date_of_graduation as vet_graduation_date,
  date_of_visit
from visits
inner join animals a on animal_id = a.id
inner join vets v on vet_id = v.id
inner join owners o on a.owner_id = o.id
inner join species s on a.species_id = s.id
where
date_of_visit = (
  select
    MAX(date_of_visit)
  from visits
  inner join vets on vet_id = vets.id
);
/* How many visits were with a vet that did not specialize in that animal's species? */
select
  count(*)
from
  vets ve
inner join visits vi on vi.vet_id = ve.id
inner join animals an on an.id = vi.animal_id
left join specializations sp on sp.vet_id = ve.id
where
an.species_id != sp.species_id
and ve.name != 'Stephanie Mendez'
or ve.name = 'Maisy Smith';
/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
select
  species.name as species,
  count(date_of_visit) as visits
from visits
inner join animals on  visits.animal_id = animals.id
inner join species on animals.species_id = species.id
inner join vets on visits.vet_id = vets.id
where vets.name = 'Maisy Smith'
group by species.name;