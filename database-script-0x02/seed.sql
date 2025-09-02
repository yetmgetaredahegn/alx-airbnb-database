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
('Eve', 'Davis', 'eve@example.com', 'hashed_password5', NULL, 'admin'),
('Frank', 'Miller', 'frank@example.com', 'hashed_password6', '456-789-0123', 'guest'),
('Grace', 'Taylor', 'grace@example.com', 'hashed_password7', '567-890-1234', 'host'),
('Henry', 'Wilson', 'henry@example.com', 'hashed_password8', NULL, 'guest'),
('Ivy', 'Moore', 'ivy@example.com', 'hashed_password9', '678-901-2345', 'host'),
('Jack', 'Anderson', 'jack@example.com', 'hashed_password10', '789-012-3456', 'guest'),
('Karen', 'Thomas', 'karen@example.com', 'hashed_password11', '890-123-4567', 'host'),
('Leo', 'Harris', 'leo@example.com', 'hashed_password12', NULL, 'guest'),
('Mona', 'Martin', 'mona@example.com', 'hashed_password13', '901-234-5678', 'guest'),
('Nina', 'Clark', 'nina@example.com', 'hashed_password14', '111-222-3333', 'host'),
('Oscar', 'Lewis', 'oscar@example.com', 'hashed_password15', NULL, 'guest'),
('Paul', 'Walker', 'paul@example.com', 'hashed_password16', '222-333-4444', 'guest'),
('Quinn', 'Hall', 'quinn@example.com', 'hashed_password17', '333-444-5555', 'host'),
('Rita', 'Allen', 'rita@example.com', 'hashed_password18', '444-555-6666', 'guest'),
('Sam', 'Young', 'sam@example.com', 'hashed_password19', NULL, 'host'),
('Tina', 'King', 'tina@example.com', 'hashed_password20', '555-666-7777', 'guest');

-- ===============================
-- 2. Seed Properties
-- ===============================
INSERT INTO "Property" (host_id, name, description, street_address, city, state_or_region, country, postal_code, pricepernight)
VALUES
((SELECT user_id FROM "User" WHERE first_name='Bob'), 'Cozy Cottage', 'A small cozy cottage in the countryside', '123 Maple St', 'Springfield', 'Illinois', 'USA', '62704', 120.00),
((SELECT user_id FROM "User" WHERE first_name='Carol'), 'Modern Apartment', 'Stylish apartment in city center', '456 Oak Ave', 'New York', 'NY', 'USA', '10001', 200.00),
((SELECT user_id FROM "User" WHERE first_name='Bob'), 'Beach House', 'Spacious house near the beach', '789 Palm Rd', 'Miami', 'FL', 'USA', '33101', 350.00),
((SELECT user_id FROM "User" WHERE first_name='Grace'), 'Mountain Cabin', 'Rustic cabin with a great view', '321 Pine Rd', 'Denver', 'CO', 'USA', '80202', 150.00),
((SELECT user_id FROM "User" WHERE first_name='Ivy'), 'Luxury Villa', 'High-end villa with pool and garden', '654 Sunset Blvd', 'Los Angeles', 'CA', 'USA', '90028', 500.00),
((SELECT user_id FROM "User" WHERE first_name='Karen'), 'City Loft', 'Trendy loft in the art district', '111 Main St', 'Chicago', 'IL', 'USA', '60601', 220.00),
((SELECT user_id FROM "User" WHERE first_name='Nina'), 'Desert Retreat', 'Quiet retreat in the desert', '222 Sand Dune Rd', 'Phoenix', 'AZ', 'USA', '85001', 180.00),
((SELECT user_id FROM "User" WHERE first_name='Quinn'), 'Lake House', 'Beautiful lake view property', '333 Lake Dr', 'Austin', 'TX', 'USA', '73301', 275.00),
((SELECT user_id FROM "User" WHERE first_name='Sam'), 'Downtown Condo', 'Perfect for business trips', '444 Market St', 'San Francisco', 'CA', 'USA', '94103', 300.00),
((SELECT user_id FROM "User" WHERE first_name='Grace'), 'Countryside Farmhouse', 'Farmhouse with animals', '555 Country Rd', 'Madison', 'WI', 'USA', '53703', 140.00),
((SELECT user_id FROM "User" WHERE first_name='Ivy'), 'Ski Lodge', 'Close to ski slopes', '666 Snow St', 'Aspen', 'CO', 'USA', '81611', 400.00),
((SELECT user_id FROM "User" WHERE first_name='Nina'), 'Historic B&B', 'Charming and cozy', '777 River Rd', 'Boston', 'MA', 'USA', '02108', 160.00),
((SELECT user_id FROM "User" WHERE first_name='Quinn'), 'Seaside Bungalow', 'Private beach access', '888 Ocean Dr', 'San Diego', 'CA', 'USA', '92101', 280.00),
((SELECT user_id FROM "User" WHERE first_name='Sam'), 'Urban Penthouse', 'Luxury views of the skyline', '999 Tower Ln', 'Seattle', 'WA', 'USA', '98101', 600.00),
((SELECT user_id FROM "User" WHERE first_name='Carol'), 'Suburban Home', 'Family friendly home', '147 Elm St', 'Atlanta', 'GA', 'USA', '30301', 175.00);

-- ===============================
-- 3. Seed Bookings
-- ===============================
INSERT INTO "Booking" (property_id, user_id, start_date, end_date, total_price, status)
VALUES
((SELECT property_id FROM "Property" WHERE name='Cozy Cottage'), (SELECT user_id FROM "User" WHERE first_name='Alice'), '2025-09-01', '2025-09-05', 480.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Modern Apartment'), (SELECT user_id FROM "User" WHERE first_name='Dave'), '2025-10-10', '2025-10-12', 400.00, 'pending'),
((SELECT property_id FROM "Property" WHERE name='Beach House'), (SELECT user_id FROM "User" WHERE first_name='Frank'), '2025-08-15', '2025-08-20', 1750.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Mountain Cabin'), (SELECT user_id FROM "User" WHERE first_name='Henry'), '2025-09-12', '2025-09-15', 450.00, 'cancelled'),
((SELECT property_id FROM "Property" WHERE name='Luxury Villa'), (SELECT user_id FROM "User" WHERE first_name='Jack'), '2025-12-01', '2025-12-07', 3000.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='City Loft'), (SELECT user_id FROM "User" WHERE first_name='Leo'), '2025-11-05', '2025-11-08', 660.00, 'pending'),
((SELECT property_id FROM "Property" WHERE name='Desert Retreat'), (SELECT user_id FROM "User" WHERE first_name='Mona'), '2025-09-20', '2025-09-22', 360.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Lake House'), (SELECT user_id FROM "User" WHERE first_name='Oscar'), '2025-10-01', '2025-10-05', 1100.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Downtown Condo'), (SELECT user_id FROM "User" WHERE first_name='Paul'), '2025-08-25', '2025-08-28', 900.00, 'pending'),
((SELECT property_id FROM "Property" WHERE name='Countryside Farmhouse'), (SELECT user_id FROM "User" WHERE first_name='Rita'), '2025-10-15', '2025-10-18', 420.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Ski Lodge'), (SELECT user_id FROM "User" WHERE first_name='Tina'), '2025-12-20', '2025-12-27', 2800.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Historic B&B'), (SELECT user_id FROM "User" WHERE first_name='Alice'), '2025-07-01', '2025-07-04', 520.00, 'cancelled'),
((SELECT property_id FROM "Property" WHERE name='Seaside Bungalow'), (SELECT user_id FROM "User" WHERE first_name='Dave'), '2025-11-12', '2025-11-16', 1120.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Urban Penthouse'), (SELECT user_id FROM "User" WHERE first_name='Eve'), '2025-09-25', '2025-09-29', 2400.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Suburban Home'), (SELECT user_id FROM "User" WHERE first_name='Frank'), '2025-08-10', '2025-08-12', 350.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Luxury Villa'), (SELECT user_id FROM "User" WHERE first_name='Paul'), '2025-11-01', '2025-11-03', 1500.00, 'pending'),
((SELECT property_id FROM "Property" WHERE name='Lake House'), (SELECT user_id FROM "User" WHERE first_name='Henry'), '2025-09-07', '2025-09-10', 825.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Modern Apartment'), (SELECT user_id FROM "User" WHERE first_name='Jack'), '2025-09-02', '2025-09-04', 410.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Beach House'), (SELECT user_id FROM "User" WHERE first_name='Karen'), '2025-09-14', '2025-09-19', 1725.00, 'confirmed'),
((SELECT property_id FROM "Property" WHERE name='Cozy Cottage'), (SELECT user_id FROM "User" WHERE first_name='Leo'), '2025-09-22', '2025-09-25', 365.00, 'pending');

-- ===============================
-- 4. Seed Payments
-- ===============================
INSERT INTO "Payment" (booking_id, amount, payment_method)
VALUES
((SELECT booking_id FROM "Booking" WHERE total_price=480.00), 480.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=400.00), 400.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=1750.00), 1750.00, 'debit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=450.00), 450.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=3000.00), 3000.00, 'bank_transfer'),
((SELECT booking_id FROM "Booking" WHERE total_price=660.00), 660.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=360.00), 360.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=1100.00), 1100.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=900.00), 900.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=420.00), 420.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=2800.00), 2800.00, 'bank_transfer'),
((SELECT booking_id FROM "Booking" WHERE total_price=520.00), 520.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=1120.00), 1120.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=2400.00), 2400.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=350.00), 350.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=1500.00), 1500.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=825.00), 825.00, 'credit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=410.00), 410.00, 'debit_card'),
((SELECT booking_id FROM "Booking" WHERE total_price=1725.00), 1725.00, 'paypal'),
((SELECT booking_id FROM "Booking" WHERE total_price=365.00), 365.00, 'credit_card');

-- ===============================
-- 5. Seed Reviews
-- ===============================
INSERT INTO "Review" (property_id, user_id, rating, comment)
VALUES
((SELECT property_id FROM "Property" WHERE name='Cozy Cottage'), (SELECT user_id FROM "User" WHERE first_name='Alice'), 5, 'Absolutely loved it!'),
((SELECT property_id FROM "Property" WHERE name='Modern Apartment'), (SELECT user_id FROM "User" WHERE first_name='Dave'), 4, 'Very nice and clean.'),
((SELECT property_id FROM "Property" WHERE name='Beach House'), (SELECT user_id FROM "User" WHERE first_name='Frank'), 5, 'Perfect vacation spot.'),
((SELECT property_id FROM "Property" WHERE name='Mountain Cabin'), (SELECT user_id FROM "User" WHERE first_name='Henry'), 3, 'Cozy but a bit cold.'),
((SELECT property_id FROM "Property" WHERE name='Luxury Villa'), (SELECT user_id FROM "User" WHERE first_name='Jack'), 5, 'Luxury at its best!'),
((SELECT property_id FROM "Property" WHERE name='City Loft'), (SELECT user_id FROM "User" WHERE first_name='Leo'), 4, 'Trendy place with great location.'),
((SELECT property_id FROM "Property" WHERE name='Desert Retreat'), (SELECT user_id FROM "User" WHERE first_name='Mona'), 5, 'Very peaceful stay.'),
((SELECT property_id FROM "Property" WHERE name='Lake House'), (SELECT user_id FROM "User" WHERE first_name='Oscar'), 4, 'Beautiful views.'),
((SELECT property_id FROM "Property" WHERE name='Downtown Condo'), (SELECT user_id FROM "User" WHERE first_name='Paul'), 5, 'Super convenient!'),
((SELECT property_id FROM "Property" WHERE name='Countryside Farmhouse'), (SELECT user_id FROM "User" WHERE first_name='Rita'), 3, 'Rustic experience.'),
((SELECT property_id FROM "Property" WHERE name='Ski Lodge'), (SELECT user_id FROM "User" WHERE first_name='Tina'), 5, 'Best ski trip ever.'),
((SELECT property_id FROM "Property" WHERE name='Historic B&B'), (SELECT user_id FROM "User" WHERE first_name='Alice'), 4, 'Charming place.'),
((SELECT property_id FROM "Property" WHERE name='Seaside Bungalow'), (SELECT user_id FROM "User" WHERE first_name='Dave'), 5, 'Can’t beat the beach!'),
((SELECT property_id FROM "Property" WHERE name='Urban Penthouse'), (SELECT user_id FROM "User" WHERE first_name='Eve'), 5, 'Amazing views!'),
((SELECT property_id FROM "Property" WHERE name='Suburban Home'), (SELECT user_id FROM "User" WHERE first_name='Frank'), 4, 'Great for families.');

-- ===============================
-- 6. Seed Messages
-- ===============================
INSERT INTO "Message" (sender_id, recipient_id, message_body)
VALUES
((SELECT user_id FROM "User" WHERE first_name='Alice'), (SELECT user_id FROM "User" WHERE first_name='Bob'), 'Hi Bob, excited about my stay!'),
((SELECT user_id FROM "User" WHERE first_name='Dave'), (SELECT user_id FROM "User" WHERE first_name='Carol'), 'Hello, can I check in earlier?'),
((SELECT user_id FROM "User" WHERE first_name='Frank'), (SELECT user_id FROM "User" WHERE first_name='Bob'), 'Do you allow pets at the beach house?'),
((SELECT user_id FROM "User" WHERE first_name='Henry'), (SELECT user_id FROM "User" WHERE first_name='Grace'), 'Is the mountain cabin heated?'),
((SELECT user_id FROM "User" WHERE first_name='Jack'), (SELECT user_id FROM "User" WHERE first_name='Ivy'), 'Loved the villa, will book again!'),
((SELECT user_id FROM "User" WHERE first_name='Leo'), (SELECT user_id FROM "User" WHERE first_name='Karen'), 'Is parking available at the loft?'),
((SELECT user_id FROM "User" WHERE first_name='Mona'), (SELECT user_id FROM "User" WHERE first_name='Nina'), 'How remote is the desert retreat?'),
((SELECT user_id FROM "User" WHERE first_name='Oscar'), (SELECT user_id FROM "User" WHERE first_name='Quinn'), 'Can I use the kayak at the lake house?'),
((SELECT user_id FROM "User" WHERE first_name='Paul'), (SELECT user_id FROM "User" WHERE first_name='Sam'), 'Do you have early check-in for the condo?'),
((SELECT user_id FROM "User" WHERE first_name='Rita'), (SELECT user_id FROM "User" WHERE first_name='Grace'), 'Any fresh eggs at the farmhouse?'),
((SELECT user_id FROM "User" WHERE first_name='Tina'), (SELECT user_id FROM "User" WHERE first_name='Ivy'), 'Is ski equipment storage available?'),
((SELECT user_id FROM "User" WHERE first_name='Alice'), (SELECT user_id FROM "User" WHERE first_name='Nina'), 'Is breakfast included at the B&B?'),
((SELECT user_id FROM "User" WHERE first_name='Dave'), (SELECT user_id FROM "User" WHERE first_name='Quinn'), 'How close is the bungalow to the beach?'),
((SELECT user_id FROM "User" WHERE first_name='Eve'), (SELECT user_id FROM "User" WHERE first_name='Sam'), 'Can you confirm the penthouse Wi-Fi speed?'),
((SELECT user_id FROM "User" WHERE first_name='Frank'), (SELECT user_id FROM "User" WHERE first_name='Carol'), 'Is there a crib available at the suburban home?');
