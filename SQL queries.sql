-- Customers Table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    city TEXT
);

INSERT INTO customers (name, email, city) VALUES
('Alice Johnson', 'alice@example.com', 'New York'),
('Bob Smith', 'bob@example.com', 'Chicago'),
('Clara Lee', 'clara@example.com', 'San Francisco'),
('Daniel Kim', 'daniel@example.com', 'Los Angeles'),
('Eva Wang', 'eva@example.com', 'Seattle');

 Products Table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

INSERT INTO products (product_name, category, price) VALUES
('Wireless Mouse', 'Electronics', 25.99),
('Bluetooth Speaker', 'Electronics', 45.00),
('Office Chair', 'Furniture', 150.00),
('Notebook', 'Stationery', 5.50),
('Pen Set', 'Stationery', 3.20);

--Orders Table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-12-01', 71.99),
(2, '2023-12-05', 155.50),
(3, '2023-12-10', 8.70),
(1, '2023-12-15', 195.00),
(4, '2023-12-20', 150.00);

-- Order Items Table
CREATE TABLE order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 25.99),
(1, 4, 2, 5.50),
(2, 3, 1, 150.00),
(2, 5, 1, 3.20),
(3, 5, 2, 3.20),
(4, 2, 1, 45.00),
(4, 3, 1, 150.00),
(5, 3, 1, 150.00);

SELECT 
    c.customer_id,
    c.name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM 
    customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id;

SELECT 
    p.category,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM 
    order_items oi
   JOIN products p ON oi.product_id = p.product_id
GROUP BY 
    p.category;

SELECT 
    c.name,
    SUM(o.total_amount) AS total_spent
FROM 
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id
HAVING 
    total_spent > 100;

SELECT 
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.price,
    o.total_amount
FROM 
    orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id;

SELECT 
    p.product_name
FROM 
    products p
  LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE 
    oi.product_id IS NULL;

SELECT 
    c.city,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM 
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 
    c.city;
