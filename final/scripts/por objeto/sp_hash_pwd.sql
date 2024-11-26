USE `michangarro`;

-- Eliminar procedimiento si ya existe
DROP PROCEDURE IF EXISTS sp_hash_pwd;

DELIMITER $$

CREATE PROCEDURE sp_hash_pwd (
    IN pwd VARCHAR(255),                         -- Entrada: contraseña
    OUT hashed_password VARBINARY(32),           -- Salida: contraseña hasheada
    OUT salt VARBINARY(16),                      -- Salida: salt en binario
    OUT pwd_message VARCHAR(255),                -- Mensaje de error o éxito
    OUT is_pwd_valid BOOLEAN                     -- Validación de la contraseña
)
BEGIN
	
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;  -- Variable de control para operaciones
    DECLARE error_message VARCHAR(255);                 -- Variable para almacenar el mensaje de error
    DECLARE hex_salt VARCHAR(32);
    DECLARE proc_name VARCHAR(50) DEFAULT 'sp_hash_pwd';
    
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              -- Capturamos el mensaje de error
        SET pwd_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET salt = NULL;                                -- Limpiamos los valores
        SET hashed_password = NULL;
        SET is_pwd_valid = FALSE;
        SET operation_successful = FALSE;
    END;
    
    -- Validación de la contraseña de entrada
    IF pwd IS NULL OR pwd = '' THEN
        SET salt = NULL;
        SET hashed_password = NULL;
        SET pwd_message = 'La clave no puede ser nula o vacía';
        SET is_pwd_valid = FALSE;
        SET operation_successful = FALSE;
    END IF;

    -- Si la operación es exitosa, realizar el hash y salt
    IF operation_successful THEN
		SET hex_salt = UPPER(REPLACE(UUID(), '-', ''));		-- En mayusculas
        SET salt = UNHEX(hex_salt);  -- Generar salt como binario (sin guiones, 16 bytes)
        SET hashed_password = UNHEX(SHA2(CONCAT(pwd, hex_salt), 256)); -- Hashear la contraseña con SHA2
        SET is_pwd_valid = TRUE;
        SET pwd_message = 'Contraseña procesada correctamente';
    END IF;

END$$

DELIMITER ;
