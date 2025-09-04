-- =========================================
-- partitioning.sql
-- Self-contained migration + partitioning + indexes
-- =========================================

BEGIN;

-- =========================================
-- Step 0: Drop old FK in Payment to avoid conflicts
-- =========================================
ALTER TABLE "Payment" DROP CONSTRAINT IF EXISTS fk_payment_booking;

-- =========================================
-- Step 1: Rename original Booking table
-- =========================================
ALTER TABLE "Booking" RENAME TO "Booking_old";

-- =========================================
-- Step 2: Create new partitioned parent table
-- =========================================
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


-- =========================================
-- Step 3: Create yearly partitions
-- =========================================
CREATE TABLE booking_2024 PARTITION OF "Booking"
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF "Booking"
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE booking_2026 PARTITION OF "Booking"
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Default partition for out-of-range data
CREATE TABLE booking_default PARTITION OF "Booking"
DEFAULT;

-- =========================================
-- Step 4: Create indexes for performance
-- =========================================
CREATE INDEX IF NOT EXISTS idx_booking_start_date_2024 ON booking_2024(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_start_date_2025 ON booking_2025(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_start_date_2026 ON booking_2026(start_date);

CREATE INDEX IF NOT EXISTS idx_booking_user_id_2024 ON booking_2024(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_user_id_2025 ON booking_2025(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_user_id_2026 ON booking_2026(user_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_id_2024 ON booking_2024(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id_2025 ON booking_2025(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id_2026 ON booking_2026(property_id);

ANALYZE "Booking";

-- =========================================
-- Step 5: Reinsert old data into partitioned table
-- =========================================
INSERT INTO "Booking" (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
SELECT booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at
FROM "Booking_old";


-- =========================================
-- Step 6: Example query to test performance
-- =========================================
EXPLAIN ANALYZE
SELECT booking_id, start_date, end_date, status
FROM "Booking"
WHERE start_date BETWEEN DATE '2025-10-01' AND DATE '2025-12-31';


COMMIT;
--rollback; 


-- Before Partitionin
EXPLAIN ANALYZE
SELECT booking_id, start_date, end_date, status
FROM "Booking_old"
WHERE start_date BETWEEN DATE '2025-10-01' AND DATE '2025-12-31';


--trying to connect the payment with booking new one
ALTER TABLE "Payment" 
ADD COLUMN start_date DATE;

-- Update existing records with the corresponding booking start_date
UPDATE "Payment" p
SET start_date = b.start_date
FROM "Booking" b
WHERE p.booking_id = b.booking_id;

-- Make the column NOT NULL after populating
ALTER TABLE "Payment" 
ALTER COLUMN start_date SET NOT NULL;

ALTER TABLE "Payment"
ADD CONSTRAINT fk_payment_booking
FOREIGN KEY (booking_id, start_date) 
REFERENCES "Booking"(booking_id, start_date);
