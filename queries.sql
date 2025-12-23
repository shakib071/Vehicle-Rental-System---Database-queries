

-- Query 1 

select b.booking_id,u.name as customer_name , v.name as vehicle_name, b.start_date,b.end_date,b.status
from Bookings as b
join Users as u on u.user_id = b.user_id
join Vehicles as v on b.vehicle_id = v.vehicle_id;


-- Query 2


select v.vehicle_id,v.name,v.type,v.model,v.registration_number,v.rental_price,v.status
from Vehicles as v
where not exists (
    SELECT 1
    FROM Bookings b
    WHERE b.vehicle_id = v.vehicle_id
);




-- Query 3


select *
from Vehicles
where type = 'car' and status = 'available';



--Query 4

select v.name as vehicle_name,count(*) as total_bookings
from Bookings as b
join Vehicles as v on b.vehicle_id = v.vehicle_id
group by b.vehicle_id,v.name
having count(*) > 2;










