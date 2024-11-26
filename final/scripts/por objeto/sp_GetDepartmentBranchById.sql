USE michangarro;

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

