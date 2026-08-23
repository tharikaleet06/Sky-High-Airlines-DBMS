# Database Normalization

## Overview

The Sky High Airlines database was designed using normalization principles to reduce data redundancy and avoid insertion, deletion, and update anomalies.

The database design was normalized through the following stages:

* Unnormalised Form (UNF)
* First Normal Form (1NF)
* Second Normal Form (2NF)
* Third Normal Form (3NF)
* Boyce-Codd Normal Form (BCNF)

## Unnormalised Form (UNF)

Initially, airline information was stored with multiple values in the same record, including flight details, seat numbers, and amounts.

This structure could lead to:

* Data redundancy
* Insertion anomalies
* Deletion anomalies
* Update anomalies

## First Normal Form (1NF)

The database was converted into First Normal Form by ensuring that:

* All attributes contain atomic values.
* No repeating groups exist.

## Second Normal Form (2NF)

The database was further normalized to remove partial dependencies.

The main entities identified at this stage include:

* PASSENGER
* FLIGHT
* BOOKING

## Third Normal Form (3NF)

Third Normal Form removes transitive dependencies by separating related entities into individual tables.

The normalized database includes:

* PASSENGER
* FLIGHT
* AIRCRAFT
* BOOKING
* SEAT
* PAYMENT

Each non-key attribute depends on the primary key of its respective table.

## Boyce-Codd Normal Form (BCNF)

The database design satisfies BCNF where, for every functional dependency:

`X → Y`

`X` must be a candidate key.

## Result

The final normalized design reduces redundancy and provides a structured relational database for managing airline operations.

