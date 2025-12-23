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



-- Sample Data Input 


-- users table data input 

insert into Users (name, email, password, phone, role) values
('Alice', 'alice@example.com', 'abc123xyz', '1234567890', 'Customer'),
('Bob', 'bob@example.com', 'def456uvw', '0987654321', 'Admin'),
('Charlie', 'charlie@example.com', 'ghi789rst', '1122334455', 'Customer');


--vehicles table data input 


insert into Vehicles (name, type, model, registration_number, rental_price, status) values
('Toyota Corolla', 'car', '2022', 'ABC-123', 50.00, 'available'),
('Honda Civic', 'car', '2021', 'DEF-456', 60.00, 'rented'),
('Yamaha R15', 'bike', '2023', 'GHI-789', 30.00, 'available'),
('Ford F-150', 'truck', '2020', 'JKL-012', 100.00, 'maintenance');


-- Bookings table data input 

insert into Bookings (user_id, vehicle_id, start_date, end_date, status, total_cost) values
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240.00),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120.00),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60.00),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100.00);




-- Query 1 

select b.booking_id,u.name as customer_name , v.name as vehicle_name, b.start_date,b.end_date,b.status
from Bookings as b
join Users as u on u.user_id = b.user_id
join Vehicles as v on b.vehicle_id = v.vehicle_id;


-- Query 2


select v.vehicle_id,v.name,v.type,v.model,v.registration_number,v.rental_price,v.status
from Vehicles as v
left join Bookings as b on v.vehicle_id = b.vehicle_id
where b.vehicle_id is null;




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










