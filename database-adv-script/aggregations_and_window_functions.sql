SELECT b.user_id, COUNT(*) AS total_bookings
FROM "Booking" b 
GROUP BY b.user_id;

SELECT 
    p.property_id,
    p."name",
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_row,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_rank
FROM "Property" p
LEFT JOIN "Booking" b
    ON p.property_id = b.property_id
GROUP BY p.property_id, p."name";




