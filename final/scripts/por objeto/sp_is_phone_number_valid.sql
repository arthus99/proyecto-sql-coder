USE `michangarro`;
DROP procedure IF EXISTS sp_is_phone_number_valid;

DELIMITER $$

CREATE PROCEDURE sp_is_phone_number_valid (
	p_phone VARCHAR(30) , 
    OUT phone_number_message VARCHAR(255),
    OUT cleaned_phone VARCHAR(15),
    OUT is_phone_number_valid BOOLEAN)
BEGIN
	
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
    DECLARE proc_name VARCHAR(50) DEFAULT 'sp_is_phone_number_valid';
    DECLARE error_message VARCHAR(255);
    
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              	-- Capturamos el mensaje de error
        SET phone_number_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET is_phone_number_valid = FALSE;				-- Limpiamos los valores
        SET cleaned_phone = '';
        SET operation_successful = FALSE;
    END;
    
    SET is_phone_number_valid = FALSE;
    SET phone_number_message = '';
    
    -- Válida y limpia el número de teléfono
    SET cleaned_phone = REGEXP_REPLACE(p_phone, '[^0-9]', '');
    -- Validar que el número tenga entre 10 y 15 dígitos
    IF NOT (cleaned_phone REGEXP '^[0-9]{10,15}$') THEN
        SET operation_successful = FALSE;
        SET phone_number_message = 'El número de teléfono debe tener entre 10 y 15 dígitos.';
        SET is_phone_number_valid = FALSE;
    END IF;
	
    -- Verifica que el telefono sea único
    IF operation_successful THEN
		IF EXISTS(SELECT 1 FROM customer WHERE phone = cleaned_phone) THEN
			SET phone_number_message = 'Este número de teléfono ya esta registrado.';
			SET is_phone_number_valid = FALSE;
            SET operation_successful = FALSE;
		ELSE
			SET phone_number_message = 'Número de teléfono válido';
			SET is_phone_number_valid = TRUE;
		END IF;
	END IF;
   
END$$

DELIMITER ;

