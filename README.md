# Sales Data Analysis

A beginner-friendly data analysis project exploring one year (2025) of e-commerce sales data across five Nigerian regions. Built entirely with **SQL** and **Excel** — no extra tools or libraries — to demonstrate core data analysis fundamentals.

## 📌 Project Overview

This project analyzes 600 sales transactions to answer common business questions:
- Which regions and product categories drive the most revenue?
- How do sales trend across the year?
- Who are the highest-value customers?
- What payment methods do customers prefer?

## 🛠️ Tools Used

- **Excel** — data cleaning, pivot-style summary tables, charts, KPI dashboard
- **SQL (SQLite syntax, works in any standard SQL engine)** — 10 business analysis queries

## 📁 Project Structure

```
sales-data-analysis/
├── data/
│   └── sales_data.csv          # Raw dataset (600 records)
├── sales_data_analysis.xlsx    # Excel workbook: raw data, summary dashboard, charts, findings
├── sql_queries.sql             # 10 SQL queries covering key business questions
└── README.md
```

## 📊 Dataset

`data/sales_data.csv` contains 600 orders with the following fields:

| Column | Description |
|---|---|
| OrderID | Unique order identifier |
| OrderDate | Date of purchase (YYYY-MM-DD) |
| CustomerName | Customer placing the order |
| Region | Lagos, Abuja, Port Harcourt, Ibadan, or Kano |
| Category | Electronics, Fashion, Home & Living, or Beauty |
| Product | Specific product purchased |
| Quantity | Units purchased |
| UnitPrice | Price per unit (₦) |
| TotalSale | Quantity × UnitPrice (₦) |
| PaymentMethod | Card, Bank Transfer, Cash on Delivery, or USSD |

## 📈 Excel Workbook

`sales_data_analysis.xlsx` has three sheets:
1. **Raw Data** — the full, cleaned dataset
2. **Summary & Insights** — KPI dashboard (total revenue, orders, average order value) plus summary tables and charts for revenue by region, revenue by category, and the monthly revenue trend
3. **Key Findings** — a written summary of the business insights uncovered

All summary figures are built with live Excel formulas (`SUMIF`, `COUNTIF`, `SUMPRODUCT`), so they recalculate automatically if the raw data changes.

## 🗄️ SQL Analysis

`sql_queries.sql` contains 10 queries, including:
1. Total revenue and order overview
2. Revenue by region
3. Revenue by product category
4. Top 10 best-selling products
5. Monthly sales trend
6. Average order value by region
7. Top 10 customers by spend
8. Payment method breakdown
9. Category performance by region
10. High-value orders above the average

**To run these queries yourself:** import `data/sales_data.csv` into any SQL tool (SQLite, MySQL Workbench, or even Excel's Power Query) as a table named `sales`, then run the queries in `sql_queries.sql`.

## 🔍 Key Business Insights

- **Lagos leads all regions** in both order volume and total revenue.
- **Electronics is the top revenue category**, driven mainly by Laptop and Smartphone sales, even though Fashion has more individual orders.
- **Kano has the highest average order value**, suggesting fewer but higher-ticket purchases.
- **Card and USSD payments** together make up over half of all orders, showing a strong customer preference for digital payment over cash on delivery.
- **A small group of repeat customers** account for a disproportionate share of total revenue, pointing to an opportunity for a loyalty program.

## 👤 About

This project was built as a portfolio piece to demonstrate practical SQL and Excel data analysis skills for entry-level / assistant data analyst roles.
