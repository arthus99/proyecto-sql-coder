USE `michangarro`;
DROP procedure IF EXISTS `michangarro`.`sp_create_table_customer_temp`;

DELIMITER $$

CREATE PROCEDURE `sp_create_table_customer_temp`()
BEGIN
	DROP TABLE IF EXISTS `customer_temp` ;
    
	CREATE TABLE `customer_temp` (
	`username` varchar(150) NOT NULL,
	`password` varchar(255) NOT NULL,
	`name` varchar(100) NOT NULL,
	`lastname` varchar(100) NOT NULL,
	`email` varchar(150) NOT NULL,
	`birth_date` date NOT NULL,
	`customer_type_id` smallint unsigned NOT NULL,
	`phone` varchar(30) NOT NULL
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
END$$

DELIMITER ;
