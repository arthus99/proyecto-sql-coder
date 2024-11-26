use michangarro;

-- Probando las Vistas
SELECT * FROM v_interests;
SELECT * FROM v_departments;

-- Prueba la función: fn_check_interest_cycle
-- El (1) da el valor de Electrónica y sus hijos
-- valores con los que puede tener un loop
-- En la tabla interests
call sp_test_cycle_simulation(1);

-- Para probar los triggers 
call sp_test_cycle_simulation(2);
-- Note que 2.Ropa de Moda y 18. Ropa para Niños
-- Ropa y Moda no puede tener como padre así mismo ni a sus hijos

-- Cambiamos Ropa de niño a Electrónica
-- se debe activar tr_check_interests_before_update
-- Aquí lo permite
UPDATE interests
SET parent_interest_id = 1 -- Electrónica
WHERE interest_id = 18; -- Ropa de niño

call sp_test_cycle_simulation(1);  -- Verifique el depto electronica

-- Ahora crearemos un ciclo 
call sp_test_cycle_simulation(2); -- Ropa y Moda
-- (Ropa Hombre no puede ser padre de Ropa)
UPDATE interests
SET parent_interest_id = 16 -- Ropa Hombre
WHERE interest_id = 2; -- Ropa

-- Sí no vemos el error
SHOW WARNINGS;
-- 'Error', '1644', 'Ciclo detectado en la jerarquía de intereses.'

call sp_GetDepartmentByName(NULL); -- Todos Los Departamentos
call sp_GetDepartmentByName('Electrónicos');  -- Sólo Electrónicos

call sp_GetDepartmentById(NULL);	-- Todos los Deptos.
call sp_GetDepartmentByid(1);		-- Electrónicos

-- 1. Electrónicos es padre de Electrodomésticos, Tectnología movil, etc.
call sp_GetDepartmentBranchById(1);

-- 2. Electrodomésticos a su vez es padre de cocinas, Regrigeradores, etc
call sp_GetDepartmentBranchById(2);

-- Obtiene la relación intereses y departamentos
call sp_GetInterestByDepId(NULL);
call sp_GetInterestByDepId(3);

-- Selecciona datos del Cliente
-- Si aún no tiene clientes abajo esta el procedimiento sp_add_customer 
-- y el procedimiento para llenar la tabla customer
CALL sp_sel_customer(NULL); -- Muestra Todos
CALL sp_sel_customer("jdoe");	-- Muestra Sólo a jdoe


-- Valida convierte el password
CALL sp_hash_pwd ("password1",                         -- Entrada: contraseña
    @hashed_password,           -- Salida: contraseña hasheada
    @salt,                      -- Salida: salt en binario
    @pwd_message,                		 -- Mensaje de error o éxito
    @is_pwd_valid);
SELECT @hashed_password,           -- Salida: contraseña hasheada
    @salt,                      -- Salida: salt en binario
    @pwd_message,                		 -- Mensaje de error o éxito
    @is_pwd_valid;

-- Valida el número de teléfono
SET @phone = '(123) 456-7890';
SET @cleaned_phone = fn_validate_phone_number(@phone);		-- Ya no use esta función
SELECT @cleaned_phone;  -- Esto debería mostrar '1234567890'.

-- Válida que el teléfono no exista en la bd y tenga entre 10 y 15 dígitos.
CALL sp_is_phone_number_valid('(555)123 4567', -- teléfono de Jhon Doe
	@phone_number_message, 		-- Error (si existe)
    @cleaned_phone, 			-- Teléfono
    @is_phone_number_valid);	-- Valido

SELECT @phone_number_message,@cleaned_phone,@is_phone_number_valid;		-- Muestra los valores
SHOW ERRORS;

-- Válida el username 
CALL sp_is_username_valid ("",@username_message, @username_valid);
SELECT @username_message,@username_valid;		-- El username no puede estar vacio.

CALL sp_is_username_valid ("arsanche",@username_message, @username_valid);
SELECT @username_message,@username_valid; 		-- No existe este usuarío por lo que es válido

CALL sp_is_username_valid ("jdoe",@username_message, @username_valid);
SELECT @username_message,@username_valid;		-- Este usuario ya existe.

-- Válida el email (sólo que sea único)
CALL sp_is_email_valid ("juan.perez@example.com", -- No existe en la BD
	@email_message, 							-- No hay mensaje ya que no existe (NULL)
    @is_email_valid);							-- Es Valido TRUE(1)
SELECT @email_message,@is_email_valid;

-- Válida el email (que no este vacío)
CALL sp_is_email_valid ("", -- No existe en la BD
	@email_message, 							-- No hay mensaje ya que no existe (NULL)
    @is_email_valid);							-- Es Valido TRUE(1)
SELECT @email_message,@is_email_valid;

-- Agregar un Cliente
 CALL sp_add_customer("juanperez",  			-- p_username
				"password1",				-- p_password
                "Juan",						-- p_name
                "Pérez",					-- p_lastname
                "juan.perez@example.com",	-- p_email
                "1990-01-15",				-- p_birth_date
                1,							-- p_customer_type_id
                "(123) 456-7890");				-- p_phone
-- Si existe algún error vea:
show warnings;
CALL sp_sel_customer("juanperez"); -- Muestra 

-- Authentication (puede encontrar más usuarios y pwd en datos/csv/customer_temp.csv)
SELECT fn_Authentication('juanperez', 'password1') AS is_authenticated;		-- Justo lo agregamos

-- Actualización del cliente
CALL sp_update_customer(
    'juanperez',          			-- p_username (obligatorio)
    'password2',                 	-- p_password (no se actualizará)
    NULL,       					-- p_name (no se actualizará)
    NULL,                 			-- p_lastname (no se actualizará)
    'nuevo_email@example.com',  	-- p_email 
    '1990-01-01',         			-- p_birth_date
    NULL,                 			-- p_customer_type_id (no se actualizará)
    '987-654 3210',       			-- p_phone
    NULL							-- p_new_username (no se actualizará)
);

show warnings; -- sí hay error
CALL sp_sel_customer("juanperez"); -- Muestra 

-- Authentication
SELECT fn_Authentication('juanperez', 'password2') AS is_authenticated;

-- Borrar un Cliente
CALL sp_del_customer("juanperez"); -- sólo por username
CALL sp_sel_customer("juanperez"); -- Muestra

-- Procedimiento para llenar la tabla customer
call sp_create_table_customer_temp();
-- llenar la tabla customer temp con customer_temp.csv
-- ejecutar el store:
CALL sp_reset_customers;	-- Inserta datos en customers y elimina la tabla customer_temp.
							-- Observe que customer_temp.csv el password esta límpio h en la
                            -- tabla customer es binario y  cifrado con hash.
-- Si existe algún error vea:
show errors;

 CALL sp_insert_department("Departamento de prueba", 	-- dept_name, 
		"Descripción del departamento de prueba.",		-- dept_description, 
        NULL												-- parent_id
        );
        
SELECT LAST_INSERT_ID();

CALL sp_insert_department("Hijo departamento de prueba", 	-- dept_name, 
		"Descripción del departamento de prueba hijo.",		-- dept_description, 
        80												-- parent_id
        );
-- id = 81
CALL sp_insert_department("Nieto departamento de prueba", 	-- dept_name, 
		"Descripción del departamento de prueba nieto.",		-- dept_description, 
        81												-- parent_id
        );

call sp_GetDepartmentBranchById(80);

CALL sp_delete_department(88);


CALL sp_manage_departments(
    NULL,   										-- ID del departamento
    "Departamento sin Asignar",      				-- Nombre del departamento
    "Esta situación se da si se borra un depto.",  	-- Descripción del departamento
    NULL											-- parent_id   
    );

-- insert departments set department_id = 80, name = 'Departamento de prueba',description = 'Descripción del depa de pruebas';    
-- insert department_closure set ancestor = 80, descendant = 81, depth = 1;

show errors;
call sp_GetDepartmentBranchById(1);
call sp_GetDepartmentBranchById(80);

-- Por ahora no se actualiza el arbol de departamentos.
CALL sp_update_department( 80,           	-- Departamento a actualizar
							'PRUEB',       -- Nuevo nombre
							null, 			-- Nueva descripción
							2); 

-- Insertar datos de ventas.
-- Encontrará más en: datos/json/ventas.txt
-- Esta es sólo una aproximación; el final debería tomar los datos existentes de la bd,
-- reducir el stock entre otras operaciones.                            
CALL sp_insert_sales_from_json('{
  "sales": [
    {
      "customer_payment_method_id": "299FC37AA93411EF893F0242AC120002", 
      "customer_type_discount": 10.00,
      "items": [
        {
          "item_id": "739CD0BFA93411EF893F0242AC120002", 
          "quantity": 2, 
          "item_price": 8.99, 
          "item_discount": 5.00
        },
        {
          "item_id": "739CDAC2A93411EF893F0242AC120002", 
          "quantity": 6, 
          "item_price": 9.99, 
          "item_discount": 10.00
        }
      ]
    }
  ]
}');   

SELECT MAX(sales_id) FROM sales;

-- Muestra el detalle de las compras realizadas
CALL sp_get_sale_details(1);                         
                            
                            