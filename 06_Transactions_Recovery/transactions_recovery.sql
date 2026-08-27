-- ============================================
-- TRANSACTION.SQL
-- TICKET BOOKING SYSTEM
-- Demonstration of:
-- COMMIT, ROLLBACK, SAVEPOINT,
-- Concurrency Conflict and Deadlock
-- ============================================


-- ============================================
-- 1. CREATE TABLES
-- ============================================

CREATE TABLE SEAT (
    seat_id VARCHAR2(10) PRIMARY KEY,
    seat_status VARCHAR2(20)
);

CREATE TABLE PAYMENT (
    payment_id VARCHAR2(10) PRIMARY KEY,
    booking_id VARCHAR2(10),
    amount NUMBER,
    payment_method VARCHAR2(20),
    payment_status VARCHAR2(20),
    refund_amount NUMBER,
    payment_date DATE
);

CREATE TABLE BOOKING (
    booking_id VARCHAR2(10) PRIMARY KEY,
    passenger_id VARCHAR2(10),
    flight_id VARCHAR2(10),
    seat_id VARCHAR2(10),
    user_id VARCHAR2(10),
    pnr VARCHAR2(20),
    booking_date DATE,
    trip_type VARCHAR2(20),
    booking_status VARCHAR2(20),
    vehicle_type VARCHAR2(20),
    amount NUMBER
);


-- ============================================
-- 2. INSERT SAMPLE SEATS
-- ============================================

INSERT INTO SEAT VALUES ('S081', 'AVAILABLE');
INSERT INTO SEAT VALUES ('S090', 'AVAILABLE');
INSERT INTO SEAT VALUES ('S092', 'AVAILABLE');
INSERT INTO SEAT VALUES ('S093', 'AVAILABLE');
INSERT INTO SEAT VALUES ('S094', 'AVAILABLE');

COMMIT;


-- ============================================
-- 3. TICKET BOOKING TRANSACTION
-- ============================================

-- STEP 1: Check seat availability

SELECT seat_status
FROM SEAT
WHERE seat_id = 'S090';


-- STEP 2: Reserve seat temporarily

SAVEPOINT seat_reserved;

UPDATE SEAT
SET seat_status = 'RESERVED'
WHERE seat_id = 'S090';


-- STEP 3: Process payment

INSERT INTO PAYMENT
VALUES (
    'PAY801',
    'B221',
    24000,
    'UPI',
    'SUCCESS',
    0,
    SYSDATE
);


-- STEP 4: Confirm booking

INSERT INTO BOOKING
VALUES (
    'B221',
    'P001',
    'F023',
    'S090',
    'U031',
    'PNR1200',
    SYSDATE,
    'ONE WAY',
    'CONFIRMED',
    'VEG',
    24000
);


-- Update seat to BOOKED

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S090';


-- Save all changes

COMMIT;


-- ============================================
-- 4. SAVEPOINT AND ROLLBACK DEMONSTRATION
-- ============================================

-- Make seat available again for demonstration

UPDATE SEAT
SET seat_status = 'AVAILABLE'
WHERE seat_id = 'S090';

COMMIT;


-- Create SAVEPOINT

SAVEPOINT seat_reserved;


-- Reserve the seat

UPDATE SEAT
SET seat_status = 'RESERVED'
WHERE seat_id = 'S090';


-- Payment fails

INSERT INTO PAYMENT
VALUES (
    'PAY802',
    'B222',
    24000,
    'UPI',
    'FAILED',
    0,
    SYSDATE
);


-- Rollback to SAVEPOINT
-- This removes changes after the SAVEPOINT.
-- The seat remains RESERVED.

ROLLBACK TO seat_reserved;


-- To make seat AVAILABLE again:

UPDATE SEAT
SET seat_status = 'AVAILABLE'
WHERE seat_id = 'S090';

COMMIT;


-- ============================================
-- 5. FULL ROLLBACK DEMONSTRATION
-- ============================================

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S081';


-- Check changed value

SELECT seat_status
FROM SEAT
WHERE seat_id = 'S081';


-- Undo the update

ROLLBACK;


-- Check again

SELECT seat_status
FROM SEAT
WHERE seat_id = 'S081';


-- ============================================
-- 6. COMMIT DEMONSTRATION
-- ============================================

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S081';


COMMIT;


SELECT seat_status
FROM SEAT
WHERE seat_id = 'S081';


-- ============================================
-- 7. CONCURRENCY CONFLICT
-- ============================================

-- ============================================
-- SESSION 1
-- ============================================

SELECT seat_status
FROM SEAT
WHERE seat_id = 'S092';


-- Session 1 books the seat

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S092';

-- Do NOT COMMIT yet
-- Session 1 holds the lock


-- ============================================
-- SESSION 2
-- Run the following in another SQL session
-- ============================================

SELECT seat_status
FROM SEAT
WHERE seat_id = 'S092';


-- Try to update the same seat

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S092';

-- This waits because Session 1 holds the lock


-- ============================================
-- BACK TO SESSION 1
-- ============================================

COMMIT;


-- ============================================
-- BACK TO SESSION 2
-- ============================================

-- After Session 1 commits,
-- check the seat status again

SELECT seat_status
FROM SEAT
WHERE seat_id = 'S092';

-- It will show BOOKED

ROLLBACK;


-- ============================================
-- 8. DEADLOCK SIMULATION
-- ============================================

-- ============================================
-- SESSION 1
-- ============================================

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S093';

-- Do not commit


-- ============================================
-- SESSION 2
-- Run in another SQL session
-- ============================================

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S094';

-- Do not commit


-- ============================================
-- SESSION 1
-- ============================================

-- Try to lock S094

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S094';

-- Session 1 waits because
-- Session 2 holds the lock


-- ============================================
-- SESSION 2
-- ============================================

-- Try to lock S093

UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S093';

-- Deadlock occurs:
-- Session 1 waits for S094
-- Session 2 waits for S093


-- Oracle detects the deadlock
-- and chooses one transaction as victim


-- Rollback the selected transaction

ROLLBACK;


-- After lock is released,
-- the other session can continue

COMMIT;


-- ============================================
-- 9. FAILURE AND RECOVERY DEMONSTRATION
-- ============================================

-- Check seat availability

SELECT seat_status
FROM SEAT
WHERE seat_id = 'S090';


-- Create SAVEPOINT

SAVEPOINT seat_reserved;


-- Temporarily reserve seat

UPDATE SEAT
SET seat_status = 'RESERVED'
WHERE seat_id = 'S090';


-- Payment fails

INSERT INTO PAYMENT
VALUES (
    'PAY803',
    'B223',
    24000,
    'UPI',
    'FAILED',
    0,
    SYSDATE
);


-- Rollback payment changes
-- and return to saved point

ROLLBACK TO seat_reserved;


-- Seat was reserved before SAVEPOINT rollback,
-- so set it back to AVAILABLE

UPDATE SEAT
SET seat_status = 'AVAILABLE'
WHERE seat_id = 'S090';


COMMIT;


-- ============================================
-- FINAL CHECK
-- ============================================

SELECT * FROM SEAT;

SELECT * FROM PAYMENT;

SELECT * FROM BOOKING;
