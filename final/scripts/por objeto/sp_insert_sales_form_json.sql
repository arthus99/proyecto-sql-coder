DROP PROCEDURE IF EXISTS sp_insert_sales_from_json;

DELIMITER $$

CREATE PROCEDURE `sp_insert_sales_from_json`(IN sales_json JSON)
BEGIN
    DECLARE current_sale INT DEFAULT 0;
    DECLARE num_sales INT;
    DECLARE current_sales_id BIGINT;
    DECLARE current_payment_method_id BINARY(16);
    DECLARE current_discount DECIMAL(5,2);
    
    -- Variables para artículos vendidos
    DECLARE item_number INT DEFAULT 0;
    DECLARE num_items INT;
    DECLARE current_item_id BINARY(16);
    DECLARE current_quantity INT;
    DECLARE current_item_price DECIMAL(10,2);
	DECLARE current_item_discount DECIMAL(5,2);
    DECLARE error_message VARCHAR(255);
    
    -- Manejador para manejar excepciones
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Capturar el mensaje de error
        GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
		SET error_message = CONCAT('Error: ', error_message);
		ROLLBACK;
        -- Lanzar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
	END;
    
    -- Comienza la Transacción
    START TRANSACTION;
    
    -- Obtén el número de ventas en el JSON
    SET num_sales = JSON_LENGTH(sales_json->'$.sales');
    
    -- Itera sobre las ventas
    WHILE current_sale < num_sales DO
        -- Obtén los detalles de la venta      
        SET current_payment_method_id = UNHEX(JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[',current_sale, '].customer_payment_method_id'))));
        SET current_discount = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].customer_type_discount')));
        
        -- Inserta la venta
        INSERT INTO sales (customer_payment_method_id, customer_type_discount)
        VALUES (current_payment_method_id, current_discount);
        
        SET current_sales_id = LAST_INSERT_ID();
                
        -- Obtén el número de artículos para esta venta
        SET num_items = JSON_LENGTH(sales_json,CONCAT('$.sales[', current_sale, '].items'));
        
        -- Inicializa item_number para cada venta
		SET item_number = 0;
        
        -- Itera sobre los artículos vendidos
        WHILE item_number < num_items DO
            SET current_item_id = UNHEX(JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale,'].items[',item_number, '].item_id'))));
            SET current_quantity = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].items[', item_number, '].quantity')));
            SET current_item_price = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].items[', item_number, '].item_price')));
            SET current_item_discount = JSON_UNQUOTE(JSON_EXTRACT(sales_json,CONCAT('$.sales[', current_sale, '].items[', item_number, '].item_discount')));

            -- Inserta los artículos vendidos
            INSERT INTO sold_items (sales_id, item_id, quantity, item_price, item_discount)
            VALUES (current_sales_id, current_item_id, current_quantity, current_item_price, current_item_discount);

            
            SET item_number = item_number + 1;
        END WHILE;
        
        SET current_sale= current_sale + 1;
    END WHILE;
    
     -- Confirmar la transacción si todo se realizó correctamente
    COMMIT;

END$$

DELIMITER ;
