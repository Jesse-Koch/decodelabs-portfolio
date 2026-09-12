-- ============================================================
-- PROJECT 3: SQL DATA ANALYSIS
-- DecodeLabs Industrial Training
-- Author: Jesse Trevor Koch
-- Dataset: 1,200 rows, 14 columns
-- Database: MySQL
-- ============================================================

-- ============================================================
-- SETUP: DATABASE AND TABLE
-- ============================================================

CREATE DATABASE IF NOT EXISTS decodelabs;
USE decodelabs;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    OrderID VARCHAR(50) PRIMARY KEY,
    OrderDate DATE,
    CustomerID VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    ShippingAddress VARCHAR(50),
    PaymentMethod  VARCHAR(50),
    OrderStatus VARCHAR(20),
    TrackingNumber VARCHAR(50),
    ItemsInCart INT,
    CouponCode VARCHAR(50),
    ReferralSource VARCHAR(50),
    TotalPrice DECIMAL(10,2)
);

-- Enable local file loading
SET GLOBAL local_infile = 1;

-- Imported the cleaned CSV
LOAD DATA LOCAL INFILE 'E:/et/Data Analysis/DecodeLabs/DecodeLabs_Dataset_Cleaned.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Verify import
SELECT COUNT(*) AS total_rows FROM orders;


-- ============================================================
-- SECTION 1: BASIC SELECT QUERIES
-- ============================================================

-- Q1: Preview all columns for the first 10 orders
SELECT *
FROM orders
LIMIT 10;

-- Q2: Select specific columns for all orders
SELECT OrderID, OrderDate, CustomerID, Product, Quantity, TotalPrice
FROM orders;

-- Q3: Show the 20 most recent orders
SELECT OrderID, OrderDate, CustomerID, Product, Quantity, TotalPrice
FROM orders
ORDER BY OrderDate DESC
LIMIT 20;


-- ============================================================
-- SECTION 2: WHERE CLAUSE
-- ============================================================

-- Q4: Count delivered orders
SELECT COUNT(OrderID) AS delivered_orders
FROM orders
WHERE OrderStatus = 'Delivered';

-- Q5: High-value orders above 2,000
SELECT OrderID, TotalPrice, Product
FROM orders
WHERE TotalPrice > 2000;

-- Q6: Orders from Facebook
SELECT ReferralSource, COUNT(OrderID) AS orders
FROM orders
WHERE ReferralSource = 'Facebook';

-- Q7: Most recent 20 orders (ascending)
SELECT OrderID, OrderDate, CustomerID, Product, Quantity, TotalPrice
FROM orders
ORDER BY OrderDate ASC
LIMIT 20;

-- Q8: Distinct products with unit prices, sorted alphabetically
SELECT DISTINCT Product, UnitPrice
FROM orders
ORDER BY Product ASC;

-- Q9: Top 20 highest-value orders
SELECT OrderID, OrderDate, CustomerID, Product, Quantity, TotalPrice
FROM orders
ORDER BY TotalPrice DESC
LIMIT 20;


-- ============================================================
-- SECTION 3: GROUP BY + COUNT
-- ============================================================

-- Q10: Order count by OrderStatus
SELECT OrderStatus, COUNT(OrderID) AS orders
FROM orders
GROUP BY OrderStatus;

-- Q11: Order count by ReferralSource
SELECT ReferralSource, COUNT(OrderID) AS orders
FROM orders
GROUP BY ReferralSource;

-- Q12: Order count by Year
SELECT YEAR(OrderDate) AS order_year, COUNT(OrderID) AS orders
FROM orders
GROUP BY order_year;

-- Q13: Order count by PaymentMethod
SELECT PaymentMethod, COUNT(OrderID) AS orders
FROM orders
GROUP BY PaymentMethod;

-- Q14: Count of unique customers
SELECT COUNT(DISTINCT CustomerID) AS customers
FROM orders;

-- Q15: Order count by Product
SELECT Product, COUNT(OrderID) AS orders
FROM orders
GROUP BY Product;

-- Q16: Count of high-value orders (above 2,000)
SELECT COUNT(OrderID) AS orders
FROM orders
WHERE TotalPrice > 2000;

-- Q17: Count of orders with no coupon
SELECT COUNT(OrderID) AS orders
FROM orders
WHERE CouponCode = 'No Coupon';

-- Q18: Count of orders that used specific coupons
SELECT COUNT(OrderID) AS orders
FROM orders
WHERE CouponCode IN ('SAVE10', 'FREESHIP', 'WINTER15');


-- ============================================================
-- SECTION 4: GROUP BY + SUM
-- ============================================================

-- Q19: Total revenue
SELECT SUM(TotalPrice) AS total_revenue
FROM orders;

-- Q20: Revenue by Product
SELECT Product, SUM(TotalPrice) AS revenue
FROM orders
GROUP BY Product
ORDER BY revenue DESC;

-- Q21: Revenue by ReferralSource
SELECT ReferralSource, SUM(TotalPrice) AS revenue
FROM orders
GROUP BY ReferralSource
ORDER BY revenue DESC;

-- Q22: Revenue by PaymentMethod
SELECT PaymentMethod, SUM(TotalPrice) AS revenue
FROM orders
GROUP BY PaymentMethod
ORDER BY revenue DESC;

-- Q23: Revenue and orders by Year
SELECT YEAR(OrderDate) AS order_year, SUM(TotalPrice) AS revenue, COUNT(OrderID) AS orders
FROM orders
GROUP BY order_year
ORDER BY revenue DESC;

-- Q24: Total quantity sold by Product
SELECT Product, SUM(Quantity) AS total_sold
FROM orders
GROUP BY Product
ORDER BY total_sold DESC;


-- ============================================================
-- SECTION 5: GROUP BY + AVG
-- ============================================================

-- Q25: Overall average order value
SELECT ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders;

-- Q26: Average order value by PaymentMethod
SELECT PaymentMethod, ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY PaymentMethod
ORDER BY avg_order_value DESC;

-- Q27: Average order value by ReferralSource
SELECT ReferralSource, ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY ReferralSource
ORDER BY avg_order_value DESC;

-- Q28: Average quantity by Product
SELECT Product, ROUND(AVG(Quantity), 1) AS avg_quantity
FROM orders
GROUP BY Product
ORDER BY avg_quantity DESC;

-- Q29: Average order value and revenue by Year
SELECT YEAR(OrderDate) AS order_year, ROUND(AVG(TotalPrice), 2) AS avg_order_value, SUM(TotalPrice) AS revenue
FROM orders
GROUP BY order_year
ORDER BY avg_order_value DESC, revenue DESC;

-- Q30: Average order value and revenue by Product
SELECT Product, ROUND(AVG(TotalPrice), 2) AS avg_order_value, SUM(TotalPrice) AS revenue
FROM orders
GROUP BY Product
ORDER BY avg_order_value DESC, revenue DESC;

-- Q31: Average order value and revenue by PaymentMethod
SELECT PaymentMethod, ROUND(AVG(TotalPrice), 2) AS avg_order_value, SUM(TotalPrice) AS revenue
FROM orders
GROUP BY PaymentMethod
ORDER BY avg_order_value DESC, revenue DESC;


-- ============================================================
-- SECTION 6: WHERE + GROUP BY
-- ============================================================

-- Q32: Revenue by Product, only for Delivered orders
SELECT Product, OrderStatus, SUM(TotalPrice) AS revenue
FROM orders
WHERE OrderStatus = 'Delivered'
GROUP BY Product, OrderStatus
ORDER BY revenue DESC;

-- Q33: Revenue by PaymentMethod, only for 2024
SELECT PaymentMethod, SUM(TotalPrice) AS revenue
FROM orders
WHERE YEAR(OrderDate) = 2024
GROUP BY PaymentMethod
ORDER BY revenue DESC;

-- Q34: Average order value by Product, only for coupon orders
SELECT Product, ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
WHERE CouponCode <> 'No Coupon'
GROUP BY Product
ORDER BY avg_order_value DESC;

-- Q35: Total quantity sold by Product — only for Delivered orders
SELECT Product, SUM(Quantity) AS total_sold
FROM orders
WHERE OrderStatus = 'Delivered'
GROUP BY Product
ORDER BY total_sold DESC;


-- ============================================================
-- SECTION 7: HAVING (FILTER GROUPS)
-- ============================================================

-- Q36: Customers who placed more than 1 order
SELECT CustomerID, COUNT(OrderID) AS orders
FROM orders
GROUP BY CustomerID
HAVING orders > 1
ORDER BY orders DESC;

-- Q37: Months with revenue above 50,000
SELECT YEAR(OrderDate) AS order_year, MONTHNAME(OrderDate) AS order_month, SUM(TotalPrice) AS revenue
FROM orders
GROUP BY order_year, order_month
HAVING revenue > 50000
ORDER BY revenue DESC;

-- Q38: PaymentMethods with more than 250 orders
SELECT PaymentMethod, COUNT(OrderID) AS orders
FROM orders
GROUP BY PaymentMethod
HAVING orders > 250
ORDER BY orders DESC;

-- Q39: Weekdays with average order value above 1,000
SELECT DAYNAME(OrderDate) AS week_day, COUNT(OrderID) AS orders, ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY week_day
HAVING avg_order_value > 1000
ORDER BY avg_order_value DESC, orders DESC;