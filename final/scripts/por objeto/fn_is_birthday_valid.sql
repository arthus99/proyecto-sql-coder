USE michangarro;
DROP FUNCTION IF EXISTS fn_is_birthday_valid;
DELIMITER $$

CREATE FUNCTION fn_is_birthday_valid(p_birthday DATE) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	
    DECLARE century date;
    DECLARE ten_years date;
	DECLARE error_message VARCHAR(255) DEFAULT '';
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;   -- Capturamos el mensaje de error
		SET  error_message = concat('Error:',error_message);
		return error_message;
    END;

    SET century = DATE_SUB(curdate(),INTERVAL 100 YEAR) ;
    SET ten_years = DATE_SUB(curdate(),INTERVAL 10 YEAR) ;
  
	
    -- Verificar si la fecha es NULL
    IF p_birthday IS NULL THEN
       RETURN 'La fecha no puede ser nula.';  -- Indica que la fecha no es válida
    END IF;
    
    -- Verificar si la fecha está fuera de un rango permitido (ejemplo: entre 2000-01-01 y 2099-12-31)
    IF (p_birthday > century) AND (p_birthday < ten_years) THEN
        RETURN 'fecha válida.';
	ELSE
		RETURN 'La fecha no está en el rango permitido';
    END IF;

END$$

DELIMITER ;
