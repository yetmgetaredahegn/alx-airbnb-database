EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, p.city
FROM "Booking" b
JOIN "Property" p ON b.property_id = p.property_id
WHERE b.user_id = '3e1bf9f1-06ac-42d3-88d8-e0115fe230c2'
  AND p.city = 'New York';

CREATE INDEX idx_property_city ON "Property"(city);
CREATE INDEX idx_property_price ON "Property"(pricepernight);
CREATE INDEX idx_booking_start_date ON "Booking"(start_date);

DROP INDEX IF EXISTS idx_property_city;
DROP INDEX IF EXISTS idx_property_price;
DROP INDEX IF EXISTS idx_booking_start_date;
