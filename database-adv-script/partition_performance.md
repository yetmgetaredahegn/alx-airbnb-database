# Partition Performance Report

## Objective
The objective of this task was to optimize queries on the `Booking` table, which is assumed to be large, by implementing **range partitioning** based on the `start_date` column. Partitioning can improve query performance by allowing **partition pruning**, which restricts queries to only relevant subsets of data instead of scanning the entire table.

---

## Steps Taken

1. **Renamed Original Table**
   ```sql
   ALTER TABLE "Booking" RENAME TO "Booking_old";
```
-Preserved original data for migration.

C2. **Created Partitioned Parent Table**
```sql
CREATE TABLE "Booking" (
    booking_id   UUID NOT NULL DEFAULT gen_random_uuid(),
    property_id  UUID NOT NULL REFERENCES "Property"(property_id),
    user_id      UUID NOT NULL REFERENCES "User"(user_id),
    start_date   DATE NOT NULL,
    end_date     DATE NOT NULL,
    total_price  DECIMAL NOT NULL,
    status       VARCHAR NOT NULL CHECK (status IN ('pending','confirmed','canceled')),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);
```
3. **Created Child Partitions**

- Yearly partitions:

	- `booking_2024`, `booking_2025`, `booking_2026`

- Default partition for out-of-range dates:

	- `booking_default`

4. **Created Indexes on Partitions**

- Indexes on `start_date`, `user_id`, and `property_id` for each partition to optimize filtering and joins.

5. **Migrated Existing Data**
```sql
INSERT INTO "Booking" (...)
SELECT ... FROM "Booking_old";
```
6. **Updated Payment Table for Foreign Key**

- Added `start_date` column to Payment.

- Populated it using existing Booking data.

- Added FK constraint referencing partitioned parent table:
```sql
FOREIGN KEY (booking_id, start_date) REFERENCES "Booking"(booking_id, start_date);
```
## Performance Testing
### Query Used for Testing:
```sql
SELECT booking_id, start_date, end_date, status
FROM "Booking"
WHERE start_date BETWEEN DATE '2025-10-01' AND DATE '2025-12-31';
```
**Before Partitioning (on Booking_old):**
```sql
Planning Time: 0.353 ms
Execution Time: 8.689 msPlanning Time: 0.353 ms
```
**After Partitioning (on partitioned Booking table):**
```sql
Planning Time: 0.472 ms
Execution Time: 1.129 ms
```
## Observation:

- The partitioned query is expected to be significantly faster because PostgreSQL only scans relevant child partitions (`booking_2025` in this example), avoiding a full table scan on all historical bookings.

- Indexes on `start_date`, `user_id`, and `property_id` further improve filtering and join performance.

## Conclusion
- Partitioning by `start_date` allows partition pruning, which restricts queries to only relevant partitions.

- Indexes on partitioned tables provide additional speedups for filters and joins.

- Existing foreign keys required adjustments to reference the new partitioned parent table, ensuring data integrity.

- Overall, partitioning large tables is effective for performance optimization on date-range queries.
