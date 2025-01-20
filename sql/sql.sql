DROP VIEW IF EXISTS user_items CASCADE;
DROP VIEW IF EXISTS item_images CASCADE;
DROP VIEW IF EXISTS active_sales CASCADE;

-- Drop tables if they exist
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS item_tags CASCADE;
DROP TABLE IF EXISTS images CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;
-- Comprehensive PostgreSQL schema with support for images and item cataloging

-- Creating tables
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    category_id INT REFERENCES categories(category_id) ON DELETE SET NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE images (
    image_id SERIAL PRIMARY KEY,
    item_id INT REFERENCES items(item_id) ON DELETE CASCADE,
    image_url VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE item_tags (
    tag_id SERIAL PRIMARY KEY,
    item_id INT REFERENCES items(item_id) ON DELETE CASCADE,
    tag_name VARCHAR(50) NOT NULL
);

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    item_id INT REFERENCES items(item_id) ON DELETE CASCADE,
    price NUMERIC(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    is_sold BOOLEAN DEFAULT FALSE,
    platform VARCHAR(50) DEFAULT 'Vinted',
    listed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transactions table for completed sales
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES sales(id) ON DELETE CASCADE,
    buyer_name VARCHAR(100),
    buyer_contact TEXT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Sample views
CREATE VIEW user_items AS
SELECT 
    u.username,
    i.item_id,
    i.name AS item_name,
    i.description AS item_description,
    c.name AS category_name,
    i.created_at
FROM items i
JOIN users u ON i.user_id = u.user_id
LEFT JOIN categories c ON i.category_id = c.category_id;

CREATE VIEW item_images AS
SELECT 
    i.item_id,
    i.name AS item_name,
    img.image_url,
    img.uploaded_at
FROM items i
JOIN images img ON i.item_id = img.item_id;

CREATE OR REPLACE VIEW active_sales AS
SELECT 
    s.id AS sale_id,
    i.name AS item_name,
    s.price,
    s.currency,
    s.platform,
    s.is_sold,
    s.listed_at
FROM sales s
JOIN items i ON s.item_id = i.item_id
WHERE s.is_sold = FALSE;

-- Seeding data
INSERT INTO users (username, email, password_hash) VALUES
('john_doe', 'john@example.com', 'hashedpassword1'),
('jane_smith', 'jane@example.com', 'hashedpassword2');

INSERT INTO categories (name, description) VALUES
('Tools', 'Various tools and equipment'),
('Furniture', 'Household furniture'),
('Electronics', 'Electronic items and gadgets');

INSERT INTO items (user_id, category_id, name, description) VALUES
(1, 1, 'Hammer', 'A durable steel hammer'),
(1, 2, 'Wooden Chair', 'An antique wooden chair'),
(2, 3, 'Laptop', 'A high-performance laptop');

INSERT INTO images (item_id, image_url) VALUES
(1, 'https://example.com/images/hammer.jpg'),
(2, 'https://example.com/images/chair.jpg'),
(3, 'https://example.com/images/laptop.jpg');

INSERT INTO item_tags (item_id, tag_name) VALUES
(1, 'DIY'),
(2, 'Antique'),
(3, 'Tech');

-- Insert sample users
INSERT INTO users (username, email, password_hash, created_at)
VALUES
    ('alice_wonder', 'alice@example.com', 'hash1', CURRENT_TIMESTAMP),
    ('bob_builder', 'bob@example.com', 'hash2', CURRENT_TIMESTAMP),
    ('charlie_day', 'charlie@example.com', 'hash3', CURRENT_TIMESTAMP),
    ('daisy_duke', 'daisy@example.com', 'hash4', CURRENT_TIMESTAMP),
    ('edgar_allan', 'edgar@example.com', 'hash5', CURRENT_TIMESTAMP);


-- Insert sales listings
INSERT INTO sales (item_id, price, currency, platform) VALUES
(1, 50.00, 'USD', 'Vinted'),
(2, 300.00, 'USD', 'Vinted'),
(3, 80.00, 'USD', 'Vinted');

-- Insert completed transactions
INSERT INTO transactions (sale_id, buyer_name, buyer_contact) VALUES
(1, 'John Doe', 'john.doe@example.com'),
(2, 'Jane Smith', 'jane.smith@example.com');




-- Dodanie kategorii dla nowych przedmiotów
INSERT INTO categories (name, description) VALUES
('Opony i felgi', 'Opony samochodowe oraz felgi do różnych pojazdów'),
('Pojemniki i akcesoria', 'Plastikowe pojemniki, wiadra i inne akcesoria do przechowywania');

-- Dodanie nowych przedmiotów
INSERT INTO items (user_id, category_id, name, description, created_at) VALUES
(1, 1, 'Opona 165/70R14', 'Opona samochodowa z felgą. Rozmiar: 165/70R14, klasa: 81T.', CURRENT_TIMESTAMP),
(1, 2, 'Baniak plastikowy 5L', 'Plastikowy pojemnik z zieloną nakrętką, przeznaczony do płynów technicznych.', CURRENT_TIMESTAMP),
(1, 2, 'Plastikowe wiadro', 'Wiadro w plastikowym worku, widoczne na zdjęciu w piwnicy.', CURRENT_TIMESTAMP);

-- Dodanie zdjęć dla tych przedmiotów
INSERT INTO images (item_id, image_url, uploaded_at) VALUES
(1, '20250120_070753.jpg', CURRENT_TIMESTAMP),
(2, '20250120_070412.jpg', CURRENT_TIMESTAMP),
(3, '20250120_070412.jpg', CURRENT_TIMESTAMP);

-- Tagowanie przedmiotów
INSERT INTO item_tags (item_id, tag_name) VALUES
(1, 'opona'),
(1, 'samochodowa'),
(2, 'pojemnik'),
(2, 'plastikowy'),
(3, 'wiadro');

-- Dodanie kategorii dla książek
INSERT INTO categories (name, description) VALUES
('Książki techniczne', 'Książki i podręczniki techniczne z zakresu programowania, elektroniki oraz informatyki');

-- Dodanie książek
INSERT INTO items (user_id, category_id, name, description, created_at) VALUES
(1, 1, 'PHP. Receptury', 'Podręcznik do języka PHP z gotowymi rozwiązaniami.', CURRENT_TIMESTAMP),
(1, 1, 'Linux - praktyka administracji', 'Kompleksowy przewodnik po administracji systemem Linux.', CURRENT_TIMESTAMP),
(1, 1, 'Sztuka elektroniki. Część 1', 'Klasyczna pozycja o elektronice autorstwa P. Horowitza i W. Hilla.', CURRENT_TIMESTAMP),
(1, 1, 'Sztuka elektroniki. Część 2', 'Druga część bestsellerowego podręcznika do elektroniki.', CURRENT_TIMESTAMP),
(1, 1, 'C++ Elementarz hakera', 'Poradnik dla zaawansowanych programistów C++.', CURRENT_TIMESTAMP),
(1, 1, 'Jak pisać wirusy', 'Książka o pisaniu wirusów komputerowych (dla celów edukacyjnych!).', CURRENT_TIMESTAMP),
(1, 1, 'abc komputera', 'Podstawy obsługi komputera dla początkujących.', CURRENT_TIMESTAMP),
(1, 1, 'UNIX - programowanie systemowe', 'Kompletny podręcznik do programowania systemowego w UNIX.', CURRENT_TIMESTAMP),
(1, 1, 'qmail. Szybki i wydajny serwer pocztowy', 'Instrukcja konfiguracji i administracji serwerem qmail.', CURRENT_TIMESTAMP),
(1, 1, 'Serwisy WWW. Projektowanie, tworzenie i zarządzanie', 'Praktyczny poradnik dla twórców stron WWW.', CURRENT_TIMESTAMP);

-- Dodanie zdjęć książek
INSERT INTO images (item_id, image_url, uploaded_at) VALUES
(1, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(2, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(3, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(4, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(5, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(6, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(7, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(8, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(9, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(10, '20250120_070449.jpg', CURRENT_TIMESTAMP);

-- Tagowanie książek
INSERT INTO item_tags (item_id, tag_name) VALUES
(1, 'php'),
(2, 'linux'),
(3, 'elektronika'),
(4, 'elektronika'),
(5, 'c++'),
(6, 'wirusy'),
(7, 'komputery'),
(8, 'unix'),
(9, 'qmail'),
(10, 'www');

-- Dodanie kategorii
INSERT INTO categories (name, description) VALUES
('Kuchnia i AGD', 'Przedmioty kuchenne, sprzęty AGD oraz akcesoria'),
('Akcesoria domowe', 'Elementy wyposażenia wnętrz, torby i półki');

-- Dodanie przedmiotów
INSERT INTO items (user_id, category_id, name, description, created_at) VALUES
(1, 1, 'Maszynka do mielenia 986', 'Maszynka do mielenia mięsa w oryginalnym pudełku.', CURRENT_TIMESTAMP),
(1, 1, 'Metalowe garnki', 'Zestaw metalowych garnków lub parownik.', CURRENT_TIMESTAMP),
(1, 2, 'Czarna torba', 'Torba z zamkiem błyskawicznym, średniej wielkości.', CURRENT_TIMESTAMP),
(1, 2, 'Drewniana półka z haczykami', 'Półka drewniana z metalowymi haczykami.', CURRENT_TIMESTAMP);

-- Dodanie zdjęcia
INSERT INTO images (item_id, image_url, uploaded_at) VALUES
(1, '20250120_070559.jpg', CURRENT_TIMESTAMP),
(2, '20250120_070559.jpg', CURRENT_TIMESTAMP),
(3, '20250120_070559.jpg', CURRENT_TIMESTAMP),
(4, '20250120_070559.jpg', CURRENT_TIMESTAMP);
