-- Sample Data Insertion for Airbnb Database

-- Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  ('uuid-user-1', 'Alice', 'Johnson', 'alice@example.com', 'hash1', '1234567890', 'guest', CURRENT_TIMESTAMP),
  ('uuid-user-2', 'Bob', 'Smith', 'bob@example.com', 'hash2', '0987654321', 'host', CURRENT_TIMESTAMP),
  ('uuid-user-3', 'Carol', 'White', 'carol@example.com', 'hash3', NULL, 'admin', CURRENT_TIMESTAMP);

-- Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
  ('uuid-prop-1', 'uuid-user-2', 'Cozy Cottage', 'A small cozy cottage in the countryside.', 'Naivasha, Kenya', 5000.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('uuid-prop-2', 'uuid-user-2', 'Modern Apartment', 'Modern apartment in the city center.', 'Nairobi, Kenya', 8000.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  ('uuid-book-1', 'uuid-prop-1', 'uuid-user-1', '2025-07-01', '2025-07-05', 20000.00, 'confirmed', CURRENT_TIMESTAMP),
  ('uuid-book-2', 'uuid-prop-2', 'uuid-user-1', '2025-08-10', '2025-08-12', 16000.00, 'pending', CURRENT_TIMESTAMP);

-- Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  ('uuid-pay-1', 'uuid-book-1', 20000.00, CURRENT_TIMESTAMP, 'credit_card');

-- Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  ('uuid-rev-1', 'uuid-prop-1', 'uuid-user-1', 5, 'Great place to relax. Highly recommend!', CURRENT_TIMESTAMP),
  ('uuid-rev-2', 'uuid-prop-2', 'uuid-user-1', 4, 'Nice and clean apartment.', CURRENT_TIMESTAMP);

-- Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  ('uuid-msg-1', 'uuid-user-1', 'uuid-user-2', 'Hi Bob, is your cottage available for next weekend?', CURRENT_TIMESTAMP),
  ('uuid-msg-2', 'uuid-user-2', 'uuid-user-1', 'Hi Alice, yes it is available. Feel free to book.', CURRENT_TIMESTAMP);
