-- Create Inital Table schema from column headers - Gabe Tharp
CREATE TABLE ecommerce (
    Row_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(14),
    Order_Date DATE,
	Ship_Date DATE,
    Ship_Mode VARCHAR(14),
    Customer_ID VARCHAR(11),
    Customer_Name VARCHAR(150),
    Segment VARCHAR(11),
    Country VARCHAR(13),
    City VARCHAR(17),
    State VARCHAR(20),
    Postal_Code VARCHAR(10),
    Region VARCHAR(7),
    Product_ID VARCHAR(15),
    Category VARCHAR(15),
    SubCategory VARCHAR(12),
    Product_Name VARCHAR(130),
    Sales DECIMAL(7,2),
    Quantity INT,
    Discount DECIMAL(3,2),
    Profit DECIMAL(7,2) 
);
-- Test that it uploaded - Gabe Tharp
SELECT * FROM ecommerce LIMIT 5;
-- Create 2NF tables for normalization -- Owen Randolph
CREATE TABLE Customers (
    Customer_ID VARCHAR(11) PRIMARY KEY,
    Customer_Name VARCHAR(150) NOT NULL UNIQUE,
    Segment VARCHAR(11)
);

CREATE TABLE Orders (
    Order_ID VARCHAR(14) PRIMARY KEY,
    Customer_ID VARCHAR(11),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(14),
    Postal_Code VARCHAR(10),
    Region VARCHAR(7),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

CREATE TABLE Products (
    Product_ID VARCHAR(15) PRIMARY KEY,
    Product_Name VARCHAR(130) NOT NULL UNIQUE,
    Category VARCHAR(15),
    SubCategory VARCHAR(12)
);

CREATE TABLE Order_Details (
    Order_ID VARCHAR(14),
    Product_ID VARCHAR(15),
    Quantity INT NOT NULL,
    Discount DECIMAL(3,2),
    Sales DECIMAL(7,2),
    Profit DECIMAL(7,2),
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);
-- Add data to the new tables -  Owen Randolph
INSERT INTO Customers (Customer_ID, Customer_Name, Segment)
SELECT DISTINCT Customer_ID, Customer_Name, Segment
FROM ecommerce;

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Ship_Date, Ship_Mode, Postal_Code, Region)
SELECT DISTINCT Order_ID, Customer_ID, Order_Date, Ship_Date, Ship_Mode, Postal_Code, Region
FROM ecommerce;

INSERT INTO Products (Product_ID, Product_Name, Category, SubCategory)
SELECT DISTINCT Product_ID, Product_Name, Category, SubCategory
FROM ecommerce;

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Discount, Sales, Profit)
SELECT DISTINCT Order_ID, Product_ID, Quantity, Discount, Sales, Profit
FROM ecommerce;

-- Test query to see if DDL has worked
SELECT * FROM order_details LIMIT 5;

-- Create more tables for 3NF normalization - Marcos Fernandez
CREATE TABLE Categories (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Subcategories (
    SubCategory_ID INT AUTO_INCREMENT PRIMARY KEY,
    SubCategory_Name VARCHAR(12) NOT NULL UNIQUE,
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID)
);

CREATE TABLE Locations (
    Postal_Code VARCHAR(10) PRIMARY KEY,
    Region VARCHAR(7) NOT NULL UNIQUE
);

-- Insert data into new tables - Marcos Fernandez
INSERT INTO Categories (Category_Name)
SELECT DISTINCT Category FROM ecommerce;

INSERT INTO Subcategories (SubCategory_Name, Category_ID)
SELECT DISTINCT 
    e.SubCategory,
    c.Category_ID
FROM ecommerce e
JOIN Categories c ON e.Category = c.Category_Name;

INSERT INTO Locations (Postal_Code, Region)
SELECT DISTINCT Postal_Code, Region FROM ecommerce;

-- Add foreign keys for new tables - Owen Randolph
ALTER TABLE products
ADD FOREIGN KEY (SubCategory_ID) REFERENCES subcategories(SubCategory_ID);

ALTER TABLE orders
ADD FOREIGN KEY (Postal_Code) REFERENCES locations(Postal_Code);

ALTER TABLE products
DROP COLUMN Category,
DROP COLUMN SubCategory;

ALTER TABLE orders
DROP COLUMN Region;

DESCRIBE products;












