DROP DATABASE IF EXISTS miChangarro;
CREATE DATABASE miChangarro;

USE miChangarro;

CREATE TABLE customer_type (
    customer_type_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    customer_type_discount DECIMAL(5, 2) NOT NULL DEFAULT 0.00 CHECK (customer_type_discount >= 0 AND customer_type_discount <= 100)
);

CREATE TABLE payment_method (
    payment_method_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

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

CREATE TABLE `department_interests` (
  `department_id` smallint unsigned NOT NULL,
  `interest_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`department_id`,`interest_id`),
  KEY `fk_interest` (`interest_id`),
  CONSTRAINT `fk_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_interest` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`interest_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE customer (
    customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(150) NOT NULL UNIQUE,
    password VARBINARY(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    birth_date DATE NOT NULL,
    customer_type_id SMALLINT UNSIGNED NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    FOREIGN KEY (customer_type_id) REFERENCES customer_type(customer_type_id)
);

CREATE TABLE customer_interests (
    customer_id INT UNSIGNED NOT NULL,
    interest_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (customer_id, interest_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (interest_id) REFERENCES interests(interest_id)
);

CREATE TABLE customer_payment_method (
    customer_payment_method_id BINARY(16) NOT NULL PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    payment_method_id SMALLINT UNSIGNED NOT NULL,
    creditcard VARBINARY(255),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

CREATE TABLE items (
    item_id BINARY(16) NOT NULL PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_description VARCHAR(255),
    item_stock INT NOT NULL CHECK (item_stock >= 0),
    item_price DECIMAL(10, 2) NOT NULL CHECK (item_price >= 0),
    item_discount DECIMAL(5, 2) NOT NULL DEFAULT 0.00 CHECK (item_discount >= 0 AND item_discount <= 100),
    department_id SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


CREATE TABLE sales (
    sales_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    sales_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    customer_payment_method_id BINARY(16) NOT NULL,
    customer_type_discount DECIMAL(5, 2) NOT NULL CHECK (customer_type_discount >= 0 AND customer_type_discount <= 100),
    FOREIGN KEY (customer_payment_method_id) REFERENCES customer_payment_method(customer_payment_method_id),
    INDEX (customer_payment_method_id) 
);



CREATE TABLE sold_items (
    sales_id BIGINT UNSIGNED NOT NULL,
    item_id BINARY(16) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    item_price DECIMAL(10, 2) NOT NULL CHECK (item_price >= 0),
    item_discount DECIMAL(5, 2) NOT NULL CHECK (item_discount >= 0 AND item_discount <= 100),
    PRIMARY KEY (sales_id, item_id),
    FOREIGN KEY (sales_id) REFERENCES sales(sales_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
