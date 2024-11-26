USE `michangarro`;
DROP procedure IF EXISTS sp_is_username_valid;

DELIMITER $$
USE `michangarro`$$
CREATE PROCEDURE sp_is_username_valid (
	p_username VARCHAR(150), 
    OUT username_message VARCHAR(150), 
    OUT is_username_valid BOOLEAN)
BEGIN

    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
	DECLARE proc_name VARCHAR(50) DEFAULT 'sp_is_username_valid';
    DECLARE error_message VARCHAR(255) DEFAULT '';
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              	-- Capturamos el mensaje de error
        SET username_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET is_username_valid = FALSE;				-- Limpiamos los valores
        SET operation_successful = FALSE;
    END;
    
	-- Válida que no este vacio.
    if p_username is NULL or p_username = '' then
		SET username_message = 'Error: El username no puede estar vacío.';
        SET is_username_valid = FALSE;
        SET operation_successful = FALSE;
	end if;
	
    IF operation_successful THEN    
		-- Si existe al menos un registro, no es único
        IF EXISTS (SELECT 1 FROM customer 
					WHERE username = p_username) THEN
			set username_message = 'Error: Este usuarío ya existe.';
			set is_username_valid = FALSE;
		ELSE
			set username_message = 'usuario válido';
			set is_username_valid = TRUE;
		END IF;
	END IF;
END$$

DELIMITER ;

