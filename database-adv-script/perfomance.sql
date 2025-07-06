-- Initial Query: Retrieve all bookings with user, property, and payment details
SELECT 
    b.id AS booking_id,
    b.created_at AS booking_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.payment_method
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON pay.booking_id = b.id;

-- Analyze Performance
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.created_at AS booking_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.payment_method
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON pay.booking_id = b.id;

-- Refactored Query (Assumes large dataset and need for performance)
-- Remove unneeded fields and use indexing-friendly JOINs
EXPLAIN ANALYZE
SELECT 
    b.id, b.created_at, u.name, p.name, pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON pay.booking_id = b.id
WHERE b.created_at > NOW() - INTERVAL '90 days';
