# Vehicle Rental System (PostgreSQL)

##  Project Overview
The **Vehicle Rental System** is a relational database project built using **PostgreSQL**.  
It manages users, vehicles, and bookings for a rental service. The design uses **ENUM types**, **foreign keys**, and **constraints** to ensure data integrity and scalability.


---

##  Technologies Used
- PostgreSQL

---

##  Database Structure

### Users Table
Stores system users such as **Admins** and **Customers**.

**Fields:**
- `user_id` (Primary Key)
- `name`
- `email` (Unique)
- `password`
- `phone`
- `role` (`Admin`, `Customer`)

---

###  Vehicles Table
Stores information about rental vehicles.

**Fields:**
- `vehicle_id` (Primary Key)
- `name`
- `type` (`car`, `bike`, `truck`)
- `model`
- `registration_number` (Unique)
- `rental_price`
- `status` (`available`, `rented`, `maintenance`)

---

### Bookings Table
Manages vehicle rental bookings.

**Fields:**
- `booking_id` (Primary Key)
- `user_id` (Foreign Key -> Users)
- `vehicle_id` (Foreign Key -> Vehicles)
- `start_date`
- `end_date`
- `status` (`pending`, `confirmed`, `completed`, `cancelled`)
- `total_cost`

---

##  Explanation of Queries

###  Query 1: Booking Details with User and Vehicle
#### Lists all bookings along with the customer who made the booking and the vehicle that was booked.

```sql
    SELECT b.booking_id,
        u.name AS customer_name,
        v.name AS vehicle_name,
        b.start_date,
        b.end_date,
        b.status
    FROM Bookings b
    JOIN Users u ON u.user_id = b.user_id
    JOIN Vehicles v ON v.vehicle_id = b.vehicle_id;
```

#### Explanation:

JOIN Users connects each booking to the user who made it.
JOIN Vehicles connects each booking to the vehicle and select necessary column.

Output example:
| booking_id | customer_name | vehicle_name | start_date | end_date | status |
|------------|---------------|--------------|------------|----------|-----------|
| 1 | John Doe | Toyota Camry | 2025-12-01 | 2025-12-05 | confirmed |



###  Query 2: Vehicles Never Booked
#### Finds vehicles that have never been rented.

```sql
    SELECT v.vehicle_id,
       v.name,
       v.type,
       v.model,
       v.registration_number,
       v.rental_price,
       v.status
    FROM Vehicles v
    WHERE NOT EXISTS (
        SELECT 1
        FROM Bookings b
        WHERE b.vehicle_id = v.vehicle_id
    );
```

#### Explanation:

The outer query selects all vehicles from the Vehicles table.
The subquery checks if a booking exists for that vehicle (b.vehicle_id = v.vehicle_id).
NOT EXISTS ensures only vehicles with no matching booking are returned.

Example Output:

| vehicle_id | name        | type | model | registration_number | rental_price | status    |
|------------|------------|------|-------|--------------------|--------------|-----------|
| 3          | Honda Civic | car  | 2022  | XYZ-1234           | 50.00        | available |
| 5          | Suzuki Bike | bike | 2021  | BIKE-5678          | 20.00        | available |




###  Query 3: Available Cars

#### Retrieves all cars that are currently available for rent.

```sql
    SELECT *
    FROM Vehicles
    WHERE type = 'car'
    AND status = 'available';
```

#### Explanation:

Filters Vehicles table by type = 'car' and status = 'available'.

Output example:
| vehicle_id | name | type | model | registration_number | rental_price | status |
|------------|-------------|------|-------|--------------------|--------------|-----------|
| 2 | Toyota Camry | car | 2021 | ABC-5678 | 60.00 | available |



###  Query 4: Vehicles with More Than 2 Bookings
#### Identifies high-demand vehicles.

```sql
    SELECT v.name AS vehicle_name,
    COUNT(*) AS total_bookings
    FROM Bookings b
    JOIN Vehicles v ON b.vehicle_id = v.vehicle_id
    GROUP BY b.vehicle_id, v.name
    HAVING COUNT(*) > 2;
```

#### Explanation:

JOIN Vehicles links bookings to the vehicle names.
GROUP BY aggregates bookings by vehicle.
having count(*) > 2 filters only vehicles with more than 2 bookings.

Output example:
| vehicle_name | total_bookings |
|--------------|----------------|
| Toyota Camry | 5 |
| Honda Civic | 3 |

