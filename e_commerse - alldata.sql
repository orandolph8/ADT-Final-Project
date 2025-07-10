CREATE TABLE e_commerce (
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
    Postal_Code INT,
    Region VARCHAR(7),
    Product_ID VARCHAR(15),
    Category VARCHAR(15),
    SubCategory VARCHAR(12),
    Product_Name VARCHAR(130),
    Sales DECIMAL(7,2),
    Quantity INT,
    Discount FLOAT(2),
    Profit DECIMAL(7,2) 
);



