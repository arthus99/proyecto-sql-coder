DROP PROCEDURE IF EXISTS sp_get_sale_details;

DELIMITER $$

CREATE PROCEDURE sp_get_sale_details( p_sales_id BIGINT UNSIGNED)
BEGIN
    SELECT 
        s.sales_id,
        si.item_id,
        i.item_name,
        si.quantity,
        i.item_price,
        si.item_discount,
        -- Calcular el precio con descuento por artículo
        ROUND(si.quantity * i.item_price * (1 - si.item_discount / 100), 2) AS item_total,
        -- Calcular el total de la venta (incluyendo el descuento del cliente)
        ROUND(
            si.quantity * i.item_price * (1 - si.item_discount / 100) * (1 - s.customer_type_discount / 100),
            2
        ) AS total_sale
    FROM 
        sales s
    JOIN 
        sold_items si ON s.sales_id = si.sales_id
    JOIN 
        items i ON si.item_id = i.item_id
    WHERE 
        s.sales_id = p_sales_id;
END$$

DELIMITER ;
