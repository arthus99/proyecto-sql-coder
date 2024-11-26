USE michangarro;
DROP PROCEDURE IF EXISTS sp_add_customer;
DELIMITER //

CREATE PROCEDURE sp_add_customer(
    p_username VARCHAR(150),
    p_password VARCHAR(150),
    p_name VARCHAR(100),
    p_lastname VARCHAR(100),
    p_email VARCHAR(150),
    p_birthday DATE,
    p_customer_type_id SMALLINT UNSIGNED,
    p_phone VARCHAR(30)
)
BEGIN
	
    DECLARE cleaned_phone VARCHAR(15);
    DECLARE hashed_password VARBINARY(32);
    DECLARE p_salt VARBINARY(16);
	
    -- Variables de validación
    DECLARE is_phone_number_valid BOOLEAN DEFAULt FALSE;
    DECLARE is_username_valid BOOLEAN DEFAULt FALSE;
    DECLARE is_pwd_valid BOOLEAN DEFAULt FALSE;
    DECLARE is_email_valid BOOLEAN DEFAULt FALSE;
    
    DECLARE phone_number_message TEXT;
    DECLARE username_message TEXT;
    DECLARE pwd_message TEXT;
    DECLARE email_message TEXT; 
    DECLARE birthday_message TEXT;
    
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
        
	DECLARE msg_error VARCHAR(255);
	DECLARE message_error VARCHAR(255) DEFAULT '';
	DECLARE full_error_message TEXT;
	
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

    
    -- Validar el nombre de usuarío
	CALL sp_is_username_valid (p_username, username_message,
				is_username_valid);
	IF NOT is_username_valid THEN 
		SET operation_successful = FALSE; 
		SET message_error = username_message;	
	END IF;
    
    IF operation_successful THEN
		-- Valida la fecha
		SET birthday_message = fn_is_birthday_valid(p_birthday);
		IF birthday_message != 'fecha válida.' THEN
			SET operation_successful = FALSE;
			SET message_error = birthday_message;
		END IF;
    END IF;
    
    IF operation_successful THEN
		-- Validar y limpiar el número de teléfono
		CALL sp_is_phone_number_valid(p_phone, phone_number_message,
					cleaned_phone, is_phone_number_valid);
		IF NOT is_phone_number_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,phone_number_message);
		END IF;
    END IF;
    
    IF operation_successful THEN
		-- Validar el correo
		CALL sp_is_email_valid (p_email, email_message, is_email_valid);
		IF NOT is_email_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,"Error:",email_message);
		END IF;
    END IF;
    IF operation_successful THEN
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
   
	IF operation_successful THEN
        -- Inserta el nuevo cliente en la base de datos
        INSERT INTO customer (username, password, name, lastname, email, birth_date, customer_type_id, phone, salt)
        VALUES (p_username, hashed_password, p_name, p_lastname, p_email, p_birthday, p_customer_type_id, cleaned_phone, p_salt);
    ELSE
        -- Lanzar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_error;
    END IF;
   
END//

DELIMITER ;
