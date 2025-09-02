SELECT *
FROM "Property"
where property_id in (
	select property_id 
	from "Review" r 
	group by property_id
	having  AVG(r.rating ) > 4
);


select *
from  "User" u 
where (
	select count(*)
	from "Booking" b 
	where b.user_id   = u.user_id 
) > 3;




