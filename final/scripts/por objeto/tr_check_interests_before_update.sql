DROP TRIGGER IF EXISTS tr_check_interests_before_update;
DELIMITER //

CREATE TRIGGER tr_check_interest_before_update
BEFORE UPDATE ON interests
FOR EACH ROW
BEGIN
    DECLARE cycle_detected BOOLEAN;

    -- Llamar a la función check_interest_cycle
    SET cycle_detected = fn_check_interest_cycle(NEW.parent_interest_id, NEW.interest_id);

    IF cycle_detected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ciclo detectado en la jerarquía de intereses.';
    END IF;
END;
//

DELIMITER ;

