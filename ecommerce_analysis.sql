CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

CREATE TABLE sales_data (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_Name VARCHAR(100),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Region VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(12,2),
    Discount DECIMAL(5,2),
    Sales DECIMAL(14,2)
);

USE ecommerce_analytics;

SELECT * FROM ecommerce_analytics.sales_data;

SELECT DATABASE();

SHOW TABLES FROM ecommerce_analytics;

SELECT * 
FROM sales_data;

USE ecommerce_analytics;

SELECT COUNT(*) AS Total_Rows
FROM sales_data;

SELECT *
FROM sales_data
LIMIT 10;

USE ecommerce_analytics;

DROP TABLE IF EXISTS sales_data;

CREATE TABLE sales_data (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_Name VARCHAR(100),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Region VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(12,2),
    Discount DECIMAL(5,2),
    Sales DECIMAL(14,2)
);
CREATE TABLE sales_data_raw (
    Order_ID VARCHAR(20),
    Order_Date VARCHAR(20),
    Customer_Name VARCHAR(100),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Region VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(12,2),
    Discount DECIMAL(5,2),
    Sales DECIMAL(14,2)
);

SELECT COUNT(*) AS Total_Rows
FROM sales_data_raw;

SELECT *
FROM sales_data_raw
LIMIT 10;

INSERT INTO sales_data (
    Order_ID,
    Order_Date,
    Customer_Name,
    Product,
    Category,
    Region,
    Quantity,
    Unit_Price,
    Discount,
    Sales
)
SELECT
    Order_ID,
    STR_TO_DATE(Order_Date, '%d-%m-%Y'),
    Customer_Name,
    Product,
    Category,
    Region,
    Quantity,
    Unit_Price,
    Discount,
    Sales
FROM sales_data_raw;


SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Order_ID) AS Unique_Order_IDs,
    COUNT(*) - COUNT(DISTINCT Order_ID) AS Duplicate_Order_IDs
FROM sales_data;

SELECT
    SUM(Order_ID IS NULL) AS Missing_Order_ID,
    SUM(Order_Date IS NULL) AS Missing_Order_Date,
    SUM(Customer_Name IS NULL) AS Missing_Customer_Name,
    SUM(Product IS NULL) AS Missing_Product,
    SUM(Category IS NULL) AS Missing_Category,
    SUM(Region IS NULL) AS Missing_Region,
    SUM(Quantity IS NULL) AS Missing_Quantity,
    SUM(Unit_Price IS NULL) AS Missing_Unit_Price,
    SUM(Discount IS NULL) AS Missing_Discount,
    SUM(Sales IS NULL) AS Missing_Sales
FROM sales_data;

SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data;

SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM sales_data;

SELECT
    COUNT(DISTINCT Customer_Name) AS Total_Customers
FROM sales_data;

SELECT
    SUM(Quantity) AS Total_Quantity
FROM sales_data;

SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM sales_data;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT
    Product,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY Product
ORDER BY Total_Sales DESC;

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Month;

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Total_Sales DESC
LIMIT 1;

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Total_Sales ASC
LIMIT 1;

SELECT
    Category,
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY Category, Region
ORDER BY Total_Sales DESC;

SELECT
    Order_ID,
    Product,
    Sales,
    CASE
        WHEN Sales >= 100000 THEN 'High'
        WHEN Sales >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS Sales_Performance
FROM sales_data;

SELECT
    Product,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Sales_Rank
FROM sales_data
GROUP BY Product;

SELECT
    Product,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY Product
HAVING SUM(Sales) = (
    SELECT MAX(Product_Sales)
    FROM (
        SELECT SUM(Sales) AS Product_Sales
        FROM sales_data
        GROUP BY Product
    ) AS Product_Totals
);

SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_Name) AS Total_Customers,
    SUM(Quantity) AS Total_Quantity,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM sales_data;









































































































