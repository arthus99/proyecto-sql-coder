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

