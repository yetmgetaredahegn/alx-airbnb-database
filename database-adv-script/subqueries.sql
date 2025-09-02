SELECT *
FROM "Property"
WHERE property_id in (
	SELECT property_id 
	FROM "Review" r 
	GROUP BY property_id
	HAVING  AVG(r.rating ) > 4
);


SELECT *
FROM  "User" u 
WHERE (
	SELECT COUNT(*)
	FROM "Booking" b 
	WHERE b.user_id   = u.user_id 
) > 3;




