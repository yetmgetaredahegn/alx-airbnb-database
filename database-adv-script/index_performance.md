# Index Performance Report

## Query 1: Find all bookings for a specific user in a city
```sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, p.city
FROM "Booking" b
JOIN "Property" p ON b.property_id = p.property_id
WHERE b.user_id = '123e4567-e89b-12d3-a456-426614174000'
  AND p.city = 'Addis Ababa';

