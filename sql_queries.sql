/* =========================================================
   SALES DATA ANALYSIS -- SQL QUERIES
   Author: Abraham (github.com/Spiritual-Dev)

   Dataset: data/sales_data.csv -> import as table `sales`
   Tool: SQLite syntax, but these run fine in MySQL/Postgres too
         with minor tweaks (strftime -> DATE_FORMAT etc.)
   =========================================================

   TABLE SCHEMA
   sales (
     OrderID       INTEGER,
     OrderDate     TEXT,      -- format: YYYY-MM-DD
     CustomerName  TEXT,
     Area          TEXT,      -- Lagos area: Ikeja, Lekki, Surulere, Ikorodu, Yaba, Ajah
     Category      TEXT,
     Product       TEXT,
     Quantity      INTEGER,
     UnitPrice     REAL,
     TotalSale     REAL,
     PaymentMethod TEXT
   )
   ========================================================= */


-- 1. OVERALL SNAPSHOT
-- First thing I check on any dataset -- how big is it, how much money
-- moved, and what does a typical order look like.
SELECT
    COUNT(OrderID)            AS total_orders,
    SUM(Quantity)             AS total_units_sold,
    ROUND(SUM(TotalSale), 2)  AS total_revenue,
    ROUND(AVG(TotalSale), 2)  AS avg_order_value
FROM sales;


-- 2. REVENUE BY AREA
-- Wanted to see which Lagos areas are actually bringing in the money,
-- not just where most of the orders are coming from.
SELECT
    Area,
    COUNT(OrderID)            AS orders,
    ROUND(SUM(TotalSale), 2)  AS revenue
FROM sales
GROUP BY Area
ORDER BY revenue DESC;


-- 3. REVENUE BY CATEGORY
-- Same idea but by product category -- tells you where to focus stock
-- and marketing spend.
SELECT
    Category,
    COUNT(OrderID)            AS orders,
    ROUND(SUM(TotalSale), 2)  AS revenue
FROM sales
GROUP BY Category
ORDER BY revenue DESC;


-- 4. TOP 10 PRODUCTS BY REVENUE
SELECT
    Product,
    Category,
    SUM(Quantity)              AS units_sold,
    ROUND(SUM(TotalSale), 2)   AS revenue
FROM sales
GROUP BY Product, Category
ORDER BY revenue DESC
LIMIT 10;


-- 5. MONTHLY REVENUE TREND
-- This is the one I'd show first in a report -- shows if the business
-- is actually growing across the year or just staying flat.
SELECT
    strftime('%Y-%m', OrderDate) AS month,
    COUNT(OrderID)                AS orders,
    ROUND(SUM(TotalSale), 2)      AS revenue
FROM sales
GROUP BY month
ORDER BY month;


-- 6. AVERAGE ORDER VALUE BY AREA
-- Orders and revenue alone can be misleading -- an area could have fewer
-- orders but customers spending a lot more per order. This catches that.
SELECT
    Area,
    ROUND(AVG(TotalSale), 2) AS avg_order_value
FROM sales
GROUP BY Area
ORDER BY avg_order_value DESC;


-- 7. TOP 10 CUSTOMERS BY SPEND
-- Useful for spotting your "regulars" -- the people worth a loyalty
-- discount or a personal follow-up message.
SELECT
    CustomerName,
    COUNT(OrderID)             AS orders,
    ROUND(SUM(TotalSale), 2)   AS total_spent
FROM sales
GROUP BY CustomerName
ORDER BY total_spent DESC
LIMIT 10;


-- 8. PAYMENT METHOD BREAKDOWN
-- Good for knowing what payment options actually need to work well on
-- checkout -- no point over-investing in one nobody uses.
SELECT
    PaymentMethod,
    COUNT(OrderID)              AS orders,
    ROUND(SUM(TotalSale), 2)    AS revenue,
    ROUND(100.0 * COUNT(OrderID) / (SELECT COUNT(*) FROM sales), 1) AS pct_of_orders
FROM sales
GROUP BY PaymentMethod
ORDER BY revenue DESC;


-- 9. CATEGORY PERFORMANCE BY AREA
-- Cross-checks category against area -- e.g. maybe Electronics does great
-- in Lekki but barely sells in Ikorodu. Helps with area-specific stocking.
SELECT
    Area,
    Category,
    ROUND(SUM(TotalSale), 2) AS revenue
FROM sales
GROUP BY Area, Category
ORDER BY Area, revenue DESC;


-- 10. HIGH-VALUE ORDERS (ABOVE AVERAGE)
-- Flags the "big" orders sitting above the average order value --
-- worth looking at individually rather than lumped into an average.
SELECT
    OrderID,
    OrderDate,
    CustomerName,
    Product,
    TotalSale
FROM sales
WHERE TotalSale > (SELECT AVG(TotalSale) FROM sales)
ORDER BY TotalSale DESC
LIMIT 20;


-- 11. PAYMENT METHOD PREFERENCE ON HIGH-VALUE ORDERS (MY OWN QUESTION)
-- I wanted to know something the other queries don't tell you directly --
-- do people paying by transfer/card tend to spend MORE per order than
-- people paying cash on delivery or USSD? If yes, that's worth knowing
-- for anyone deciding which payment options to push at checkout.
SELECT
    PaymentMethod,
    COUNT(OrderID)             AS orders,
    ROUND(AVG(TotalSale), 2)   AS avg_order_value
FROM sales
GROUP BY PaymentMethod
ORDER BY avg_order_value DESC;
