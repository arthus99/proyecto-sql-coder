show errors;

CALL sp_delete_department(80);

DELETE from departments WHERE department_id = 80;

DELETE FROM department_closure WHERE ancestor = 79;
DELETE FROM department_closure WHERE descendant = 79;

    DELETE FROM department_closure WHERE ancestor = 79 OR descendant = 79;
    DELETE FROM department_interests WHERE department_id = 79;
    DELETE FROM items WHERE department_id = 79;
    
 -- Insertar relaciones para todos los ancestros del `parent_id` (nietos, bisnietos, etc.)
        INSERT INTO department_closure (ancestor, descendant, depth)
        SELECT new_department_id, descendant, depth + 1
        FROM department_closure
        WHERE ancestor = parent_id;    
        
call sp_GetDepartmentBranchById(80);  

SELECT ancestor,depth FROM department_closure WHERE descendant = 81;      


-- 80, 81, 1
-- 81, 81, 0


CALL sp_insert_sales_from_json('{
  "sales": [
    {
      "customer_payment_method_id": "b6a2bff1f36f44d09e03cb49c9da7c12", 
      "customer_type_discount": 10.00,
      "items": [
        {
          "item_id": "c3722f2e3a6d44aeb7982f477fad378b", 
          "quantity": 2, 
          "item_price": 299.99, 
          "item_discount": 5.00
        },
        {
          "item_id": "cc5c9387d0ea4e09b8a9b3328b7369f5", 
          "quantity": 1, 
          "item_price": 99.99, 
          "item_discount": 0.00
        }
      ]
    }
  ]
}');

























































CALL sp_hash_pwd ("password1",                         -- Entrada: contraseña
    @hashed_password,           	-- Salida: contraseña hasheada
    @salt,                      	-- Salida: salt en binario
    @pwd_message,                	-- Mensaje de error o éxito
    @is_pwd_valid);	    
-- 'BBE5D5F4506D35E67A5EB5E7A3A75DF645E09861D664DCB7DEE5D57ED12902C4', '58727fa4a0ec11ef89780242ac120002'
SELECT hex(@hashed_password),           -- Salida: contraseña hasheada
    hex(@salt),                      	-- Salida: salt en binario
    @pwd_message,                		-- Mensaje de error o éxito
    @is_pwd_valid;    
SET @hashed_password = UNHEX(SHA2(CONCAT('password1', '58727FA4A0EC11EF89780242AC120002'), 256));
SELECT hex(@hashed_password);    


SELECT str_to_date("1990-15-1",'%Y-%m-%d');
SELECT str_to_date("1-15-1990",'%Y-%m-%d');
SELECT str_to_date("1990-1-15",'%Y-%m-%d');

SELECT fn_is_birthday_valid("1990-15-1");
SELECT fn_is_birthday_valid("1-15-1990");
SELECT fn_is_birthday_valid("1990-1-15");
SELECT fn_is_birthday_valid('1990-01-01');

show errors;
show variables like 'local_infile';

-- Importacion de datos a la tabla clientes mediante .csv
SET GLOBAL local_infile = 1;

CREATE TEMPORARY TABLE IF NOT EXISTS `customer_temp` (
	`username` varchar(150) NOT NULL,
	`password` varchar(255) NOT NULL,
	`name` varchar(100) NOT NULL,
	`lastname` varchar(100) NOT NULL,
	`email` varchar(150) NOT NULL,
	`birth_date` date NOT NULL,
	`customer_type_id` smallint unsigned NOT NULL,
	`phone` varchar(30) NOT NULL
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
    
LOAD DATA  LOCAL INFILE '/home/arturo/proyecto-sql-coder/final/csv/customer_temp.csv'
INTO TABLE customer_temp
FIELDS TERMINATED BY ','  ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
-- COLUMNAS QUE ME INTERESA INGESTAR
(username,password,name,lastname,email,birth_date,customer_type_id,phone);


LOAD DATA LOCAL INFILE '/home/arturo/customer_temp.csv'
INTO TABLE customer_temp
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

show errors;

CREATE TABLE `interests` (
  `interest_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_interest_id` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`interest_id`),
  KEY `fk_parent_interest` (`parent_interest_id`),
  CONSTRAINT `fk_parent_interest` FOREIGN KEY (`parent_interest_id`) REFERENCES `interests` (`interest_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `departments` (
  `department_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department_closure` (
  `ancestor` smallint unsigned NOT NULL,
  `descendant` smallint unsigned NOT NULL,
  `depth` int DEFAULT NULL,
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `descendant` (`descendant`),
  CONSTRAINT `department_closure_ibfk_1` FOREIGN KEY (`ancestor`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `department_closure_ibfk_2` FOREIGN KEY (`descendant`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT parent_interest_id FROM interests WHERE interest_id = 1;
SET @algo = fn_check_interest_cycle(0,1);
SELECT @algo;


select * FROM department_closure order by descendant,depth;

INSERT INTO department_closure (ancestor, descendant, depth)
        SELECT ancestor,800, depth + 1
        FROM department_closure
        WHERE descendant = 57;
        
   CREATE TABLE `payment_method` (
  `payment_method_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

  SELECT UUID_TO_BIN(UUID());
   
CREATE TABLE `customer_payment_method` (
  `customer_payment_method_id` binary(16) NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `payment_method_id` smallint unsigned NOT NULL,
  `creditcard` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`customer_payment_method_id`),
  KEY `customer_id` (`customer_id`),
  KEY `payment_method_id` (`payment_method_id`),
  CONSTRAINT `customer_payment_method_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `customer_payment_method_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `items` (
  `item_id` binary(16) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_description` varchar(255) DEFAULT NULL,
  `item_stock` int NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `item_discount` decimal(5,2) NOT NULL DEFAULT '0.00',
  `department_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `items_chk_1` CHECK ((`item_stock` >= 0)),
  CONSTRAINT `items_chk_2` CHECK ((`item_price` >= 0)),
  CONSTRAINT `items_chk_3` CHECK (((`item_discount` >= 0) and (`item_discount` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `interests` (
  `interest_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_interest_id` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`interest_id`),
  KEY `fk_parent_interest` (`parent_interest_id`),
  CONSTRAINT `fk_parent_interest` FOREIGN KEY (`parent_interest_id`) REFERENCES `interests` (`interest_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `customer_interests` (
  `customer_id` int unsigned NOT NULL,
  `interest_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`customer_id`,`interest_id`),
  KEY `interest_id` (`interest_id`),
  CONSTRAINT `customer_interests_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `customer_interests_ibfk_2` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sales` (
  `sales_id` bigint unsigned NOT NULL,
  `sales_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_payment_method_id` binary(16) NOT NULL,
  `customer_type_discount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`sales_id`),
  KEY `customer_payment_method_id` (`customer_payment_method_id`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`customer_payment_method_id`) REFERENCES `customer_payment_method` (`customer_payment_method_id`),
  CONSTRAINT `sales_chk_1` CHECK (((`customer_type_discount` >= 0) and (`customer_type_discount` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sold_items` (
  `sales_id` bigint unsigned NOT NULL,
  `item_id` binary(16) NOT NULL,
  `quantity` int NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `item_discount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`sales_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `sold_items_ibfk_1` FOREIGN KEY (`sales_id`) REFERENCES `sales` (`sales_id`),
  CONSTRAINT `sold_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`),
  CONSTRAINT `sold_items_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `sold_items_chk_2` CHECK ((`item_price` >= 0)),
  CONSTRAINT `sold_items_chk_3` CHECK (((`item_discount` >= 0) and (`item_discount` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



        


