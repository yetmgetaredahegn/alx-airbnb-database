# Airbnb Database Normalization

This document explains the normalization process applied to the Airbnb database ERD. The goal is to ensure all tables conform to **Third Normal Form (3NF)**.

---

## 1. User Table
- **Primary Key:** `user_id`
- **Normalization:** Already in 3NF
- **Reasoning:**
  - 1NF: All columns are atomic.
  - 2NF: All non-key columns fully depend on `user_id`.
  - 3NF: No non-key column depends on another non-key column.

---

## 2. Property Table
- **Primary Key:** `property_id`
- **Normalization Issue:** `location` column is not atomic (contains street, city, country in one field).
- **Action Taken:** Split `location` into separate atomic fields:  
  - `street_address`  
  - `city`  
  - `state_or_region` (optional)  
  - `country`  
  - `postal_code` (optional)
- **Result:** Property table now satisfies 1NF, 2NF, and 3NF.

---

## 3. Booking Table
- **Primary Key:** `booking_id`
- **Normalization:** Already in 3NF
- **Reasoning:**
  - 1NF: All columns atomic
  - 2NF: All columns depend on the full PK
  - 3NF: No transitive dependencies

---

## 4. Payment Table
- **Primary Key:** `payment_id`
- **Normalization:** Already in 3NF
- **Reasoning:** Atomic columns, full dependency on PK, no transitive dependency

---

## 5. Review Table
- **Primary Key:** `review_id`
- **Normalization:** Already in 3NF
- **Reasoning:** Atomic columns, all columns depend on PK, rating constraint does not affect normalization

---

## 6. Message Table
- **Primary Key:** `message_id`
- **Normalization:** Already in 3NF
- **Reasoning:** Atomic columns, all columns depend on PK, no transitive dependency

---

## ✅ Summary
- Only the **Property table** required a change to satisfy 1NF by splitting the `location` column.  
- All other tables are already normalized up to 3NF.

