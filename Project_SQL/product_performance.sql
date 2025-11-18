/*
PRODUCT PERFORMANCE & PROFITABILITY ANALYSIS
-------------------------------------------
Objective:
Identify top-selling and high-profit products 
to understand what drives business performance.
-------------------------------------------
    Key Questions:
    1. Which product category generates the highest total revenue?

    2. Which individual products generate the highest total revenue?

    3. What is the average unit price for each product category?

    4. Which products have the largest difference between unit_price and unit_cost?

    5. Which products have the highest cancellation/return rate?
*/

---1. Which product category generates the highest total revenue?
SELECT p.category,
    SUM(oi.line_total) AS total_revenue
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

---2. Which individual products generate the highest total revenue?
SELECT p.product_id,
    p.product_name,
    SUM(oi.line_total) AS total_revenue
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY total_revenue DESC;

---3. What is the average unit price for each product category?
SELECT category,
    AVG(unit_price) AS avg_unit_price
FROM products
GROUP BY category;

---4. Which products have the largest difference between unit_price and unit_cost?
SELECT product_name,
    (unit_price - unit_cost) AS price_cost_difference
FROM products
ORDER BY price_cost_difference DESC;

---5. Which products have the highest cancellation/return rate?
SELECT p.product_name,
    COUNT(o.order_status) AS cancellation_return_count
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
LEFT JOIN orders AS o
ON oi.order_id = o.order_id
WHERE order_status IN ('Cancelled', 'Returned')
GROUP BY p.product_name
ORDER BY cancellation_return_count DESC;