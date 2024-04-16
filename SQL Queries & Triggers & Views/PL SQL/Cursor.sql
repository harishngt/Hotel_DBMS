DROP PROCEDURE calculate_total_spent;

DELIMITER //
CREATE PROCEDURE calculate_total_spent()
BEGIN
    DECLARE total DECIMAL(10, 2) DEFAULT 0.00;
    DECLARE done INT DEFAULT 0;
    DECLARE guest_id INT;
    DECLARE amount DECIMAL(10, 2);
    -- Declare cursor
    DECLARE guest_cursor CURSOR FOR
        SELECT guests_guest_id, total_amount FROM bookings;
    -- Declare continue handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN guest_cursor;
    guest_loop: LOOP
        FETCH guest_cursor INTO guest_id, amount;
        IF done THEN
            LEAVE guest_loop;
        END IF;
        -- Calculate total spent
        SET total = total + amount;
    END LOOP;
    CLOSE guest_cursor;
    SELECT total AS total_spent;
END;
//
DELIMITER ;


CALL calculate_total_spent();
