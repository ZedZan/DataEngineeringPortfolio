SELECT *
FROM (
    SELECT
        us.first_name,
        us.last_name,
        ord.order_id,
        (ord.quantity * pro.price) AS total_price,
        ROW_NUMBER() OVER (
            PARTITION BY us.user_id
            ORDER BY (ord.quantity * pro.price) DESC
        ) AS rn
    FROM orders AS ord
    JOIN users AS us ON us.user_id = ord.user_id
    JOIN products AS pro ON pro.product_id = ord.product_id
) AS sub
WHERE rn = 1;

