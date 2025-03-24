Coffee Shop Sales Analysis Using SQL

📌 Project Overview

This project focuses on analyzing coffee shop sales data using SQL. The goal is to extract meaningful business insights, including total revenue, sales trends, and store performance, which can help in decision-making.

📊 Key Insights & Analysis

Total Sales, Orders, and Quantity Sold – Evaluated overall revenue performance for May.

Month-over-Month Growth Analysis – Compared April vs. May sales trends.

Store & Product Performance – Identified top-performing locations and best-selling product categories.

Sales Trends by Time – Analyzed customer purchasing behavior by day of the week and hour of the day.

📂 Dataset Details

Table Name: coffee_shop_sales

Key Columns:

transaction_id – Unique order identifier

transaction_date – Date of transaction (DD/MM/YY format)

transaction_time – Time of purchase

unit_price – Price per unit

transaction_qty – Quantity purchased

store_location – Store where the transaction occurred

product_category – Product category (e.g., Coffee, Pastries)

🔍 SQL Queries Used

Total Sales for May

SELECT ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5;

Total Orders in May

SELECT COUNT(transaction_id) AS Total_Orders
FROM coffee_shop_sales
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5;

Month-over-Month Sales Comparison (April vs. May)

SELECT
    MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) AS month,
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y'))))
    / LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y'))) * 100 AS mom_increase_percentage
FROM
    coffee_shop_sales
WHERE
    MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) IN (4, 5)
GROUP BY
    MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y'))
ORDER BY
    MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y'));

Sales Performance by Store Location

SELECT
    store_location,
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5
GROUP BY store_location
ORDER BY Total_Sales DESC;

🚀 Tools & Technologies Used

SQL (MySQL) – Data extraction and analysis

Data Visualization – Optional (Excel, Power BI, Tableau, etc.)

📈 Business Impact

Helps identify peak sales hours and days for better staffing decisions.

Reveals best-performing store locations for strategic expansion.

Assists in optimizing inventory based on product category demand.

📎 How to Use This Project

Clone the repository.

Import the dataset into your MySQL database.

Run the provided SQL queries to generate insights.

Visualize the results using Excel, Power BI, or any BI tool.

🎯 Future Enhancements

Integrate a dashboard for interactive visualizations.

Expand analysis to include customer demographics and purchase patterns.

Apply machine learning for sales forecasting.
