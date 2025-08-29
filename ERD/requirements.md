# Airbnb Database ERD Documentation

## 📌 Objective
The goal of this project is to design an Entity-Relationship Diagram (ERD) for an **Airbnb-like platform**. The database captures essential information about **users, properties, bookings, reviews, and payments**, enabling property management and customer interactions.

---

## 📂 Entities and Attributes

### 1. User
- `user_id` (PK) – Unique identifier for each user
- `first_name` – User's first name
- `last_name` – User's last name
- `email` – Unique email address
- `password_hash` – Hashed password
- `phone_number` – Optional phone number
- `role` – ENUM: guest, host, admin
- `created_at` – Timestamp when the user was created

### 2. Property
- `property_id` (PK) – Unique identifier for each property
- `host_id` (FK → User.user_id) – The host who owns the property
- `name` – Name of the property
- `description` – Property description
- `location` – Property location
- `price_per_night` – Price per night
- `created_at` – Timestamp when property was added
- `updated_at` – Timestamp when property was last updated

### 3. Booking
- `booking_id` (PK) – Unique identifier for each booking
- `property_id` (FK → Property.property_id) – Property being booked
- `user_id` (FK → User.user_id) – User making the booking
- `start_date` – Booking start date
- `end_date` – Booking end date
- `total_price` – Total price of booking
- `status` – ENUM: pending, confirmed, canceled
- `created_at` – Timestamp when booking was created

### 4. Payment
- `payment_id` (PK) – Unique identifier for each payment
- `booking_id` (FK → Booking.booking_id) – Booking linked to the payment
- `amount` – Payment amount
- `payment_date` – Timestamp when payment was made
- `payment_method` – ENUM: credit_card, paypal, stripe

### 5. Review
- `review_id` (PK) – Unique identifier for each review
- `property_id` (FK → Property.property_id) – Property being reviewed
- `user_id` (FK → User.user_id) – User who wrote the review
- `rating` – INTEGER between 1 and 5
- `comment` – Review text
- `created_at` – Timestamp when review was created

### 6. Message
- `message_id` (PK) – Unique identifier for each message
- `sender_id` (FK → User.user_id) – User sending the message
- `recipient_id` (FK → User.user_id) – User receiving the message
- `message_body` – Text of the message
- `sent_at` – Timestamp when message was sent

---

## 🔗 Relationships
- **User → Property**: One user (host) can list many properties.  
- **User → Booking**: One user (guest) can make many bookings.  
- **Property → Booking**: One property can have many bookings.  
- **Booking → Payment**: One booking can have zero or one payment.  
- **User → Review**: One user can write many reviews.  
- **Property → Review**: One property can have many reviews.  
- **User → Message**: One user can send and receive many messages (self-referencing).  

---

## 📊 ERD Diagram
The ERD diagram is included in this repository:  
`ERD/airbnb-erd.png`  

This diagram visually represents the entities, attributes, primary keys, foreign keys, and relationships described above.

---

## ✅ Notes
- Passwords are stored as **hashes**, not plaintext.  
- Roles differentiate **hosts**, **guests**, and **admins**.  
- Booking status ensures proper tracking of reservations.  
- Payments are always linked to a booking.  
- Messages are self-referencing and allow users to communicate with each other.
