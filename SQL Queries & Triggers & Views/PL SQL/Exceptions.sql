DROP PROCEDURE insert_room_type;

DELIMITER //

CREATE PROCEDURE insert_room_type (
    in_room_type_name VARCHAR(45),
    in_room_cost DECIMAL(10, 2),
    in_room_type_description VARCHAR(100),
    in_smoke_friendly TINYINT,
    in_pet_friendly TINYINT
)
BEGIN
    DECLARE duplicate_entry CONDITION FOR SQLSTATE '23000';
    DECLARE any_error CONDITION FOR SQLSTATE '45000';
    DECLARE unknown_error CONDITION FOR SQLSTATE 'HY000';

    DECLARE EXIT HANDLER FOR duplicate_entry
    BEGIN
        ROLLBACK;
        SELECT 'Error: Duplicate entry. Room type already exists.' AS Message;
    END;

    DECLARE CONTINUE HANDLER FOR any_error
    BEGIN
        ROLLBACK;
        SELECT 'Error: Any error occurred.' AS Message;
    END;

    DECLARE CONTINUE HANDLER FOR unknown_error
    BEGIN
        ROLLBACK;
        SELECT 'Error: Unknown error occurred.' AS Message;
    END;

    START TRANSACTION;
    
    -- Insert into table excluding room_type_id (auto-incremented primary key)
    INSERT INTO room_type (room_type_name, room_cost, room_type_description, smoke_friendly, pet_friendly)
    VALUES (in_room_type_name, in_room_cost, in_room_type_description, in_smoke_friendly, in_pet_friendly);
    
    COMMIT;

    SELECT 'Room type inserted successfully.' AS Message;
    
END;
//

DELIMITER ;


CALL insert_room_type('Standard Room', 103.00, '1 King Bed 323-sq-foot (30-sq-meter) room with city views', 0, 1);
