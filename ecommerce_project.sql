-- E-COMMERCE ANALYTICS PROJECT

CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert Data
INSERT INTO Customers VALUES
(1, 'Arjun', 'Hyderabad'),
(2, 'Priya', 'Chennai'),
(3, 'Kiran', 'Bangalore');

INSERT INTO Products VALUES
(1, 'Laptop', 50000),
(2, 'Mobile', 20000),
(3, 'Headphones', 3000);

INSERT INTO Orders VALUES
(101, 1, '2024-01-01'),
(102, 2, '2024-01-02'),
(103, 3, '2024-01-03');

INSERT INTO Order_Items VALUES
(1, 101, 1, 1),
(2, 102, 2, 2),
(3, 103, 3, 3);

INSERT INTO Payments VALUES
(1, 101, 'Success'),
(2, 102, 'Pending'),
(3, 103, 'Success');

-- Queries

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.name;

SELECT p.name, SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;

SELECT * FROM Payments
WHERE payment_status = 'Pending';

SELECT MONTH(order_date) AS month, COUNT(*) AS orders
FROM Orders
GROUP BY MONTH(order_date);
