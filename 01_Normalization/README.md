# Database Normalization

## Overview

The Sky High Airlines database was normalized to reduce data redundancy and avoid insertion, deletion, and update anomalies.

The normalization process was carried out through the following stages:

1. Unnormalised Form (UNF)
2. First Normal Form (1NF)
3. Second Normal Form (2NF)
4. Third Normal Form (3NF)
5. Boyce-Codd Normal Form (BCNF)

---

## 1. Unnormalised Form (UNF)

All the information of Sky High Airlines is initially kept in the same table.

| Booking_ID | P_Name       | Passport_No | Flight_Details                                               | Seat_Nos | Amounts      |
| ---------- | ------------ | ----------- | ------------------------------------------------------------ | -------- | ------------ |
| B001       | Kavya Sharma | IND001      | (AI101, JFK-LHR, Boeing 787), (AI102, LHR-CDG, Boeing 787)   | 12A, 15B | 12000, 15000 |
| B002       | Rahul Verma  | IND002      | (AI201, DEL-DXB, Airbus A320), (AI202, DXB-LHR, Airbus A320) | 8C, 10D  | 23000, 24500 |

The above table has attributes with multiple values. Data redundancy and anomalies can occur during:

* Insertion
* Deletion
* Updation

---

## 2. First Normal Form (1NF)

The data is converted into First Normal Form by ensuring that:

* All attributes have atomic values.
* No repeating values exist.

| Booking_ID | P_ID | P_Name       | Passport_No | Flight_No | Source | Destination | Aircraft_Model | Seat_No | Amount |
| ---------- | ---- | ------------ | ----------- | --------- | ------ | ----------- | -------------- | ------- | ------ |
| B001       | P001 | Kavya Sharma | IND001      | AI101     | JFK    | LHR         | Boeing-787     | 12A     | 12000  |
| B001       | P001 | Kavya Sharma | IND001      | AI101     | LHR    | CDG         | Boeing-787     | 15B     | 15000  |
| B002       | P002 | Rahul Verma  | IND002      | AI102     | DEL    | DXB         | Airbus A320    | 8C      | 23000  |
| B002       | P002 | Rahul Verma  | IND002      | AI102     | DXB    | LHR         | Airbus A320    | 10D     | 24500  |

The above table contains atomic values, but there exists a partial dependency because passenger details are fully dependent on `P_ID` and not on the booking information.

---

## 3. Second Normal Form (2NF)

For a table to be in Second Normal Form:

* The table should be in 1NF.
* No partial dependency should exist.

### Table: PASSENGER

| P_ID | P_Name       | Passport_No |
| ---- | ------------ | ----------- |
| P001 | Kavya Sharma | IND001      |
| P002 | Rahul Verma  | IND002      |

### Table: FLIGHT

| Flight_No | Source | Destination | Aircraft_Model |
| --------- | ------ | ----------- | -------------- |
| AI101     | JFK    | LHR         | Boeing-787     |
| AI101     | LHR    | CDG         | Boeing-787     |
| AI102     | DEL    | DXB         | Airbus A320    |
| AI102     | DXB    | LHR         | Airbus A320    |

### Table: BOOKING

| Booking_ID | P_ID | Flight_No | Seat_No | Amount |
| ---------- | ---- | --------- | ------- | ------ |
| B001       | P001 | AI101     | 12A     | 12000  |
| B001       | P001 | AI101     | 15B     | 15000  |
| B002       | P002 | AI102     | 8C      | 23000  |
| B002       | P002 | AI102     | 10D     | 24500  |

The above tables do not contain partial dependencies, but `Aircraft_Model` depends on `Flight_No`, which can lead to a transitive dependency.

---

## 4. Third Normal Form (3NF)

For a table to be in Third Normal Form:

* Tables should be in 2NF.
* No transitive dependency should exist.

### Table: PASSENGER

| P_ID | P_Name       | Passport_No |
| ---- | ------------ | ----------- |
| P001 | Kavya Sharma | IND001      |
| P002 | Rahul Varma  | IND002      |

### Table: FLIGHT

| Flight_ID | Flight_No | Source | Destination | Aircraft_ID |
| --------- | --------- | ------ | ----------- | ----------- |
| F001      | AI101     | JFK    | LHR         | A001        |
| F001      | AI101     | LHR    | CDG         | A001        |
| F002      | AI102     | DEL    | DXB         | A002        |
| F002      | AI102     | DXB    | LHR         | A002        |

### Table: AIRCRAFT

| Aircraft_ID | Aircraft_Model |
| ----------- | -------------- |
| A001        | Boeing-787     |
| A002        | Airbus A320    |

### Table: BOOKING

| Booking_ID | P_ID | Flight_ID | Seat_ID |
| ---------- | ---- | --------- | ------- |
| B001       | P001 | F001      | S001    |
| B001       | P001 | F001      | S002    |
| B002       | P002 | F002      | S003    |
| B002       | P002 | F002      | S004    |

### Table: SEAT

| Seat_ID | Seat_No | Seat_Class | Flight_ID |
| ------- | ------- | ---------- | --------- |
| S001    | 12A     | Economy    | F001      |
| S002    | 15B     | Economy    | F001      |
| S003    | 8C      | Business   | F002      |
| S004    | 10D     | Business   | F002      |

### Table: PAYMENT

| Payment_ID | Booking_ID | Amount |
| ---------- | ---------- | ------ |
| PAY01      | B001       | 27000  |
| PAY02      | B002       | 47500  |

In the above tables, all non-key attributes are dependent on their respective primary key and no transitive dependency occurs.

---

## 5. Boyce-Codd Normal Form (BCNF)

For every functional dependency:

`X → Y`

`X` must be a candidate key.

The tables defined in 3NF satisfy BCNF, as all the determinants are candidate keys.

---

## Normalization Flow

```text
UNF
 ↓
1NF
 ↓
2NF
 ↓
3NF
 ↓
BCNF
```

---

## Author

**Tharika P**

