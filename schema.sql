/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id              INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name            VARCHAR(255) NOT NULL,
    date_of_birth   DATE NOT NULL,
    escape_attempts INT DEFAULT 0,
    neutered        BOOLEAN DEFAULT FALSE,
    weight_kg       DECIMAL(5,2) NOT NULL
);
