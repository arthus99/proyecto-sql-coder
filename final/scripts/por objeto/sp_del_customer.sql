USE michangarro;
DROP PROCEDURE IF EXISTS sp_del_customer;
DELIMITER //

CREATE PROCEDURE sp_del_customer(
    p_username VARCHAR(150)
)
BEGIN
    -- Validar el parámetro
    IF p_username IS NULL OR p_username = '' THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El nombre de usuario no puede ser nulo o vacío.';
    END IF;

    -- Eliminar el registro del cliente
    DELETE FROM customer WHERE username = p_username;

    -- Comprobar si se eliminó alguna fila
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El usuario no existe o no se pudo eliminar.';
    END IF;
    
END//

DELIMITER ;
