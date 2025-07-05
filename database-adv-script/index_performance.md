# README: Database Indexing and Performance Measurement

## Objective
This document outlines the purpose and process of identifying high-usage columns in the Airbnb Clone backend's database schema and creating indexes on those columns. Additionally, it demonstrates how query performance was measured using `EXPLAIN` before and after indexing.

## Identified High-Usage Columns
Based on the queries in the system that frequently use `WHERE`, `JOIN`, and `ORDER BY` clauses, the following columns were identified as high-usage:

- **users**: `id`, `email`
- **bookings**: `user_id`, `property_id`, `created_at`
- **properties**: `id`, `host_id`, `location`

## Index Creation
The following indexes were created in `database_index.sql`:
```sql
-- Users Table
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_id ON users(id);

-- Bookings Table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Properties Table
CREATE INDEX idx_properties_id ON properties(id);
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
```

## Performance Measurement

To measure the query performance improvement, `EXPLAIN ANALYZE` was used before and after adding indexes.

### Example:
#### Query:
```sql
SELECT *
FROM bookings
JOIN users ON bookings.user_id = users.id
WHERE bookings.created_at > NOW() - INTERVAL '30 days'
ORDER BY bookings.created_at DESC;
```

#### Before Indexing:
- `EXPLAIN` shows sequential scans on `bookings` and `users`
- Higher cost estimate due to full table scan

#### After Indexing:
- `EXPLAIN` shows index scan on `bookings.created_at` and `users.id`
- Significantly lower cost and faster execution time

## Summary
Creating indexes on frequently queried columns improves the performance and scalability of the backend. This step is critical in optimizing response time, especially for high-traffic operations such as user lookups, recent bookings, and location-based property searches.

---
**File Location**: `database_index.sql`

**Next Steps**:
- Monitor the query plan periodically to ensure indexes remain efficient
- Avoid excessive indexing to minimize write overhead
