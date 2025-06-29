# Airbnb Database Schema and Sample Data

This repository contains the database schema and sample data for an Airbnb-like booking platform. The design follows best practices in relational modeling and adheres to the Third Normal Form (3NF).

## 📘 Schema Overview

### Tables:

* **User** – stores users (guests, hosts, admins)
* **Property** – stores listings from hosts
* **Booking** – manages user reservations
* **Payment** – tracks booking payments
* **Review** – stores user reviews for properties
* **Message** – handles direct user communication

### Relationships:

* Each **User** can be a guest, host, or admin.
* A **Host** can own many **Properties**.
* A **User** can book multiple **Properties**.
* Each **Booking** can have one **Payment**.
* A **User** can write multiple **Reviews** per **Property**.
* **Messages** connect two users (sender and recipient).

## 🔧 Normalization

All tables are normalized to 3NF:

* No redundant/repeating groups
* Each attribute depends on the whole primary key
* No transitive dependencies

## 📂 Files

| File                | Description                                                       |
| ------------------- | ----------------------------------------------------------------- |
| `airbnb_schema.sql` | SQL `CREATE TABLE` scripts defining all entities and constraints  |
| `sample_data.sql`   | SQL `INSERT` statements to populate the database with sample data |
| `README.md`         | This documentation file                                           |

## ⚙️ Setup Instructions

1. Clone the repository.
2. Connect to your SQL database (PostgreSQL, MySQL, etc.).
3. Run `airbnb_schema.sql` to create tables.
4. Run `sample_data.sql` to populate with data.
5. Run SELECT queries to verify integrity and usage.

## 🔎 Example Usage

```sql
-- Get all confirmed bookings
SELECT * FROM Booking WHERE status = 'confirmed';

-- List all properties by a specific host
SELECT * FROM Property WHERE host_id = 'uuid-user-2';

-- Show reviews for a property
SELECT rating, comment FROM Review WHERE property_id = 'uuid-prop-1';
```

## 👨‍💻 Author

**Immanuel Njogu**


