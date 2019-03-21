USE gcc200393648;

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS employees;

CREATE TABLE items (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (50) NOT NULL,
price DECIMAL (4,2)
);

CREATE TABLE customers (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (100) NOT NULL,
last_name VARCHAR (100) NOT NULL

);

CREATE TABLE employees (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
employee_name VARCHAR (50) NOT NULL
);

CREATE TABLE orders (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
quantity INT NOT NULL,
date VARCHAR (15) NOT NULL,
items_id INT NOT NULL,
customers_id INT NOT NULL,
employees_id INT NOT NULL,
FOREIGN KEY (items_id) REFERENCES items(id),
FOREIGN KEY (customers_id) REFERENCES customers(id),
FOREIGN KEY (employees_id) REFERENCES employees(id)
);

CREATE TABLE reviews (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
reviews VARCHAR (350) NOT NULL,
orders_id INT NOT NULL,
FOREIGN KEY (orders_id) REFERENCES orders(id)
);

INSERT INTO customers (name, last_name)
VALUES ('Kirill', 'Varsukov'),
('Radhika', 'Kamur'),
('Juanpi', 'Sovera'),
('Anju', 'Chawla'),
('Vladimir','Putin'),
('Homer','Simpsom')
;

INSERT INTO items (name, price)
VALUES ('Burguer', 6.50),
('Fries', 5.00),
('Coke', 2.00),
('Hot Dog', 4.50),
('Poutine', 4.00)
;

INSERT INTO employees (employee_name)
VALUES ('Justin Bieber'),
('Nicholas Maduro'),
('Cristiano Ronaldo'),
('Bill Gates'),
('Kim Kardasian')
;

INSERT INTO orders (quantity, date, items_id, customers_id, employees_id)
VALUES (3, '12/01/2019',1,1,1),
(2, '12/01/2019',2,3,2),
(1, '12/01/2019',1,5,4),
(2, '12/01/2019',5,1,3),
(2, '12/01/2019',2,2,2),
(2, '12/01/2019',3,4,1),
(3, '12/01/2019',4,2,1),
(4, '12/01/2019',3,1,2),
(1, '12/01/2019',5,3,4),
(2, '12/01/2019',2,4,5),
(3, '12/01/2019',5,5,1),
(2, '12/01/2019',3,3,3),
(5, '12/01/2019',4,4,2),
(1, '12/01/2019',5,1,1),
(2, '12/01/2019',2,2,3),
(4, '12/01/2019',2,4,5)
;

INSERT INTO reviews (reviews, orders_id)
VALUES ('The hamburguer and the Asian girl that cooks were absolutely amazing <3!' , 1),
('Best burguer in Barrie!!', 4),
('I will difinitely come back', 6),
('Can not wait to bring my lover here. Excellent place!', 7),
('Niaaaa, you could improve', 10)
;

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM items;
SELECT * FROM reviews;
SELECT * FROM employees;

#a. All customers, orders and order items grouped by customers and orders

SELECT customers.name AS 'Customer Name', items.name AS 'Menu' , orders.id AS 'Nº of Order', orders.quantity AS 'Quantity'
FROM orders INNER JOIN customers ON orders.customers_id = customers.id
INNER JOIN items ON orders.items_id = items.id
ORDER BY customers.id, orders.id
;
