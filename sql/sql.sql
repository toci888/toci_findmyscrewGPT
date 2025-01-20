DROP VIEW IF EXISTS api_user_items CASCADE;
DROP VIEW IF EXISTS api_item_images CASCADE;
DROP VIEW IF EXISTS api_active_sales CASCADE;

-- Drop tables if they exist
DROP TABLE IF EXISTS api_jars CASCADE;
DROP TABLE IF EXISTS api_transactions CASCADE;
DROP TABLE IF EXISTS api_sales CASCADE;
DROP TABLE IF EXISTS api_item_tags CASCADE;
DROP TABLE IF EXISTS api_images CASCADE;
DROP TABLE IF EXISTS api_items CASCADE;
DROP TABLE IF EXISTS api_categories CASCADE;
DROP TABLE IF EXISTS api_users CASCADE;
-- Comprehensive PostgreSQL schema with support for images and item cataloging

-- Creating tables
CREATE TABLE api_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE api_categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE api_items (
    item_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES api_users(user_id) ON DELETE CASCADE,
    category_id INT REFERENCES api_categories(category_id) ON DELETE SET NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE api_images (
    image_id SERIAL PRIMARY KEY,
    item_id INT REFERENCES api_items(item_id) ON DELETE CASCADE,
    image_url VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE api_item_tags (
    tag_id SERIAL PRIMARY KEY,
    item_id INT REFERENCES api_items(item_id) ON DELETE CASCADE,
    tag_name VARCHAR(50) NOT NULL
);

CREATE TABLE api_sales (
    id SERIAL PRIMARY KEY,
    item_id INT REFERENCES api_items(item_id) ON DELETE CASCADE,
    price NUMERIC(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    is_sold BOOLEAN DEFAULT FALSE,
    platform VARCHAR(50) DEFAULT 'Vinted',
    listed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transactions table for completed sales
CREATE TABLE api_transactions (
    id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES api_sales(id) ON DELETE CASCADE,
    buyer_name VARCHAR(100),
    buyer_contact TEXT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE api_jars (
    jar_id SERIAL PRIMARY KEY,
    shelf INT NOT NULL,
    description TEXT,
    content_type VARCHAR(50),
    weight_grams INT,
    is_empty BOOLEAN DEFAULT FALSE,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample views
CREATE VIEW api_user_items AS
SELECT 
    u.username,
    i.item_id,
    i.name AS item_name,
    i.description AS item_description,
    c.name AS category_name,
    i.created_at
FROM api_items i
JOIN api_users u ON i.user_id = u.user_id
LEFT JOIN categories c ON i.category_id = c.category_id;

CREATE VIEW api_item_images AS
SELECT 
    i.item_id,
    i.name AS item_name,
    img.image_url,
    img.uploaded_at
FROM api_items i
JOIN api_images img ON i.item_id = img.item_id;

CREATE OR REPLACE VIEW api_active_sales AS
SELECT 
    s.id AS sale_id,
    i.name AS item_name,
    s.price,
    s.currency,
    s.platform,
    s.is_sold,
    s.listed_at
FROM api_sales s
JOIN api_items i ON s.item_id = i.item_id
WHERE s.is_sold = FALSE;
