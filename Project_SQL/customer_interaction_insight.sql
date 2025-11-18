/*
CUSTOMER-PRODUCT-CAMPAIGN INTERACTION INSIGHT
-------------------------------------------
Objective:
Understand how customers, products,
and marketing campaigns interact to influence buying behavior.
-------------------------------------------
    Key Questions:
    1. Revenue per segment and category

    2. Average revenue per customer in each segment

    3. Revenue by region and segment

    4. Top 5 customers by total revenue

    5. Countries with average order value above global average
*/

---1. Revenue per segment and category
SELECT
    c.segment,
    p.category,
    SUM(oi.line_total) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.segment, p.category
ORDER BY c.segment, total_revenue DESC;

---2. Average revenue per customer in each segment
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.segment,
        COALESCE(SUM(oi.line_total), 0) AS total_revenue
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.segment
)
SELECT
    segment,
    ROUND(AVG(total_revenue), 2) AS avg_revenue_per_customer
FROM customer_revenue
GROUP BY segment
ORDER BY avg_revenue_per_customer DESC;

---3. Revenue by region and segment
SELECT
    CASE 
        WHEN country IN ('Thailand', 'Japan', 'Singapore') THEN 'Asia'
        ELSE 'Other'
    END AS region,
    c.segment,
    SUM(oi.line_total) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY region, c.segment
ORDER BY region, total_revenue DESC;

---4. Top 5 customers by total revenue
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.line_total) AS total_revenue
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id
JOIN order_items oi 
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC
LIMIT 5;

---5. Countries with average order value above global average
WITH order_values AS (
    SELECT
        o.order_id,
        c.country,
        SUM(oi.line_total) AS order_value
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, c.country
),
country_aov AS (
    SELECT
        country,
        AVG(order_value) AS avg_order_value
    FROM order_values
    GROUP BY country
)
SELECT
    country,
    avg_order_value
FROM country_aov
WHERE avg_order_value > (
    SELECT AVG(order_value) FROM order_values
)
ORDER BY avg_order_value DESC;