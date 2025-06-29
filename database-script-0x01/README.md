# Airbnb Database Schema

This project defines the relational database schema for an Airbnb-like application, structured to follow database normalization principles up to Third Normal Form (3NF).

## 📦 Entities and Relationships

### 1. **User**

Stores information about users (guests, hosts, and admins).

* `user_id` (UUID): Primary Key
* `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`
* Email is unique
* Role can be `guest`, `host`, or `admin`

### 2. **Property**

Represents listed properties by hosts.

* `property_id` (UUID): Primary Key
* `host_id`: Foreign Key referencing `User(user_id)`
* `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`

### 3. **Booking**

Captures property bookings by users.

* `booking_id` (UUID): Primary Key
* Foreign Keys: `property_id`, `user_id`
* `start_date`, `end_date`, `total_price`, `status`, `created_at`
* `status`: `pending`, `confirmed`, or `canceled`

### 4. **Payment**

Handles booking payments.

* `payment_id` (UUID): Primary Key
* `booking_id`: Foreign Key
* `amount`, `payment_date`, `payment_method`
* Payment methods: `credit_card`, `paypal`, `stripe`

### 5. **Review**

Stores property reviews.

* `review_id` (UUID): Primary Key
* Foreign Keys: `property_id`, `user_id`
* `rating` (1–5), `comment`, `created_at`

### 6. **Message**

Handles user messaging.

* `message_id` (UUID): Primary Key
* Foreign Keys: `sender_id`, `recipient_id`
* `message_body`, `sent_at`

## 🧠 Normalization

* The schema adheres to 3NF:

  * No repeating groups or arrays
  * Each non-key attribute is fully dependent on the primary key
  * No transitive dependencies

## 📈 Indexing

* Primary keys are indexed automatically.
* Additional indexes:

  * `User.email`
  * `Property.property_id`
  * `Booking.property_id`, `Booking.booking_id`
  * `Payment.booking_id`

## 📂 SQL Files

* See the `airbnb_schema_sql` file for complete `CREATE TABLE` statements.

## 🛠️ Setup Instructions

1. Use PostgreSQL or MySQL-compatible DBMS.
2. Run the `airbnb_schema_sql` script to set up the schema.
3. Populate data and test with appropriate queries.

## ✍️ Author

**Immanuel Njogu** 
