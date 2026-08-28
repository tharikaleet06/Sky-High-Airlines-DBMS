-- ============================================================
-- SKY HIGH AIRLINES DBMS
-- DATABASE SECURITY
-- Author: Tharika P
-- ============================================================


-- ============================================================
-- 1. ROLE-BASED ACCESS CONTROL (RBAC)
-- ============================================================


-- ------------------------------------------------------------
-- ADMIN ROLE
-- ------------------------------------------------------------

CREATE ROLE ADMIN;

GRANT ALL PRIVILEGES TO ADMIN;


-- ------------------------------------------------------------
-- AGENT ROLE
-- ------------------------------------------------------------

CREATE ROLE AGENT;

GRANT INSERT ON BOOKING TO AGENT;

GRANT SELECT ON FLIGHT TO AGENT;


-- ------------------------------------------------------------
-- CREW ROLE
-- ------------------------------------------------------------

CREATE ROLE CREW;


-- Create Passenger Manifest View

CREATE VIEW PASSENGER_MANIFEST AS
SELECT p.passenger_id,
       p.first_name,
       p.last_name,
       b.flight_id
FROM PASSENGER p
JOIN BOOKING b
ON p.passenger_id = b.passenger_id;


-- Grant access to the Passenger Manifest

GRANT SELECT ON PASSENGER_MANIFEST TO CREW;


-- ============================================================
-- 2. ASSIGN ROLES TO USERS
-- ============================================================

GRANT AGENT TO U031;

GRANT CREW TO U050;

GRANT ADMIN TO ADMIN1;


-- ============================================================
-- 3. REVOKE PRIVILEGES
-- ============================================================

REVOKE INSERT ON BOOKING FROM AGENT;


-- ============================================================
-- 4. SQL INJECTION DEMONSTRATION
-- ============================================================

-- Example of a vulnerable SQL condition.
-- Directly using unvalidated user input in an application query
-- can lead to SQL injection vulnerabilities.

SELECT *
FROM USER_ACCOUNT
WHERE username = ''' OR ''1''=''1'
AND password = 'anything';


-- ============================================================
-- SECURE APPROACH
-- ============================================================

-- Use parameterized queries / PreparedStatement in the
-- application layer so user input is treated as data rather
-- than executable SQL code.


-- ============================================================
-- END OF DATABASE SECURITY
-- ============================================================
