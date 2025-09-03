-- =========================================
-- Initial query (broad, unoptimized)
-- =========================================
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, b.status, b.total_price,
       u.user_id, u.first_name, u.last_name, u.email,
       p.property_id, p.name AS property_name, p.city, p.country, p.pricepernight,
       pay.payment_id, pay.amount, pay.payment_method
FROM "Booking"  b
JOIN "User"     u   ON u.user_id = b.user_id
JOIN "Property" p   ON p.property_id = b.property_id
LEFT JOIN "Payment" pay ON pay.booking_id = b.booking_id;


-- =========================================
-- Index creation for optimization
-- =========================================
CREATE INDEX IF NOT EXISTS idx_booking_user_id          ON "Booking"(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id      ON "Booking"(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_status_startdate ON "Booking"(status, start_date);
CREATE INDEX IF NOT EXISTS idx_property_city            ON "Property"(city);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id       ON "Payment"(booking_id);
ANALYZE;


-- =========================================
-- Optimized query (uses indexes)
-- =========================================
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, b.status, b.total_price,
       u.user_id, u.first_name, u.last_name, u.email,
       p.property_id, p.name AS property_name, p.city, p.country, p.pricepernight,
       pay.payment_id, pay.amount, pay.payment_method
FROM "Booking"  b
JOIN "User"     u   ON u.user_id = b.user_id
JOIN "Property" p   ON p.property_id = b.property_id
LEFT JOIN "Payment" pay ON pay.booking_id = b.booking_id
WHERE b.status = 'confirmed'
  AND b.start_date >= DATE '2025-10-01'
  AND p.city = 'New York';
