-- =========================================================


-- SKY HIGH AIRLINES DATABASE
-- ADVANCED QUERIES
-- Queries 16 to 20
-- =========================================================


-- 16. Generate a sales report showing flight route,
--     tickets sold, and total revenue

SELECT f.source_airport || ' - ' || f.destination_airport AS route,
       COUNT(b.booking_id) AS tickets_sold,
       SUM(b.ticket_price) AS total_revenue
FROM FLIGHT f
JOIN BOOKING b
    ON f.flight_id = b.flight_id
WHERE b.booking_status = 'CONFIRMED'
GROUP BY f.source_airport, f.destination_airport
ORDER BY total_revenue DESC;


-- 17. List passengers who have travelled
--     more than 50,000 miles

SELECT p.passenger_id,
       p.first_name,
       p.last_name,
       SUM(f.distance_km * 0.621371) AS total_miles
FROM PASSENGER p
JOIN BOOKING b
    ON p.passenger_id = b.passenger_id
JOIN FLIGHT f
    ON b.flight_id = f.flight_id
WHERE b.booking_status = 'CONFIRMED'
GROUP BY p.passenger_id,
         p.first_name,
         p.last_name
HAVING SUM(f.distance_km * 0.621371) > 50000
ORDER BY total_miles DESC;


-- 18. Identify flights with less than
--     50% occupancy

SELECT f.flight_id,
       f.flight_number,
       COUNT(b.booking_id) AS booked_seats,
       a.total_capacity,
       ROUND(
           (COUNT(b.booking_id) / a.total_capacity) * 100,
           2
       ) AS occupancy_percentage
FROM FLIGHT f
JOIN AIRCRAFT a
    ON f.aircraft_id = a.aircraft_id
LEFT JOIN BOOKING b
    ON f.flight_id = b.flight_id
    AND b.booking_status = 'CONFIRMED'
GROUP BY f.flight_id,
         f.flight_number,
         a.total_capacity
HAVING (COUNT(b.booking_id) / a.total_capacity) < 0.5
ORDER BY occupancy_percentage;


-- 19. Find passengers who missed their flights
--     with NO SHOW status

SELECT DISTINCT
       p.passenger_id,
       p.first_name,
       p.last_name,
       f.flight_number
FROM PASSENGER p
JOIN BOOKING b
    ON p.passenger_id = b.passenger_id
JOIN FLIGHT f
    ON b.flight_id = f.flight_id
WHERE b.booking_status = 'NO SHOW';


-- 20. Create a view showing flight information

CREATE OR REPLACE VIEW flight_status_view AS
SELECT flight_number,
       source_airport,
       destination_airport,
       departure_datetime,
       flight_status
FROM FLIGHT;


-- Display the created view

SELECT *
FROM flight_status_view;
