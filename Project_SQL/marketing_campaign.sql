/*
MARKETING CAMPAIGN EFFECTIVENESS & ROI
-------------------------------------------
Objective:
Measure the performance of marketing campaigns and their impact on 
sales and customer behavior.
-------------------------------------------
    Key Questions:
    1. Revenue and orders per campaign

    2. Simple ROI per campaign

    3. Revenue per channel + average revenue per campaign

    4. Conversion: how many completed orders per campaign

    5. Compare campaigns vs no campaign
*/

---1. Revenue and orders per campaign
SELECT
    mc.campaign_id,
    mc.campaign_name,
    SUM(oi.line_total) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM marketing_campaigns mc
LEFT JOIN orders o ON mc.campaign_id = o.campaign_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY mc.campaign_id, mc.campaign_name
ORDER BY total_revenue DESC;

---2. Simple ROI per campaign
WITH campaign_revenue AS (
    SELECT
        mc.campaign_id,
        mc.campaign_name,
        mc.budget_usd,
        SUM(oi.line_total) AS total_revenue
    FROM marketing_campaigns mc
    LEFT JOIN orders o ON mc.campaign_id = o.campaign_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY mc.campaign_id, mc.campaign_name, mc.budget_usd
)
SELECT
    campaign_id,
    campaign_name,
    budget_usd,
    total_revenue,
    total_revenue - budget_usd AS roi
FROM campaign_revenue
ORDER BY roi DESC;

---3. Revenue per channel + average revenue per campaign
WITH campaign_revenue AS (
    SELECT
        mc.campaign_id,
        mc.channel,
        SUM(oi.line_total) AS total_revenue
    FROM marketing_campaigns mc
    LEFT JOIN orders o ON mc.campaign_id = o.campaign_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY mc.campaign_id, mc.channel
)
SELECT
    channel,
    SUM(total_revenue) AS total_revenue,
    AVG(total_revenue) AS avg_revenue_per_campaign
FROM campaign_revenue
GROUP BY channel
ORDER BY total_revenue DESC;

---4. How many completed orders per campaign
SELECT
    mc.campaign_id,
    mc.campaign_name,
    SUM(CASE WHEN o.order_status = 'Completed' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN o.order_status <> 'Completed' OR o.order_status IS NULL THEN 1 ELSE 0 END) AS non_completed_orders
FROM marketing_campaigns mc
LEFT JOIN orders o ON mc.campaign_id = o.campaign_id
GROUP BY mc.campaign_id, mc.campaign_name
ORDER BY completed_orders DESC;

---5. Compare campaigns vs no campaign
WITH order_revenue AS (
    SELECT
        o.order_id,
        CASE 
            WHEN o.campaign_id IS NULL THEN 'No Campaign'
            ELSE 'Has Campaign'
        END AS campaign_flag,
        SUM(oi.line_total) AS order_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, campaign_flag
)
SELECT 
    campaign_flag,
    COUNT(*) AS num_orders,
    SUM(order_revenue) AS total_revenue
FROM order_revenue
GROUP BY campaign_flag
ORDER BY total_revenue DESC;