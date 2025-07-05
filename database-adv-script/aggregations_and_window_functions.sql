-- Query 1: Total number of bookings made by each user
SELECT
    users.id AS user_id,
    users.first_name,
    users.last_name,
    COUNT(bookings.id) AS total_bookings
FROM
    users
LEFT JOIN
    bookings ON users.id = bookings.user_id
GROUP BY
    users.id, users.first_name, users.last_name
ORDER BY
    total_bookings DESC;

-- Query 2: Rank properties based on the total number of bookings
SELECT
    property_id,
    COUNT(*) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS booking_rank
FROM
    bookings
GROUP BY
    property_id;
