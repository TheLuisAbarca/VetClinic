/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id              INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name            VARCHAR(255) NOT NULL,
    date_of_birth   DATE NOT NULL,
    escape_attempts INT DEFAULT 0,
    neutered        BOOLEAN DEFAULT FALSE,
    weight_kg       DECIMAL(5,2) NOT NULL
);

/* Second Milestone */

/* Add a column species of type string to your animals table. */
ALTER TABLE animals ADD species varchar(40) null;

/* Third Milestone */
/*
Create a table named owners with the following columns:
    id: integer (set it as autoincremented PRIMARY KEY)
    full_name: string
    age: integer
*/
CREATE TABLE owners(
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(40) NOT NULL,
  age INT NOT NULL
);
/* 
Create a table named owners with the following columns:
    id: integer (set it as autoincremented PRIMARY KEY)
    full_name: string
    age: integer
*/
CREATE TABLE species(
  id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL
);

/* 
Modify animals table:
    Make sure that id is set as autoincremented PRIMARY KEY
    Remove column species
    Add column species_id which is a foreign key referencing species table
    Add column owner_id which is a foreign key referencing the owners table
*/
alter table animals drop column id;
alter table animals add column id SERIAL PRIMARY KEY;
alter table animals drop column species;
alter table animals add column species_id INT,
add constraint species_id_fk foreign key (species_id)
references species(id);

alter table animals add column owner_id INT,
add constraint owner_id_fk foreign key (owner_id)
references owners(id);

/* Fourth Milestone */

/* 
Create a table named vets with the following columns:
    id: integer (set it as autoincremented PRIMARY KEY)
    name: string
    age: integer
    date_of_graduation: date
*/
CREATE TABLE vets(
  id SERIAL PRIMARY KEY,
  name VARCHAR(40) not null,
  age int not null,
  date_of_graduation date not null
);

CREATE TABLE vets (
    id INT SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE,
);

/* 
Create a "join table" called 
specializations to handle this relationship.
*/
CREATE TABLE specializations (
    vet_id INT,
    species_id INT
);

/*
There is a many-to-many relationship between the tables 
species and vets: a vet can specialize in multiple species, 
and a species can have multiple vets specialized in it. 
*/
alter table specializations add constraint fk_vets
foreign key (vet_id) references vets(id);

alter table specializations add constraint fk_species
foreign key (species_id) references species(id);

/*
Create a "join table" called visits to handle this relationship, 
it should also keep track of the date of the visit.
*/
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE
);
/*
There is a many-to-many relationship between the tables animals
and vets: an animal can visit multiple vets and one vet can be 
visited by multiple animals. 
*/
alter table visits add constraint fk_animals
foreign key (animal_id) references animals(id);

alter table visits add constraint fk_vets
foreign key (vet_id) references vets(id);


/* Fifth Milestone - Normalization & Performance */
ALTER TABLE visits ADD COLUMN id SERIAL PRIMARY KEY;