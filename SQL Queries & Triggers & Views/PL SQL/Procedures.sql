DELIMITER //

CREATE OR REPLACE PROCEDURE insert_booking (
    in_guest_id INT,
    in_check_in_date DATETIME,
    in_duration_of_stay VARCHAR(10),
    in_booking_payment_type VARCHAR(45),
    in_total_rooms_booked INT,
    in_hotel_id INT,
    in_employee_id INT,
    in_total_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Unable to insert booking.';
    END;

    START TRANSACTION;
    INSERT INTO bookings (guests_guest_id, check_in_date, duration_of_stay, booking_payment_type, total_rooms_booked, hotel_hotel_id, employees_emp_id, total_amount)
    VALUES (in_guest_id, in_check_in_date, in_duration_of_stay, in_booking_payment_type, in_total_rooms_booked, in_hotel_id, in_employee_id, in_total_amount);
    
    COMMIT;
    SELECT 'Booking inserted successfully.' AS Message;
END //

DELIMITER ;


CALL insert_booking(1, NOW(), '5 days', 'Credit Card', 2, 1, 1, 500.00);

SELECT * FROM bookings;
