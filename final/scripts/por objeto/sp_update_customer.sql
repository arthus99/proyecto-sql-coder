USE michangarro;
DROP PROCEDURE IF EXISTS sp_update_customer;
DELIMITER //

CREATE PROCEDURE sp_update_customer(
    p_username VARCHAR(150),
    p_password VARCHAR(150),
    p_name VARCHAR(100),
    p_lastname VARCHAR(100),
    p_email VARCHAR(150),
    p_birthday DATE,
    p_customer_type_id SMALLINT UNSIGNED,
    p_phone VARCHAR(30),
    p_new_username VARCHAR(150)
)
BEGIN

    DECLARE cleaned_phone VARCHAR(15);
    DECLARE hashed_password VARBINARY(32);
    DECLARE p_salt VARBINARY(16);
    
    -- Variables de validación
    DECLARE is_phone_number_valid BOOLEAN;
    DECLARE is_username_valid BOOLEAN;
	DECLARE is_pwd_valid BOOLEAN DEFAULT FALSE;
    DECLARE email_message VARCHAR(150); 
    
    DECLARE phone_number_message VARCHAR(150);
    DECLARE username_message VARCHAR(150);
    DECLARE pwd_message TEXT;
    DECLARE birthday_message TEXT;
    DECLARE is_email_valid BOOLEAN;
    
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
    
	DECLARE msg_error VARCHAR(255);
    DECLARE message_error VARCHAR(255) DEFAULT '';
	DECLARE full_error_message TEXT;
    DECLARE proc_name VARCHAR(50) DEFAULT 'sp_update_customer';
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;

		IF msg_error != message_error THEN
			SET full_error_message = CONCAT_WS(".", msg_error, message_error);
		ELSE
			SET full_error_message = msg_error;
		END IF;

		-- Si el mensaje concatenado es más largo de 255 caracteres, trunca con '...' al final
		IF LENGTH(full_error_message) > 255 THEN
			SET full_error_message = CONCAT(SUBSTRING(full_error_message, 1, 252), '...');
		END IF;

		-- Asegurar que `full_error_message` no exceda los 255 caracteres
		SET full_error_message = LEFT(full_error_message, 255);
		-- Imprimir para depuración 
		-- SELECT LENGTH(full_error_message) AS truncated_length, full_error_message AS truncated_message_check;

		-- Lanzar el error con el mensaje truncado
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = full_error_message;

		-- Actualizar el estado de la operación
		SET operation_successful = FALSE;
	END;
    
    IF p_username IS NULL OR p_username = '' THEN
		SET operation_successful = FALSE; 
        -- Lanzar el error 
		SET message_error = CONCAT("Error: (",proc_name,"). El nombre de usuario no puede ser nulo o vacio");
    END IF;
    
    IF p_new_username IS NOT NULL AND p_new_username !='' AND operation_successful THEN
		-- Validar el nuevo nombre de usuarío
		CALL sp_is_username_valid (p_new_username, username_message,
					is_username_valid);
		IF NOT is_username_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT("Error: (",proc_name,"). El nuevo nombre de usuario no es válido.");
		END IF;
    
		-- SELECT p_new_username, username_message,is_username_valid;
	END IF;
    
    IF p_birthday IS NOT NULL AND operation_successful THEN
		-- Valida la fecha
		SET birthday_message = fn_is_birthday_valid(p_birthday);
		IF birthday_message != 'fecha válida.' THEN
			SET operation_successful = FALSE;
			SET message_error = birthday_message;
		END IF;
    END IF;
    
	IF p_email IS NOT NULL AND p_email !='' AND operation_successful THEN
		-- Validar el correo
		CALL sp_is_email_valid (p_email, email_message, is_email_valid);
		IF NOT is_email_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,"Error:",email_message);
		END IF;
    END IF;
    
	IF p_password IS NOT NULL AND p_password !='' AND operation_successful THEN
		-- Realizar el hash para el password
		call sp_hash_pwd(p_password,hashed_password, p_salt,pwd_message,is_pwd_valid);
		IF NOT is_pwd_valid THEN
			SET operation_successful = FALSE;
			IF LENGTH(pwd_message) > 255 THEN
				SET message_error = CONCAT(SUBSTRING(pwd_message, 1, 252), '...');
			else
				SET message_error = pwd_message;
			END IF;
			SET message_error = LEFT(message_error, 255);
		END IF;
		-- SELECT pwd_message,length(message_error),operation_successful;
   END IF;

	IF p_phone IS NOT NULL AND p_phone !='' AND operation_successful THEN
		-- Validar y limpiar el número de teléfono
		CALL sp_is_phone_number_valid(p_phone, phone_number_message,
					cleaned_phone, is_phone_number_valid);
		IF NOT is_phone_number_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,phone_number_message);
		END IF;
	END IF;
    
	IF operation_successful THEN
    
		-- Actualizar la información del cliente en la tabla
		UPDATE customer
		SET 
			username = COALESCE(p_new_username,p_username),
			password = COALESCE(hashed_password, password),
			salt = COALESCE(p_salt, salt),
			name = COALESCE(p_name, name),
			lastname = COALESCE(p_lastname, lastname),
			email = COALESCE(p_email, email),
			birth_date = COALESCE(p_birthday, birth_date),
			customer_type_id = COALESCE(p_customer_type_id, customer_type_id),
			phone = COALESCE(p_phone, phone)
		WHERE username = p_username;
    
		-- Comprobar si se actualizó alguna fila
		IF ROW_COUNT() = 0 THEN
			SET message_error = CONCAT('Error: (',proc_name,'). El usuario no existe.');
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = message_error;
		END IF;
      
      -- SELECT 'todo benne';
	ELSE
         -- Lanzar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_error;
	END IF;
    
    
    
END//

DELIMITER ;
