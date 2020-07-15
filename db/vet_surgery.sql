DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS pet_treatments;
DROP TABLE IF EXISTS treatments;
DROP TABLE IF EXISTS owner_products;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS vets;

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    tel VARCHAR(255),
    day_off VARCHAR(255) 
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
    balance_due NUMERIC(8,2),
    registered BOOLEAN,
    marketing BOOLEAN
);

CREATE TABLE pets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    dob DATE,
    type VARCHAR(255),
    notes TEXT,
    owner_id INT REFERENCES owners(id) ON DELETE CASCADE,
    vet_id INT REFERENCES vets(id) ON DELETE CASCADE
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    curr_price NUMERIC(8,2)
);

CREATE TABLE pet_treatments (
    id SERIAL PRIMARY KEY,
    pet_id INT REFERENCES pets(id) ON DELETE CASCADE,
    treatment_id INT REFERENCES treatments(id) ON DELETE CASCADE,
    cost NUMERIC(8,2),
    date DATE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    curr_price NUMERIC(8,2)
);

CREATE TABLE owner_products (
    id SERIAL PRIMARY KEY,
    owner_id INT REFERENCES owners(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    cost NUMERIC(8,2),
    date DATE
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    owner_id INT REFERENCES owners(id) ON DELETE CASCADE,
    amount NUMERIC(8,2),
    date DATE
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    vet_id INT REFERENCES vets(id) ON DELETE CASCADE,
    pet_id INT REFERENCES pets(id) ON DELETE CASCADE,
    date_time TIMESTAMP
);