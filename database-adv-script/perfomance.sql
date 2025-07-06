-- Initial Query: Retrieve all bookings with user, property, and payment details
EXPLAIN ANALYZE
SELECT b.id AS booking_id, u.name AS user_name, p.title AS property_title, pay.amount AS payment_amount, b.created_at
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON pay.booking_id = b.id
WHERE b.created_at > NOW() - INTERVAL '30 days'
  AND pay.status = 'completed'
ORDER BY b.created_at DESC;

-- Optimized Query: Reduce unnecessary data, apply selective columns, and index usage
EXPLAIN ANALYZE
SELECT b.id, u.name, p.title, pay.amount, b.created_at
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
INNER JOIN payments pay ON pay.booking_id = b.id AND pay.status = 'completed'
WHERE b.created_at > NOW() - INTERVAL '30 days'
ORDER BY b.created_at DESC;
