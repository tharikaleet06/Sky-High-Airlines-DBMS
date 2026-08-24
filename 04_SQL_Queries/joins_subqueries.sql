-- =========================================================
-- SKY HIGH AIRLINES DATABASE
-- JOINS & SUBQUERIES
-- Queries 6 to 10
-- =========================================================


-- 6. Display booking details along with Passenger Name
--    and Flight Number

SELECT b.booking_id,
       b.booking_date,
       b.trip_type,
       p.first_name || ' ' || p.last_name AS "PASSENGER NAME",
       f.flight_number
FROM BOOKING b
JOIN PASSENGER p
    ON b.passenger_id = p.passenger_id
JOIN FLIGHT f
    ON b.flight_id = f.flight_id;


-- 7. Find passengers who have flown on Boeing 747 aircraft

SELECT p.passenger_id,
       p.first_name,
       p.last_name,
       p.gender
FROM PASSENGER p
JOIN BOOKING b
    ON b.passenger_id = p.passenger_id
JOIN FLIGHT f
    ON f.flight_id = b.flight_id
JOIN AIRCRAFT a
    ON a.aircraft_id = f.aircraft_id
WHERE a.aircraft_model = 'Boeing 747';


-- 8. List flights that are fully booked
--    (No seats available)

SELECT *
FROM FLIGHT
WHERE flight_id NOT IN (
    SELECT flight_id
    FROM SEAT
    WHERE seat_status = 'AVAILABLE'
);


-- 9. Identify passengers who have booked return tickets
--    (Round Trip)

SELECT passenger_id,
       first_name,
       last_name
FROM PASSENGER
WHERE passenger_id IN (
    SELECT passenger_id
    FROM BOOKING
    WHERE trip_type = 'ROUND TRIP'
);


-- 10. List agents who have booked more than 100 tickets
--     this month

SELECT u.user_id,
       u.username
FROM USER_ACCOUNT u
JOIN BOOKING b
    ON u.user_id = b.booked_by
WHERE u.role = 'AGENT'
GROUP BY u.user_id, u.username
HAVING COUNT(*) > 100;
