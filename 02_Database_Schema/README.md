# Database Schema

## Overview

This section contains the SQL Data Definition Language (DDL) statements used to create the database schema for the **Sky High Airlines** project.

The database was implemented using **Oracle SQL** and consists of eight main tables.

## Tables

### 1. USER_ACCOUNT

Stores user account details.

**Main attributes:**

- User ID
- Username
- Password
- Role
- Created Date

The supported roles are:

- PASSENGER
- ADMIN
- AGENT
- CREW

---

### 2. PASSENGER

Stores passenger details and is linked to the `USER_ACCOUNT` table.

**Main attributes:**

- Passenger ID
- User ID
- Name
- Gender
- Date of Birth
- Nationality
- Passport Number
- Phone Number
- Email

---

### 3. AIRPORT

Stores information about airports.

**Main attributes:**

- IATA Code
- Airport Name
- City
- Country

---

### 4. AIRCRAFT

Stores aircraft information.

**Main attributes:**

- Aircraft ID
- Aircraft Model
- Manufacturer
- Total Capacity

---

### 5. FLIGHT

Stores flight details.

**Main attributes:**

- Flight ID
- Flight Number
- Source Airport
- Destination Airport
- Aircraft ID
- Departure Date and Time
- Arrival Date and Time
- Distance
- Base Price
- Flight Status

---

### 6. SEAT

Stores seat information for each flight.

**Main attributes:**

- Seat ID
- Flight ID
- Seat Number
- Seat Class
- Seat Status

Seat classes include:

- ECONOMY
- BUSINESS

Seat status includes:

- AVAILABLE
- BOOKED

---

### 7. BOOKING

Stores booking information and connects passengers, flights, seats, and user accounts.

**Main attributes:**

- Booking ID
- Passenger ID
- Flight ID
- Seat ID
- Booked By
- Booking Date
- Trip Type
- Booking Status
- Meal Preference
- Ticket Price

Trip types include:

- ONE WAY
- ROUND TRIP

Booking statuses include:

- CONFIRMED
- CANCELLED
- WAITLIST
- NO SHOW

---

### 8. PAYMENT

Stores payment details related to bookings.

**Main attributes:**

- Payment ID
- Booking ID
- Payment Method
- Payment Status
- Refund Amount
- Payment Date

Payment statuses include:

- SUCCESS
- FAILED
- REFUNDED

---

## Database Relationships

The database tables are connected using primary keys and foreign keys.

```text
USER_ACCOUNT
      │
      └──── PASSENGER


AIRPORT ─────┐
             │
AIRCRAFT ─── FLIGHT ─── SEAT
                  │
                  │
PASSENGER ─── BOOKING ─── PAYMENT
                  │
                  │
             USER_ACCOUNT
