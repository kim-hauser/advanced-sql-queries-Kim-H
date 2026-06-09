DROP TABLE IF EXISTS customers;  -- setting up test database
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
 id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(50),
 last_name VARCHAR(50)
);

CREATE TABLE orders (
 id INT PRIMARY KEY,
 customer_id INT NULL,
 order_date DATE,
 total_amount DECIMAL(10, 2),
 FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES 
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);


SELECT customer_id, SUM(total_amount) AS total_spent -- group by to find total spent by each customer
FROM orders
GROUP BY customer_id;

SELECT customer_id, SUM(total_amount) AS total_spent -- filters by greater than $200
FROM orders
WHERE total_amount > 200
GROUP BY customer_id;

SELECT customer_id, SUM(total_amount) AS total_spent -- HAVING is applied after the groupby clause to also filter by >$200
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;

SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount -- inner join to include first and last name
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount -- left join includes all rows from first table
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

SELECT id, order_date, total_amount -- subquery, scalar
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount) FROM orders); 

SELECT id, order_date, total_amount, customer_id -- subquery, column
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');

SELECT order_date -- subquery, table
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;
