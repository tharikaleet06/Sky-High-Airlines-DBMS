-- =========================================================
-- SKY HIGH AIRLINES DATABASE
-- Sample Data Population
-- Oracle SQL
-- =========================================================


-- =========================================================
-- 1. AIRCRAFT
-- =========================================================

INSERT INTO AIRCRAFT VALUES
('AC001', 'Boeing 747', 'Boeing', 416);

INSERT INTO AIRCRAFT VALUES
('AC002', 'Boeing 737', 'Boeing', 189);

INSERT INTO AIRCRAFT VALUES
('AC003', 'Airbus A320', 'Airbus', 180);


-- =========================================================
-- 2. AIRPORT
-- =========================================================

INSERT INTO AIRPORT VALUES
('CPT', 'Cape Town Airport', 'Cape Town', 'South Africa');

INSERT INTO AIRPORT VALUES
('CAI', 'Cairo International', 'Cairo', 'Egypt');

INSERT INTO AIRPORT VALUES
('MEX', 'Mexico City Airport', 'Mexico City', 'Mexico');


-- =========================================================
-- 3. USER_ACCOUNT
-- =========================================================

INSERT INTO USER_ACCOUNT VALUES
('U047', 'AbhishekShah', 'Abhishek@123', 'PASSENGER', SYSDATE-28);

INSERT INTO USER_ACCOUNT VALUES
('U048', 'NandiniSuresh', 'Nandini@123', 'PASSENGER', SYSDATE-26);

INSERT INTO USER_ACCOUNT VALUES
('U049', 'YashPatel', 'Yash@123', 'PASSENGER', SYSDATE-24);


-- =========================================================
-- 4. PASSENGER
-- =========================================================

INSERT INTO PASSENGER VALUES
('P001', 'U001', 'Kavya', 'Sharma', 'FEMALE',
 DATE '2002-02-15', 'Indian', 'IND10001',
 '9876500001', 'kavya@gmail.com');

INSERT INTO PASSENGER VALUES
('P002', 'U002', 'Arjun', 'Verma', 'MALE',
 DATE '2001-03-20', 'Indian', 'IND10002',
 '9876500002', 'arjun@gmail.com');

INSERT INTO PASSENGER VALUES
('P003', 'U003', 'Priya', 'Nair', 'FEMALE',
 DATE '2002-05-12', 'Indian', 'IND10003',
 '9876500003', 'priya@gmail.com');


-- =========================================================
-- 5. FLIGHT
-- =========================================================

INSERT INTO FLIGHT VALUES
('F001', 'AI101', 'DEL', 'BOM', 'AC001',
 TIMESTAMP '2026-06-10 08:00:00',
 TIMESTAMP '2026-06-10 10:00:00',
 1148, 5500, 'SCHEDULED');

INSERT INTO FLIGHT VALUES
('F002', 'AI102', 'BOM', 'DEL', 'AC002',
 TIMESTAMP '2026-06-12 12:00:00',
 TIMESTAMP '2026-06-12 14:00:00',
 1148, 5500, 'ON TIME');

INSERT INTO FLIGHT VALUES
('F003', 'AI103', 'MAA', 'BLR', 'AC003',
 TIMESTAMP '2026-06-11 09:00:00',
 TIMESTAMP '2026-06-11 10:30:00',
 350, 3200, 'ON TIME');


-- =========================================================
-- 6. SEAT
-- =========================================================

INSERT INTO SEAT VALUES
('S001', 'F001', '1A', 'BUSINESS', 'BOOKED');

INSERT INTO SEAT VALUES
('S002', 'F001', '1B', 'BUSINESS', 'BOOKED');

INSERT INTO SEAT VALUES
('S003', 'F001', '12A', 'ECONOMY', 'BOOKED');

INSERT INTO SEAT VALUES
('S004', 'F001', '12B', 'ECONOMY', 'AVAILABLE');


-- =========================================================
-- 7. BOOKING
-- =========================================================

INSERT INTO BOOKING VALUES
('B001', 'P001', 'F001', 'S001', 'U001',
 'PNR1001', SYSDATE-20, 'ONE WAY',
 'CONFIRMED', 'VEG', 6500);

INSERT INTO BOOKING VALUES
('B002', 'P002', 'F001', 'S002', 'U031',
 'PNR1002', SYSDATE-19, 'ROUND TRIP',
 'CONFIRMED', 'NON VEG', 7200);

INSERT INTO BOOKING VALUES
('B003', 'P003', 'F001', 'S003', 'U032',
 'PNR1003', SYSDATE-18, 'ONE WAY',
 'CONFIRMED', 'JAIN', 6000);


-- =========================================================
-- 8. PAYMENT
-- =========================================================

INSERT INTO PAYMENT VALUES
('PAY001', 'B001', 6500, 'UPI',
 'SUCCESS', 0, SYSDATE-20);

INSERT INTO PAYMENT VALUES
('PAY002', 'B002', 7200, 'CREDIT CARD',
 'SUCCESS', 0, SYSDATE-19);

INSERT INTO PAYMENT VALUES
('PAY003', 'B003', 6000, 'DEBIT CARD',
 'SUCCESS', 0, SYSDATE-18);
