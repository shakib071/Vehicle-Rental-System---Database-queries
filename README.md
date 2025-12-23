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
Displays booking information along with customer and vehicle names.

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
