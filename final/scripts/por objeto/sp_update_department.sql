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
