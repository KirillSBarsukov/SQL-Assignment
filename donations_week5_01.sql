USE gc200395896;
#USE gcc200393648;

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS employees;

# Create an item table
CREATE TABLE items (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (50) NOT NULL,
price DECIMAL (4,2)
);

# Create a customer table
CREATE TABLE customers (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (100) NOT NULL,
last_name VARCHAR (100) NOT NULL
);

# # Create an employee table
CREATE TABLE employees (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
employee_name VARCHAR (50) NOT NULL
);

# Create an order table
CREATE TABLE orders (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
quantity INT NOT NULL,
date VARCHAR (15) NOT NULL,
item_id INT NOT NULL,
customer_id INT NOT NULL,
employee_id INT NOT NULL,
FOREIGN KEY (item_id) REFERENCES items(id),
FOREIGN KEY (customer_id) REFERENCES customers(id),
FOREIGN KEY (employee_id) REFERENCES employees(id)
);

# Create a review table
CREATE TABLE reviews (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
reviews VARCHAR (350) NOT NULL,
order_id INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(id)
);

# Insert customers into the table
INSERT INTO customers (name, last_name)
VALUES ('Kirill', 'Varsukov'),
('Radhika', 'Kamur'),
('Juanpi', 'Sovera'),
('Anju', 'Chawla'),
('Vladimir','Putin'),
('Homer','Simpsom')
;

# Insert items into the table
INSERT INTO items (name, price)
VALUES ('Burguer', 6.50),
('Fries', 5.00),
('Coke', 2.00),
('Hot Dog', 4.50),
('Poutine', 4.00)
;

# Insert employees into the table
INSERT INTO employees (employee_name)
VALUES ('Justin Bieber'),
('Nicholas Maduro'),
('Cristiano Ronaldo'),
('Bill Gates'),
('Kim Kardasian')
;

# Insert orders into the table
INSERT INTO orders (quantity, date, item_id, customer_id, employee_id)
VALUES 
(2, '01/01/2019',2,3,2),
(1, '02/01/2019',1,5,4),
(2, '03/01/2019',5,1,3),
(2, '04/01/2019',2,2,2),
(2, '05/01/2019',3,4,1),
(3, '06/01/2019',4,2,1),
(4, '07/01/2019',3,1,2),
(1, '08/01/2019',5,3,4),
(2, '09/01/2019',2,4,5),
(3, '10/01/2019',5,5,1),
(2, '11/01/2019',3,3,3),
(5, '12/01/2019',4,4,2),
(1, '13/01/2019',5,1,1),
(2, '14/01/2019',2,2,3),
(4, '15/01/2019',2,4,5),
(3, '16/01/2019',1,1,1)
;

#Insert reviews into the table
INSERT INTO reviews (reviews, order_id)
VALUES ('The hamburguer and the Asian girl that cooks were absolutely amazing <3!' , 1),
('Best burguer in Barrie!!', 4),
('I will difinitely come back', 6),
('Can not wait to bring my lover here. Excellent place!', 7),
('Niaaaa, you could improve', 10)
;

# Select all tables
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM items;
SELECT * FROM reviews;
SELECT * FROM employees;

#a. All customers, orders and order items grouped by customers and orders
SELECT customers.name AS 'Customer Name', items.name AS 'Menu' , orders.id AS 'Nº of Order', orders.quantity AS 'Quantity'
FROM orders INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN items ON orders.item_id = items.id
ORDER BY customers.name, orders.id;

#b. All customers, orders, and reviews ordered by review date (newest first).
SELECT customers.name, orders.id, reviews.reviews, orders.date FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN reviews ON orders.id = reviews.order_id
ORDER BY orders.date DESC;

#c. All customers and orders, sorted by price of orders highest first.
SELECT customers.name, orders.id, (orders.quantity * items.price) AS 'Total of order'  FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN items ON orders.item_id = items.id
ORDER BY orders.quantity DESC;

#d. All the people who have spent the most money. You must use a nested query in case there are more than one customer.

#e. Display the item(s) that is the most popular. You must use a nested query in case there are more than one item.

#f. Find the average cost of an order for each employee in descending order.
SELECT employees.employee_name, orders.id, orders.quantity, items.price, (orders.quantity * items.price) AS 'Total of order'  
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN employees ON orders.employee_id = employees.id
JOIN items ON orders.item_id = items.id
ORDER BY orders.quantity DESC;

#g. The number of orders and total amount sold of each employee.
SELECT employees.employee_name AS 'Employee', COUNT(orders.quantity) AS 'Number of orders', (orders.quantity * items.price) AS 'Total amount sold'  
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN employees ON orders.employee_id = employees.id
JOIN items ON orders.item_id = items.id
GROUP BY employees.employee_name;

#h. Determine which employee has the highest sales to order ratio. Meaning add up all the sales of the employee and divided by the number of orders.

#i. Two queries of your own choosing using functionality (Key words) that have not been used in this assignment so far. Create a comment to describe what your query is finding.



















