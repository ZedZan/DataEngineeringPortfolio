- Week 1 Day 1 SQL Queries

-- 1. Join users + orders + products to show order summary
SELECT ur.first_name, ur.last_name, pr.product_name, ord.quantity,
       (ord.quantity * pr.price) AS total_price, ord.order_id
FROM orders AS ord
JOIN products AS pr ON pr.product_id = ord.product_id
JOIN users AS ur ON ur.user_id = ord.user_id
ORDER BY total_price DESC;

-- 2. Total sales per user
SELECT ur.first_name, ur.last_name, SUM(pr.price * ord.quantity) AS total_price
FROM orders AS ord
JOIN products AS pr ON pr.product_id = ord.product_id
JOIN users AS ur ON ur.user_id = ord.user_id
GROUP BY ur.user_id, ur.first_name, ur.last_name
ORDER BY total_price DESC;

