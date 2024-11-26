USE michangarro;
DROP PROCEDURE IF EXISTS sp_sel_customer;
DELIMITER //

CREATE PROCEDURE sp_sel_customer(
    p_username VARCHAR(150)
)
BEGIN
    -- Selecciona el registro del cliente
    SELECT username,
		c.name as "Nombre",
        c.lastname as "Apellido",
        c.email as "Correo Electronico",
        c.birth_date as "Fecha Nacimiento",
        ct.name as "Tipo Cliente",
        c.phone as "Telefono"
    FROM customer c
    INNER JOIN customer_type ct on c.customer_type_id = ct.customer_type_id 
    WHERE username = coalesce(p_username,username);

    
END//

DELIMITER ;
