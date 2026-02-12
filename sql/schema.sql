-- ============================================
-- Project: Database Schema Design and Normalization
-- Description: Retail Analytics Database (3NF)
-- ============================================

-- Step 1: Create Database
CREATE DATABASE RetailAnalytics;
USE RetailAnalytics;

-- ============================================
-- STEP 2: CREATE TABLES (Normalized to 3NF)
-- ============================================

-- Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

-- Category Table (Removed Transitive Dependency)
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Product Table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Order Details Table (Composite Primary Key)
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- ============================================
-- STEP 3: INSERT SAMPLE DATA
-- ============================================

INSERT INTO Customer VALUES
(1, 'Rahul', 'Chennai'),
(2, 'Anita', 'Bangalore');

INSERT INTO Category VALUES
(1, 'Electronics'),
(2, 'Clothing');

INSERT INTO Product VALUES
(101, 'Laptop', 1, 50000),
(102, 'Shirt', 2, 1500);

INSERT INTO Orders VALUES
(1001, 1, '2026-02-10'),
(1002, 2, '2026-02-11');

INSERT INTO Order_Details VALUES
(1001, 101, 1),
(1002, 102, 2);

-- ============================================
-- STEP 4: ANALYTICAL QUERIES
-- ============================================

-- Total Sales Per Customer
SELECT c.name, SUM(p.price * od.quantity) AS total_spent
FROM Order_Details od
JOIN Orders o ON od.order_id = o.order_id
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Product p ON od.product_id = p.product_id
GROUP BY c.name;

-- Total Quantity Sold Per Product
SELECT p.product_name, SUM(od.quantity) AS total_quantity_sold
FROM Order_Details od
JOIN Product p ON od.product_id = p.product_id
GROUP BY p.product_name;

-- Revenue by Category
SELECT cat.category_name, 
SUM(p.price * od.quantity) AS revenue
FROM Order_Details od
JOIN Product p ON od.product_id = p.product_id
JOIN Category cat ON p.category_id = cat.category_id
GROUP BY cat.category_name;

-- ============================================
-- END OF PROJECT
-- ============================================
