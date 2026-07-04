# Sales Data Analysis

I built this project to practice core data analysis fundamentals with SQL and Excel before applying for entry-level / assistant data analyst roles. It looks at a year (2025) of e-commerce sales activity across six areas of Lagos.

## Why I built it this way

I deliberately kept this to just SQL and Excel, no Python, no extra libraries, to show I can handle the fundamentals cleanly before reaching for more tooling.

## Tools Used

- **Excel** — data cleaning, summary tables, KPI dashboard, charts
- **SQL (SQLite syntax)** — 11 queries covering the business questions I'd actually want answered

## Project Structure

```
sales-data-analysis/
├── data/
│   └── sales_data.csv          # Raw dataset (600 records)
├── sales_data_analysis.xlsx    # Excel workbook: raw data, dashboard, charts, findings
├── sql_queries.sql             # 11 SQL queries
└── README.md
```

## About the Data

`data/sales_data.csv` is a self-generated dataset built for practice purposes — not real company data. It has 600 orders with the following fields:

| Column | Description |
|---|---|
| OrderID | Unique order identifier |
| OrderDate | Date of purchase (YYYY-MM-DD) |
| CustomerName | Customer placing the order |
| Area | Lagos area: Ikeja, Lekki, Surulere, Ikorodu, Yaba, or Ajah |
| Category | Electronics, Fashion, Home & Living, or Beauty |
| Product | Specific product purchased |
| Quantity | Units purchased |
| UnitPrice | Price per unit (₦) |
| TotalSale | Quantity × UnitPrice (₦) |
| PaymentMethod | Card, Bank Transfer, Cash on Delivery, or USSD |

## Excel Workbook

`sales_data_analysis.xlsx` has three sheets:
1. **Raw Data** — the full dataset, frozen header row for easy scrolling
2. **Summary & Insights** — KPI dashboard (total revenue, orders, average order value) plus summary tables and charts for revenue by area, revenue by category, and the monthly revenue trend
3. **Key Findings** — my own read on what the numbers are showing

Every summary figure is a live formula (`SUMIF`, `COUNTIF`, `SUMPRODUCT`), so the dashboard updates itself if the raw data changes — nothing is hardcoded.

## SQL Analysis

`sql_queries.sql` has 11 queries. The first 10 cover the standard questions (revenue by area, top products, monthly trend, top customers, payment breakdown, etc.). The 11th is one I wanted to check myself: whether customers paying by card or transfer tend to spend more per order than those paying cash on delivery or USSD.

**To run these yourself:** import `data/sales_data.csv` into any SQL tool (SQLite, MySQL Workbench, or Excel's Power Query) as a table named `sales`, then run the queries in `sql_queries.sql`.

## What I Found

- **Ikeja and Lekki bring in the most revenue by far** — the busiest, most commercial areas in the dataset, so this tracks.
- **Electronics is the top revenue category**, even though Fashion has more individual orders — a few expensive laptops and phones outweigh a lot of cheaper items.
- **Ajah has fewer orders than anywhere else, but its average order value holds up** — worth watching if that area grows.
- **Revenue moves up and down month to month** rather than trending steadily — in a real business I'd want to line this up against promo dates or seasonal events to explain the spikes.
- **Card and USSD together make up over half of all orders**, so checkout needs to work flawlessly for those two first.
- **A small group of customers place way more orders than everyone else** — worth a loyalty perk or a personal follow-up, since they're already proving they'll buy again.

## About

Built by Abraham — [github.com/Spiritual-Dev](https://github.com/Spiritual-Dev)