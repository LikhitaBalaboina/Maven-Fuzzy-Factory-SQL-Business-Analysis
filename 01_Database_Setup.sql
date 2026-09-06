CREATE DATABASE maven_fuzzy_factory;

USE maven_fuzzy_factory;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    created_at DATETIME,
    website_session_id INT,
    user_id INT,
    primary_product_id INT,
    items_purchased INT,
    price_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    created_at DATETIME,
    order_id INT,
    product_id INT,
    is_primary_item INT,
    price_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2)
);

CREATE TABLE order_item_refunds (
    order_item_refund_id INT PRIMARY KEY,
    created_at DATETIME,
    order_item_id INT,
    order_id INT,
    refund_amount_usd DECIMAL(10,2)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    created_at DATETIME,
    product_name VARCHAR(255)
);

CREATE TABLE website_sessions (
    website_session_id INT PRIMARY KEY,
    created_at DATETIME,
    user_id INT,
    is_repeat_session INT,
    utm_source VARCHAR(50),
    utm_campaign VARCHAR(50),
    utm_content VARCHAR(50),
    device_type VARCHAR(50),
    http_referer VARCHAR(255)
);

CREATE TABLE website_pageviews (
    website_pageview_id INT PRIMARY KEY,
    created_at DATETIME,
    website_session_id INT,
    pageview_url VARCHAR(255)
);

CREATE TABLE maven_fuzzy_factory_data_dictionary (
    table_name VARCHAR(100),
    field_name VARCHAR(100),
    description VARCHAR(500)
);
