SELECT 
    b.booking_id,
    b.user_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id AS user_id_ref,
    u.first_name,
    u.email,
    u.phone_number
FROM "Booking" b
JOIN "User" u
    ON b.user_id = u.user_id;



SELECT 
    p.property_id,
    p.host_id,
    p."name" ,
    p.country ,
    p.city ,
    p.street_address ,
    p.pricepernight ,
    p.description ,
    r.review_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM "Property" p
LEFT JOIN "Review" r
    ON p.property_id = r.property_id;


SELECT 
    b.booking_id,
    b.user_id AS booking_user_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id AS user_id_ref,
    u.first_name,
    u.email,
    u.phone_number
FROM "Booking" b
FULL OUTER JOIN "User" u 
    ON b.user_id = u.user_id;
