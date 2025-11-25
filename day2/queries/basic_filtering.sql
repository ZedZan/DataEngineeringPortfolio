SELECT 
    us.first_name, 
    us.last_name, 
    pro.product_name, 
    (ord.quantity * pro.price) AS total_price
FROM orders AS ord
JOIN users AS us ON us.user_id = ord.user_id
JOIN products AS pro ON pro.product_id = ord.product_id
WHERE (ord.quantity * pro.price) > 300;

