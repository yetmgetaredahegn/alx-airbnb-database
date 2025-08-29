# Airbnb Database - Seed Data

This folder contains the PostgreSQL seed script for the ALX Airbnb Database project.

## Files

- `seed.sql` - SQL script to insert sample data into all tables (User, Property, Booking, Payment, Review, Message).

## Instructions

1. Make sure PostgreSQL is installed and running on your machine.
2. Ensure your Airbnb database is already created and the schema (`schema.sql`) has been executed.
3. Navigate to this folder in your terminal.
4. Run the seed script using the `psql` command:

```bash
psql -d airbnb_db -f seed.sql

