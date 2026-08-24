-- =========================================================
-- SKY HIGH AIRLINES DATABASE
-- AGGREGATION & REPORTS
-- Queries 11 to 15
-- =========================================================


-- 11. Find the Top 5 most popular destinations
--     based on the number of bookings

SELECT f.destination_airport,
       COUNT(b.booking_id) AS booking_count
FROM FLIGHT f
JOIN BOOKING b
    ON f.flight_id = b.flight_id
GROUP BY f.destination_airport
ORDER BY booking_count DESC
FETCH FIRST 5 ROWS ONLY;


-- 12. Calculate the total revenue generated
--     per flight route

SELECT f.source_airport,
       f.destination_airport,
       SUM(b.ticket_price) AS total_revenue
FROM FLIGHT f
JOIN BOOKING b
    ON f.flight_id = b.flight_id
WHERE b.booking_status = 'CONFIRMED'
GROUP BY f.source_airport,
         f.destination_airport
ORDER BY total_revenue DESC;


-- 13. Identify the day of the week
--     with the highest travel volume

SELECT TO_CHAR(f.departure_datetime, 'DAY') AS travel_day,
       COUNT(b.booking_id) AS passenger_count
FROM FLIGHT f
JOIN BOOKING b
    ON f.flight_id = b.flight_id
WHERE b.booking_status = 'CONFIRMED'
GROUP BY TO_CHAR(f.departure_datetime, 'DAY')
ORDER BY passenger_count DESC
FETCH FIRST 1 ROW ONLY;


-- 14. Calculate the average ticket price
--     for Economy and Business class

SELECT s.seat_class,
       ROUND(AVG(b.ticket_price), 2) AS average_ticket_price
FROM BOOKING b
JOIN SEAT s
    ON b.seat_id = s.seat_id
WHERE b.booking_status = 'CONFIRMED'
GROUP BY s.seat_class
ORDER BY s.seat_class;


-- 15. Count the number of passengers
--     by nationality

SELECT nationality,
       COUNT(*) AS passenger_count
FROM PASSENGER
GROUP BY nationality
ORDER BY passenger_count DESC;
