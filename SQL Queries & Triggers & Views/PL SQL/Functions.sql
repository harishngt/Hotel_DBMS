DROP FUNCTION calculate_total_amount;

DELIMITER //

CREATE FUNCTION calculate_total_amount(
    in_room_rate DECIMAL(10, 2),
    in_duration INT
) RETURNS DECIMAL(10, 2) READS SQL DATA
BEGIN
    DECLARE total_amount DECIMAL(10, 2);
    SET total_amount := in_room_rate * in_duration;
    RETURN total_amount;
END;
//

DELIMITER ;


SET @room_rate := 100.00;
SET @duration := 5;

SELECT calculate_total_amount(@room_rate, @duration) AS total_amount;
