USE `michangarro`;
DROP procedure IF EXISTS sp_is_email_valid;

DELIMITER $$

CREATE PROCEDURE sp_is_email_valid (
	p_email VARCHAR(150), 
    OUT email_message VARCHAR(150), 
    OUT is_email_valid BOOLEAN)
BEGIN
	DECLARE operation_successful BOOLEAN DEFAULT TRUE;
	DECLARE proc_name VARCHAR(50) DEFAULT 'sp_is_email_valid';
    DECLARE error_message VARCHAR(255) DEFAULT '';
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              	-- Capturamos el mensaje de error
        SET email_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET is_email_valid = FALSE;				-- Limpiamos los valores
        SET operation_successful = FALSE;
    END;
    
    
	IF p_email is NULL or p_email = '' then
		set email_message = 'El correo no puede estar vacio.';
        set is_email_valid = FALSE;
        SET operation_successful = FALSE;
    END IF;
    IF operation_successful THEN
		-- Verifica si el correo existe
		IF EXISTS (SELECT 1 FROM customer 
					WHERE email = p_email) THEN
			set email_message = 'Este correo ya existe.';
			set is_email_valid = FALSE;
		ELSE
			set email_message = 'Correo válido';
			set is_email_valid = TRUE;
		END IF;
	END IF;
END$$

DELIMITER ;

