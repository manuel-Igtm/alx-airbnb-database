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
