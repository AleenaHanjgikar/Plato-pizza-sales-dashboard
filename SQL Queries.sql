CREATE DATABASE pizza_sales_db;
USE pizza_sales_db;

-- TotalRevenue
SELECT 
    SUM(total_price) AS total_revenue
FROM 
    pizza_sales;

-- Sales by Day of the Week (Busiest Days)
-- Goal: Find which days of the week are busiest in terms of sales.
SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS day_of_week,
    SUM(total_price) AS total_revenue
FROM 
    pizza_sales
GROUP BY 
    day_of_week
ORDER BY 
    total_revenue DESC;

-- Sales by Hour of the Day (Peak Hours)
-- Goal: Find what time of day has the highest sales.
SELECT 
    HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS hour_of_day,
    SUM(total_price) AS total_revenue
FROM 
    pizza_sales
GROUP BY 
    hour_of_day
ORDER BY 
    total_revenue DESC;

-- Best & Worst-Selling Pizzas (By Quantity Sold)
--  Find which pizzas sell the most and which sell the least.
SELECT 
    pizza_name,
    SUM(quantity) AS total_quantity_sold
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    total_quantity_sold DESC;

-- What’s Our Average Order Value?
-- Goal: Find the average value of each order -> important for understanding customer spending habits.
SELECT 
    AVG(order_total) AS average_order_value
FROM (
    SELECT 
        order_id, 
        SUM(total_price) AS order_total
    FROM 
        pizza_sales
    GROUP BY 
        order_id
) AS subquery;

-- Final Query → Seating Capacity Utilization
-- Goal: Estimate how well the restaurant utilizes its seating capacity.
--  Let’s estimate -> Number of orders per day -> Peak Hours -> Utilization.
--  1. Orders Per Day -> Are we filling the restaurant on busy days?
SELECT 
    HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS hour_of_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    hour_of_day
ORDER BY 
    total_orders DESC;

-- Peak Hour Estimate
-- 2. Orders Per Hour (Peak Periods) -> Busiest Hours of Day
SELECT 
    HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS hour_of_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    hour_of_day
ORDER BY 
    total_orders DESC;

-- Highest orders in a single hour on a single day
--
SELECT 
    STR_TO_DATE(order_date, '%d-%m-%Y') AS order_date,
    HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS hour_of_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    order_date, hour_of_day
ORDER BY 
    total_orders DESC;

