SELECT
    c.customer_id,
    c.first_name || '' || c.last_name AS customer_name,
    (SELECT SUM(p.amount)
    FROM payments p
    WHERE p.customer_id = c.customer_id AS total_amount_spent,
    (SELECT AVG(o.amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id AS avg_order_value
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY total_amount_spent DESC;