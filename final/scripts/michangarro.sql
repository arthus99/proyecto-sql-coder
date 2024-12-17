DROP DATABASE IF EXISTS michangarro;
CREATE DATABASE michangarro;

USE michangarro;

CREATE TABLE `customer_type` (
  `customer_type_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `customer_type_discount` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`customer_type_id`),
  CONSTRAINT `customer_type_chk_1` CHECK (((`customer_type_discount` >= 0) and (`customer_type_discount` <= 100)))
);


CREATE TABLE `payment_method` (
  `payment_method_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`payment_method_id`)
);


CREATE TABLE `interests` (
  `interest_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_interest_id` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`interest_id`),
  KEY `fk_parent_interest` (`parent_interest_id`),
  CONSTRAINT `fk_parent_interest` FOREIGN KEY (`parent_interest_id`) REFERENCES `interests` (`interest_id`) ON DELETE CASCADE
);


CREATE TABLE `departments` (
  `department_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
);


CREATE TABLE `customer` (
  `customer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` varbinary(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `birth_date` date NOT NULL,
  `customer_type_id` smallint unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  `salt` varbinary(16) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `customer_type_id` (`customer_type_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`customer_type_id`) REFERENCES `customer_type` (`customer_type_id`)
);


CREATE TABLE `customer_interests` (
  `customer_id` int unsigned NOT NULL,
  `interest_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`customer_id`,`interest_id`),
  KEY `interest_id` (`interest_id`),
  CONSTRAINT `customer_interests_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `customer_interests_ibfk_2` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`interest_id`)
);


CREATE TABLE `customer_payment_method` (
  `customer_payment_method_id` binary(16) NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `payment_method_id` smallint unsigned NOT NULL,
  `creditcard` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`customer_payment_method_id`),
  KEY `customer_id` (`customer_id`),
  KEY `payment_method_id` (`payment_method_id`),
  CONSTRAINT `customer_payment_method_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `customer_payment_method_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`)
);


CREATE TABLE `department_closure` (
  `ancestor` smallint unsigned NOT NULL,
  `descendant` smallint unsigned NOT NULL,
  `depth` int DEFAULT NULL,
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `descendant` (`descendant`),
  CONSTRAINT `department_closure_ibfk_1` FOREIGN KEY (`ancestor`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `department_closure_ibfk_2` FOREIGN KEY (`descendant`) REFERENCES `departments` (`department_id`)
);


CREATE TABLE `items` (
  `item_id` binary(16) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_description` varchar(255) DEFAULT NULL,
  `item_stock` int NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `item_discount` decimal(5,2) NOT NULL DEFAULT '0.00',
  `department_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `items_chk_1` CHECK ((`item_stock` >= 0)),
  CONSTRAINT `items_chk_2` CHECK ((`item_price` >= 0)),
  CONSTRAINT `items_chk_3` CHECK (((`item_discount` >= 0) and (`item_discount` <= 100)))
);


CREATE TABLE `sales` (
  `sales_id` bigint unsigned NOT NULL,
  `sales_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_payment_method_id` binary(16) NOT NULL,
  `customer_type_discount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`sales_id`),
  KEY `customer_payment_method_id` (`customer_payment_method_id`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`customer_payment_method_id`) REFERENCES `customer_payment_method` (`customer_payment_method_id`),
  CONSTRAINT `sales_chk_1` CHECK (((`customer_type_discount` >= 0) and (`customer_type_discount` <= 100)))
);


CREATE TABLE `sold_items` (
  `sales_id` bigint unsigned NOT NULL,
  `item_id` binary(16) NOT NULL,
  `quantity` int NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `item_discount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`sales_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `sold_items_ibfk_1` FOREIGN KEY (`sales_id`) REFERENCES `sales` (`sales_id`),
  CONSTRAINT `sold_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`),
  CONSTRAINT `sold_items_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `sold_items_chk_2` CHECK ((`item_price` >= 0)),
  CONSTRAINT `sold_items_chk_3` CHECK (((`item_discount` >= 0) and (`item_discount` <= 100)))
);


CREATE TABLE `department_interests` (
  `department_id` smallint unsigned NOT NULL,
  `interest_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`department_id`,`interest_id`),
  KEY `fk_interest` (`interest_id`),
  CONSTRAINT `fk_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_interest` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`interest_id`) ON DELETE CASCADE
);

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

USE `michangarro`;
DROP function IF EXISTS `fn_check_interest_cycle`;

DELIMITER $$
USE `michangarro`$$
CREATE FUNCTION `fn_check_interest_cycle` (parent_id smallint unsigned,current_id smallint unsigned)
RETURNS boolean
deterministic
BEGIN
    DECLARE cycle_detected boolean DEFAULT false;
    DECLARE temp_parent_id SMALLINT UNSIGNED;

    myloop: WHILE parent_id IS NOT NULL DO
        -- Comprobar si el parent_id es igual al current_id
        IF parent_id = current_id THEN
            SET cycle_detected = true; -- Se detectó un ciclo
            LEAVE myloop; -- Salir del bucle
        END IF;

        -- Obtener el padre del current parent_id
        SELECT parent_interest_id INTO temp_parent_id FROM interests WHERE interest_id = parent_id;

        -- Actualizar parent_id para la siguiente iteración
        SET parent_id = temp_parent_id;
    END WHILE;

RETURN cycle_detected; -- Retorna 1 si hay ciclo, 0 si no
END$$

DELIMITER ;


 
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
USE `michangarro`;
DROP function IF EXISTS `michangarro`.`fn_validate_phone_number`;

DELIMITER $$
USE `michangarro`$$
CREATE FUNCTION `fn_validate_phone_number`(
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



USE `michangarro`;
DROP function IF EXISTS `michangarro`.`fn_validate_phone_number`;

DELIMITER $$
USE `michangarro`$$
CREATE FUNCTION `fn_validate_phone_number`(
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
USE `michangarro`;
DROP procedure IF EXISTS `michangarro`.`sp_create_table_customer_temp`;

DELIMITER $$

CREATE PROCEDURE `sp_create_table_customer_temp`()
BEGIN
	DROP TABLE IF EXISTS `customer_temp` ;
    
	CREATE TABLE `customer_temp` (
	`username` varchar(150) NOT NULL,
	`password` varchar(255) NOT NULL,
	`name` varchar(100) NOT NULL,
	`lastname` varchar(100) NOT NULL,
	`email` varchar(150) NOT NULL,
	`birth_date` date NOT NULL,
	`customer_type_id` smallint unsigned NOT NULL,
	`phone` varchar(30) NOT NULL
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
END$$

DELIMITER ;
 
DROP PROCEDURE IF EXISTS sp_del_customer;
DELIMITER //

CREATE PROCEDURE sp_del_customer(
    p_username VARCHAR(150)
)
BEGIN
    -- Validar el parámetro
    IF p_username IS NULL OR p_username = '' THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El nombre de usuario no puede ser nulo o vacío.';
    END IF;

    -- Eliminar el registro del cliente
    DELETE FROM customer WHERE username = p_username;

    -- Comprobar si se eliminó alguna fila
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El usuario no existe o no se pudo eliminar.';
    END IF;
    
END//

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_delete_department;

DELIMITER $$

CREATE PROCEDURE sp_delete_department ( depa_id INT)
BEGIN
    DECLARE not_department_asigned INT;
    DECLARE msg_error VARCHAR(255);
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;
		-- Si hay un error, hacer rollback
        ROLLBACK;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
	END;

    -- Iniciar la transacción
    START TRANSACTION;
    
    -- Verificar si existe el departamento 'Departamento sin Asignar'
    IF NOT EXISTS (SELECT 1 FROM departments WHERE name = 'Departamento sin Asignar') THEN
        -- Si no existe, se llama al procedimiento para crear el departamento
        CALL sp_insert_department("Departamento sin Asignar",  -- dept_name
                                  "Esta situación se da si se borra un depto.",  -- dept_description
                                  NULL);  -- parent_id
        -- Obtener el ID del nuevo departamento insertado
        SET not_department_asigned = LAST_INSERT_ID();
    ELSE
        -- Si ya existe el departamento 'Departamento sin Asignar', obtener su ID
        SELECT department_id INTO not_department_asigned 
        FROM departments 
        WHERE name = 'Departamento sin Asignar';
    END IF;

    -- Eliminar todas las relaciones donde este departamento es ancestro o descendiente
    DELETE FROM department_closure WHERE ancestor = depa_id;
    DELETE FRoM department_closure WHERE descendant = depa_id;

    -- Eliminar las relaciones en department_interests donde el departamento sea el especificado
    DELETE FROM department_interests WHERE department_id = depa_id;

    -- Actualizar los items, asignando el nuevo departamento 'sin asignar' a los registros correspondientes
    UPDATE items SET department_id = not_department_asigned WHERE department_id = depa_id;

	-- Eliminamos el departamento.
    DELETE FROM departments WHERE department_id = depa_id;
    
    -- Confirmamos la transacción
    COMMIT;
    
END $$

DELIMITER ;
 

DROP PROCEDURE IF EXISTS sp_GetDepartmentBranchById;

DELIMITER //

CREATE PROCEDURE sp_GetDepartmentBranchById(IN departmentId SMALLINT UNSIGNED)
BEGIN
    IF departmentId IS NULL THEN
        SELECT d.*
        FROM departments d;
    ELSE
        SELECT d.*, dc.depth
        FROM departments d
        JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE dc.ancestor = departmentId OR d.department_id = departmentId;
    END IF;

END //

DELIMITER ;

USE `michangarro`;
DROP procedure IF EXISTS `michangarro`.`sp_GetDepartmentById`;

DELIMITER $$
USE `michangarro`$$
CREATE PROCEDURE `sp_GetDepartmentById`(IN departmentId SMALLINT UNSIGNED)
BEGIN
    IF departmentId IS NULL THEN
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant;
    ELSE
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE d.department_id = departmentId;
    END IF;
END$$

DELIMITER ;


USE `michangarro`;
DROP procedure IF EXISTS `michangarro`.`sp_GetDepartmentByName`;

DELIMITER $$
USE `michangarro`$$
CREATE PROCEDURE `sp_GetDepartmentByName`(IN departmentName VARCHAR(100))
BEGIN
    IF departmentName IS NULL THEN
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant;
    ELSE
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE d.name LIKE CONCAT('%', departmentName, '%');
    END IF;
END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_GetInterestByDepId;
DELIMITER //

CREATE PROCEDURE sp_GetInterestByDepId(depID SMALLINT UNSIGNED)
BEGIN
    SELECT di.department_id, d.name AS department_name, di.interest_id, i.name AS interest_name
	FROM department_interests di
	INNER JOIN departments d ON d.department_id = di.department_id
	INNER JOIN interests i ON di.interest_id = i.interest_id
	WHERE di.department_id = COALESCE(depID, di.department_id);
    
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_get_sale_details;

DELIMITER $$

CREATE PROCEDURE sp_get_sale_details( p_sales_id BIGINT UNSIGNED)
BEGIN
    SELECT 
        s.sales_id,
        si.item_id,
        i.item_name,
        si.quantity,
        i.item_price,
        si.item_discount,
        -- Calcular el precio con descuento por artículo
        ROUND(si.quantity * i.item_price * (1 - si.item_discount / 100), 2) AS item_total,
        -- Calcular el total de la venta (incluyendo el descuento del cliente)
        ROUND(
            si.quantity * i.item_price * (1 - si.item_discount / 100) * (1 - s.customer_type_discount / 100),
            2
        ) AS total_sale
    FROM 
        sales s
    JOIN 
        sold_items si ON s.sales_id = si.sales_id
    JOIN 
        items i ON si.item_id = i.item_id
    WHERE 
        s.sales_id = p_sales_id;
END$$

DELIMITER ;

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
DROP PROCEDURE IF EXISTS sp_insert_department;

DELIMITER $$

CREATE PROCEDURE sp_insert_department(
    IN dept_name VARCHAR(100),
    IN dept_description VARCHAR(255),
    IN parent_id SMALLINT UNSIGNED
)
BEGIN
    DECLARE new_department_id SMALLINT UNSIGNED;
    DECLARE msg_error VARCHAR(255);
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;
		-- Si hay un error, hacer rollback
        ROLLBACK TO before_insert;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
	END;
    
    -- Iniciar transacción para asegurar atomicidad
    START TRANSACTION;
    SAVEPOINT before_insert;

    -- Insertar el nuevo departamento en la tabla 'departments'
    INSERT INTO departments (name, description)
    VALUES (dept_name, dept_description);

    -- Obtener el ID del nuevo departamento insertado
    SET new_department_id = LAST_INSERT_ID();
    
    -- Inserta el nuevo departamento como su propio ancestro con profundidad 0
	INSERT INTO department_closure (ancestor, descendant, depth)
    VALUES (new_department_id, new_department_id, 0);


    -- Si el departamento tiene un padre (parent_id no es NULL)
    IF parent_id IS NOT NULL THEN
    
		-- Verificar si el parent_id existe
        IF NOT EXISTS (SELECT 1 FROM departments WHERE department_id = parent_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El departamento padre no existe.';
        END IF;
        
        -- Agregar relaciones de cierre entre el nuevo departamento y su padre
        INSERT INTO department_closure (ancestor, descendant, depth)
        SELECT ancestor, new_department_id, depth + 1
        FROM department_closure
        WHERE descendant = parent_id;
        
	END IF;
	    
    -- Confirmar la transacción
    COMMIT;
    
END $$

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_insert_sales_from_json;

DELIMITER $$

CREATE PROCEDURE `sp_insert_sales_from_json`( sales_json JSON )
BEGIN
    DECLARE current_sale INT DEFAULT 0;
    DECLARE num_sales INT;
    DECLARE current_sales_id BIGINT;
    DECLARE current_payment_method_id BINARY(16);
    DECLARE current_discount DECIMAL(5,2);
    
    -- Variables para artículos vendidos
    DECLARE item_number INT DEFAULT 0;
    DECLARE num_items INT;
    DECLARE current_item_id BINARY(16);
    DECLARE current_quantity INT;
    DECLARE current_item_price DECIMAL(10,2);
	DECLARE current_item_discount DECIMAL(5,2);

	DECLARE msg_error VARCHAR(255); -- Variable para almacenar el mensaje de error

	-- Manejador para manejar excepciones SQL
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Capturar el mensaje de error
		GET DIAGNOSTICS CONDITION 1 msg_error = MESSAGE_TEXT;
	
		-- Limitar el tamaño del mensaje de error a 120 caracteres (no agregamos más texto)
		SET msg_error = LEFT(msg_error, 120);  -- Truncar directamente el mensaje
		-- Realizar un rollback en caso de error
		ROLLBACK;
		-- Lanzar el error con el mensaje truncado
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
	END;
    
    -- Comienza la Transacción
    START TRANSACTION;
    
    -- Obtén el número de ventas en el JSON
    SET num_sales = JSON_LENGTH(sales_json->'$.sales');
    
    -- Itera sobre las ventas
    WHILE current_sale < num_sales DO
        -- Obtén los detalles de la venta      
        SET current_payment_method_id = UNHEX(JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[',current_sale, '].customer_payment_method_id'))));
        SET current_discount = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].customer_type_discount')));
		
        -- SET current_sales_id = 1;

        SET current_sales_id = COALESCE((SELECT MAX(sales_id)+1 FROM sales), 1);
        
        -- Inserta la venta
		INSERT INTO sales (sales_id, customer_payment_method_id, customer_type_discount)
		VALUES (current_sales_id, current_payment_method_id, current_discount);
      
        -- SELECT current_sales_id, hex(current_payment_method_id),length(current_payment_method_id), current_discount;
                
        -- Obtén el número de artículos para esta venta
        SET num_items = JSON_LENGTH(sales_json,CONCAT('$.sales[', current_sale, '].items'));
        
        -- Inicializa item_number para cada venta
		SET item_number = 0;
        
        -- Itera sobre los artículos vendidos
        WHILE item_number < num_items DO
            SET current_item_id = UNHEX(JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale,'].items[',item_number, '].item_id'))));
            SET current_quantity = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].items[', item_number, '].quantity')));
            SET current_item_price = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].items[', item_number, '].item_price')));
            SET current_item_discount = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].items[', item_number, '].item_discount')));

            -- Inserta los artículos vendidos
            INSERT INTO sold_items (sales_id, item_id, quantity, item_price, item_discount)
            VALUES (current_sales_id, current_item_id, current_quantity, current_item_price, current_item_discount);

			-- SELECT current_sales_id, current_item_id, current_quantity, current_item_price, current_item_discount;
            
            SET item_number = item_number + 1;
        END WHILE;
        
        SET current_sale= current_sale + 1;
    END WHILE;
    
     -- Confirmar la transacción si todo se realizó correctamente
    COMMIT;

END$$

DELIMITER ;
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


DROP PROCEDURE IF EXISTS sp_manage_departments;

DELIMITER $$

CREATE PROCEDURE sp_manage_departments(
    IN dept_id SMALLINT UNSIGNED,   -- ID del departamento a insertar o mover
    IN dept_name VARCHAR(100),      -- Nombre del departamento
    IN dept_description VARCHAR(255),  -- Descripción del departamento
    IN parent_id SMALLINT UNSIGNED  -- ID del ancestro o padre
)
BEGIN
    DECLARE existing_parent_id SMALLINT UNSIGNED;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        ROLLBACK;  -- En caso de error, hacer un rollback

    -- Iniciar la transacción
    START TRANSACTION;

    -- 1. Verificar si el departamento ya tiene alguna relación jerárquica con el parent_id en cualquier nivel
    SELECT ancestor INTO existing_parent_id
    FROM department_closure
    WHERE descendant = dept_id AND ancestor = parent_id;

    -- Si la relación existe (el dept_id ya está relacionado con el parent_id en cualquier nivel)
    IF existing_parent_id IS NOT NULL THEN
        -- 2. Si la relación existe, mover el departamento al nuevo ancestro
        CALL sp_move_department_to_new_ancestor(dept_id, parent_id);
    ELSE
        -- 3. Si la relación no existe, insertar el departamento
        CALL sp_sp_insert_department(dept_name, dept_description, parent_id);
    END IF;

    -- Confirmar la transacción si todo se realizó correctamente
    COMMIT;

END $$

DELIMITER ;
 
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
 
DROP PROCEDURE IF EXISTS sp_sel_customer;
DELIMITER //

CREATE PROCEDURE sp_sel_customer(
    p_username VARCHAR(150)
)
BEGIN
    -- Selecciona el registro del cliente
    SELECT username,
		c.name as "Nombre",
        c.lastname as "Apellido",
        c.email as "Correo Electronico",
        c.birth_date as "Fecha Nacimiento",
        ct.name as "Tipo Cliente",
        c.phone as "Telefono"
    FROM customer c
    INNER JOIN customer_type ct on c.customer_type_id = ct.customer_type_id 
    WHERE username = coalesce(p_username,username);

    
END//

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_test_cycle_simulation;
DELIMITER //

CREATE PROCEDURE sp_test_cycle_simulation(current_id SMALLINT UNSIGNED)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE cycle_detected BOOLEAN;
    DECLARE max_id SMALLINT;
    
    SELECT MAX(interest_id) INTO max_id FROM interests;
    
    -- Crear tabla temporal para almacenar resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        parent_id SMALLINT,
        cycle BOOLEAN
    );

    -- Simula un bucle con valores de ejemplo
    WHILE i < max_id DO
        SET cycle_detected = fn_check_interest_cycle(i, current_id); -- Llamada a la función
        -- Insertar el resultado en la tabla temporal
        INSERT INTO temp_results (parent_id,cycle) 
        VALUES (i, cycle_detected);
        SET i = i + 1;
    END WHILE;

    -- Mostrar resultados al final
    SELECT tr.parent_id as interest_id, i.name FROM temp_results tr 
    INNER JOIN interests i 
    ON tr.parent_id = i.interest_id
    WHERE cycle = true;

    DROP TEMPORARY TABLE IF EXISTS temp_results;
END;
//

DELIMITER ;
 
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
DROP PROCEDURE IF EXISTS sp_update_department;

DELIMITER $$

CREATE PROCEDURE sp_update_department(
    p_dept_id INT UNSIGNED,           -- Departamento a actualizar
    new_dept_name VARCHAR(100),       -- Nuevo nombre
    new_dept_description VARCHAR(255), -- Nueva descripción
    IN new_ancestor_id INT UNSIGNED   -- Nuevo ancestro para el departamento
)
BEGIN
    DECLARE msg_error VARCHAR(255);
    DECLARE old_parent_id SMALLINT UNSIGNED;
    DECLARE old_parent_depth INT UNSIGNED;
    DECLARE new_ancestor_depth INT UNSIGNED;
    
    -- Manejo de errores
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Obtener el mensaje de error
        GET DIAGNOSTICS CONDITION 1 
            msg_error = MESSAGE_TEXT;
        -- Si hay un error, hacer rollback
        ROLLBACK;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
    END;

    -- Iniciar transacción para asegurar atomicidad
    START TRANSACTION;

    -- 1. Actualizar los detalles del departamento (nombre y descripción)
    UPDATE departments d
    SET name = COALESCE(new_dept_name, name),
        description = COALESCE(new_dept_description, description)
    WHERE d.department_id = p_dept_id;

    -- 2. Obtener el antiguo `parent_id` y `depth` del departamento
    SELECT ancestor, depth INTO old_parent_id, old_parent_depth
    FROM department_closure
    WHERE descendant = p_dept_id AND depth = 1 LIMIT 1;

    -- Obtener el `depth` del nuevo ancestro
    SELECT depth INTO new_ancestor_depth
    FROM department_closure
    WHERE descendant = new_ancestor_id AND ancestor = new_ancestor_id;

	select new_ancestor_id,old_parent_id;
    -- 3. Verificar si el nuevo ancestro es diferente al antiguo
    IF new_ancestor_id <> old_parent_id THEN
		SELECT "ENTRA";
        -- Verificar si el nuevo ancestro es un descendiente del departamento (prevención de ciclos)
        IF EXISTS (
            SELECT 1
            FROM department_closure
            WHERE ancestor = p_dept_id AND descendant = new_ancestor_id
        ) THEN
            -- Si es así, no se puede mover a este ancestro (ciclo).
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: El nuevo ancestro es un descendiente del departamento.';
        ELSE
            -- 4. Eliminar las relaciones anteriores del departamento (relaciones con el viejo ancestro)
            DELETE FROM department_closure
            WHERE descendant = p_dept_id;

            -- 5. Insertar las nuevas relaciones con el nuevo ancestro
            -- Relacionamos el departamento con todos los ancestros existentes y el nuevo ancestro
            INSERT INTO department_closure (ancestor, descendant, depth)
            SELECT ancestor, p_dept_id, depth + new_ancestor_depth - old_parent_depth
            FROM department_closure
            WHERE descendant = new_ancestor_id;

            -- Insertamos también la relación del departamento consigo mismo (depth=0)
            INSERT INTO department_closure (ancestor, descendant, depth)
            VALUES (p_dept_id, p_dept_id, 0);

            -- 6. Actualizar los descendientes
            -- La diferencia de profundidad entre los dos ancestros será aplicada a los descendientes
            UPDATE department_closure dc
            JOIN department_closure dc_parent ON dc.ancestor = dc_parent.descendant
            SET dc.depth = dc_parent.depth + (new_ancestor_depth - old_parent_depth)
            WHERE dc.descendant IN (
                SELECT descendant
                FROM department_closure
                WHERE ancestor = p_dept_id
            ) AND dc_parent.ancestor = new_ancestor_id;

        END IF;
    END IF;

    -- Confirmar la transacción
    COMMIT;

END $$

DELIMITER ;
DROP TRIGGER IF EXISTS tr_check_interest_before_insert;
DELIMITER //

CREATE TRIGGER tr_check_interest_before_insert
BEFORE INSERT ON interests
FOR EACH ROW
BEGIN
    DECLARE cycle_detected BOOLEAN;

    -- Llamar a la función fn_check_interest_cycle
    SET cycle_detected = fn_check_interest_cycle(NEW.parent_interest_id, NEW.interest_id);

    IF cycle_detected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ciclo detectado en la jerarquía de intereses.';
    END IF;
END;
//

DELIMITER ;

DROP TRIGGER IF EXISTS tr_check_interests_before_update;
DELIMITER //

CREATE TRIGGER tr_check_interest_before_update
BEFORE UPDATE ON interests
FOR EACH ROW
BEGIN
    DECLARE cycle_detected BOOLEAN;

    -- Llamar a la función check_interest_cycle
    SET cycle_detected = fn_check_interest_cycle(NEW.parent_interest_id, NEW.interest_id);

    IF cycle_detected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ciclo detectado en la jerarquía de intereses.';
    END IF;
END;
//

DELIMITER ;

DROP view IF EXISTS `michangarro`.`v_departments`;
DELIMITER //
create or replace
view `michangarro`.`v_departments` as
select
    `d1`.`department_id` as `department_id`,
    `d1`.`name` as `department_name`,
    `d1`.`description` as `department_description`,
    `d2`.`department_id` as `subdepartment_id`,
    `d2`.`name` as `subdepartment_name`,
    `d2`.`description` as `subdepartment_description`,
    `dc`.`depth` as `depth`
from
    ((`michangarro`.`departments` `d1`
left join `michangarro`.`department_closure` `dc` on
    ((`d1`.`department_id` = `dc`.`ancestor`)))
left join `michangarro`.`departments` `d2` on
    ((`dc`.`descendant` = `d2`.`department_id`)))
order by
    `d1`.`department_id`,
    `dc`.`depth`;    
//
DELIMITER ;
DROP view IF EXISTS `michangarro`.`v_interests`;
DELIMITER //
CREATE OR REPLACE VIEW `michangarro`.`v_interests` AS
SELECT 
    i.interest_id,
    i.name AS interest_name,
    i.description,
    p.name AS parent_name,
    p.interest_id as parent_id
FROM 
    interests i
LEFT JOIN 
    interests p ON i.parent_interest_id = p.interest_id
where p.name is not null;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_delete_department;

DELIMITER $$

CREATE PROCEDURE sp_delete_department ( depa_id INT)
BEGIN
    DECLARE not_department_asigned INT;
    DECLARE msg_error VARCHAR(255);
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;
		-- Si hay un error, hacer rollback
        ROLLBACK;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
	END;

    -- Iniciar la transacción
    START TRANSACTION;
    
    -- Verificar si existe el departamento 'Departamento sin Asignar'
    IF NOT EXISTS (SELECT 1 FROM departments WHERE name = 'Departamento sin Asignar') THEN
        -- Si no existe, se llama al procedimiento para crear el departamento
        CALL sp_insert_department("Departamento sin Asignar",  -- dept_name
                                  "Esta situación se da si se borra un depto.",  -- dept_description
                                  NULL);  -- parent_id
        -- Obtener el ID del nuevo departamento insertado
        SET not_department_asigned = LAST_INSERT_ID();
    ELSE
        -- Si ya existe el departamento 'Departamento sin Asignar', obtener su ID
        SELECT department_id INTO not_department_asigned 
        FROM departments 
        WHERE name = 'Departamento sin Asignar';
    END IF;

    -- Eliminar todas las relaciones donde este departamento es ancestro o descendiente
    DELETE FROM department_closure WHERE ancestor = depa_id;
    DELETE FRoM department_closure WHERE descendant = depa_id;

    -- Eliminar las relaciones en department_interests donde el departamento sea el especificado
    DELETE FROM department_interests WHERE department_id = depa_id;

    -- Actualizar los items, asignando el nuevo departamento 'sin asignar' a los registros correspondientes
    UPDATE items SET department_id = not_department_asigned WHERE department_id = depa_id;

	-- Eliminamos el departamento.
    DELETE FROM departments WHERE department_id = depa_id;
    
    -- Confirmamos la transacción
    COMMIT;
    
END $$

DELIMITER ;
 

DROP PROCEDURE IF EXISTS sp_GetDepartmentBranchById;

DELIMITER //

CREATE PROCEDURE sp_GetDepartmentBranchById(IN departmentId SMALLINT UNSIGNED)
BEGIN
    IF departmentId IS NULL THEN
        SELECT d.*
        FROM departments d;
    ELSE
        SELECT d.*, dc.depth
        FROM departments d
        JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE dc.ancestor = departmentId OR d.department_id = departmentId;
    END IF;

END //

DELIMITER ;

USE `michangarro`;
DROP procedure IF EXISTS `michangarro`.`sp_GetDepartmentById`;

DELIMITER $$
USE `michangarro`$$
CREATE PROCEDURE `sp_GetDepartmentById`(IN departmentId SMALLINT UNSIGNED)
BEGIN
    IF departmentId IS NULL THEN
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant;
    ELSE
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE d.department_id = departmentId;
    END IF;
END$$

DELIMITER ;


USE `michangarro`;
DROP procedure IF EXISTS `michangarro`.`sp_GetDepartmentByName`;

DELIMITER $$
USE `michangarro`$$
CREATE PROCEDURE `sp_GetDepartmentByName`(IN departmentName VARCHAR(100))
BEGIN
    IF departmentName IS NULL THEN
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant;
    ELSE
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE d.name LIKE CONCAT('%', departmentName, '%');
    END IF;
END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_GetInterestByDepId;
DELIMITER //

CREATE PROCEDURE sp_GetInterestByDepId(depID SMALLINT UNSIGNED)
BEGIN
    SELECT di.department_id, d.name AS department_name, di.interest_id, i.name AS interest_name
	FROM department_interests di
	INNER JOIN departments d ON d.department_id = di.department_id
	INNER JOIN interests i ON di.interest_id = i.interest_id
	WHERE di.department_id = COALESCE(depID, di.department_id);
    
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_get_sale_details;

DELIMITER $$

CREATE PROCEDURE sp_get_sale_details( p_sales_id BIGINT UNSIGNED)
BEGIN
    SELECT 
        s.sales_id,
        si.item_id,
        i.item_name,
        si.quantity,
        i.item_price,
        si.item_discount,
        -- Calcular el precio con descuento por artículo
        ROUND(si.quantity * i.item_price * (1 - si.item_discount / 100), 2) AS item_total,
        -- Calcular el total de la venta (incluyendo el descuento del cliente)
        ROUND(
            si.quantity * i.item_price * (1 - si.item_discount / 100) * (1 - s.customer_type_discount / 100),
            2
        ) AS total_sale
    FROM 
        sales s
    JOIN 
        sold_items si ON s.sales_id = si.sales_id
    JOIN 
        items i ON si.item_id = i.item_id
    WHERE 
        s.sales_id = p_sales_id;
END$$

DELIMITER ;
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

DROP PROCEDURE IF EXISTS sp_manage_departments;

DELIMITER $$

CREATE PROCEDURE sp_manage_departments(
    IN dept_id SMALLINT UNSIGNED,   -- ID del departamento a insertar o mover
    IN dept_name VARCHAR(100),      -- Nombre del departamento
    IN dept_description VARCHAR(255),  -- Descripción del departamento
    IN parent_id SMALLINT UNSIGNED  -- ID del ancestro o padre
)
BEGIN
    DECLARE existing_parent_id SMALLINT UNSIGNED;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        ROLLBACK;  -- En caso de error, hacer un rollback

    -- Iniciar la transacción
    START TRANSACTION;

    -- 1. Verificar si el departamento ya tiene alguna relación jerárquica con el parent_id en cualquier nivel
    SELECT ancestor INTO existing_parent_id
    FROM department_closure
    WHERE descendant = dept_id AND ancestor = parent_id;

    -- Si la relación existe (el dept_id ya está relacionado con el parent_id en cualquier nivel)
    IF existing_parent_id IS NOT NULL THEN
        -- 2. Si la relación existe, mover el departamento al nuevo ancestro
        CALL sp_move_department_to_new_ancestor(dept_id, parent_id);
    ELSE
        -- 3. Si la relación no existe, insertar el departamento
        CALL sp_sp_insert_department(dept_name, dept_description, parent_id);
    END IF;

    -- Confirmar la transacción si todo se realizó correctamente
    COMMIT;

END $$

DELIMITER ;
