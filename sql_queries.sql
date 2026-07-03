/* =========================================================
   SALES DATA ANALYSIS — SQL QUERIES
   Dataset: data/sales_data.csv (import as table `sales`)
   Tool: SQLite (works in any standard SQL environment)
   =========================================================

   TABLE SCHEMA
   sales (
     OrderID       INTEGER,
     OrderDate     TEXT,      -- format: YYYY-MM-DD
     CustomerName  TEXT,
     Region        TEXT,
     Category      TEXT,
     Product       TEXT,
     Quantity      INTEGER,
     UnitPrice     REAL,
     TotalSale     REAL,
     PaymentMethod TEXT
   )
   ========================================================= */


-- 1. TOTAL REVENUE AND ORDER COUNT
-- Quick overview of overall business performance.
SELECT
    COUNT(OrderID)      AS total_orders,
    SUM(Quantity)        AS total_units_sold,
    ROUND(SUM(TotalSale), 2) AS total_revenue,
    ROUND(AVG(TotalSale), 2) AS avg_order_value
FROM sales;


-- 2. REVENUE BY REGION
-- Which regions generate the most sales.
SELECT
    Region,
    COUNT(OrderID)            AS orders,
    ROUND(SUM(TotalSale), 2)  AS revenue
FROM sales
GROUP BY Region
ORDER BY revenue DESC;


-- 3. REVENUE BY PRODUCT CATEGORY
-- Identifies the strongest performing category.
SELECT
    Category,
    COUNT(OrderID)            AS orders,
    ROUND(SUM(TotalSale), 2)  AS revenue
FROM sales
GROUP BY Category
ORDER BY revenue DESC;


-- 4. TOP 10 BEST-SELLING PRODUCTS (BY REVENUE)
SELECT
    Product,
    Category,
    SUM(Quantity)              AS units_sold,
    ROUND(SUM(TotalSale), 2)   AS revenue
FROM sales
GROUP BY Product, Category
ORDER BY revenue DESC
LIMIT 10;


-- 5. MONTHLY SALES TREND
-- Reveals seasonality and growth/decline across the year.
SELECT
    strftime('%Y-%m', OrderDate) AS month,
    COUNT(OrderID)                AS orders,
    ROUND(SUM(TotalSale), 2)      AS revenue
FROM sales
GROUP BY month
ORDER BY month;


-- 6. AVERAGE ORDER VALUE BY REGION
-- Shows which regions have higher-value baskets, not just more orders.
SELECT
    Region,
    ROUND(AVG(TotalSale), 2) AS avg_order_value
FROM sales
GROUP BY Region
ORDER BY avg_order_value DESC;


-- 7. TOP 10 CUSTOMERS BY TOTAL SPEND
SELECT
    CustomerName,
    COUNT(OrderID)             AS orders,
    ROUND(SUM(TotalSale), 2)   AS total_spent
FROM sales
GROUP BY CustomerName
ORDER BY total_spent DESC
LIMIT 10;


-- 8. PAYMENT METHOD BREAKDOWN
-- Useful for understanding customer payment preferences.
SELECT
    PaymentMethod,
    COUNT(OrderID)              AS orders,
    ROUND(SUM(TotalSale), 2)    AS revenue,
    ROUND(100.0 * COUNT(OrderID) / (SELECT COUNT(*) FROM sales), 1) AS pct_of_orders
FROM sales
GROUP BY PaymentMethod
ORDER BY revenue DESC;


-- 9. CATEGORY PERFORMANCE BY REGION (CROSS-ANALYSIS)
-- Which category sells best in which region — useful for targeted marketing/stocking.
SELECT
    Region,
    Category,
    ROUND(SUM(TotalSale), 2) AS revenue
FROM sales
GROUP BY Region, Category
ORDER BY Region, revenue DESC;


-- 10. HIGH-VALUE ORDERS (ABOVE AVERAGE)
-- Flags orders worth more than the overall average order value — useful for
-- spotting big-ticket transactions or potential VIP customers.
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
