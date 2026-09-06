SELECT COUNT(*) AS total_rows
FROM orders;

SELECT COUNT(*) AS total_rows
FROM order_items;

SELECT COUNT(*) AS total_rows
FROM order_item_refunds;

SELECT COUNT(*) AS total_rows
FROM products;

SELECT COUNT(*) AS total_rows
FROM website_sessions;

SELECT COUNT(*) AS total_rows
FROM website_pageviews;



SELECT
    order_id,
    COUNT(*) AS count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
    order_item_id,
    COUNT(*) AS count
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

SELECT
    order_item_refund_id,
    COUNT(*) AS count
FROM order_item_refunds
GROUP BY order_item_refund_id
HAVING COUNT(*) > 1;

SELECT
    product_id,
    COUNT(*) AS count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT
    website_session_id,
    COUNT(*) AS count
FROM website_sessions
GROUP BY website_session_id
HAVING COUNT(*) > 1;

SELECT
    website_pageview_id,
    COUNT(*) AS count
FROM website_pageviews
GROUP BY website_pageview_id
HAVING COUNT(*) > 1;



SELECT
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(created_at IS NULL) AS created_at_nulls,
    SUM(website_session_id IS NULL) AS session_id_nulls,
    SUM(user_id IS NULL) AS user_id_nulls,
    SUM(primary_product_id IS NULL) AS product_id_nulls,
    SUM(items_purchased IS NULL) AS items_purchased_nulls,
    SUM(price_usd IS NULL) AS price_nulls,
    SUM(cogs_usd IS NULL) AS cogs_nulls
FROM orders;


SELECT
    SUM(order_item_id IS NULL) AS order_item_id_nulls,
    SUM(created_at IS NULL) AS created_at_nulls,
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(product_id IS NULL) AS product_id_nulls,
    SUM(is_primary_item IS NULL) AS is_primary_item_nulls,
    SUM(price_usd IS NULL) AS price_nulls,
    SUM(cogs_usd IS NULL) AS cogs_nulls
FROM order_items;


SELECT
    SUM(order_item_refund_id IS NULL) AS refund_id_nulls,
    SUM(created_at IS NULL) AS created_at_nulls,
    SUM(order_item_id IS NULL) AS order_item_id_nulls,
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(refund_amount_usd IS NULL) AS refund_amount_nulls
FROM order_item_refunds;


SELECT
    SUM(product_id IS NULL) AS product_id_nulls,
    SUM(created_at IS NULL) AS created_at_nulls,
    SUM(product_name IS NULL) AS product_name_nulls
FROM products;


SELECT
    SUM(website_session_id IS NULL) AS session_id_nulls,
    SUM(created_at IS NULL) AS created_at_nulls,
    SUM(user_id IS NULL) AS user_id_nulls,
    SUM(is_repeat_session IS NULL) AS repeat_session_nulls,
    SUM(utm_source IS NULL) AS utm_source_nulls,
    SUM(utm_campaign IS NULL) AS utm_campaign_nulls,
    SUM(utm_content IS NULL) AS utm_content_nulls,
    SUM(device_type IS NULL) AS device_type_nulls,
    SUM(http_referer IS NULL) AS http_referer_nulls
FROM website_sessions;


SELECT
    SUM(website_pageview_id IS NULL) AS pageview_id_nulls,
    SUM(created_at IS NULL) AS created_at_nulls,
    SUM(website_session_id IS NULL) AS session_id_nulls,
    SUM(pageview_url IS NULL) AS pageview_url_nulls
FROM website_pageviews;



SELECT *
FROM orders
WHERE items_purchased < 0
   OR price_usd < 0
   OR cogs_usd < 0;
   

SELECT *
FROM order_items
WHERE price_usd < 0
   OR cogs_usd < 0;
   
   
SELECT *
FROM order_item_refunds
WHERE refund_amount_usd < 0;


SELECT *
FROM orders
WHERE items_purchased <= 0;


SELECT
    MIN(created_at) AS earliest_order,
    MAX(created_at) AS latest_order
FROM orders;

SELECT oi.order_id
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


SELECT oi.product_id
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT r.order_item_id
FROM order_item_refunds r
LEFT JOIN order_items oi
    ON r.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL;

SELECT o.website_session_id
FROM orders o
LEFT JOIN website_sessions ws
    ON o.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL;

--- Overall Business Overview ---
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(price_usd) AS total_revenue,
    SUM(items_purchased) AS total_items_sold,
    AVG(price_usd) AS average_order_value
FROM orders;


--- Product Overview ---
SELECT
    p.product_id,
    p.product_name, 
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.price_usd) AS total_revenue,
    SUM(oi.price_usd - oi.cogs_usd) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC;


--- Website Overview ---
SELECT
    COUNT(*) AS total_sessions,
    COUNT(DISTINCT user_id) AS unique_users,
    SUM(is_repeat_session) AS repeat_sessions
FROM website_sessions;


--- Website Pageview Overview ---
SELECT
    COUNT(*) AS total_pageviews,
    COUNT(DISTINCT website_session_id) AS sessions_with_pageviews,
    ROUND(COUNT(*) / COUNT(DISTINCT website_session_id), 2) AS avg_pageviews_per_session
FROM website_pageviews;


--- Website Conversion Overview ---
SELECT
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT ws.website_session_id), 2
    ) AS conversion_rate
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id;
    
    
--- Refund Overview ---
SELECT
    COUNT(*) AS total_refunds,
    SUM(refund_amount_usd) AS total_refunded_amount,
    AVG(refund_amount_usd) AS average_refund_amount
FROM order_item_refunds;