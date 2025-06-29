# Airbnb Database Normalization to 3NF

## Objective

To ensure that the Airbnb relational database schema follows the Third Normal Form (3NF), eliminating data redundancies and ensuring data integrity.

---

## 1. First Normal Form (1NF)

**Definition:** A relation is in 1NF if it contains only atomic values and each record is unique.

### ✅ Achieved:

* All tables have atomic attributes.
* There are no repeating groups or arrays.
* Each table has a primary key.

---

## 2. Second Normal Form (2NF)

**Definition:** A relation is in 2NF if it is in 1NF and all non-key attributes are fully functionally dependent on the entire primary key.

### ✅ Achieved:

* No partial dependencies exist since all primary keys are single-column (UUID).
* All non-key attributes in each table depend on the whole primary key.

---

## 3. Third Normal Form (3NF)

**Definition:** A relation is in 3NF if it is in 2NF and there are no transitive dependencies (non-key attributes depending on other non-key attributes).

### 🔍 Review and Adjustments:

### ⚠ Potential Violation: `User.phone_number`

* *Issue:* While not a clear transitive dependency, phone\_number can be considered optional and might be moved to a separate `UserContact` table if users can have multiple contact methods.
* *Resolution:* Keeping phone\_number in `User` is acceptable for current scope but can be normalized further depending on future requirements.

### ⚠ Potential Violation: `Property.location`

* *Issue:* If `location` includes detailed structured data (e.g., city, state, country), it could be decomposed into a `Location` table.
* *Resolution:* For simplicity, it's currently a single `VARCHAR`. If needed, we could extract it:

```sql
CREATE TABLE Location (
    location_id UUID PRIMARY KEY,
    city VARCHAR NOT NULL,
    state VARCHAR,
    country VARCHAR NOT NULL
);
```

And then modify Property:

```sql
ALTER TABLE Property ADD COLUMN location_id UUID REFERENCES Location(location_id);
```

---

## ✅ Final Decision

The existing schema **complies with 3NF** for its current scope and usage.

* All non-key attributes are functionally dependent only on the primary key.
* No transitive dependencies exist.
* Optional refinements (like splitting `Location`) can be implemented in more complex versions.

---

## Summary

| Table    | 1NF | 2NF | 3NF | Notes                                         |
| -------- | --- | --- | --- | --------------------------------------------- |
| User     | ✅   | ✅   | ✅   | Possible separation of contact info if needed |
| Property | ✅   | ✅   | ✅   | Location can be normalized further            |
| Booking  | ✅   | ✅   | ✅   | Fully normalized                              |
| Payment  | ✅   | ✅   | ✅   | Fully normalized                              |
| Review   | ✅   | ✅   | ✅   | Fully normalized                              |
| Message  | ✅   | ✅   | ✅   | Fully normalized                              |

> The schema is in 3NF and optimized for data integrity, with potential for modular enhancements as the application scales.
