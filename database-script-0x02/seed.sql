-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ===============================
-- 1. Seed Users
-- ===============================
INSERT INTO "User" (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('Alice', 'Johnson', 'alice@example.com', 'hashed_password1', '123-456-7890', 'guest'),
('Bob', 'Smith', 'bob@example.com', 'hashed_password2', '234-567-8901', 'host'),
('Carol', 'Williams', 'carol@example.com', 'hashed_password3', NULL, 'host'),
('Dave', 'Brown', 'dave@example.com', 'hashed_password4', '345-678-9012', 'guest'),
('Eve', 'Davis', 'eve@example.com', 'hashed_password5', NULL, 'admin');

-- ===============================
-- 2. Seed Properties
-- ===============================
INSERT INTO "Property" (host_id, name, description, street_address, city, state_or_region, country, postal_code, pricepernight)
VALUES
((SELECT user_id FROM "User" WHERE first_name='Bob'), 'Cozy Cottage', 'A small cozy cottage in the countryside', '123 Maple St', 'Springfield', 'Illinois', 'USA', '62704', 120.00),
((SELECT user_id FROM "User" WHERE first_name='Carol'), 'Modern Apartment', 'Stylish apartment in city center', '456 Oak Ave', 'New York', 'NY', 'USA', '10001', 200.00),
((SELECT user_id FROM "User" WHERE first_name='Bob'), 'Beach House', 'Spacious house near the beach', '789 Palm Rd', 'Miami', 'FL', 'USA', '33101', 350.00);

-- ===============================
-- 3. Seed Bookings
-- ===============================
INSERT INTO "Booking" (property_id, user_id, start_date, end_date, total_price, status)
VALUES
((SELECT property_id FROM "Property" WHERE name='Cozy Cottage'), (SELECT user_id FROM "User" WHERE first_name='Alice'), '2025-09-01', '2025-09-05', 480.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Modern Apartment'), (SELECT user_id FROM "User" WHERE first_name='Dave'), '2025-10-10', '2025-10-12', 400.00, 'pending');

-- ===============================
-- 4. Seed Payments
-- ===============================
INSERT INTO "Payment" (booking_id, amount, payment_method)
VALUES
((SELECT booking_id FROM "Booking" WHERE total_price=480.00), 480.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=400.00), 400.00, 'paypal');

-- ===============================
-- 5. Seed Reviews
-- ===============================
INSERT INTO "Review" (property_id, user_id, rating, comment)
VALUES
((SELECT property_id FROM "Property" WHERE name='Cozy Cottage'), (SELECT user_id FROM "User" WHERE first_name='Alice'), 5, 'Absolutely loved it!'),
((SELECT property_id FROM "Property" WHERE name='Modern Apartment'), (SELECT user_id FROM "User" WHERE first_name='Dave'), 4, 'Very nice and clean.');

-- ===============================
-- 6. Seed Messages
-- ===============================
INSERT INTO "Message" (sender_id, recipient_id, message_body)
VALUES
((SELECT user_id FROM "User" WHERE first_name='Alice'), (SELECT user_id FROM "User" WHERE first_name='Bob'), 'Hi Bob, excited about my stay!'),
((SELECT user_id FROM "User" WHERE first_name='Dave'), (SELECT user_id FROM "User" WHERE first_name='Carol'), 'Hello, can I check in earlier?');

