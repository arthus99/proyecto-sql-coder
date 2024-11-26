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

