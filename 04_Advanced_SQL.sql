--- Which products generated the most revenue, and how do they compare with the average product revenue 
WITH product_revenue AS (
    SELECT
        product_id,
        SUM(price_usd) AS total_revenue
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.product_name,
    ROUND(pr.total_revenue, 2) AS product_revenue,
    ROUND(AVG(pr.total_revenue) OVER (), 2) AS average_product_revenue,
    ROUND(
        pr.total_revenue - AVG(pr.total_revenue) OVER (),
        2
    ) AS difference_from_average
FROM product_revenue pr
JOIN products p
    ON pr.product_id = p.product_id
ORDER BY product_revenue DESC;


--- What is the revenue rank of each product 
SELECT
    p.product_name,
    ROUND(SUM(oi.price_usd), 2) AS product_revenue,
    RANK() OVER (
        ORDER BY SUM(oi.price_usd) DESC
    ) AS revenue_rank
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY revenue_rank;