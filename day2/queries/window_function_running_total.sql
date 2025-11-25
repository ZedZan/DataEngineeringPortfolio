SELECT 
    us.first_name,
    us.last_name,
    ord.order_id,
    (ord.quantity * pro.price) AS total_price,
    SUM(ord.quantity * pro.price) OVER (
        PARTITION BY us.user_id
        ORDER BY ord.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM orders AS ord
JOIN users AS us ON us.user_id = ord.user_id
JOIN products AS pro ON pro.product_id = ord.product_id
ORDER BY us.user_id, ord.order_date;

