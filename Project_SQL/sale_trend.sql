/*
SALES TRENDS & ORDER PATTERN
-------------------------------------------
Objective:
Analyze sales trends over time and identify patterns 
in customer purchasing behavior.
-------------------------------------------
    Key Questions:
    1. Monthly revenue and order count

    2. Yearly revenue and average order value

    3. Revenue on weekdays vs weekends

    4. Highest-revenue day for each year

    5. Revenue in first half vs second half of each year
*/

---1. Monthly revenue and total order.
SELECT 
    EXTRACT(month FROM o.order_date) AS month,
    SUM(oi.line_total) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

---2. Yearly revenue and average order value
SELECT
    EXTRACT(year FROM o.order_date) AS year,
    SUM(oi.line_total) AS total_revenue,
    SUM(oi.line_total) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year;

---3. Revenue on weekdays vs weekends
SELECT
    CASE 
        WHEN EXTRACT(dow FROM o.order_date) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(oi.line_total) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY day_type
ORDER BY total_revenue DESC;

---4. Highest-revenue day for each year
WITH daily_revenue AS (
    SELECT
        DATE(o.order_date) AS day,
        EXTRACT(year FROM o.order_date) AS year,
        SUM(oi.line_total) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY day, year
)
SELECT dr.*
FROM daily_revenue dr
WHERE dr.total_revenue = (
    SELECT MAX(dr2.total_revenue)
    FROM daily_revenue dr2
    WHERE dr2.year = dr.year
)
ORDER BY year, day;

---5. Compare H1 vs H2 revenue in each year
SELECT
    EXTRACT(year FROM o.order_date) AS year,
    CASE 
        WHEN EXTRACT(month FROM o.order_date) <= 6 THEN 'H1'
        ELSE 'H2'
    END AS half_year,
    SUM(oi.line_total) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year, half_year
ORDER BY year, half_year;