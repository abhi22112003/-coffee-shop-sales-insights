USE coffeesales;
-- Total sales for May
SELECT ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales 
FROM coffee_shop_sales 
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5;

-- Total orders in May
SELECT COUNT(transaction_id) AS Total_Orders
FROM coffee_shop_sales 
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5;

-- Total quantity sold in May
SELECT SUM(transaction_qty) AS Total_Quantity_Sold
FROM coffee_shop_sales 
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5;

-- Month-over-Month sales comparison (April vs May)
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

-- Sales performance by store location
SELECT 
    store_location,
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5 
GROUP BY store_location
ORDER BY Total_Sales DESC;

-- Sales performance by product category
SELECT 
    product_category,
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5 
GROUP BY product_category
ORDER BY Total_Sales DESC;

-- Sales trends by day of the week
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5
GROUP BY Day_of_Week;

-- Sales performance by hour of the day
SELECT 
    HOUR(transaction_time) AS Hour_of_Day,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(STR_TO_DATE(transaction_date, '%d/%m/%y')) = 5
GROUP BY Hour_of_Day
ORDER BY Hour_of_Day;

