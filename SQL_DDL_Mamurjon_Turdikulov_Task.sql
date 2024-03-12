-- 1. Create the physical database with an appropriate domain-related name
CREATE DATABASE my_domain_database;

-- 2. Switch to the newly created database
\c my_domain_database;

-- 3. Create tables based on the 3NF model developed during the DB Basics module
CREATE SCHEMA my_schema;
SET search_path TO my_schema;

-- Create Table: Person
CREATE TABLE Person (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    date_of_birth DATE CHECK (date_of_birth > '2000-01-01'),
    record_ts TIMESTAMP DEFAULT CURRENT_DATE
);

-- Create Table: Address
CREATE TABLE Address (
    address_id SERIAL PRIMARY KEY,
    person_id INT REFERENCES Person(person_id),
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    record_ts TIMESTAMP DEFAULT CURRENT_DATE
);

-- 4. Create relationships between tables using primary and foreign keys
-- This was done in the table creation step.

-- 5. Apply check constraints across the tables
-- Date constraint on Person table already applied in table creation
-- Unique constraint on email in Email table
ALTER TABLE Person ADD CONSTRAINT unique_email UNIQUE (email);

-- 6. Populate the tables with sample data
INSERT INTO Person (first_name, last_name, gender, date_of_birth) VALUES
    ('John', 'Doe', 'M', '1985-05-10'),
    ('Jane', 'Smith', 'F', '1990-12-15');

INSERT INTO Address (person_id, street, city, state, zip_code) VALUES
    (1, '123 Main St', 'Anytown', 'NY', '12345'),
    (2, '456 Oak Ave', 'Somewhere', 'CA', '67890');

-- 7. Add 'record_ts' field to each table using ALTER TABLE statements
ALTER TABLE Person ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_DATE;
ALTER TABLE Address ADD COLUMN record_ts TIMESTAMP DEFAULT CURRENT_DATE;

-- Check to make sure the value has been set for the existing rows
-- No action needed as the default value is already set.

-- Optionally, display the tables to verify
SELECT * FROM Person;
SELECT * FROM Address;
