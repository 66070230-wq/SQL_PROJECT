/*
 CUSTOMER BEHAVIOR & SEGMENTATION ANALYSIS
 -------------------------------------------
 Objective:
 Understand how different customer groups (segment + country) contribute to revenue,
 order volume, and retention.
 -------------------------------------------
 Key Questions:
 1. Which customer segment have the most revenue?
 
 2. What is the average order value (AOV) by segment and country?
 
 3. Which countries have the most active customers?
 
 4. How many orders does each customer segment place in total?
 
 5. What is the total revenue per customer segment and country??
 */

--- Which customer segment have the most revenue?
SELECT c.segment,
    COALESCE(SUM(oi.line_total)) AS total_revenue
FROM customers AS c
    LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi 
    ON o.order_id = oi.order_id
GROUP BY c.segment
ORDER BY total_revenue DESC;

--- What is the average order value by segment and country?
SELECT c.segment,
    c.country,
    SUM(oi.line_total) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM customers c
    LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY c.segment,
    c.country
ORDER BY avg_order_value DESC;

--- Which countries have the most active customers?
SELECT country,
    COUNT(DISTINCT customer_id) AS active_customers
FROM customers
GROUP BY country
ORDER BY active_customers DESC;

--- How many orders does each customer segment place in total?
SELECT c.segment,
    COUNT(o.order_id) as Total_orders
FROM customers AS c
    LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
GROUP BY c.segment
ORDER BY Total_orders DESC;

--- What is the total revenue per customer segment and country?
SELECT c.segment,
    c.country,
    SUM(oi.line_total) as Total_revenue
FROM customers AS c
LEFT JOIN orders as o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items as oi
    ON o.order_id = oi.order_id
GROUP BY c.segment, c.country
ORDER BY Total_revenue DESC;