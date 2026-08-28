# ✈️ Sky High Airlines DBMS

A comprehensive **Database Management System project** designed for managing airline operations such as passengers, flights, bookings, seats, payments, and user accounts.

The project demonstrates core DBMS concepts including **normalization, schema design, data population, SQL querying, indexing and optimization, transaction recovery, and database security**.

---

## 📌 Project Overview

The **Sky High Airlines DBMS** is designed to manage and organize airline-related data efficiently.

The database includes information about:

- User Accounts
- Passengers
- Airports
- Aircraft
- Flights
- Seats
- Bookings
- Payments

The project is implemented using **SQL and Oracle Database concepts**.

---

## 🗂️ Project Structure

```text
Sky-High-Airlines-DBMS/
│
├── 01_Normalization/
│   └── README.md
│
├── 02_Database_Schema/
│   ├── README.md
│   └── create_tables.sql
│
├── 03_Data_Population/
│   ├── README.md
│   └── sample_inserts.sql
│
├── 04_SQL_Queries/
│   ├── README.md
│   ├── basic_queries.sql
│   ├── joins_subqueries.sql
│   ├── aggregation_reports.sql
│   └── advanced_queries.sql
│
├── 05_Indexing_Optimization/
│   ├── README.md
│   └── indexing_optimization.sql
│
├── 06_Transactions_Recovery/
│   ├── README.md
│   └── transactions_recovery.sql
│
├── 07_Database_Security/
│   ├── README.md
│   └── database_security.sql
│
└── README.md
```
# 1. Database Normalization

The database design follows normalization principles to reduce data redundancy and improve data integrity.

The normalization process organizes airline-related information into separate tables based on their relationships and dependencies.

Topics covered include:

- First Normal Form (1NF)
- Second Normal Form (2NF)
- Third Normal Form (3NF)
- Functional Dependencies
- Reduction of Data Redundancy
- Improved Data Consistency

📁 **Folder:** `01_Normalization`

---

# 2. Database Schema

The database schema defines the structure of the airline management system.

The following tables are created:

| Table | Description |
|---|---|
| `USER_ACCOUNT` | Stores user account and role information |
| `PASSENGER` | Stores passenger details |
| `AIRPORT` | Stores airport information |
| `AIRCRAFT` | Stores aircraft details |
| `FLIGHT` | Stores flight schedules and information |
| `SEAT` | Stores seat details and availability |
| `BOOKING` | Stores passenger booking information |
| `PAYMENT` | Stores payment details |

The schema includes:

- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints
- Default Values

📁 **Folder:** `02_Database_Schema`

📄 **SQL File:** `create_tables.sql`

---

# 3. Data Population

This section populates the database with sample airline data.

The inserted data includes:

- Aircraft records
- Airport records
- User accounts
- Passenger information
- Flight details
- Seat information
- Booking records
- Payment details

The data is designed to support the SQL queries, reports, optimization, transactions, and security operations implemented in later sections.

📁 **Folder:** `03_Data_Population`

📄 **SQL File:** `sample_inserts.sql`

---

# 4. SQL Queries

This section contains **20 SQL queries** organized into four categories.

## Basic Queries

1. List all flights departing from New York (JFK).
2. Find passengers who have booked Business Class seats.
3. Retrieve flights scheduled for the next Monday.
4. List bookings that have been cancelled.
5. Find airports located in France.

📄 [`basic_queries.sql`](04_SQL_Queries/basic_queries.sql)

---

## Joins and Subqueries

6. Display booking details along with passenger name and flight number.
7. Find passengers who have flown on a Boeing 747 aircraft.
8. List flights that are fully booked with no seats available.
9. Identify passengers who have booked round-trip tickets.
10. List agents who have booked more than 100 tickets.

📄 [`joins_subqueries.sql`](04_SQL_Queries/joins_subqueries.sql)

---

## Aggregation and Reports

11. Find the top 5 most popular destinations based on booking count.
12. Calculate the total revenue generated per flight route.
13. Identify the day of the week with the highest travel volume.
14. Calculate the average ticket price for Economy and Business Class.
15. Count the number of passengers by nationality.

📄 [`aggregation_reports.sql`](04_SQL_Queries/aggregation_reports.sql)

---

## Advanced Queries

16. Generate a sales report showing route, tickets sold, and revenue.
17. List passengers who have travelled more than 50,000 miles.
18. Identify flights with less than 50% occupancy.
19. Find passengers who have missed their flights with a `NO SHOW` status.
20. Create a view showing Flight Number, Source, Destination, Departure Time, and Flight Status.

📄 [`advanced_queries.sql`](04_SQL_Queries/advanced_queries.sql)

---

# 5. Indexing and Query Optimization

This section demonstrates how indexes can improve query performance and how SQL queries can be optimized.

Indexes are created on:

- `flight_number`
- `booking_date`
- `passenger_id`

The section also includes:

- Execution plan comparison
- Full table scan analysis
- Index range scan analysis
- Query optimization using date filtering
- Monthly booking analysis
- Optimized monthly sales reports

📁 **Folder:** `05_Indexing_Optimization`

📄 **SQL File:** `indexing_optimization.sql`

---

# 6. Transactions and Recovery

This section demonstrates database transaction management and recovery concepts.

It includes operations related to:

- `COMMIT`
- `ROLLBACK`
- `SAVEPOINT`
- Transaction control
- Recovery from failed operations

These concepts help maintain **data consistency and reliability** during database operations.

📁 **Folder:** `06_Transactions_Recovery`

📄 **SQL File:** `transactions_recovery.sql`

---

# 7. Database Security

This section implements database security using **Role-Based Access Control (RBAC)**.

The following roles are defined:

### Admin

- Full privileges on the database.

### Agent

- `INSERT` privilege on bookings.
- `SELECT` privilege on flights.

### Crew

- `SELECT` privilege on the passenger manifest.

The section also demonstrates:

- Creating database roles
- Granting privileges using `GRANT`
- Revoking privileges using `REVOKE`
- Assigning roles to users
- Creating a passenger manifest view
- SQL Injection demonstration
- Secure handling using prepared statements

📁 **Folder:** `07_Database_Security`

📄 **SQL File:** `database_security.sql`

---

# 🛠️ Technologies Used

- SQL
- Oracle Database
- Oracle SQL Developer
- GitHub

---

# ▶️ How to Run the Project

1. Clone the repository:

```bash
git clone https://github.com/tharikaleet06/Sky-High-Airlines-DBMS.git
```
2. Open the project in **Oracle SQL Developer** or another compatible SQL environment.

3. Execute the files in the following order:

```text
1. 02_Database_Schema/create_tables.sql
2. 03_Data_Population/sample_inserts.sql
3. 04_SQL_Queries/
4. 05_Indexing_Optimization/indexing_optimization.sql
5. 06_Transactions_Recovery/transactions_recovery.sql
6. 07_Database_Security/database_security.sql
```
The normalization section can be reviewed before creating the database schema.

---

# 📚 Concepts Demonstrated

- Database Design
- Database Normalization
- DDL Commands
- DML Commands
- Primary and Foreign Keys
- Constraints
- SQL Queries
- Joins
- Subqueries
- Aggregate Functions
- Views
- Indexing
- Query Optimization
- Execution Plans
- Transactions
- Commit and Rollback
- Savepoints
- Database Recovery
- Role-Based Access Control
- `GRANT` and `REVOKE`
- SQL Injection Awareness

---

## 👩‍💻 Author

**Tharika P**

GitHub: [tharikaleet06](https://github.com/tharikaleet06)
