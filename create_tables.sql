-- Apple Sales Project: table definitions
-- Load order: category -> products -> stores -> sales -> warranty

DROP TABLE IF EXISTS warranty;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS category;

CREATE TABLE category (
    category_id   VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(20)
);

CREATE TABLE products (
    product_id   VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(35),
    category_id  VARCHAR(10) REFERENCES category(category_id),
    launch_date  DATE,
    price        DOUBLE PRECISION
);

CREATE TABLE stores (
    store_id   VARCHAR(5) PRIMARY KEY,
    store_name VARCHAR(30),
    city       VARCHAR(25),
    country    VARCHAR(25)
);

CREATE TABLE sales (
    sale_id    VARCHAR(15) PRIMARY KEY,
    sale_date  DATE,
    store_id   VARCHAR(10) REFERENCES stores(store_id),
    product_id VARCHAR(10) REFERENCES products(product_id),
    quantity   INTEGER
);

CREATE TABLE warranty (
    claim_id      VARCHAR(10) PRIMARY KEY,
    claim_date    DATE,
    sale_id       VARCHAR(15) REFERENCES sales(sale_id),
    repair_status VARCHAR(15)
);

-- Import the CSV files (change the paths). Files have a header row.
-- COPY category FROM '/path/category.csv' CSV HEADER;
-- COPY products FROM '/path/products.csv' CSV HEADER;
-- COPY stores   FROM '/path/stores.csv'   CSV HEADER;
-- COPY sales    FROM '/path/sales.csv'    CSV HEADER;
-- COPY warranty FROM '/path/warranty.csv' CSV HEADER;
