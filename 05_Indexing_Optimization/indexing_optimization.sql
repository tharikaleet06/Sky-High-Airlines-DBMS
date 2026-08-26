-- ============================================================
-- SKY HIGH AIRLINES DBMS
-- INDEXING & QUERY OPTIMIZATION
-- Author: Tharika P
-- ============================================================


-- ============================================================
-- 1. INDEX CREATION
-- ============================================================


-- Index on Flight Number
CREATE INDEX IDX_FLIGHT_NUMBER
ON FLIGHT(flight_number);


-- Index on Booking Date
CREATE INDEX IDX_BOOKING_DATE
ON BOOKING(booking_date);


-- Index on Passenger ID
CREATE INDEX IDX_PASSENGER_ID
ON PASSENGER(passenger_id);


-- ============================================================
-- 2. EXECUTION PLAN COMPARISON
-- ============================================================

-- Compare query execution before and after using an index.


-- ------------------------------------------------------------
-- WITHOUT INDEX
-- ------------------------------------------------------------

-- Generate the execution plan for a query on BOOKING.

EXPLAIN PLAN FOR
SELECT *
FROM BOOKING
WHERE booking_date = TRUNC(SYSDATE);

-- Display the execution plan.

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


-- Expected observation:
-- Oracle performs a FULL TABLE SCAN when an appropriate index
-- is not available or not selected by the optimizer.


-- ------------------------------------------------------------
-- WITH INDEX
-- ------------------------------------------------------------

-- The IDX_BOOKING_DATE index can be used for filtering
-- booking records by booking_date.

EXPLAIN PLAN FOR
SELECT *
FROM BOOKING
WHERE booking_date = TRUNC(SYSDATE);

-- Display the execution plan.

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


-- Expected observation:
-- Oracle may use:
--   INDEX RANGE SCAN
--   TABLE ACCESS BY INDEX ROWID
--
-- This allows matching index entries to be accessed instead of
-- scanning the complete table.


-- ============================================================
-- 3. QUERY OPTIMIZATION
-- ============================================================


-- ============================================================
-- QUERY 1
-- List agents who have booked more than 100 tickets this month
-- ============================================================


-- ------------------------------------------------------------
-- WITHOUT OPTIMIZATION
-- ------------------------------------------------------------

SELECT u.user_id,
       u.username
FROM USER_ACCOUNT u
JOIN BOOKING b
ON u.user_id = b.booked_by
WHERE u.role = 'AGENT'
GROUP BY u.user_id,
         u.username
HAVING COUNT(*) > 100;


-- ------------------------------------------------------------
-- WITH OPTIMIZATION
-- ------------------------------------------------------------

-- Restrict the query to bookings made during the current month.

SELECT u.user_id,
       u.username
FROM USER_ACCOUNT u
JOIN BOOKING b
ON u.user_id = b.booked_by
WHERE u.role = 'AGENT'
AND b.booking_date >= TRUNC(SYSDATE, 'MM')
AND b.booking_date < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1)
GROUP BY u.user_id,
         u.username
HAVING COUNT(*) > 100;


-- ============================================================
-- QUERY 2
-- Generate a monthly sales report
-- Route, Tickets Sold, Revenue
-- ============================================================


-- ------------------------------------------------------------
-- WITHOUT OPTIMIZATION
-- ------------------------------------------------------------

SELECT f.source_airport || '->' || f.destination_airport AS ROUTE,
       COUNT(*) AS TICKETS_SOLD,
       SUM(p.amount) AS REVENUE
FROM FLIGHT f
JOIN BOOKING b
ON f.flight_id = b.flight_id
JOIN PAYMENT p
ON p.booking_id = b.booking_id
WHERE p.payment_status = 'SUCCESS'
GROUP BY f.source_airport,
         f.destination_airport;


-- ------------------------------------------------------------
-- WITH OPTIMIZATION
-- ------------------------------------------------------------

-- Restrict the report to a specific monthly date range.

SELECT f.source_airport || '->' || f.destination_airport AS ROUTE,
       COUNT(*) AS TICKETS_SOLD,
       SUM(p.amount) AS REVENUE
FROM FLIGHT f
JOIN BOOKING b
ON f.flight_id = b.flight_id
JOIN PAYMENT p
ON p.booking_id = b.booking_id
WHERE p.payment_status = 'SUCCESS'
AND b.booking_date >= DATE '2026-06-01'
AND b.booking_date < DATE '2026-07-01'
GROUP BY f.source_airport,
         f.destination_airport;


-- ============================================================
-- END OF INDEXING & QUERY OPTIMIZATION
-- ============================================================
