/* Populate database with sample data. */

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Gabumon', '2018-11-15', 2, true, 8.00);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Devimon', '2017-05-12', 5, true, 11);

/* Second Milestone */
/* Insert the following data:  */
INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Charmander', '2020-02-08', 0, false, -11);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Plantmon', '2022-11-15', 2, true, -5.7);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Squirtle', '1993-04-03', 3, false, -12.13);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Angemon', '2005-06-12', 1, true, -45);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);

INSERT INTO animals ("name", "date_of_birth", "escape_attempts", "neutered", "weight_kg")  
VALUES ('Blossom', '1998-10-13', 3, true, 17);

/* Third Milestone */

/*
Insert the following data into the owners table:
    Sam Smith 34 years old.
    Jennifer Orwell 19 years old.
    Bob 45 years old.
    Melody Pond 77 years old.
    Dean Winchester 14 years old.
    Jodie Whittaker 38 years old.
*/
INSERT INTO owners (full_name,age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name,age) VALUES ('Jennifer Orwell', 19); 
INSERT INTO owners (full_name,age) VALUES ('Bob', 45);
INSERT INTO owners (full_name,age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name,age) VALUES ('Dean Winchester', 14); 
INSERT INTO owners (full_name,age) VALUES ('Jodie Whittaker', 38);

/*
Insert the following data into the species table:
    Pokemon
    Digimon
*/
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/*
Modify your inserted animals so it includes the species_id value:
    If the name ends in "mon" it will be Digimon
    All other animals are Pokemon
*/
UPDATE animals SET species_id = 1 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 2 WHERE species_id IS NULL;

/*
Modify your inserted animals to include owner information (owner_id):
    Sam Smith owns Agumon.
    Jennifer Orwell owns Gabumon and Pikachu.
    Bob owns Devimon and Plantmon.
    Melody Pond owns Charmander, Squirtle, and Blossom.
    Dean Winchester owns Angemon and Boarmon.
*/
UPDATE animals SET owner_id=1 WHERE name='Agumon';
UPDATE animals SET owner_id=2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id=3 WHERE name IN ('Devimon','Plantmon');
UPDATE animals SET owner_id=4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id=5 WHERE name IN ('Angemon','Boarmon');

/* Fourth Milestone */
/*
Insert the following data for vets:
    Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
    Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
    Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
    Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
*/

insert into vets (name, age, date_of_graduation) values ('William Thatcher', 45, 'Apr 23, 2000');
insert into vets (name, age, date_of_graduation) values ('Maisy Smith', 26, 'Jan 17, 2019');
insert into vets (name, age, date_of_graduation) values ('Stephanie Mendez', 64, 'May 4, 1981');
insert into vets (name, age, date_of_graduation) values ('Jack Harkness', 38, 'Jun 8, 2008');

/* DATA SPECIALIZATIONS*/
/* Vet William Tatcher is specialized in Pokemon. */
insert into specializations (vet_id, species_id)
select
  vets.id,
  species.id
from
  vets,
  species
where
  vets.name = 'William Thatcher'
and
  species.name = 'Pokemon';

/* Vet Stephanie Mendez is specialized in Digimon and Pokemon. */
insert into specializations (vet_id, species_id)
select
  vets.id,
  species.id
from
  vets,
  species
where
  vets.name = 'Stephanie Mendez'
and
  species.name IN ('Pokemon', 'Digimon');

/* Vet Jack Harkness is specialized in Digimon. */
insert into specializations (vet_id, species_id)
select
  vets.id,
  species.id
from
  vets,
  species
where
  vets.name = 'Jack Harkness'
and
  species.name = 'Digimon';

/* DATA VISITS*/
/* Agumon visited William Tatcher on May 24th, 2020.*/
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-05-24'
from
  animals, vets
where
  animals.name = 'Agumon'
and
  vets.name = 'William Thatcher';

/* Agumon visited Stephanie Mendez on Jul 22th, 2020.*/
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-07-22'
from
  animals, vets
where
  animals.name = 'Agumon'
and
  vets.name = 'Stephanie Mendez';
/* Gabumon visited Jack Harkness on Feb 2nd, 2021. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2021-02-02'
from
  animals, vets
where
  animals.name = 'Gabumon'
and
  vets.name = 'Jack Harkness';
/* Pikachu visited Maisy Smith on Jan 5th, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-01-05'
from
  animals, vets
where
  animals.name = 'Pikachu'
and
  vets.name = 'Maisy Smith';
/* Pikachu visited Maisy Smith on Mar 8th, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-03-08'
from
  animals, vets
where
  animals.name = 'Pikachu'
and
  vets.name = 'Maisy Smith';
/* Pikachu visited Maisy Smith on May 14th, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-05-14'
from
  animals, vets
where
  animals.name = 'Pikachu'
and
  vets.name = 'Maisy Smith';
/* Devimon visited Stephanie Mendez on May 4th, 2021. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2021-05-04'
from
  animals, vets
where
  animals.name = 'Devimon'
and
  vets.name = 'Stephanie Mendez';
/* Charmander visited Jack Harkness on Feb 24th, 2021. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2021-02-24'
from
  animals, vets
where
  animals.name = 'Charmander'
and
  vets.name = 'Jack Harkness';

/* We have to insert again the digimon Plantmon*/
insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id)
values ('Plantmon', 'Nov 15, 2022', 2, TRUE, 5.7, 2, 3);

/* Plantmon visited Maisy Smith on Dec 21st, 2019. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2019-12-21'
from
  animals, vets
where
  animals.name = 'Plantmon'
and
  vets.name = 'Maisy Smith';
/* Plantmon visited William Tatcher on Aug 10th, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-08-10'
from
  animals, vets
where
  animals.name = 'Plantmon'
and
  vets.name = 'William Thatcher';
/* Plantmon visited Maisy Smith on Apr 7th, 2021. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2021-04-07'
from
  animals, vets
where
  animals.name = 'Plantmon'
and
  vets.name = 'Maisy Smith';
/* Squirtle visited Stephanie Mendez on Sep 29th, 2019. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2019-09-29'
from
  animals, vets
where
  animals.name = 'Squirtle'
and
  vets.name = 'Stephanie Mendez';
/* Angemon visited Jack Harkness on Oct 3rd, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-10-03'
from
  animals, vets
where
  animals.name = 'Angemon'
and
  vets.name = 'Jack Harkness';
/* Angemon visited Jack Harkness on Nov 4th, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-11-04'
from
  animals, vets
where
  animals.name = 'Angemon'
and
  vets.name = 'Jack Harkness';
/* Boarmon visited Maisy Smith on Jan 24th, 2019. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2019-01-24'
from
  animals, vets
where
  animals.name = 'Boarmon'
and
  vets.name = 'Maisy Smith';
/* Boarmon visited Maisy Smith on May 15th, 2019. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2019-05-15'
from
  animals, vets
where
  animals.name = 'Boarmon'
and
  vets.name = 'Maisy Smith';
/* Boarmon visited Maisy Smith on Feb 27th, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-02-27'
from
  animals, vets
where
  animals.name = 'Boarmon'
and
  vets.name = 'Maisy Smith';
/* Boarmon visited Maisy Smith on Aug 3rd, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-08-03'
from
  animals, vets
where
  animals.name = 'Boarmon'
and
  vets.name = 'Maisy Smith';
/* Blossom visited Stephanie Mendez on May 24th, 2020. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2020-05-24'
from
  animals, vets
where
  animals.name = 'Blossom'
and
  vets.name = 'Stephanie Mendez';
/* Blossom visited William Tatcher on Jan 11th, 2021. */
insert into visits (animal_id, vet_id, date_of_visit)
select
  animals.id,
  vets.id,
  '2021-01-11'
from
  animals, vets
where
  animals.name = 'Blossom'
and
  vets.name = 'William Thatcher';

-- Fifth Milestone

-- This command was executed 12 times to get the query run time over 1000ms
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This command was executed twice to get the query run time over 1000ms
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
