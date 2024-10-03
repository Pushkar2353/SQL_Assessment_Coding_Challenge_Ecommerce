Create Database SQL_Coding_Challenge
go

USE SQL_Coding_Challenge
GO

CREATE TABLE Customers (
    customer_ID INT PRIMARY KEY IDENTITY(1,1), 
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,                    
    Email VARCHAR(100) NOT NULL UNIQUE,     
    Address VARCHAR(200) NOT NULL UNIQUE   
);

CREATE TABLE Products (
    product_ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(200) NOT NULL UNIQUE ,
	Price DECIMAL(10, 2) NOT NULL,
    stockQuantity VARCHAR(15) NOT NULL
);

CREATE TABLE Cart (
    cart_ID INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    product_id INT,
    quantity VARCHAR(15) NOT NULL,
    FOREIGN KEY (customer_ID) REFERENCES Customers(customer_ID),
    FOREIGN KEY (product_ID) REFERENCES Products(product_ID)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity VARCHAR(15) NOT NULL,
	item_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO Customers (First_Name, Last_Name, Email, Address)
VALUES
('John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
('Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
('Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
('Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
('David', 'Lee', 'david@example.com', '234 Cedar St, District'),
('Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
('Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
('Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
('William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
('Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory');
GO

INSERT INTO Products (Name, Description, Price, stockQuantity)
VALUES
('Laptop', 'High-performance laptop', 800.00, '10'),
('Smartphone', 'Latest smartphone', 600.00, '15'),
('Tablet', 'Portable tablet', 300.00, '20'),
('Headphones', 'Noise-canceling', 150.00, '30'),
('TV', '4K Smart TV', 900.00, '5'),
('Coffee Maker', 'Automatic coffee maker', 50.00, '25'),
('Refrigerator', 'Energy-efficient', 700.00, '10'),
('Microwave Oven', 'Countertop microwave', 80.00, '15'),
('Blender', 'High-speed blender', 70.00, '20'),
('Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, '10');

INSERT INTO Cart (customer_id, product_id, quantity)
VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 4),
(3, 5, 2),
(4, 6, 1),
(5, 1, 1),
(6, 10, 2),
(6, 9, 3),
(7, 7, 2);

INSERT INTO Orders (customer_id, order_date, total_price)
VALUES
(1, '2023-01-05', 1200.00),
(2, '2023-02-10', 900.00),
(3, '2023-03-15', 300.00),
(4, '2023-04-20', 150.00),
(5, '2023-05-25', 1800.00),
(6, '2023-06-30', 400.00),
(7, '2023-07-05', 700.00),
(8, '2023-08-10', 160.00),
(9, '2023-09-15', 140.00),
(10, '2023-10-20', 1400.00);

INSERT INTO Order_Items (order_id, product_id, quantity, item_amount)
VALUES
(1, 1, 2, 1600.00),
(1, 3, 1, 300.00),
(2, 2, 3, 1800.00),
(3, 5, 2, 1800.00),
(4, 4, 4, 600.00),
(4, 6, 1, 50.00),
(5, 1, 1, 800.00),
(5, 2, 2, 1200.00),
(6, 10, 2, 240.00),
(6, 9, 3, 210.00);


SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Cart;
SELECT * FROM Orders;
SELECT * FROM Order_Items;


--1
UPDATE Products
SET Price = 800.00
WHERE Name = 'Refrigerator';

SELECT * FROM Products;

--2
DELETE FROM Cart
WHERE customer_id = 4;

SELECT * FROM Cart;

--3
SELECT * FROM Products
WHERE Price < 100;

--4
SELECT * FROM Products
WHERE CAST(stockQuantity AS INT) > 5;

--5
SELECT * FROM Orders
WHERE total_price BETWEEN 500 AND 1000;

--6
SELECT * FROM Products
WHERE Name LIKE '%r';

--7
INSERT INTO Cart (customer_id, product_id, quantity)
VALUES
(5, 1, 1);

SELECT * FROM Cart;

SELECT * FROM Cart
WHERE customer_id = 5;

--8
SELECT DISTINCT c.First_Name, c.Last_Name, c.Email
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;

--9
SELECT Name, MIN(CAST(stockQuantity AS INT)) AS MinStock
FROM Products
GROUP BY Name;

--10
SELECT c.First_Name, c.Last_Name, SUM(o.total_price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.First_Name, c.Last_Name;

--11
SELECT c.customer_ID,c.First_Name, c.Last_Name, AVG(o.total_price) AS AvgOrderAmount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_ID,c.First_Name, c.Last_Name;

--12
SELECT c.customer_ID,c.First_Name, c.Last_Name, COUNT(o.order_id) AS OrderCount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_ID,c.First_Name, c.Last_Name;

--13
SELECT c.customer_ID,c.First_Name, c.Last_Name, MAX(o.total_price) AS MaxOrderAmount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_ID,c.First_Name, c.Last_Name;

--14
SELECT c.First_Name, c.Last_Name, SUM(o.total_price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.First_Name, c.Last_Name
HAVING SUM(o.total_price) > 1000;

--15
SELECT * FROM Products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Cart);

--16
DELETE FROM Orders
WHERE customer_id = 9;
SELECT * FROM Orders

SELECT * FROM Customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders);

--17
SELECT Name, (SUM(oi.item_amount) * 100.0 / (SELECT SUM(item_amount) FROM Order_Items)) AS RevenuePercentage
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY Name;

--18
SELECT * FROM Products
WHERE CAST(stockQuantity AS INT) < (SELECT AVG(CAST(stockQuantity AS INT)) FROM Products);

--19
SELECT * FROM Customers
WHERE customer_id IN (SELECT customer_id FROM Orders WHERE total_price > 1000);



