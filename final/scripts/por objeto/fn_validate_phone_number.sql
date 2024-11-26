USE `michangarro`;
DROP function IF EXISTS `michangarro`.`fn_validate_phone_number`;

DELIMITER $$
USE `michangarro`$$
CREATE DEFINER=`root`@`%` FUNCTION `fn_validate_phone_number`(
    phone VARCHAR(30) 
) RETURNS varchar(15) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE cleaned_phone VARCHAR(15);
    
    -- Limpiar el número de teléfono (eliminar caracteres no numéricos)
    SET cleaned_phone = REGEXP_REPLACE(phone, '[^0-9]', '');

    -- Validar que el número tenga entre 10 y 15 dígitos
    IF cleaned_phone REGEXP '^[0-9]{10,15}$' THEN
        RETURN cleaned_phone;  -- Devuelve el número limpio si es válido
    ELSE
        RETURN NULL;  -- Devuelve NULL si no es válido
    END IF;
END$$

DELIMITER ;



