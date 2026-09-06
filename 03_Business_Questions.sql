--- BQ1 — Overall Sales Performance 
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(price_usd) AS total_revenue,
    SUM(items_purchased) AS total_items_sold,
    ROUND(AVG(price_usd), 2) AS average_order_value
FROM orders;

--- BQ2 — Sales Trend Over Time 
SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price_usd), 2) AS total_revenue
FROM orders
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
ORDER BY month;

--- BQ3 — Product Performance 
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.price_usd) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC;

--- BQ4 — Product Revenue Contribution 
SELECT
    p.product_name,
    ROUND(SUM(oi.price_usd), 2) AS product_revenue,
    ROUND(
        SUM(oi.price_usd) * 100.0 /
        (SELECT SUM(price_usd) FROM order_items),
        2
    ) AS revenue_contribution_pct
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY product_revenue DESC;


--- BQ5 — Marketing Source Performance 
SELECT
    COALESCE(ws.utm_source, 'Direct') AS marketing_source,
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY COALESCE(ws.utm_source, 'Direct')
ORDER BY total_orders DESC;

--- BQ6 — Website Conversion Performance 
SELECT
    COALESCE(ws.utm_source, 'Direct') AS marketing_source,
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT ws.website_session_id),
        2
    ) AS conversion_rate_pct
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY COALESCE(ws.utm_source, 'Direct')
ORDER BY conversion_rate_pct DESC;

--- BQ7 — New vs Repeat Sessions 
SELECT
    CASE
        WHEN ws.is_repeat_session = 1 THEN 'Repeat'
        ELSE 'New'
    END AS session_type,
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT ws.website_session_id),
        2
    ) AS conversion_rate_pct
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY
    CASE
        WHEN ws.is_repeat_session = 1 THEN 'Repeat'
        ELSE 'New'
    END
ORDER BY conversion_rate_pct DESC;


--- BQ8 — Customer Order Behavior 
SELECT
    user_id,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price_usd), 2) AS total_spent,
    ROUND(AVG(price_usd), 2) AS avg_order_value
FROM orders
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;


--- BQ9 — Refund Analysis 
SELECT
    p.product_name,
    COUNT(DISTINCT oi.order_item_id) AS total_items,
    COUNT(DISTINCT r.order_item_id) AS refunded_items,
    ROUND(COALESCE(SUM(r.refund_amount_usd), 0), 2) AS total_refunded_amount,
    ROUND(
        COUNT(DISTINCT r.order_item_id) * 100.0
        / COUNT(DISTINCT oi.order_item_id),
        2
    ) AS refund_rate_pct
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN order_item_refunds r
    ON oi.order_item_id = r.order_item_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_refunded_amount DESC;


--- BQ10 — Advanced Business Analysis 
SELECT
    p.product_name,
    ROUND(SUM(oi.price_usd), 2) AS product_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING SUM(oi.price_usd) >
(
    SELECT AVG(product_revenue)
    FROM
    (
        SELECT SUM(price_usd) AS product_revenue
        FROM order_items
        GROUP BY product_id
    ) AS product_totals
)
ORDER BY product_revenue DESC;