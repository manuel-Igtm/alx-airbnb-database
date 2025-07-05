# README.md - SQL Join Queries Documentation

This document explains three SQL join queries used to retrieve related data from an Airbnb-style relational database. The queries demonstrate how to effectively combine information across multiple tables: `users`, `bookings`, `properties`, and `reviews`.

---

## 1. INNER JOIN - Bookings and Users

### Query:

```sql
SELECT
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date,
    users.id AS user_id,
    users.first_name,
    users.last_name,
    users.email
FROM
    bookings
INNER JOIN
    users ON bookings.user_id = users.id;
```

### Description:

* Retrieves all bookings **that are linked to users**.
* Combines `bookings` and `users` where `bookings.user_id = users.id`.
* Excludes bookings without a valid user.
* Useful for showing who made each booking.

---

## 2. LEFT JOIN - Properties and Reviews

### Query:

```sql
SELECT
    properties.id AS property_id,
    properties.title,
    properties.location,
    reviews.id AS review_id,
    reviews.rating,
    reviews.comment
FROM
    properties
LEFT JOIN
    reviews ON properties.id = reviews.property_id;
```

### Description:

* Retrieves **all properties**, and their reviews if available.
* Ensures every property appears, even if it has **no reviews**.
* Review fields will be `NULL` for properties without reviews.
* Helps list all properties with their review status.

---

## 3. FULL OUTER JOIN - Users and Bookings

### Query:

```sql
SELECT
    users.id AS user_id,
    users.first_name,
    users.last_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date
FROM
    users
FULL OUTER JOIN
    bookings ON users.id = bookings.user_id;
```

### Description:

* Retrieves **all users and all bookings**, even if they don’t match.
* Includes:

  * Users without bookings.
  * Bookings without an associated user.
* Useful for auditing and identifying data mismatches or orphan records.

---

## Summary of Join Types:

| Join Type       | Includes                                     |
| --------------- | -------------------------------------------- |
| INNER JOIN      | Only matching rows in both tables            |
| LEFT JOIN       | All rows from left table + matches           |
| FULL OUTER JOIN | All rows from both tables, matched/unmatched |

These queries are essential for backend operations like generating reports, validating data, and ensuring relationships between users, bookings, and properties are maintained properly.


# README.md - Advanced SQL Queries (Subqueries)

This documentation provides explanations and SQL examples for two advanced query types used within the Airbnb-style relational database: a subquery for filtering properties by rating, and a correlated subquery for identifying users with frequent bookings.

---

## 1. Subquery: Properties with Average Rating Greater Than 4.0

### Query:

```sql
SELECT *
FROM properties
WHERE id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
```

### Description:

* **Objective**: Retrieve all property records where the average review rating is greater than 4.0.
* **How it works**:

  * The subquery:

    * Groups the `reviews` table by `property_id`.
    * Calculates the average rating for each property.
    * Filters only those with `AVG(rating) > 4.0`.
  * The outer query selects properties whose `id` is present in the filtered result set from the subquery.
* **Use Case**: This is useful when listing only top-rated properties on the platform.

---

## 2. Correlated Subquery: Users with More Than 3 Bookings

### Query:

```sql
SELECT *
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3;
```

### Description:

* **Objective**: Retrieve all users who have made more than three bookings.
* **How it works**:

  * The subquery:

    * Is evaluated for each user (`u`) from the `users` table.
    * Counts the number of rows in `bookings` where `bookings.user_id = users.id`.
    * Returns the count.
  * The outer query selects those users where the count is greater than 3.
* **Use Case**: This helps identify highly active users, which is useful for loyalty programs or advanced analytics.

---

## Summary Table:

| Query Type          | Purpose                             | Output Focus          |
| ------------------- | ----------------------------------- | --------------------- |
| Subquery            | Filter properties by average rating | High-rated properties |
| Correlated Subquery | Count user bookings per user ID     | Frequent users        |

These queries enhance system functionality by enabling intelligent filtering and personalized experiences.

---

**Note**: Ensure proper indexing on `property_id` and `user_id` columns to improve performance of subqueries in production systems.


# SQL Aggregate and Window Function Queries

This document provides two SQL queries that leverage aggregate and window functions to analyze data in an Airbnb-style backend system.

---

## 1. Total Number of Bookings Made by Each User

### Query:

```sql
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
```

### Description:

* Uses the `COUNT()` function to tally how many bookings each user has made.
* `LEFT JOIN` ensures users with 0 bookings are included.
* Grouped by user ID and name to get distinct users.
* Sorted in descending order of bookings.

---

## 2. Ranking Properties Based on Total Number of Bookings

### Query:

```sql
SELECT
    property_id,
    COUNT(*) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_by_bookings
FROM
    bookings
GROUP BY
    property_id;
```

### Description:

* Groups all bookings by `property_id`.
* Counts total bookings for each property.
* Uses `RANK()` window function to assign a rank based on the booking count.
* Highest booked property gets rank 1.

---

These queries are useful for understanding user engagement and property popularity in the Airbnb clone backend system.
