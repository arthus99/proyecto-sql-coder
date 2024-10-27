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
