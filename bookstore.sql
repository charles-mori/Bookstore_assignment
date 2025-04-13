
-- Create and use the database
CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;

-- Create tables
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(100),
    city VARCHAR(50),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address_status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status VARCHAR(50)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    nationality VARCHAR(100),
    name VARCHAR(100)
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    genre VARCHAR(100),
    publishing_date DATE,
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    method VARCHAR(100)
);

CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status VARCHAR(50)
);

CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    shipping_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

CREATE TABLE order_history (
    order_id INT,
    status_id INT,
    history_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, status_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Insert sample data
INSERT INTO country (name) VALUES
('South Sudan'), ('Kenya'), ('Uganda'), ('Ethiopia'), ('Nigeria'),
('Ghana'), ('Rwanda'), ('Tanzania'), ('USA'), ('UK');

INSERT INTO address (street, city, country_id) VALUES
('Juba Rd', 'Juba', 1), ('Moi Ave', 'Nairobi', 2), ('Kampala St', 'Kampala', 3),
('Bole Rd', 'Addis Ababa', 4), ('Lagos St', 'Lagos', 5),
('Accra Ave', 'Accra', 6), ('Kigali Blvd', 'Kigali', 7), ('Dodoma Rd', 'Dodoma', 8),
('5th Ave', 'New York', 9), ('Oxford St', 'London', 10);

INSERT INTO address_status (status) VALUES
('current'), ('old'), ('temporary'), ('billing'), ('shipping'),
('primary'), ('secondary'), ('work'), ('home'), ('other');

INSERT INTO customer (name) VALUES
('John Doe'), ('Alice Smith'), ('Peter Kim'), ('Grace Achieng'),
('Michael Johnson'), ('Linda Okello'), ('Ahmed Musa'),
('Beatrice Anyango'), ('Ezekiel Otieno'), ('Sarah Brown');

INSERT INTO customer_address (customer_id, address_id, address_status_id) VALUES
(1,1,1), (2,2,1), (3,3,1), (4,4,1), (5,5,1),
(6,6,1), (7,7,1), (8,8,1), (9,9,1), (10,10,1);

INSERT INTO book_language (name) VALUES
('English'), ('Arabic'), ('Swahili'), ('French'), ('German'),
('Portuguese'), ('Amharic'), ('Dinka'), ('Nuer'), ('Luganda');

INSERT INTO publisher (name) VALUES
('Pearson'), ('Macmillan'), ('Oxford Press'), ('Penguin'),
('Nairobi Press'), ('Juba Books'), ('Lagos Print'), ('Kampala Pub'),
('Cambridge Press'), ('HarperCollins');

INSERT INTO author (name) VALUES
('Chinua Achebe'), ("Ngugi wa Thiong'o"), ('Wole Soyinka'),
('Margaret Ogola'), ('Binyavanga Wainaina'), ('J.K. Rowling'),
('George Orwell'), ('John Grisham'), ('Malcolm Gladwell'), ('Stephen King');

INSERT INTO book (title, publisher_id, language_id) VALUES
('Things Fall Apart', 1, 1), ('Petals of Blood', 2, 1),
('The River and the Source', 3, 1), ('Wizard of the Crow', 2, 3),
('Animal Farm', 4, 1), ('Outliers', 5, 1), ('Carrie', 6, 1),
('Born a Crime', 7, 1), ('Dreams from My Father', 8, 1), ('The Alchemist', 9, 4);

INSERT INTO book_author (book_id, author_id) VALUES
(1,1), (2,2), (3,4), (4,2), (5,7), (6,9), (7,10), (8,10), (9,9), (10,5);

INSERT INTO shipping_method (method) VALUES
('Standard'), ('Express'), ('Next Day'), ('In-Store Pickup'), ('Courier'),
('Drone'), ('Postal'), ('Truck'), ('Air Freight'), ('Bike Delivery');

INSERT INTO order_status (status) VALUES
('pending'), ('confirmed'), ('shipped'), ('delivered'), ('cancelled'),
('returned'), ('on hold'), ('refunded'), ('processing'), ('failed');

INSERT INTO cust_order (customer_id, shipping_method_id) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5),
(6,6), (7,7), (8,8), (9,9), (10,10);

INSERT INTO order_history (order_id, status_id) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5),
(6,6), (7,7), (8,8), (9,9), (10,10);

INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1,1,1), (2,2,2), (3,3,1), (4,4,3), (5,5,1),
(6,6,1), (7,7,1), (8,8,2), (9,9,1), (10,10,1);

-- Roles and Permissions (MySQL 8+)
CREATE ROLE db_admin;
CREATE ROLE db_developer;
CREATE ROLE db_viewer;

GRANT ALL PRIVILEGES ON bookstore_db.* TO db_admin;
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX ON bookstore_db.* TO db_developer;
GRANT SELECT ON bookstore_db.* TO db_viewer;

CREATE USER 'charles'@'%' IDENTIFIED BY 'CharlesPass123';
CREATE USER 'tamara'@'%' IDENTIFIED BY 'TamaraPass123';
CREATE USER 'hlazo'@'%' IDENTIFIED BY 'HlazoPass123';

GRANT db_admin TO 'tamara'@'%';
GRANT db_developer TO 'charles'@'%';
GRANT db_viewer TO 'hlazo'@'%';

SET DEFAULT ROLE db_admin TO 'tamara'@'%';
SET DEFAULT ROLE db_developer TO 'charles'@'%';
SET DEFAULT ROLE db_viewer TO 'hlazo'@'%';
