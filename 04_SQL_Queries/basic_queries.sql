-- =========================================================
-- SKY HIGH AIRLINES DATABASE
-- BASIC QUERIES
-- Queries 1 to 5
-- =========================================================


-- 1. List all flights departing from New York (JFK)

SELECT *
FROM FLIGHT
WHERE source_airport = 'JFK';


-- 2. Find passengers who have booked Business Class seats

SELECT *
FROM SEAT
WHERE seat_class = 'BUSINESS';


-- 3. Retrieve flights scheduled for Next Monday

SELECT *
FROM FLIGHT
WHERE TRUNC(departure_datetime) =
      NEXT_DAY(TRUNC(SYSDATE), 'MONDAY');


-- 4. List bookings that have been Cancelled

SELECT *
FROM BOOKING
WHERE booking_status = 'CANCELLED';


-- 5. Find airports located in France

SELECT *
FROM AIRPORT
WHERE country = 'France';
