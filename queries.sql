create database vehicle_rental_system;



-- create users table 

create type user_role as enum ('Admin','Customer');

create table Users(
  user_id serial primary key,
  name varchar(100) not null,
  email varchar(100) not null unique,
  password varchar(150) not null,
  phone varchar(20) not null,
  role user_role not null default 'Customer'
);



-- create  Vehicles table 

create type vehicle_type as enum ('car','bike','truck');

create type vehicle_status as enum ('available','rented','maintenance');

create table Vehicles (
  vehicle_id serial primary key,
  name varchar(100) not null,
  type vehicle_type not null,
  model varchar(50) not null,
  registration_number varchar(50) not null unique,
  rental_price decimal(10,2) not null,
  status vehicle_status not null default 'available'
);


-- create Booking table 
create type booking_status as enum ('pending','confirmed','completed','cancelled');

create table Bookings(
  booking_id serial primary key,
  user_id int not null references Users(user_id) on delete cascade,
  vehicle_id int not null references Vehicles(vehicle_id) on delete cascade,
  start_date date not null,
  end_date date not null,
  status booking_status not null,
  total_cost decimal(10,2) not null
  
);



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










