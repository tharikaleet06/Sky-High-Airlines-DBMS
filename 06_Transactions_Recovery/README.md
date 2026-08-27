# Transaction Management, Recovery & Concurrency

This section demonstrates the implementation of **database transactions** for a Ticket Booking System using Oracle SQL. It covers transaction control operations such as **COMMIT, ROLLBACK, SAVEPOINT**, along with practical demonstrations of **concurrency conflicts, deadlocks, failure handling, and recovery**.

## Features Implemented

### 1. Ticket Booking Transaction

A complete ticket booking transaction is implemented with the following steps:

1. Check seat availability.
2. Create a temporary reservation.
3. Process the payment.
4. Confirm the booking.
5. Update the seat status to `BOOKED`.
6. Commit the transaction.

This ensures that all related booking operations are handled as a single transaction.

## 2. COMMIT

`COMMIT` is used to permanently save all changes made during a transaction.

Example:

```sql
UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S081';

COMMIT;
```

Once committed, the changes become permanent and cannot be undone using `ROLLBACK`.

## 3. ROLLBACK

`ROLLBACK` is used to undo changes made during the current transaction before a `COMMIT`.

Example:

```sql
UPDATE SEAT
SET seat_status = 'BOOKED'
WHERE seat_id = 'S081';

ROLLBACK;
```

The seat status returns to its previously committed state.

## 4. SAVEPOINT

A `SAVEPOINT` creates a checkpoint inside a transaction. If an error occurs, the transaction can roll back to that specific point instead of undoing the entire transaction.

Example:

```sql
SAVEPOINT seat_reserved;

UPDATE SEAT
SET seat_status = 'RESERVED'
WHERE seat_id = 'S090';

ROLLBACK TO seat_reserved;
```

This is useful in scenarios such as payment failure during ticket booking.

## 5. Failure and Recovery

The system demonstrates how a failed payment can be handled safely.

Transaction flow:

```text
Check Seat Availability
        ↓
Create SAVEPOINT
        ↓
Reserve Seat
        ↓
Process Payment
        ↓
Payment Failed
        ↓
ROLLBACK TO SAVEPOINT
        ↓
Recover Previous Seat State
```

This prevents incomplete or failed transactions from leaving the database in an inconsistent state.

## 6. Concurrency Conflict

A concurrency conflict is demonstrated using two separate database sessions attempting to book the same seat simultaneously.

### Session 1

* Checks seat availability.
* Updates the seat status to `BOOKED`.
* Holds the row lock without committing.

### Session 2

* Attempts to update the same seat.
* Waits until Session 1 releases the lock.

After Session 1 commits, Session 2 can recheck the seat status and determine whether the seat has already been booked.

This demonstrates how database locking helps prevent multiple passengers from successfully booking the same seat.

## 7. Deadlock Simulation

A deadlock is demonstrated using two sessions.

### Session 1

* Locks seat `S093`.
* Attempts to lock seat `S094`.

### Session 2

* Locks seat `S094`.
* Attempts to lock seat `S093`.

This creates a circular wait:

```text
Session 1 → Waiting for S094
Session 2 → Waiting for S093

        ↓

      DEADLOCK
```

The database detects the deadlock and resolves it by selecting one transaction as the victim and rolling it back. The released locks allow the remaining transaction to continue.

## Database Tables Used

### SEAT

Stores seat information and availability status.

```text
seat_id
seat_status
```

Possible statuses include:

* `AVAILABLE`
* `RESERVED`
* `BOOKED`

### PAYMENT

Stores payment details and transaction status.

```text
payment_id
booking_id
amount
payment_method
payment_status
refund_amount
payment_date
```

### BOOKING

Stores confirmed ticket booking information.

```text
booking_id
passenger_id
flight_id
seat_id
user_id
pnr
booking_date
trip_type
booking_status
vehicle_type
amount
```

## Key Concepts Demonstrated

| Concept                 | Purpose                                            |
| ----------------------- | -------------------------------------------------- |
| `COMMIT`                | Permanently saves transaction changes              |
| `ROLLBACK`              | Undoes uncommitted changes                         |
| `SAVEPOINT`             | Creates a checkpoint within a transaction          |
| `ROLLBACK TO SAVEPOINT` | Restores the transaction to a specific checkpoint  |
| Concurrency Control     | Prevents conflicting simultaneous updates          |
| Row Locking             | Controls access to the same database record        |
| Deadlock                | Demonstrates circular waiting between transactions |
| Recovery                | Restores database consistency after failure        |

## How to Run

1. Open Oracle SQL Developer or SQL*Plus.
2. Connect to the Oracle database.
3. Run the table creation and sample data statements.
4. Execute the ticket booking transaction.
5. Run the `COMMIT`, `ROLLBACK`, and `SAVEPOINT` demonstrations.
6. Open two separate database sessions to test:

   * Concurrency conflict
   * Deadlock simulation

## Conclusion

This module demonstrates how database transaction management maintains **data consistency, reliability, and integrity** in a Ticket Booking System. Using `COMMIT`, `ROLLBACK`, and `SAVEPOINT`, the system can safely handle successful transactions and failures. Concurrency control and deadlock handling further ensure that simultaneous booking operations do not result in inconsistent or duplicate seat reservations.

