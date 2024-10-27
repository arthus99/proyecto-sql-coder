USE `michangarro`;
-- show errors;

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


DROP TRIGGER IF EXISTS tr_check_interest_before_update;
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
