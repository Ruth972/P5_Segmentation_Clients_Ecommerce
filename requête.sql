
-- Requête 1 : Commandes récentes livrées en retard

SELECT
    order_id,
    customer_id,
    order_purchase_timestamp,
    order_delivered_customer_date,
    JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date) AS retard_en_jours
FROM
    orders
WHERE
    order_status = 'delivered'
    
    AND order_purchase_timestamp >= (
        SELECT DATE(MAX(order_purchase_timestamp), '-3 months') FROM orders
    )
    
    AND retard_en_jours >= 3
ORDER BY
    retard_en_jours DESC;

-- Requête 2 : Vendeurs à haut chiffre d'affaires (> 100k BRL)

SELECT
    oi.seller_id,
    SUM(oi.price) AS total_revenue
FROM
    orders AS o
INNER JOIN
    order_items AS oi ON o.order_id = oi.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    oi.seller_id
HAVING
    SUM(oi.price) > 100000
ORDER BY
    total_revenue DESC;


-- Requête 3 : Nouveaux vendeurs très engagés

WITH latest_order AS (
    SELECT MAX(order_purchase_timestamp) AS max_date
    FROM orders
),
unique_order_lines AS (
    SELECT DISTINCT
        oi.seller_id,
        o.order_id,
        oi.price,
        o.order_purchase_timestamp
    FROM
        orders AS o
    INNER JOIN
        order_items AS oi ON o.order_id = oi.order_id
    WHERE
        o.order_status = 'delivered'
),
seller_aggregation AS (
    SELECT
        seller_id,
        SUM(price) AS total_amount_sold,
        COUNT(order_id) AS total_items_sold, -- On compte les lignes uniques, pas le total des produits
        MIN(order_purchase_timestamp) AS first_sale_date
    FROM
        unique_order_lines
    GROUP BY
        seller_id
)
SELECT
    seller_id,
    total_amount_sold,
    total_items_sold
FROM
    seller_aggregation
WHERE
    -- On garde les vendeurs "nouveaux"
    first_sale_date >= (SELECT DATE(max_date, '-3 months') FROM latest_order)
    -- On garde les vendeurs "engagés"
    AND total_items_sold > 30
ORDER BY
    total_items_sold DESC;

    
-- Requête 4 : Top 5 des codes postaux avec les pires avis

SELECT
    c.customer_zip_code_prefix,
    AVG(r.review_score) AS score_moyen,
    COUNT(r.review_id) AS nombre_avis
FROM
    orders AS o
INNER JOIN
    order_reviews AS r ON o.order_id = r.order_id
INNER JOIN
    customers AS c ON o.customer_id = c.customer_id
WHERE
    o.order_purchase_timestamp >= (
        SELECT DATE(MAX(order_purchase_timestamp), '-12 months') FROM orders
    )
GROUP BY
    c.customer_zip_code_prefix
HAVING
    COUNT(r.review_id) > 30
ORDER BY
    score_moyen ASC
LIMIT 5;
