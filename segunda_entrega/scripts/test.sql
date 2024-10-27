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

