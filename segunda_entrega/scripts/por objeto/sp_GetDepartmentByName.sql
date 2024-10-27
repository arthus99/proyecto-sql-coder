
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
