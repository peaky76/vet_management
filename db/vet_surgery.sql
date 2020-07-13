DROP TABLE IF EXISTS pet_treatments;
DROP TABLE IF EXISTS treatments;
DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS vets;

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    tel VARCHAR(255)
);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    addr_1 VARCHAR(255),
    addr_2 VARCHAR(255),
    town_city VARCHAR(255),
    postcode VARCHAR(255),
    email VARCHAR(255),
    tel VARCHAR(255),
    balance INT,
    registered BOOLEAN,
    marketing BOOLEAN
);

CREATE TABLE pets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    dob VARCHAR(255),
    type VARCHAR(255),
    notes TEXT,
    owner_id INT REFERENCES owners(id),
    vet_id INT REFERENCES vets(id)
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price NUMERIC(8,2)
);

CREATE TABLE pet_treatments (
    id SERIAL PRIMARY KEY,
    pet_id INT REFERENCES pets(id),
    treatment_id INT REFERENCES treatments(id),
    date VARCHAR(255)
)