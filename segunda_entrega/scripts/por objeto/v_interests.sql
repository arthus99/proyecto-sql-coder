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
