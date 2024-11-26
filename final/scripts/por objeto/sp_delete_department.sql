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
