CREATE DATABASE restaurant_db;

USE restaurant_db;
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    salary DECIMAL(10,2),
    joining_date DATE
);
CREATE TABLE menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    availability VARCHAR(20) DEFAULT 'Available'
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    table_id INT,
    staff_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(30) DEFAULT 'Pending',

    FOREIGN KEY (table_id)
        REFERENCES restaurant_tables(table_id),

    FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
);
USE restaurant_db;

CREATE TABLE IF NOT EXISTS restaurant_tables (
    table_id INT PRIMARY KEY AUTO_INCREMENT,
    table_number INT UNIQUE NOT NULL,
    capacity INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Available'
);
SHOW TABLES;
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    table_id INT,
    staff_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(30) DEFAULT 'Pending',

    FOREIGN KEY (table_id)
        REFERENCES restaurant_tables(table_id),

    FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (menu_id)
        REFERENCES menu(menu_id)
);
CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNIQUE NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) DEFAULT 0,
    discount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30) DEFAULT 'Pending',
    bill_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);
SHOW TABLES;
DESC staff;
DESC restaurant_tables;
DESC menu;
DESC orders;
DESC order_items;
DESC billing;
INSERT INTO staff
(staff_name, role, phone, salary, joining_date)
VALUES
('Rahul Sharma','Manager','9876543210',35000,'2025-01-10'),
('Amit Kumar','Waiter','9876543211',18000,'2025-02-15'),
('Neha Singh','Waiter','9876543212',19000,'2025-03-12'),
('Pooja Verma','Cashier','9876543213',22000,'2025-04-05'),
('Rohit Kumar','Chef','9876543214',28000,'2025-05-20'),
('Anjali Gupta','Waiter','9876543215',18500,'2025-06-11'),
('Vikas Yadav','Chef','9876543216',30000,'2025-07-01'),
('Simran Kaur','Cashier','9876543217',23000,'2025-07-18'),
('Arjun Singh','Waiter','9876543218',17500,'2025-08-09'),
('Karan Mehta','Chef','9876543219',29000,'2025-08-20'),
('Nisha Sharma','Waiter','9876543220',18500,'2025-09-01'),
('Deepak Singh','Manager','9876543221',38000,'2025-09-15'),
('Priya Gupta','Waiter','9876543222',19000,'2025-10-10'),
('Manish Kumar','Chef','9876543223',31000,'2025-11-05'),
('Riya Verma','Cashier','9876543224',22500,'2025-12-01');
SELECT * FROM staff;

INSERT INTO restaurant_tables
(table_number, capacity, status)
VALUES
(1,2,'Available'),
(2,2,'Occupied'),
(3,4,'Available'),
(4,4,'Occupied'),
(5,6,'Available'),
(6,2,'Available'),
(7,4,'Occupied'),
(8,6,'Available'),
(9,2,'Available'),
(10,4,'Occupied'),
(11,6,'Available'),
(12,2,'Available'),
(13,4,'Available'),
(14,6,'Occupied'),
(15,2,'Available');
SELECT * FROM restaurant_tables;
INSERT INTO menu
(item_name, category, price, availability)
VALUES
('Paneer Tikka','Starter',220,'Available'),
('Chicken Tikka','Starter',280,'Available'),
('Veg Spring Roll','Starter',160,'Available'),
('French Fries','Starter',120,'Available'),
('Butter Chicken','Main Course',320,'Available'),
('Paneer Butter Masala','Main Course',280,'Available'),
('Dal Makhani','Main Course',220,'Available'),
('Chicken Biryani','Rice',300,'Available'),
('Veg Biryani','Rice',220,'Available'),
('Jeera Rice','Rice',160,'Available'),
('Butter Naan','Bread',50,'Available'),
('Garlic Naan','Bread',70,'Available'),
('Tandoori Roti','Bread',35,'Available'),
('Cold Drink','Beverage',60,'Available'),
('Fresh Lime Soda','Beverage',90,'Available');
SELECT * FROM menu;
INSERT INTO orders
(table_id, staff_id, order_status)
VALUES
(1,2,'Completed'),
(2,3,'Completed'),
(3,2,'Pending'),
(4,6,'Completed'),
(5,9,'Preparing'),
(6,11,'Completed'),
(7,3,'Completed'),
(8,13,'Pending'),
(9,2,'Completed'),
(10,6,'Preparing'),
(11,9,'Completed'),
(12,11,'Completed'),
(13,13,'Pending'),
(14,3,'Completed'),
(15,2,'Completed');

INSERT INTO order_items
(order_id, menu_id, quantity, price)
VALUES
(1,1,2,220),
(1,11,4,50),

(2,5,1,320),
(2,8,1,300),
(2,14,2,60),

(3,6,2,280),
(3,12,2,70),

(4,2,2,280),
(4,9,1,220),

(5,8,2,300),
(5,13,4,35),

(6,7,1,220),
(6,11,3,50),

(7,1,1,220),
(7,5,1,320),

(8,9,2,220),
(8,14,2,60),

(9,3,2,160),
(9,12,2,70),

(10,5,2,320),
(10,8,1,300),

(11,6,1,280),
(11,11,4,50),

(12,4,2,120),
(12,15,2,90),

(13,2,1,280),
(13,8,1,300),

(14,7,2,220),
(14,13,4,35),

(15,1,2,220),
(15,14,2,60);
INSERT INTO billing
(order_id, subtotal, tax, discount, total_amount, payment_method, payment_status)
VALUES
(1,640,32,0,672,'Cash','Paid'),
(2,740,37,20,757,'UPI','Paid'),
(3,700,35,0,735,'Card','Pending'),
(4,780,39,30,789,'UPI','Paid'),
(5,740,37,0,777,'Cash','Pending'),
(6,370,18.5,0,388.5,'UPI','Paid'),
(7,540,27,0,567,'Card','Paid'),
(8,560,28,20,568,'UPI','Pending'),
(9,460,23,0,483,'Cash','Paid'),
(10,940,47,40,947,'Card','Pending'),
(11,480,24,0,504,'UPI','Paid'),
(12,420,21,0,441,'Cash','Paid'),
(13,580,29,0,609,'UPI','Pending'),
(14,580,29,30,579,'Card','Paid'),
(15,560,28,0,588,'Cash','Paid');
SELECT * FROM menu;
SELECT item_name, price
FROM menu;
SELECT *
FROM menu
WHERE price > 200;
SELECT *
FROM menu
WHERE availability = 'Available';
SELECT *
FROM menu
ORDER BY price DESC;
SELECT
    o.order_id,
    rt.table_number,
    s.staff_name,
    o.order_date,
    o.order_status
FROM orders o
JOIN restaurant_tables rt
    ON o.table_id = rt.table_id
JOIN staff s
    ON o.staff_id = s.staff_id;
    SELECT
    o.order_id,
    m.item_name,
    oi.quantity,
    oi.price
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN menu m
    ON oi.menu_id = m.menu_id;
    SELECT
    category,
    AVG(price) AS average_price
FROM menu
GROUP BY category;
SELECT
    category,
    AVG(price) AS average_price
FROM menu
GROUP BY category
HAVING AVG(price) > 200;
SELECT
    payment_method,
    SUM(total_amount) AS total_collection
FROM billing
WHERE payment_status = 'Paid'
GROUP BY payment_method;
SELECT *
FROM menu
WHERE price = (
    SELECT MAX(price)
    FROM menu
);
SELECT *
FROM menu
WHERE price > (
    SELECT AVG(price)
    FROM menu
);
CREATE VIEW order_summary AS
SELECT
    o.order_id,
    rt.table_number,
    s.staff_name,
    o.order_date,
    o.order_status
FROM orders o
JOIN restaurant_tables rt
    ON o.table_id = rt.table_id
JOIN staff s
    ON o.staff_id = s.staff_id;
    SELECT * FROM order_summary;
    DELIMITER //

CREATE TRIGGER after_order_completed
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.order_status = 'Completed'
       AND OLD.order_status <> 'Completed' THEN

        UPDATE restaurant_tables
        SET status = 'Available'
        WHERE table_id = NEW.table_id;

    END IF;
END //

DELIMITER ;
UPDATE orders
SET order_status = 'Completed'
WHERE order_id = 3;
SELECT *
FROM restaurant_tables
WHERE table_id = 3;
SELECT SUM(total_amount) AS total_revenue
FROM billing
WHERE payment_status = 'Paid';
SELECT *
FROM billing
WHERE total_amount = (
    SELECT MAX(total_amount)
    FROM billing
);
SELECT *
FROM billing
WHERE payment_status = 'Pending';
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN menu m
    ON oi.menu_id = m.menu_id
GROUP BY m.menu_id, m.item_name
ORDER BY total_quantity DESC;
SELECT
    s.staff_name,
    COUNT(o.order_id) AS total_orders
FROM staff s
LEFT JOIN orders o
    ON s.staff_id = o.staff_id
GROUP BY s.staff_id, s.staff_name
ORDER BY total_orders DESC;
SELECT
    o.order_id,
    rt.table_number,
    s.staff_name,
    m.item_name,
    oi.quantity,
    oi.price,
    b.total_amount,
    b.payment_method,
    b.payment_status
FROM orders o
JOIN restaurant_tables rt
    ON o.table_id = rt.table_id
JOIN staff s
    ON o.staff_id = s.staff_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN menu m
    ON oi.menu_id = m.menu_id
JOIN billing b
    ON o.order_id = b.order_id;