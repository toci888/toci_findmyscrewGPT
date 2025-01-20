DROP VIEW IF EXISTS user_items CASCADE;
DROP VIEW IF EXISTS item_images CASCADE;
DROP VIEW IF EXISTS active_sales CASCADE;

-- Drop tables if they exist
DROP TABLE IF EXISTS jars CASCADE;
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

CREATE TABLE jars (
    jar_id SERIAL PRIMARY KEY,
    shelf INT NOT NULL,
    description TEXT,
    content_type VARCHAR(50),
    weight_grams INT,
    is_empty BOOLEAN DEFAULT FALSE,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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


-- Dodanie nowej kategorii
INSERT INTO categories (name, description) VALUES
('Sport i podróże', 'Torby, plecaki oraz akcesoria podróżne i sportowe.');

-- Dodanie przedmiotu
INSERT INTO items (user_id, category_id, name, description, created_at) VALUES
(1, (SELECT category_id FROM categories WHERE name = 'Sport i podróże'), 
'Czarna torba sportowa', 
'Duża torba sportowa z kilkoma zamkami błyskawicznymi i rączkami, idealna na wyjazdy lub treningi.', 
CURRENT_TIMESTAMP);

-- Dodanie zdjęcia dla przedmiotu
INSERT INTO images (item_id, image_url, uploaded_at) VALUES
((SELECT item_id FROM items WHERE name = 'Czarna torba sportowa'), 
'20250120_070519.jpg', 
CURRENT_TIMESTAMP);

-- Dodanie nowej kategorii dla materiałów budowlanych
INSERT INTO categories (name, description) VALUES
('Materiały budowlane', 'Produkty do remontów i budowy, takie jak gips, cement, farby.');

-- Dodanie przedmiotu do katalogu
INSERT INTO items (user_id, category_id, name, description, created_at) VALUES
(1, (SELECT category_id FROM categories WHERE name = 'Materiały budowlane'), 
'Worki z materiałami budowlanymi', 
'Dwa worki: jeden plastikowy, prawdopodobnie zawierający odpady, oraz worek z gipsowym tynkiem MP 75.', 
CURRENT_TIMESTAMP);

-- Dodanie zdjęcia przedmiotu
INSERT INTO images (item_id, image_url, uploaded_at) VALUES
((SELECT item_id FROM items WHERE name = 'Worki z materiałami budowlanymi'), 
'20250120_070329.jpg', 
CURRENT_TIMESTAMP);


--jars
INSERT INTO jars (shelf, description, content_type, weight_grams, is_empty) VALUES
(1, 'Słoik z ogórkami kiszonymi', 'Ogórki', 1200, FALSE),
(1, 'Słoik z olejem kokosowym', 'Olej kokosowy', 500, FALSE),
(1, 'Pusty słoik', NULL, 0, TRUE),
(2, 'Słoik z keczupem', 'Keczup', 700, FALSE),
(2, 'Słoik z przetworami owocowymi', 'Dżem truskawkowy', 400, FALSE),
(2, 'Pusty słoik z zakrętką czerwoną', NULL, 0, TRUE),
(3, 'Duży pusty słoik', NULL, 0, TRUE),
(3, 'Średni pusty słoik', NULL, 0, TRUE),
(3, 'Mały pusty słoik', NULL, 0, TRUE);

INSERT INTO jars (shelf, description, content_type, weight_grams, is_empty)
VALUES
(1, 'Korniszony w słoiku', 'Ogórki kiszone', 720, FALSE),
(1, 'Słoik oleju kokosowego', 'Olej kokosowy', 500, FALSE),
(1, 'Marynowana papryka w słoiku', 'Papryka marynowana', 300, FALSE),
(1, 'Słoik z dżemem wiśniowym', 'Dżem wiśniowy', 330, FALSE),
(2, 'Słoik miodu wielokwiatowego', 'Miód', 900, FALSE),
(2, 'Słoik z ketchupem łagodnym', 'Ketchup', 500, FALSE),
(2, 'Marynowana dynia w dużym słoiku', 'Dynia marynowana', 1000, FALSE),
(2, 'Słoik z ogórkami kwaszonymi', 'Ogórki kwaszone', 720, FALSE),
(2, 'Słoik przecieru pomidorowego', 'Przecier pomidorowy', 700, FALSE),
(2, 'Słoik z piklami warzywnymi', 'Pikle', 500, FALSE);

INSERT INTO items (user_id, category_id, name, description, created_at)
VALUES 
(1, 3, 'Panele podłogowe', 'Stos paneli podłogowych w jasnym odcieniu drewna, pozostałość po remoncie.', CURRENT_TIMESTAMP);

INSERT INTO items (user_id, category_id, name, description, created_at)
VALUES 
(1, 4, 'Wiaderko Ultra Biel', 'Wiaderko farby Ultra Biel do ścian i sufitów, częściowo zużyte.', CURRENT_TIMESTAMP),
(1, 5, 'Para starych butów', 'Czarne, lekko zużyte buty sportowe, potencjalnie przydatne do pracy.', CURRENT_TIMESTAMP),
(1, 6, 'Reklamówka z zawartością', 'Biała reklamówka z nieznaną zawartością, może zawierać drobne przedmioty.', CURRENT_TIMESTAMP);

INSERT INTO items (user_id, category_id, name, description, created_at)
VALUES 
(1, 7, 'Stare koła rowerowe', 'Dwa stare koła rowerowe z oponami, jedno z odblaskiem.', CURRENT_TIMESTAMP),
(1, 8, 'Metalowy garnek', 'Duży, metalowy garnek z plastikowymi uchwytami.', CURRENT_TIMESTAMP),
(1, 9, 'Poduszka z gąbki', 'Duża poduszka z gąbki, potencjalnie używana jako materiał izolacyjny.', CURRENT_TIMESTAMP),
(1, 10, 'Doniczka gliniana', 'Mała, okrągła doniczka wykonana z gliny.', CURRENT_TIMESTAMP),
(1, 10, 'Czerwona konewka', 'Plastikowa konewka w kolorze czerwonym, lekko używana.', CURRENT_TIMESTAMP),
(1, 10, 'Spray techniczny', 'Puszka ze sprayem technicznym, przeznaczenie bliżej nieokreślone.', CURRENT_TIMESTAMP);

INSERT INTO items (user_id, category_id, name, description, created_at)
VALUES 
(1, 7, 'Rura rowerowa', 'Stara rura rowerowa w plastikowej donicy.', CURRENT_TIMESTAMP),
(1, 9, 'Czerwona donica', 'Plastikowa, czerwona donica średniej wielkości.', CURRENT_TIMESTAMP),
(1, 8, 'Puszka sprayu technicznego', 'Spray techniczny w puszce marki Motip.', CURRENT_TIMESTAMP),
(1, 10, 'Sprężone powietrze', 'Duża niebieska puszka ze sprężonym powietrzem, używana do czyszczenia.', CURRENT_TIMESTAMP);


INSERT INTO items (user_id, category_id, name, description, created_at)
VALUES 
(1, 9, 'Koła rowerowe', 'Trzy zużyte koła rowerowe z widocznymi szprychami, powieszone na ścianie.', CURRENT_TIMESTAMP),
(1, 10, 'Karton po telewizorze', 'Duży karton po telewizorze LED 43-calowym, używany do przechowywania.', CURRENT_TIMESTAMP),
(1, 10, 'Worek z materiałami', 'Przezroczysty worek z nieokreślonymi materiałami, możliwe tekstylia.', CURRENT_TIMESTAMP),
(1, 10, 'Karton po sprzęcie', 'Karton po urządzeniu Mini Oil Pressing Machine.', CURRENT_TIMESTAMP);

-- INSERT INTO categories (name, description) VALUES
-- ('Książki techniczne', 'Literatura z zakresu techniki i programowania'),
-- ('AGD i kuchnia', 'Akcesoria kuchenne, garnki i sprzęty AGD'),
-- ('Materiały budowlane', 'Produkty remontowe i budowlane'),
-- ('Sport i rowery', 'Akcesoria sportowe oraz części rowerowe'),
-- ('Dom i ogród', 'Wyposażenie domu i ogrodu'),
-- ('Inne', 'Pozostałe przedmioty');

-- Seed użytkowników
INSERT INTO users (username, email, password_hash) VALUES
('lemiesz', 'lemiesz@example.com', 'hash1'),
('seba', 'seba@example.com', 'hash2'),
('kamil', 'kamil@example.com', 'hash3'),
('michal', 'michal@example.com', 'hash4');