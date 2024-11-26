use michangarro;
DROP PROCEDURE IF EXISTS sp_reset_customers;
DELIMITER $$
USE `michangarro`$$
CREATE PROCEDURE sp_reset_customers()
BEGIN

	DECLARE done INT DEFAULT FALSE;
	DECLARE p_username VARCHAR(150);
	DECLARE p_password VARCHAR(150);
	DECLARE p_name VARCHAR(100);
	DECLARE p_lastname VARCHAR(100);
	DECLARE p_email VARCHAR(150);
	DECLARE p_birth_date DATE;
	DECLARE p_customer_type_id SMALLINT UNSIGNED;
	DECLARE p_phone VARCHAR(30);
    
	-- Cursor para recorrer los registros de la tabla temporal
	DECLARE cur CURSOR FOR
	SELECT username, password, name, lastname, email, birth_date, customer_type_id, phone 
	FROM customer_temp;

	-- Manejador para manejar excepciones (captura errores SQL)
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Capturar el mensaje de error
        GET DIAGNOSTICS CONDITION 1 
					@error_message = MESSAGE_TEXT;
		-- Mostrar el error
		SELECT CONCAT('Error: ', error_message) AS error_message;
		ROLLBACK;
	END;

	-- Manejador de terminación del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	-- Comienza la Transacción
    START TRANSACTION;
    
	-- Eliminar registros previos de la tabla customer
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM customer;
    ALTER TABLE customer AUTO_INCREMENT = 1;
    SET SQL_SAFE_UPDATES = 1;
    
    OPEN cur;

	read_loop: LOOP
		FETCH cur INTO p_username, 
						p_password, 
						p_name, 
						p_lastname, 
						p_email, 
						p_birth_date, 
						p_customer_type_id, 
						p_phone;
		IF done THEN
			LEAVE read_loop;
		END IF;

		-- Llamar al procedimiento almacenado
		CALL sp_add_customer(p_username,
					p_password,
					p_name,
					p_lastname,
					p_email,
					p_birth_date,
					p_customer_type_id,
					p_phone);
    
	END LOOP;

	CLOSE cur;
	
	DROP TABLE IF EXISTS customer_temp;
	COMMIT;
	CALL sp_sel_customer(NULL);


END$$

DELIMITER ;
