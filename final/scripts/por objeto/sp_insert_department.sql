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
        ROLLBACK;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
	END;
    
    -- Iniciar transacción para asegurar atomicidad
    START TRANSACTION;

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
        
        -- Insertar relaciones para todos los ancestros del `parent_id` (nietos, bisnietos, etc.)
        INSERT INTO department_closure (ancestor, descendant, depth)
        SELECT descendant, new_department_id, depth + 1
        FROM department_closure
        WHERE ancestor = parent_id;
        
	END IF;
	    
    -- Confirmar la transacción
    COMMIT;
    
END $$

DELIMITER ;
