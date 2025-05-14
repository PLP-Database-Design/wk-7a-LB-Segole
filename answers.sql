-- Question 1: Achieving 1NF (First Normal Form)

CREATE TABLE OrderProducts (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

INSERT INTO OrderProducts (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Achieving 2NF (Second Normal Form)

CREATE TABLE Customers2NF (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

INSERT INTO Customers2NF (CustomerID, CustomerName)
SELECT DISTINCT SUBSTR(OrderID, 1, 3) AS CustomerID, CustomerName
FROM OrderDetails;

CREATE TABLE OrderItems2NF (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

INSERT INTO OrderItems2NF (OrderID, ProductID, Quantity)
SELECT OrderID,
       CASE
           WHEN Product = 'Laptop' THEN 1
           WHEN Product = 'Mouse' THEN 2
           WHEN Product = 'Tablet' THEN 3
           WHEN Product = 'Keyboard' THEN 4
           WHEN Product = 'Phone' THEN 5
           ELSE 0 -- Handle unknown products
       END AS ProductID,
       Quantity
FROM OrderDetails;

SELECT * FROM Customers2NF;
SELECT * FROM OrderItems2NF;
