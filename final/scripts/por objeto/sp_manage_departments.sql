
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
