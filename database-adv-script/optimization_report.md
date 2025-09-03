# Optimization Report: Complex Queries

## 1. Initial Query

- The query retrieved **all bookings**, their associated users, properties, and payments.
- Execution plan (EXPLAIN ANALYZE) showed:
  - **Seq Scan** on Booking, User, Property, Payment tables.
  - **Hash Joins** used to combine tables.
- Execution time: ~68–95 ms (depends on dataset size).
- Issue: scanning the entire tables is inefficient for large datasets.

## 2. Identified Inefficiencies

- **Sequential scans** on large tables cause high execution time.
- All rows were joined even if only a subset was needed.
- Indexes existed on join columns but were not utilized because the query requested all rows.

## 3. Optimization Strategy

1. **Create indexes** on high-usage columns:

```sql
CREATE INDEX idx_booking_user_id          ON "Booking"(user_id);
CREATE INDEX idx_booking_property_id      ON "Booking"(property_id);
CREATE INDEX idx_booking_status_startdate ON "Booking"(status, start_date);
CREATE INDEX idx_property_city            ON "Property"(city);
CREATE INDEX idx_payment_booking_id       ON "Payment"(booking_id);
ANALYZE;
```
Add selective filters to reduce rows scanned:

```sql
WHERE b.status = 'confirmed'
  AND b.start_date >= DATE '2025-10-01'
  AND p.city = 'New York';
```
- The filters allow Postgres to use indexes, reducing rows scanned drastically.

- Joins now operate on a small subset instead of the full tables.

## 4. Results After Optimization
- Execution time: ~1–2 ms.

- EXPLAIN ANALYZE showed:

- Index Scan / Bitmap Index Scan on Booking and Property.

- Hash Join on a much smaller row set.

- Dramatic reduction in execution time and resource usage.

## 5. Conclusion
- Indexes improve performance only when queries are selective.

- Refactoring queries with filters and indexes is more effective than just changing join types.

- Best practice: always analyze query patterns and create indexes on frequently filtered or joined columns.


