-- Task 1: Average order value
WITH order_values AS (
    SELECT 
        ord.order_id,
        ord.quantity * pro.price AS total_value
    FROM orders AS ord
    JOIN products AS pro ON pro.product_id = ord.product_id
)
SELECT 
    AVG(total_value) AS average_order
FROM order_values;


-- Task 2: Compare each user to global average
WITH user_totals AS (
    SELECT 
        u.user_id,
        u.first_name,
        u.last_name,
        SUM(ord.quantity * pro.price) AS user_total
    FROM orders AS ord
    JOIN users AS u ON u.user_id = ord.user_id
    JOIN products AS pro ON pro.product_id = ord.product_id
    GROUP BY u.user_id, u.first_name, u.last_name
),
global_avg AS (
    SELECT AVG(ord.quantity * pro.price) AS average_order
    FROM orders AS ord
    JOIN products AS pro ON pro.product_id = ord.product_id
)
SELECT 
    ut.first_name,
    ut.last_name,
    ut.user_total,
    ga.average_order,
    CASE
        WHEN ut.user_total > ga.average_order THEN 'above'
        ELSE 'below'
    END AS status
FROM user_totals AS ut
CROSS JOIN global_avg AS ga;


-- Task 3: Top 3 most expensive orders
SELECT *
FROM (
    SELECT 
        o.order_id,
        u.first_name || ' ' || u.last_name AS user_name,
        p.product_name,
        o.quantity,
        p.price,
        (o.quantity * p.price) AS total_price,
        RANK() OVER (ORDER BY (o.quantity * p.price) DESC) AS price_rank
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    JOIN users u ON o.user_id = u.user_id
) ranked_orders
WHERE price_rank <= 3;


-- Task 4: Previous order comparison using LAG()
SELECT
    u.first_name,
    u.last_name,
    o.order_id,
    (o.quantity * p.price) AS total_price,
    LAG(o.quantity * p.price) OVER (
        PARTITION BY u.user_id
        ORDER BY o.order_id
    ) AS prev_total_price,
    (o.quantity * p.price 
     - LAG(o.quantity * p.price) OVER (
            PARTITION BY u.user_id
            ORDER BY o.order_id
       )
    ) AS diff_from_previous
FROM orders o
JOIN users u ON u.user_id = o.user_id
JOIN products p ON p.product_id = o.product_id;

