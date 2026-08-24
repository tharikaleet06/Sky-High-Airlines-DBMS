-- =========================================================
-- SKY HIGH AIRLINES DATABASE
-- Database Schema Creation
-- Oracle SQL
-- =========================================================


-- =========================================================
-- 1. USER_ACCOUNT
-- =========================================================

CREATE TABLE USER_ACCOUNT (
    user_id VARCHAR2(20) PRIMARY KEY,
    username VARCHAR2(50) NOT NULL,
    password VARCHAR2(250) NOT NULL,
    role VARCHAR2(20) NOT NULL
        CHECK (role IN ('PASSENGER', 'ADMIN', 'AGENT', 'CREW')),
    created_at DATE DEFAULT SYSDATE
);


-- =========================================================
-- 2. PASSENGER
-- =========================================================

CREATE TABLE PASSENGER (
    passenger_id VARCHAR2(20) PRIMARY KEY,
    user_id VARCHAR2(20) UNIQUE
        REFERENCES USER_ACCOUNT(user_id),
    name VARCHAR2(50) NOT NULL,
    gender VARCHAR2(15),
    dob DATE NOT NULL,
    nationality VARCHAR2(50) NOT NULL,
    passport_number VARCHAR2(50) UNIQUE,
    phone_number VARCHAR2(20) NOT NULL,
    email VARCHAR2(100) NOT NULL
);


-- =========================================================
-- 3. AIRPORT
-- =========================================================

CREATE TABLE AIRPORT (
    IATA_code CHAR(3) PRIMARY KEY,
    airport_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(50) NOT NULL,
    country VARCHAR2(50) NOT NULL
);


-- =========================================================
-- 4. AIRCRAFT
-- =========================================================

CREATE TABLE AIRCRAFT (
    aircraft_id VARCHAR2(20) PRIMARY KEY,
    aircraft_model VARCHAR2(50) NOT NULL,
    manufacturer VARCHAR2(50),
    total_capacity NUMBER(4)
        CHECK (total_capacity > 0)
);


-- =========================================================
-- 5. FLIGHT
-- =========================================================

CREATE TABLE FLIGHT (
    flight_id VARCHAR2(20) PRIMARY KEY,
    flight_number VARCHAR2(20) UNIQUE NOT NULL,

    source_airport CHAR(3)
        NOT NULL REFERENCES AIRPORT(IATA_code),

    destination_airport CHAR(3)
        NOT NULL REFERENCES AIRPORT(IATA_code),

    aircraft_id VARCHAR2(20)
        NOT NULL REFERENCES AIRCRAFT(aircraft_id),

    departure_datetime TIMESTAMP NOT NULL,
    arrival_datetime TIMESTAMP NOT NULL,

    distance_km NUMBER
        CHECK (distance_km > 0),

    base_price NUMBER(10,2)
        CHECK (base_price >= 0),

    flight_status VARCHAR2(20)
        CHECK (
            flight_status IN (
                'SCHEDULED',
                'ON TIME',
                'DELAYED',
                'CANCELLED',
                'FULL'
            )
        )
);


-- =========================================================
-- 6. SEAT
-- =========================================================

CREATE TABLE SEAT (
    seat_id VARCHAR2(20) PRIMARY KEY,

    flight_id VARCHAR2(20)
        NOT NULL REFERENCES FLIGHT(flight_id),

    seat_number VARCHAR2(20) NOT NULL,

    seat_class VARCHAR2(20)
        CHECK (seat_class IN ('ECONOMY', 'BUSINESS')),

    seat_status VARCHAR2(20)
        CHECK (
            seat_status IN (
                'AVAILABLE',
                'BOOKED'
            )
        ),

    CONSTRAINT uq_flight_seat
        UNIQUE (flight_id, seat_number)
);


-- =========================================================
-- 7. BOOKING
-- =========================================================

CREATE TABLE BOOKING (
    booking_id VARCHAR2(20) PRIMARY KEY,

    passenger_id VARCHAR2(20)
        NOT NULL REFERENCES PASSENGER(passenger_id),

    flight_id VARCHAR2(20)
        NOT NULL REFERENCES FLIGHT(flight_id),

    seat_id VARCHAR2(20)
        UNIQUE NOT NULL REFERENCES SEAT(seat_id),

    booked_by VARCHAR2(20)
        NOT NULL REFERENCES USER_ACCOUNT(user_id),

    booking_date DATE DEFAULT SYSDATE,

    trip_type VARCHAR2(20)
        CHECK (
            trip_type IN (
                'ONE WAY',
                'ROUND TRIP'
            )
        ),

    booking_status VARCHAR2(20)
        CHECK (
            booking_status IN (
                'CONFIRMED',
                'CANCELLED',
                'WAITLIST',
                'NO SHOW'
            )
        ),

    meal_preference VARCHAR2(20)
        CHECK (
            meal_preference IN (
                'VEG',
                'NON VEG',
                'VEGAN',
                'EGGETARIAN',
                'HALAL',
                'JAIN'
            )
        ),

    ticket_price NUMBER(10,2)
        CHECK (ticket_price >= 0)
);


-- =========================================================
-- 8. PAYMENT
-- =========================================================

CREATE TABLE PAYMENT (
    payment_id VARCHAR2(20) PRIMARY KEY,

    booking_id VARCHAR2(20)
        UNIQUE NOT NULL REFERENCES BOOKING(booking_id),

    payment_method VARCHAR2(20) NOT NULL,

    payment_status VARCHAR2(20)
        CHECK (
            payment_status IN (
                'SUCCESS',
                'FAILED',
                'REFUNDED'
            )
        ),

    refund_amount NUMBER(10,2)
        CHECK (refund_amount >= 0),

    payment_date DATE DEFAULT SYSDATE
);
