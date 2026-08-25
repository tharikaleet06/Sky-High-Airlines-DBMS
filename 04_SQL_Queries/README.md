# SQL Queries

## Overview

This section contains the SQL queries implemented for the **Sky High Airlines Database Management System**.

The queries are organized into four categories:

1. Basic Queries
2. Joins and Subqueries
3. Aggregation and Reports
4. Advanced Queries

A total of **20 SQL queries** are included to retrieve, analyze, and generate reports from the airline database.

---

# 1. Basic Queries

This section contains basic data retrieval queries using SQL statements such as `SELECT` and `WHERE`.

### Query 1: List all flights departing from New York (JFK)

Retrieves all flights where the source airport is New York (JFK).

### Query 2: Find passengers who have booked Business Class seats

Retrieves information related to Business Class seat bookings.

### Query 3: Retrieve flights scheduled for the next Monday

Retrieves flights scheduled to depart on the next Monday.

### Query 4: List bookings that have been cancelled

Retrieves all bookings with the status `CANCELLED`.

### Query 5: Find airports located in France

Retrieves airport details where the country is France.

**SQL File:**

```text
(basic_queries.sql)
```

# 2. Joins and Subqueries

This section contains queries that use joins and subqueries to retrieve related data from multiple tables.

### Query 6: Display booking details along with passenger name and flight number

Combines data from the `BOOKING`, `PASSENGER`, and `FLIGHT` tables to display booking information together with passenger and flight details.

### Query 7: Find passengers who have flown on a Boeing 747 aircraft

Retrieves passengers associated with flights operated using a Boeing 747 aircraft.

### Query 8: List flights that are fully booked with no seats available

Identifies flights where no seats are available.

### Query 9: Identify passengers who have booked round-trip tickets

Retrieves passengers whose booking type is `ROUND TRIP`.

### Query 10: List agents who have booked more than 100 tickets

Identifies agents who have created more than 100 bookings.

**SQL File:**

```text
(joins_subqueries.sql)
```

# 3. Aggregation and Reports

This section contains queries that use aggregate functions to analyze and summarize airline data.

### Query 11: Find the top 5 most popular destinations based on booking count

Counts the number of bookings for each destination and retrieves the top five destinations.

### Query 12: Calculate the total revenue generated per flight route

Calculates the total ticket revenue generated for each flight route.

### Query 13: Identify the day of the week with the highest travel volume

Analyzes booking data to determine the day with the highest number of travellers.

### Query 14: Calculate the average ticket price for Economy and Business class

Calculates and compares the average ticket price for different seat classes.

### Query 15: Count the number of passengers by nationality

Groups passengers according to nationality and counts the number of passengers in each group.

**SQL File:**

```text
(aggregation_reports.sql)
```
# 4. Advanced Queries

This section contains advanced SQL queries used for reporting and more detailed analysis.

### Query 16: Generate a sales report showing route, tickets sold, and revenue

Generates a sales report containing the flight route, number of tickets sold, and total revenue generated.

### Query 17: List passengers who have travelled more than 50,000 miles

Calculates the total travel distance of passengers and identifies those who have travelled more than 50,000 miles.

### Query 18: Identify flights with less than 50% occupancy

Calculates the occupancy of flights and identifies flights operating below 50% capacity.

### Query 19: Find passengers who have missed their flights with a NO SHOW status

Retrieves passengers whose booking status is recorded as `NO SHOW`.

### Query 20: Create a view showing Flight Number, Source, Destination, Departure Time, and Flight Status

Creates a database view containing essential flight information.

**SQL File:**

```text
(advanced_queries.sql)
```
## Author

**Tharika P**

