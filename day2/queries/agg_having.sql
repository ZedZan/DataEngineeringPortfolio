SELECT 
    us.first_name, 
    us.last_name, 
    SUM(ord.quantity * pro.price) AS total_spent
FROM orders AS ord
JOIN users AS us ON us.user_id = ord.user_id
JOIN products AS pro ON pro.product_id = ord.product_id
GROUP BY us.user_id, us.first_name, us.last_name
HAVING SUM(ord.quantity * pro.price) > 500;

