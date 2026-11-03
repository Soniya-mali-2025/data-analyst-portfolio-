
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS reviews;


CREATE DATABASE customer;

USE customer;

CREATE TABLE customers (
    customer_id  INT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    email        VARCHAR(100) UNIQUE,
    city         VARCHAR(50),
    state        VARCHAR(50),
    signup_date  DATE
);

INSERT INTO customers VALUES
(1,  'Aarav Patel',         'aarav.patel@mail.com',    'Ahmedabad', 'Gujarat',       '2023-01-12'),
(2,  'Ishita Banerjee',     'ishita.b@mail.com',       'Kolkata',   'West Bengal',   '2023-02-20'),
(3,  'Rohit Chauhan',       'rohit.c@mail.com',        'Jaipur',    'Rajasthan',     '2023-03-05'),
(4,  'Pooja Hegde',         'pooja.h@mail.com',        'Bengaluru', 'Karnataka',     '2023-04-18'),
(5,  'Mohammed Faisal',     'faisal.m@mail.com',       'Hyderabad', 'Telangana',     '2023-05-22'),
(6,  'Lakshmi Narayanan',   'lakshmi.n@mail.com',      'Chennai',   'Tamil Nadu',    '2023-06-30'),
(7,  'Siddharth Malhotra',  'sid.m@mail.com',          'Delhi',     'Delhi',         '2023-08-14'),
(8,  'Nisha Kapoor',        'nisha.k@mail.com',        'Mumbai',    'Maharashtra',   '2023-09-09'),
(9,  'Varun Desai',         'varun.d@mail.com',        'Pune',      'Maharashtra',   '2023-11-01'),
(10, 'Anjali Thomas',       'anjali.t@mail.com',       'Kochi',     'Kerala',        '2024-01-07'),
(11, 'Deepak Yadav',        'deepak.y@mail.com',       'Lucknow',   'Uttar Pradesh', '2024-02-25'),  -- no orders
(12, 'Sana Sheikh',         'sana.s@mail.com',         'Bengaluru', 'Karnataka',     '2024-03-15');  -- no orders
 
 SELECT * FROM customers;
 
 USE categories;
 
 INSERT INTO categories VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Clothing'),
(4, 'Home & Kitchen'),
(5, 'Sports');  

SELECT * FROM categories;


CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    category_id  INT,
    price        DECIMAL(10,2),
    stock        INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

USE products;
INSERT INTO products VALUES
(1,  'Wireless Earbuds',        1,  2999, 150),
(2,  'Smartphone 128GB',        1, 18999,  60),
(3,  'Laptop Backpack',         3,  1499, 200),
(4,  'SQL Mastery Book',        2,   599, 300),
(5,  'Python Crash Course',     2,   749, 250),
(6,  'Cotton T-Shirt',          3,   499, 500),
(7,  'Denim Jeans',             3,  1799, 220),
(8,  'Mixer Grinder',           4,  3499,  80),
(9,  'Air Fryer',               4,  5999,  45),
(10, 'Bluetooth Speaker',       1,  2499,   0),  -- out of stock
(11, 'Data Structures Book',    2,   899, 120),
(12, 'Non-stick Cookware Set',  4,  2799,  70);
 
 SELECT * FROM products;
 
 
 CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT,
    order_date      DATE,
    status          VARCHAR(20),     -- Delivered, Shipped, Pending, Cancelled, Returned
    payment_method  VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
 
 INSERT INTO orders VALUES
(1,  1,  '2024-01-20', 'Delivered', 'UPI'),
(2,  2,  '2024-02-11', 'Delivered', 'Credit Card'),
(3,  1,  '2024-03-02', 'Delivered', 'UPI'),
(4,  3,  '2024-03-18', 'Cancelled', 'COD'),
(5,  4,  '2024-04-05', 'Delivered', 'Credit Card'),
(6,  5,  '2024-04-22', 'Delivered', 'Net Banking'),
(7,  6,  '2024-05-10', 'Shipped',   'UPI'),
(8,  7,  '2024-05-29', 'Delivered', 'Credit Card'),
(9,  8,  '2024-06-14', 'Delivered', 'UPI'),
(10, 4,  '2024-06-30', 'Delivered', 'UPI'),
(11, 9,  '2024-07-08', 'Returned',  'COD'),
(12, 2,  '2024-07-25', 'Delivered', 'Debit Card'),
(13, 10, '2024-08-12', 'Delivered', 'UPI'),
(14, 1,  '2024-08-30', 'Pending',   'UPI'),
(15, 5,  '2024-09-15', 'Delivered', 'Credit Card'),
(16, 7,  '2024-09-28', 'Delivered', 'Net Banking'),
(17, 8,  '2024-10-03', 'Shipped',   'Credit Card'),
(18, 3,  '2024-10-19', 'Delivered', 'UPI'),
(19, 6,  '2024-11-02', 'Delivered', 'Debit Card'),
(20, 4,  '2024-11-20', 'Delivered', 'UPI');
 
 
 SELECT * FROM orders;
 
 CREATE TABLE order_items (
    order_item_id  INT PRIMARY KEY,
    order_id       INT,
    product_id     INT,
    quantity       INT,
    unit_price     DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
 
 
 INSERT INTO order_items VALUES
(1,  1,  1,  1,  2999),
(2,  1,  4,  2,   599),
(3,  2,  7,  1,  1799),
(4,  2,  6,  3,   499),
(5,  3,  5,  1,   749),
(6,  3,  11, 1,   899),
(7,  4,  2,  1, 18999),
(8,  5,  9,  1,  5999),
(9,  6,  8,  1,  3499),
(10, 6,  12, 1,  2799),
(11, 7,  3,  1,  1499),
(12, 7,  6,  2,   499),
(13, 8,  2,  1, 18999),
(14, 8,  1,  1,  2999),
(15, 9,  4,  1,   599),
(16, 9,  5,  1,   749),
(17, 9,  11, 1,   899),
(18, 10, 1,  2,  2999),
(19, 11, 7,  2,  1799),
(20, 12, 12, 1,  2799),
(21, 12, 8,  1,  3499),
(22, 13, 6,  4,   499),
(23, 14, 9,  1,  5999),
(24, 15, 2,  1, 18999),
(25, 16, 3,  1,  1499),
(26, 16, 4,  1,   599),
(27, 17, 10, 1,  2499),
(28, 18, 5,  2,   749),
(29, 19, 7,  1,  1799),
(30, 19, 6,  1,   499),
(31, 20, 1,  1,  2999),
(32, 20, 11, 1,   899);
 
 
  CREATE TABLE reviews (
    review_id    INT PRIMARY KEY,
    product_id   INT,
    customer_id  INT,
    rating       INT,                -- 1 to 5
    review_date  DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO reviews VALUES
(1,  1,  1, 5, '2024-02-01'),
(2,  1,  4, 4, '2024-07-10'),
(3,  2,  7, 5, '2024-06-10'),
(4,  4,  1, 5, '2024-02-05'),
(5,  4,  8, 4, '2024-07-01'),
(6,  6,  2, 3, '2024-03-01'),
(7,  7,  2, 2, '2024-03-02'),
(8,  9,  4, 4, '2024-05-01'),
(9,  8,  5, 5, '2024-05-15'),
(10, 5,  3, 5, '2024-11-01'),
(11, 11, 1, 4, '2024-04-01'),
(12, 1,  7, 3, '2024-06-12');

SELECT * FROM reviews; 

-- 1 Count orders
SELECT COUNT(order_id) 
FROM orders;


-- 2 Products priced between 1000 and 5000.
SELECT name, price
FROM products 
WHERE price between 1000 AND 5000;


-- 3 Customers from Karnataka or Maharashtra (IN).
SELECT name, state
FROM customers
WHERE state IN ('Karnataka', 'Maharashtra')
GROUP BY name, state;

-- 4 Count of orders by status.
 SELECT * FROM orders;
SELECT status, COUNT(order_id) AS total_count
FROM orders
GROUP BY status;

-- 5 Total revenue = SUM(quantity * unit_price) for Delivered orders.
SELECT SUM(oi.quantity * oi.unit_price) AS Total_qty, o.status 
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE status = 'Delivered';

-- 6 Revenue per product category
SELECT c.category_name, SUM(oi.quantity * oi.unit_price) AS Total_qty
FROM categories c
JOIN products p 
ON p.category_id = c.category_id
JOIN order_items oi
ON oi.product_id = p.product_id
JOIN orders o
ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY category_name
ORDER BY Total_qty DESC;


-- 7 Top 3 customers by total spend.
SELECT c.customer_id, c.name, SUM(oi.quantity * oi.unit_price) AS Total_spend
FROM customers c 
JOIN orders o
ON o.customer_id = c.customer_id
JOIN order_items oi
ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spend DESC
LIMIT 3;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM categories;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM reviews; 


-- 8 Categories with no products.
SELECT c.category_id, c.category_name
FROM categories c 
LEFT JOIN products p
ON p.category_id = c.category_id
WHERE p.product_id IS NULL;
 
 
-- 9. Average rating per product, only products with 2+ reviews (HAVING).
SELECT AVG(r.rating) AS AVG_rating, p.name
FROM reviews r
JOIN products p 
ON p.product_id = r.product_id
GROUP BY p.name
HAVING AVG(r.rating) > 2; 



-- 10. Products never ordered.
SELECT p.product_id, p.name
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.order_item_id IS NULL;


-- 11. Monthly revenue trend (GROUP BY month of order_date).
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
sum(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;


-- 12. Label products: price > 5000 'Premium', > 1500 'Mid', else 'Budget' (CASE).
SELECT name, price,
CASE WHEN price > 5000 Then 'Premium'
      WHEN price > 1500 Then 'Mid'
      ELSE 'Budget' END AS price_tier
FROM products;


-- 13. Most popular payment method.
SELECT payment_method, COUNT(order_id) AS num_orders
FROM orders
GROUP BY payment_method
ORDER BY num_orders DESC;


-- 14. Customers who ordered more than once.
SELECT c.name, COUNT(o.order_id) AS num_order
FROM customers c 
JOIN orders o 
ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2
ORDER BY num_order DESC;


-- 15. Best-selling product in each category (CTE + ROW_NUMBER).
WITH sales AS (
    SELECT c.category_name, p.name AS product,
           SUM(oi.quantity)                 AS units_sold,
           SUM(oi.quantity * oi.unit_price) AS revenue
    FROM categories c
    JOIN products p     ON p.category_id = c.category_id
    JOIN order_items oi ON oi.product_id = p.product_id
    JOIN orders o       ON o.order_id    = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY c.category_name, p.name
),
ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY category_name
                              ORDER BY units_sold DESC, revenue DESC) AS rn
    FROM sales
)
SELECT category_name, product, units_sold, revenue
FROM ranked
WHERE rn = 1
ORDER BY category_name;


-- 16. Customers who bought both an Electronics and a Books item.
SELECT c.customer_id, c.name
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p     ON p.product_id  = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id
WHERE o.status = 'Delivered'
  AND cat.category_name IN ('Electronics', 'Books')
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT cat.category_name) = 2;


-- 17. Out-of-stock products that still got ordered.
SELECT p.product_id, p.name, p.stock,
       COUNT(DISTINCT oi.order_id) AS times_ordered,
       SUM(oi.quantity)            AS units_ordered
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
WHERE p.stock = 0
GROUP BY p.product_id, p.name, p.stock;

-- 18. Who are our top 3 repeat customers by delivered spend?”
SELECT c.name, COUNT(DISTINCT o.order_id) AS orders, SUM(oi.quantity * oi.unit_price) AS price,
RANK() OVER(ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rnk
FROM customers c
JOIN orders o 
ON o.customer_id = c.customer_id
JOIN order_items oi
ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY price DESC
LIMIT 3;


