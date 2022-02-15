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
