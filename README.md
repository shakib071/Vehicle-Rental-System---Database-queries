# Vehicle Rental System (PostgreSQL)

## 📌 Project Overview
The **Vehicle Rental System** is a relational database project built using **PostgreSQL**.  
It manages users, vehicles, and bookings for a rental service. The design uses **ENUM types**, **foreign keys**, and **constraints** to ensure data integrity and scalability.

This project is suitable for:
- Database design practice
- Backend projects (Django / Node.js)
- Academic coursework
- Real-world rental systems

---

## 🛠️ Technologies Used
- PostgreSQL
- SQL (DDL & DML)

---

## 📂 Database Structure

### 1️⃣ Users Table
Stores system users such as **Admins** and **Customers**.

**Fields:**
- `user_id` (Primary Key)
- `name`
- `email` (Unique)
- `password`
- `phone`
- `role` (`Admin`, `Customer`)

---

### 2️⃣ Vehicles Table
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

### 3️⃣ Bookings Table
Manages vehicle rental bookings.

**Fields:**
- `booking_id` (Primary Key)
- `user_id` (Foreign Key -> Users)
- `vehicle_id` (Foreign Key -> Vehicles)
- `start_date`
- `end_date`
- `status` (`pending`, `confirmed`, `completed`, `cancelled`)
- `total_cost`

**Note:**  
`ON DELETE CASCADE` ensures bookings are deleted automatically if a user or vehicle is removed.

---

## 📄 queries.sql (Explanation of Queries)

### 🔹 Query 1: Booking Details with User and Vehicle
#### Displays booking information along with customer and vehicle names.

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

#### Purpose: To view all bookings with complete contextual details.


### 🔹 Query 2: Vehicles Never Booked
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
    LEFT JOIN Bookings b ON v.vehicle_id = b.vehicle_id
    WHERE b.vehicle_id IS NULL;

#### Purpose: Useful for identifying unused inventory.


### 🔹 Query 3: Available Cars

#### Retrieves all cars that are currently available for rent.

```sql 
    SELECT *
    FROM Vehicles
    WHERE type = 'car'
    AND status = 'available';

#### Purpose: Helps customers or admins find ready-to-rent cars.


### 🔹 Query 4: Vehicles with More Than 2 Bookings
####Identifies high-demand vehicles.

```sql 
    SELECT v.name AS vehicle_name,
    COUNT(*) AS total_bookings
    FROM Bookings b
    JOIN Vehicles v ON b.vehicle_id = v.vehicle_id
    GROUP BY b.vehicle_id, v.name
    HAVING COUNT(*) > 2;

#### Purpose:
    Analyzes booking frequency for business insights.