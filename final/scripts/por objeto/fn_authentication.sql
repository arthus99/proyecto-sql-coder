USE `michangarro`;
DROP FUNCTION IF EXISTS `fn_authentication`;

DELIMITER $$

CREATE FUNCTION `fn_authentication` (
    p_username VARCHAR(150),
    p_password VARCHAR(150)
)
RETURNS BOOLEAN
READS SQL DATA  
NOT DETERMINISTIC
BEGIN
	-- DECLARE hex_salt VARCHAR(32);
    DECLARE stored_salt VARBINARY(16);
    DECLARE stored_password VARBINARY(32);
    DECLARE hash_password VARBINARY(32);
    -- DECLARE hex_salt VARBINARY(32);

    -- Seleccionar el salt y la contraseña almacenados
    SELECT salt, password 
    INTO stored_salt, stored_password 
    FROM customer 
    WHERE username = p_username;  

    -- Verificar si se encontró un usuario
    IF stored_password IS NULL THEN
        RETURN FALSE;  -- Usuario no encontrado
    END IF;

    -- Hashear la contraseña ingresada con el salt
    SET hash_password = UNHEX(SHA2(CONCAT(p_password, hex(stored_salt)), 256));
    -- Comparar el hash generado con el almacenado
    IF hash_password = stored_password THEN
        RETURN TRUE;  -- Autenticación exitosa
    ELSE
        RETURN FALSE;  -- Autenticación fallida
    END IF;

END$$

DELIMITER ;
