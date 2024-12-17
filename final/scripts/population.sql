-- Procedimiento para llenar la tabla customer
call sp_create_table_customer_temp();
-- llenar la tabla customer temp con el siguiente insert
INSERT INTO customer_temp (username, password, name, lastname, email, birth_date, customer_type_id, phone)
VALUES
('jdoe', 'password123', 'John', 'Doe', 'jdoe@example.com', '1990-01-15', 1, '5551234567'),
('asmith', 'password456', 'Alice', 'Smith', 'asmith@example.com', '1985-05-22', 2, '5559876543'),
('mbrown', 'password789', 'Mike', 'Brown', 'mbrown@example.com', '1992-03-30', 1, '5556543210'),
('jwhite', 'password321', 'Jane', 'White', 'jwhite@example.com', '1988-11-11', 3, '5553210987'),
('tlee', 'password654', 'Tony', 'Lee', 'tlee@example.com', '1995-07-08', 1, '5557778888'),
('kchan', 'password987', 'Kathy', 'Chan', 'kchan@example.com', '1982-12-12', 2, '5552223333'),
('pmoore', 'password456', 'Paul', 'Moore', 'pmoore@example.com', '1993-02-20', 1, '5555444555'),
('bthompson', 'password321', 'Betty', 'Thompson', 'bthompson@example.com', '1980-04-04', 3, '5559888999'),
('rjones', 'password654', 'Rachel', 'Jones', 'rjones@example.com', '1989-09-19', 2, '5550999000'),
('mclark', 'password789', 'Michael', 'Clark', 'mclark@example.com', '1991-06-30', 1, '5552111222'),
('jlopez', 'password123', 'José', 'López', 'jlopez@example.com', '1990-01-15', 1, '5557123456'),
('asmendez', 'password456', 'Ana', 'Méndez', 'asmendez@example.com', '1985-05-22', 2, '5553987654'),
('mgarcia', 'password789', 'Miguel', 'García', 'mgarcia@example.com', '1992-03-30', 1, '5550654321'),
('jmartinez', 'password321', 'Juana', 'Martínez', 'jmartinez@example.com', '1988-11-11', 3, '5557321098'),
('tparra', 'password654', 'Tomas', 'Parra', 'tparra@example.com', '1995-07-08', 1, '5557877888'),
('kramirez', 'password987', 'Karina', 'Ramírez', 'kramirez@example.com', '1982-12-12', 2, '5553222333'),
('pcastillo', 'password456', 'Pablo', 'Castillo', 'pcastillo@example.com', '1993-02-20', 1, '5554445555'),
('bfernandez', 'password321', 'Beatriz', 'Fernández', 'bfernandez@example.com', '1980-04-04', 3, '5558889999'),
('rortiz', 'password654', 'Roberto', 'Ortiz', 'rortiz@example.com', '1989-09-19', 2, '5559990000'),
('mramirez', 'password789', 'María', 'Ramírez', 'mramirez@example.com', '1991-06-30', 1, '5551112222');

-- ejecutar el store:

CALL sp_reset_customers;	-- Inserta datos en customers y elimina la tabla customer_temp.
							-- Observe que customer_temp.csv el password esta límpio
                            -- tabla customer es binario y  cifrado con hash.
                            
-- llena la tabla interests                            

INSERT INTO `interests` (`name`, `description`, `parent_interest_id`) VALUES
  ("Electrónica", "Gadgets y dispositivos", NULL),  -- Interés principal para la categoría de electrónica
  ("Ropa y Moda", "Vestimenta y accesorios", NULL),  -- Interés principal para la categoría de ropa
  ("Hogar y Muebles", "Artículos para el hogar", NULL),  -- Interés principal para artículos del hogar
  ("Cuidado Personal y Belleza", "Productos de belleza y cuidado personal", NULL),  -- Interés principal para cuidado personal
  ("Alimentos y Bebidas", "Comida y bebidas", NULL),  -- Interés principal para alimentos y bebidas
  ("Deportes y Aire Libre", "Equipamiento y ropa para actividades al aire libre", NULL),  -- Interés principal para deportes
  ("Productos para Mascotas", "Alimentos y accesorios para mascotas", NULL),  -- Interés principal para mascotas
  ("Juguetes y Juegos", "Artículos de entretenimiento para niños", NULL),  -- Interés principal para juguetes
  ("Libros y Papelería", "Material de lectura y oficina", NULL),  -- Interés principal para libros y papelería
  ("Salud y Bienestar", "Productos para mejorar la salud", NULL),  -- Interés principal para salud
  ("Ofertas", "Promociones y descuentos especiales", NULL),  -- Interés principal para ofertas
  ("Eventos Especiales", "Ofertas en ocasiones especiales", NULL),  -- Interés principal para eventos especiales
  ("Tendencias y Novedades", "Nuevos productos y tendencias del mercado", NULL),  -- Interés principal para tendencias
  
  ("Televisores y Audio", "Dispositivos de entretenimiento", 1),  -- Interés específico dentro de electrónica (Televisores y Audio)
  ("Tecnología Móvil", "Teléfonos y accesorios móviles", 1),  -- Interés específico dentro de electrónica (Tecnología móvil)
  
  ("Ropa para Hombres", "Ropa diseñada para hombres", 2),  -- Interés dentro de ropa y moda (Hombres)
  ("Ropa para Mujeres", "Ropa diseñada para mujeres", 2),  -- Interés dentro de ropa y moda (Mujeres)
  ("Ropa para Niños", "Ropa diseñada para niños", 2),  -- Interés dentro de ropa y moda (Niños)
  ("Ropa Deportiva", "Vestimenta para actividades deportivas", 2),  -- Interés dentro de ropa y moda (Deportiva)
  ("Accesorios de Moda", "Complementos de vestimenta", 2),  -- Interés dentro de ropa y moda (Accesorios)
  
  ("Muebles para el Hogar", "Muebles de diversas categorías", 3),  -- Interés dentro de hogar y muebles (Muebles)
  ("Decoración y Artículos de Limpieza", "Elementos decorativos y de limpieza", 3),  -- Interés dentro de hogar y muebles (Decoración y limpieza)
  ("Herramientas de Jardinería", "Herramientas y accesorios para el jardín", 3),  -- Interés dentro de hogar y muebles (Jardinería)
  
  ("Cosméticos y Maquillaje", "Productos para el rostro y cuerpo", 4),  -- Interés dentro de cuidado personal y belleza (Cosméticos)
  ("Productos para el Cuidado de la Piel", "Cremas y lociones para la piel", 4),  -- Interés dentro de cuidado personal y belleza (Cuidado de la piel)
  ("Artículos de Higiene Personal", "Productos para la higiene diaria", 4),  -- Interés dentro de cuidado personal y belleza (Higiene personal)
  
  ("Comida Fresca", "Frutas y verduras frescas", 5),  -- Interés dentro de alimentos y bebidas (Comida fresca)
  ("Productos Gourmet", "Alimentos de alta calidad", 5),  -- Interés dentro de alimentos y bebidas (Productos gourmet)
  ("Snacks y Golosinas", "Aperitivos y dulces", 5),  -- Interés dentro de alimentos y bebidas (Snacks)
  
  ("Equipamiento Deportivo", "Artículos para diversos deportes", 6),  -- Interés dentro de deportes y aire libre (Equipamiento deportivo)
  ("Ropa de Camping", "Vestimenta adecuada para actividades al aire libre", 6),  -- Interés dentro de deportes y aire libre (Ropa de camping)
  ("Accesorios para Actividades al Aire Libre", "Equipos complementarios para actividades al aire libre", 6),  -- Interés dentro de deportes y aire libre (Accesorios)
  
  ("Alimentos para Mascotas", "Comida para perros, gatos y otros animales", 7),  -- Interés dentro de productos para mascotas (Alimentos para mascotas)
  ("Juguetes y Accesorios", "Artículos para el entretenimiento de mascotas", 7),  -- Interés dentro de productos para mascotas (Juguetes y accesorios)
  ("Cuidado y Salud de Mascotas", "Productos para la salud de las mascotas", 7),  -- Interés dentro de productos para mascotas (Cuidado y salud)
  
  ("Juguetes Educativos", "Juguetes que fomentan el aprendizaje", 8),  -- Interés dentro de juguetes y juegos (Educativos)
  ("Juegos de Mesa y Video", "Diversión para toda la familia", 8),  -- Interés dentro de juguetes y juegos (Juegos de mesa)
  ("Artículos para Fiestas", "Decoraciones y juegos para celebraciones", 8),  -- Interés dentro de juguetes y juegos (Artículos de fiesta)
  
  ("Libros", "Literatura de diversos géneros", 9),  -- Interés dentro de libros y papelería (Libros)
  ("Material de Oficina", "Artículos para el trabajo en oficina", 9),  -- Interés dentro de libros y papelería (Material de oficina)
  ("Artículos Escolares", "Útiles escolares para estudiantes", 9),  -- Interés dentro de libros y papelería (Artículos escolares)
  
  ("Suplementos y Vitaminas", "Productos para complementar la dieta", 10),  -- Interés dentro de salud y bienestar (Suplementos)
  ("Productos de Fitness", "Equipos y artículos para ejercicio", 10),  -- Interés dentro de salud y bienestar (Fitness)
  ("Equipos de Salud y Cuidado", "Dispositivos para el monitoreo de salud", 10),  -- Interés dentro de salud y bienestar (Equipos de salud)
  
  ("Ofertas Semanales", "Descuentos que cambian semanalmente", 11),  -- Interés dentro de ofertas (Ofertas semanales)
  ("Descuentos por Temporada", "Promociones específicas de temporada", 11),  -- Interés dentro de ofertas (Descuentos de temporada)
  ("Programas de Lealtad", "Beneficios para clientes frecuentes", 11),  -- Interés dentro de ofertas (Programas de lealtad)
  
  ("Buen Fin", "Promociones especiales en el fin de semana largo", 12),  -- Interés dentro de eventos especiales (Buen Fin)
  ("Ofertas de Regreso a Clases", "Descuentos en productos escolares", 12),  -- Interés dentro de eventos especiales (Regreso a clases)
  ("Ventas de Temporada", "Ofertas por festividades y estaciones", 12),  -- Interés dentro de eventos especiales (Ventas de temporada)
  
  ("Nuevos Lanzamientos", "Productos recién disponibles en el mercado", 13),  -- Interés dentro de tendencias (Nuevos lanzamientos)
  ("Tendencias de Moda", "Lo último en moda y estilo", 13),  -- Interés dentro de tendencias (Moda)
  ("Innovaciones en Tecnología", "Avances en tecnología y gadgets", 13);  -- Interés dentro de tendencias (Innovaciones tecnológicas)
  
  
  
INSERT INTO `departments` (`department_id`, `name`, `description`) VALUES
(1, 'Electrónicos', 'Todo lo relacionado con tecnología y dispositivos electrónicos.'),
(2, 'Electrodomésticos', 'Electrodomésticos para el hogar.'),
(3, 'Cocinas', 'Cocinas para preparar alimentos.'),
(4, 'Refrigeradores', 'Refrigeradores para conservar alimentos.'),
(5, 'Lavadoras', 'Lavadoras para el cuidado de la ropa.'),
(6, 'Tecnología Móvil', 'Dispositivos móviles y accesorios.'),
(7, 'Teléfonos', 'Teléfonos móviles de diversas marcas.'),
(8, 'Tabletas', 'Tabletas para entretenimiento y trabajo.'),
(9, 'Accesorios Móviles', 'Fundas, cargadores y otros accesorios móviles.'),
(10, 'Electrónica de Consumo', 'Gadgets y dispositivos electrónicos para uso diario.'),
(11, 'Televisores', 'Televisores de diferentes tamaños y tecnologías.'),
(12, 'Audio y Video', 'Equipos de audio y video para entretenimiento.'),
(13, 'Cámaras y Fotografía', 'Cámaras y accesorios para la fotografía.'),
(14, 'Cámaras Digitales', 'Cámaras digitales para capturar momentos.'),
(15, 'Accesorios de Fotografía', 'Lentes, trípodes y otros accesorios fotográficos.'),
(16, 'Videojuegos', 'Consolas y videojuegos de diversas plataformas.'),
(17, 'Consolas', 'Consolas de videojuegos populares.'),
(18, 'Juegos', 'Juegos para diferentes consolas y plataformas.'),
(19, 'Accesorios para Videojuegos', 'Controles, headsets y otros accesorios.'),
(20, 'Música', 'Instrumentos musicales y equipos de audio.'),
(21, 'Instrumentos Musicales', 'Instrumentos para músicos de todos los niveles.'),
(22, 'Equipos de Audio', 'Altavoces y sistemas de sonido.'),
(23, 'Ropa', 'Vestimenta para hombres, mujeres y niños.'),
(24, 'Ropa Deportiva', 'Vestimenta especializada para actividades deportivas.'),
(25, 'Calzado Deportivo', 'Calzado diseñado para el deporte.'),
(26, 'Accesorios Deportivos', 'Artículos complementarios para deportes.'),
(27, 'Ropa Casual', 'Vestimenta informal para el día a día.'),
(28, 'Vestidos', 'Vestidos para diferentes ocasiones.'),
(29, 'Camisetas', 'Camisetas para hombres, mujeres y niños.'),
(30, 'Accesorios de Moda', 'Bolsos, joyas y otros complementos.'),
(31, 'Hogar y Muebles', 'Muebles y artículos para el hogar.'),
(32, 'Muebles', 'Muebles de diversas categorías.'),
(33, 'Sofás', 'Sofás y sillones para la sala.'),
(34, 'Mesas', 'Mesas de comedor y de centro.'),
(35, 'Sillas', 'Sillas para diferentes usos.'),
(36, 'Artículos de Limpieza', 'Productos de limpieza para el hogar.'),
(37, 'Jardinería', 'Plantas y herramientas para el jardín.'),
(38, 'Plantas', 'Plantas decorativas y de interior.'),
(39, 'Herramientas de Jardín', 'Herramientas para cuidar el jardín.'),
(40, 'Cocina', 'Utensilios y accesorios para la cocina.'),
(41, 'Utensilios', 'Utensilios esenciales para cocinar.'),
(42, 'Electrodomésticos de Cocina', 'Electrodomésticos para facilitar la cocina.'),
(43, 'Alimentos y Bebidas', 'Productos alimenticios y bebidas.'),
(44, 'Alimentos Frescos', 'Frutas y verduras frescas.'),
(45, 'Bebidas', 'Bebidas alcohólicas y no alcohólicas.'),
(46, 'Bebidas Alcohólicas', 'Bebidas con contenido Alcohólico'),
(47, 'Bebidas No Alcohólicas', 'Bebidas sin alcohol'),
(48, 'Salud y Belleza', 'Productos de cuidado personal y belleza.'),
(49, 'Cuidado Personal', 'Artículos para la higiene y el cuidado personal.'),
(50, 'Productos para el Cabello', 'Champús, acondicionadores y tratamientos.'),
(51, 'Productos para la Piel', 'Cremas y lociones para el cuidado de la piel.'),
(52, 'Salud y Bienestar', 'Suplementos y productos de bienestar.'),
(53, 'Suplementos', 'Suplementos de Salud'),
(54, 'Productos Naturales', 'Productos Naturistas'),
(55, 'Cuidado del Bebé', 'Productos y accesorios para bebés.'),
(56, 'Alimentos para Bebés', 'Comida y fórmulas para bebés.'),
(57, 'Accesorios para Bebés', 'Artículos para la comodidad de los bebés.'),
(58, 'Juguetes', 'Juguetes y juegos para niños.'),
(59, 'Juguetes Educativos', 'Juguetes que fomentan el aprendizaje.'),
(60, 'Juguetes para Bebés', 'Juguetes diseñados para los más pequeños.'),
(61, 'Juguetes de Construcción', 'Juguetes que estimulan la creatividad.'),
(62, 'Deportes y Aire Libre', 'Equipamiento deportivo y artículos para actividades al aire libre.'),
(63, 'Equipos Deportivos', 'Equipamiento para diversos deportes.'),
(64, 'Ropa de Camping', 'Vestimenta adecuada para actividades al aire libre.'),
(65, 'Accesorios de Pesca', 'Artículos para la pesca recreativa.'),
(66, 'Automotriz', 'Accesorios y productos para automóviles.'),
(67, 'Accesorios para Automóviles', 'Artículos para mejorar la experiencia automotriz.'),
(68, 'Herramientas para Automóviles', 'Herramientas para el mantenimiento de vehículos.'),
(69, 'Libros y Papelería', 'Libros, material de oficina y artículos de papelería.'),
(70, 'Libros', 'Libros de diferentes géneros.'),
(71, 'Ficción', 'Novelas y cuentos de ficción.'),
(72, 'No Ficción', 'Libros de historia, biografías y más.'),
(73, 'Material de Oficina', 'Artículos para el trabajo en oficina.'),
(74, 'Papelería', 'Útiles escolares y de oficina.'),
(75, 'Productos para Mascotas', 'Alimentos y accesorios para mascotas.'),
(76, 'Alimentos para Mascotas', 'Comida para perros, gatos y otros animales.'),
(77, 'Accesorios para Mascotas', 'Juguetes y accesorios para el cuidado de mascotas.'),
(78, 'Juguetes para Mascotas', 'Juguetes diseñados para entretener a las mascotas.');


INSERT INTO `department_closure` (`ancestor`, `descendant`, `depth`) VALUES
(1, 1, 0),  -- Electrónicos
(1, 2, 1),  -- Electrodomésticos
(1, 6, 1),  -- Tecnología Móvil
(1, 10, 1), -- Electrónica de Consumo
(1, 13, 1), -- Cámaras y Fotografía
(1, 16, 1), -- Videojuegos
(1, 20, 1), -- Música
(2, 3, 2),  -- Cocinas
(2, 4, 2),  -- Refrigeradores
(2, 5, 2),  -- Lavadoras
(6, 7, 2),  -- Teléfonos
(6, 8, 2),  -- Tabletas
(6, 9, 2),  -- Accesorios Móviles
(10, 11, 2), -- Televisores
(10, 12, 2), -- Audio y Video
(13, 14, 2), -- Cámaras Digitales
(13, 15, 2), -- Accesorios de Fotografía
(16, 17, 2), -- Consolas
(16, 18, 2), -- Juegos
(16, 19, 2), -- Accesorios para Videojuegos
(20, 21, 2), -- Instrumentos Musicales
(20, 22, 2), -- Equipos de Audio
(23, 23, 0), -- Ropa
(23, 24, 1), -- Ropa Deportiva
(23, 27, 1), -- Ropa Casual
(23, 30, 1), -- Accesorios de Moda
(24, 25, 2), -- Calzado Deportivo
(24, 26, 2), -- Accesorios Deportivos
(27, 28, 2), -- Vestidos
(27, 29, 2), -- Camisetas
(31, 31, 0), -- Hogar y Muebles
(31, 32, 1), -- Muebles
(31, 36, 1), -- Artículos de Limpieza
(31, 37, 1), -- Jardinería
(31, 40, 1), -- Cocina
(32, 33, 2), -- Sofás
(32, 34, 2), -- Mesas
(32, 35, 2), -- Sillas
(37, 38, 2), -- Plantas
(37, 39, 2), -- Herramientas de Jardín
(40, 41, 2), -- Utensilios
(40, 42, 2), -- Electrodomésticos de Cocina
(43, 43, 0), -- Alimentos y Bebidas
(43, 44, 1), -- Alimentos Frescos
(43, 45, 1), -- Bebidas
(45, 46, 2), -- Bebidas Alcohólicas
(45, 47, 2), -- Bebidas No Alcohólicas
(48, 48, 0), -- Salud y Belleza
(48, 49, 1), -- Cuidado Personal
(48, 52, 1), -- Salud y Bienestar
(48, 55, 1), -- Cuidado del Bebé
(49, 50, 2), -- Productos para el Cabello
(49, 51, 2), -- Productos para la Piel
(52, 53, 2), -- Suplementos
(52, 54, 2), -- Productos Naturales
(55, 56, 2), -- Alimentos para Bebés
(55, 57, 2), -- Accesorios para Bebés
(58, 58, 0), -- Juguetes
(58, 59, 1), -- Juguetes Educativos
(58, 60, 1), -- Juguetes para Bebés
(58, 61, 1), -- Juguetes de Construcción
(62, 62, 0), -- Deportes y Aire Libre
(62, 63, 1), -- Equipos Deportivos
(62, 64, 1), -- Ropa de Camping
(62, 65, 1), -- Accesorios de Pesca
(66, 66, 0), -- Automotriz
(66, 67, 1), -- Accesorios para Automóviles
(66, 68, 1), -- Herramientas para Automóviles
(69, 69, 0), -- Libros y Papelería
(69, 70, 1), -- Libros
(69, 73, 1), -- Material de Oficina
(69, 74, 1), -- Papelería
(70, 71, 2), -- Ficción
(70, 72, 2), -- No Ficción
(75, 75, 0), -- Productos para Mascotas
(75, 76, 1), -- Alimentos para Mascotas
(75, 77, 1), -- Accesorios para Mascotas
(75, 78, 1); -- Juguetes para Mascotas

INSERT INTO `department_interests` (`department_id`, `interest_id`) VALUES
(1, 1),   -- Electrónicos, Electrónica
(1, 14),  -- Electrónicos, Televisores y Audio
(1, 15),  -- Electrónicos, Tecnología Móvil
(2, 3),   -- Electrodomésticos, Hogar y Muebles
(3, 3),   -- Cocinas, Hogar y Muebles
(4, 3),   -- Refrigeradores, Hogar y Muebles
(5, 3),   -- Lavadoras, Hogar y Muebles
(6, 15),  -- Tecnología Móvil, Electrónica
(7, 15),  -- Teléfonos, Tecnología Móvil
(8, 15),  -- Tabletas, Tecnología Móvil
(9, 15),  -- Accesorios Móviles, Tecnología Móvil
(10, 1),  -- Electrónica de Consumo, Electrónica
(11, 14), -- Televisores, Televisores y Audio
(12, 14), -- Audio y Video, Televisores y Audio
(13, 14), -- Cámaras y Fotografía, Televisores y Audio
(16, 8),  -- Videojuegos, Juguetes y Juegos
(19, 8),  -- Juegos, Juguetes y Juegos
(20, 10), -- Música, Salud y Bienestar
(22, 10), -- Equipos de Audio, Salud y Bienestar
(23, 2),  -- Ropa, Ropa y Moda
(24, 19), -- Ropa Deportiva, Juguetes y Juegos
(25, 19), -- Calzado Deportivo, Juguetes y Juegos
(26, 19), -- Accesorios Deportivos, Juguetes y Juegos
(27, 2),  -- Ropa Casual, Ropa y Moda
(28, 2),  -- Vestidos, Ropa y Moda
(29, 2),  -- Camisetas, Ropa y Moda
(30, 20), -- Accesorios de Moda, Música
(31, 3),  -- Hogar y Muebles, Hogar y Muebles
(32, 3),  -- Muebles, Hogar y Muebles
(33, 3),  -- Sofás, Hogar y Muebles
(34, 3),  -- Mesas, Hogar y Muebles
(35, 3),  -- Sillas, Hogar y Muebles
(36, 4),  -- Artículos de Limpieza, Cuidado Personal y Belleza
(37, 3),  -- Jardinería, Hogar y Muebles
(38, 3),  -- Plantas, Hogar y Muebles
(39, 3),  -- Herramientas de Jardín, Hogar y Muebles
(40, 3),  -- Cocina, Hogar y Muebles
(41, 3),  -- Utensilios, Hogar y Muebles
(42, 4),  -- Electrodomésticos de Cocina, Cuidado Personal y Belleza
(43, 5),  -- Alimentos y Bebidas, Alimentos y Bebidas
(44, 5),  -- Alimentos Frescos, Alimentos y Bebidas
(45, 5),  -- Bebidas, Alimentos y Bebidas
(48, 4),  -- Salud y Belleza, Cuidado Personal y Belleza
(49, 4),  -- Cuidado Personal, Cuidado Personal y Belleza
(50, 4),  -- Productos para el Cabello, Cuidado Personal y Belleza
(51, 4),  -- Productos para la Piel, Cuidado Personal y Belleza
(55, 4),  -- Cuidado del Bebé, Cuidado Personal y Belleza
(58, 8),  -- Juguetes, Juguetes y Juegos
(59, 8),  -- Juguetes Educativos, Juguetes y Juegos
(62, 6),  -- Deportes y Aire Libre, Deportes y Aire Libre
(63, 6),  -- Equipos Deportivos, Deportes y Aire Libre
(65, 6),  -- Ropa de Camping, Deportes y Aire Libre
(66, 6),  -- Accesorios de Pesca, Deportes y Aire Libre
(67, 6),  -- Automotriz, Deportes y Aire Libre
(68, 6),  -- Herramientas para Automóviles, Deportes y Aire Libre
(69, 9),  -- Libros y Papelería, Libros y Papelería
(70, 9),  -- Libros, Libros y Papelería
(71, 9),  -- Ficción, Libros y Papelería
(72, 9),  -- No Ficción, Libros y Papelería
(73, 9),  -- Material de Oficina, Libros y Papelería
(74, 7),  -- Papelería, Productos para Mascotas
(75, 7),  -- Alimentos para Mascotas, Productos para Mascotas
(76, 7),  -- Accesorios para Mascotas, Productos para Mascotas
(77, 7),  -- Juguetes para Mascotas, Productos para Mascotas
(78, 8);  -- Juguetes para Bebés, Juguetes y Juegos


INSERT INTO `customer_type` (`name`, `description`, `customer_type_discount`) VALUES
('Empleado', 'Descuento de Empleados.', 15),   -- Empleado, descuento del 15%
('Cliente Regular', 'Compras regulares.', 0),  -- Cliente Regular, sin descuento
('Cliente VIP', 'Compradores frecuentes que disfrutan de beneficios exclusivos.', 5); -- Cliente VIP, descuento del 5%

INSERT INTO `customer_interests` (`customer_id`, `interest_id`) VALUES
  (1, 1),  -- John Doe (jdoe) tiene interés en Electrónica
  (1, 5),  -- John Doe (jdoe) tiene interés en Alimentos y Bebidas
  (1, 14), -- John Doe (jdoe) tiene interés en Televisores y Audio (subcategoría de Electrónica)
  (2, 2),  -- Alice Smith (asmith) tiene interés en Ropa y Moda
  (2, 16), -- Alice Smith (asmith) tiene interés en Ropa para Hombres (subcategoría de Ropa y Moda)
  (3, 3),  -- Mike Brown (mbrown) tiene interés en Hogar y Muebles
  (3, 21), -- Mike Brown (mbrown) tiene interés en Muebles para el Hogar (subcategoría de Hogar y Muebles)
  (4, 4),  -- Jane White (jwhite) tiene interés en Cuidado Personal y Belleza
  (4, 24), -- Jane White (jwhite) tiene interés en Cosméticos y Maquillaje (subcategoría de Cuidado Personal y Belleza)
  (5, 6),  -- Tony Lee (tlee) tiene interés en Deportes y Aire Libre
  (5, 30), -- Tony Lee (tlee) tiene interés en Equipamiento Deportivo (subcategoría de Deportes y Aire Libre)
  (6, 2),  -- Kathy Chan (kchan) tiene interés en Ropa y Moda
  (6, 17), -- Kathy Chan (kchan) tiene interés en Ropa para Mujeres (subcategoría de Ropa y Moda)
  (7, 8),  -- Paul Moore (pmoore) tiene interés en Juguetes y Juegos
  (7, 36), -- Paul Moore (pmoore) tiene interés en Juguetes Educativos (subcategoría de Juguetes y Juegos)
  (8, 9),  -- Betty Thompson (bthompson) tiene interés en Libros y Papelería
  (8, 39), -- Betty Thompson (bthompson) tiene interés en Libros (subcategoría de Libros y Papelería)
  (9, 5),  -- Rachel Jones (rjones) tiene interés en Alimentos y Bebidas
  (9, 27), -- Rachel Jones (rjones) tiene interés en Comida Fresca (subcategoría de Alimentos y Bebidas)
  (10, 7), -- Michael Clark (mclark) tiene interés en Productos para Mascotas
  (10, 33), -- Michael Clark (mclark) tiene interés en Alimentos para Mascotas (subcategoría de Productos para Mascotas)
  (11, 3), -- José López (jlopez) tiene interés en Hogar y Muebles
  (11, 22), -- José López (jlopez) tiene interés en Decoración y Artículos de Limpieza (subcategoría de Hogar y Muebles)
  (12, 4), -- Ana Méndez (asmendez) tiene interés en Cuidado Personal y Belleza
  (12, 25), -- Ana Méndez (asmendez) tiene interés en Productos para el Cuidado de la Piel (subcategoría de Cuidado Personal y Belleza)
  (13, 6), -- Miguel García (mgarcia) tiene interés en Deportes y Aire Libre
  (13, 31), -- Miguel García (mgarcia) tiene interés en Ropa de Camping (subcategoría de Deportes y Aire Libre)
  (14, 10), -- Juana Martínez (jmartinez) tiene interés en Salud y Bienestar
  (14, 42), -- Juana Martínez (jmartinez) tiene interés en Suplementos y Vitaminas (subcategoría de Salud y Bienestar)
  (15, 11), -- Tomas Parra (tparra) tiene interés en Ofertas
  (15, 45), -- Tomas Parra (tparra) tiene interés en Ofertas Semanales (subcategoría de Ofertas)
  (16, 12), -- Karina Ramírez (kramirez) tiene interés en Eventos Especiales
  (16, 48), -- Karina Ramírez (kramirez) tiene interés en Buen Fin (subcategoría de Eventos Especiales)
  (17, 13), -- Pablo Castillo (pcastillo) tiene interés en Tendencias y Novedades
  (17, 51), -- Pablo Castillo (pcastillo) tiene interés en Nuevos Lanzamientos (subcategoría de Tendencias y Novedades)
  (18, 9),  -- Beatriz Fernández (bfernandez) tiene interés en Libros y Papelería
  (18, 40), -- Beatriz Fernández (bfernandez) tiene interés en Material de Oficina (subcategoría de Libros y Papelería)
  (19, 2),  -- Roberto Ortiz (rortiz) tiene interés en Ropa y Moda
  (19, 20), -- Roberto Ortiz (rortiz) tiene interés en Accesorios de Moda (subcategoría de Ropa y Moda)
  (20, 5),  -- María Ramírez (mramirez) tiene interés en Alimentos y Bebidas
  (20, 29); -- María Ramírez (mramirez) tiene interés en Snacks y Golosinas (subcategoría de Alimentos y Bebidas)
  
  
  
  INSERT INTO `payment_method` (`name`, `description`) VALUES
('Tarjeta de Crédito', 'Pago mediante tarjeta de crédito.'),
('Tarjeta de Débito', 'Pago mediante tarjeta de débito vinculada a una cuenta bancaria.'),
('PayPal', 'Pago mediante la plataforma PayPal, rápida y segura.'),
('Transferencia Bancaria', 'Pago realizado mediante transferencia desde una cuenta bancaria.'),
('Efectivo', 'Pago en efectivo al momento de recibir el producto o servicio.');


INSERT INTO customer_payment_method (customer_payment_method_id, customer_id, payment_method_id, creditcard)
VALUES
(UNHEX('299B2170A93411EF893F0242AC120002'), 1, 1, UNHEX('4111111111111111')),
(UNHEX('299FC37AA93411EF893F0242AC120002'), 2, 2, UNHEX('5105105105105100')),
(UNHEX('299FC86EA93411EF893F0242AC120002'), 3, 3, NULL),
(UNHEX('299FCD8EA93411EF893F0242AC120002'), 4, 4, NULL),
(UNHEX('299FD23CA93411EF893F0242AC120002'), 5, 5, UNHEX('4111111111111111')),
(UNHEX('299FD8AEA93411EF893F0242AC120002'), 6, 1, UNHEX('5105105105105100')),
(UNHEX('299FDD96A93411EF893F0242AC120002'), 7, 2, UNHEX('4111111111111111')),
(UNHEX('299FE2BBA93411EF893F0242AC120002'), 8, 3, NULL),
(UNHEX('299FE763A93411EF893F0242AC120002'), 9, 4, NULL),
(UNHEX('299FEA6CA93411EF893F0242AC120002'), 10, 5, UNHEX('5105105105105100')),
(UNHEX('299FED62A93411EF893F0242AC120002'), 11, 1, UNHEX('4111111111111111')),
(UNHEX('299FF03BA93411EF893F0242AC120002'), 12, 2, UNHEX('5105105105105100')),
(UNHEX('299FF30EA93411EF893F0242AC120002'), 13, 3, NULL),
(UNHEX('299FF5DCA93411EF893F0242AC120002'), 14, 4, NULL),
(UNHEX('299FF8AEA93411EF893F0242AC120002'), 15, 5, UNHEX('4111111111111111')),
(UNHEX('299FFE8AA93411EF893F0242AC120002'), 16, 1, UNHEX('5105105105105100')),
(UNHEX('29A001EAA93411EF893F0242AC120002'), 17, 2, UNHEX('4111111111111111')),
(UNHEX('29A004C3A93411EF893F0242AC120002'), 18, 3, NULL),
(UNHEX('29A007E8A93411EF893F0242AC120002'), 19, 4, NULL),
(UNHEX('29A00C04A93411EF893F0242AC120002'), 20, 5, UNHEX('5105105105105100'));


INSERT INTO items (item_id, item_name, item_description, item_stock, item_price, item_discount, department_id)
VALUES
(UNHEX('739C9E46A93411EF893F0242AC120002'), 'Smartphone Galaxy', 'Teléfono inteligente con pantalla AMOLED y cámara de 108MP', 50, 999.99, 10.00, 1),
(UNHEX('739CABD0A93411EF893F0242AC120002'), 'Laptop HP', 'Portátil con procesador i7 y 16GB RAM', 30, 1299.99, 5.00, 1),
(UNHEX('739CB056A93411EF893F0242AC120002'), 'Tablet Samsung', 'Tablet con pantalla de 10 pulgadas y 64GB de almacenamiento', 70, 349.99, 0.00, 1),
(UNHEX('739CB4F3A93411EF893F0242AC120002'), 'Auriculares Sony', 'Auriculares inalámbricos con cancelación de ruido', 100, 149.99, 20.00, 1),
(UNHEX('739CBC42A93411EF893F0242AC120002'), 'Jeans Levi\'s', 'Pantalones vaqueros de corte regular', 200, 59.99, 15.00, 2),
(UNHEX('739CBF31A93411EF893F0242AC120002'), 'Camisa Polo', 'Camisa de algodón para hombre, talla L', 150, 39.99, 10.00, 2),
(UNHEX('739CC1BAA93411EF893F0242AC120002'), 'Chaqueta de Cuero', 'Chaqueta de cuero para hombre, talla M', 80, 199.99, 5.00, 2),
(UNHEX('739CC432A93411EF893F0242AC120002'), 'Vestido de Noche', 'Vestido de noche largo para mujer, color negro', 50, 129.99, 10.00, 2),
(UNHEX('739CC6C5A93411EF893F0242AC120002'), 'Sofá reclinable', 'Sofá cómodo con reclinación manual', 20, 499.99, 20.00, 3),
(UNHEX('739CC93DA93411EF893F0242AC120002'), 'Mesa de comedor', 'Mesa de madera para 6 personas', 15, 299.99, 10.00, 3),
(UNHEX('739CCBAFA93411EF893F0242AC120002'), 'Lámpara de Escritorio', 'Lámpara LED regulable para oficina', 50, 39.99, 0.00, 3),
(UNHEX('739CCE38A93411EF893F0242AC120002'), 'Estante para Libros', 'Estante de madera para libros y decoraciones', 40, 79.99, 5.00, 3),
(UNHEX('739CD0BFA93411EF893F0242AC120002'), 'Shampoo Pantene', 'Shampoo nutritivo para cabello seco', 100, 8.99, 5.00, 4),
(UNHEX('739CD343A93411EF893F0242AC120002'), 'Crema Nivea', 'Crema hidratante para piel seca', 120, 12.50, 0.00, 4),
(UNHEX('739CD5C6A93411EF893F0242AC120002'), 'Gel de Baño Dove', 'Gel de baño suave y cremoso', 90, 6.99, 0.00, 4),
(UNHEX('739CD840A93411EF893F0242AC120002'), 'Rímel Maybelline', 'Máscara de pestañas voluminosas', 80, 12.99, 5.00, 4),
(UNHEX('739CDAC2A93411EF893F0242AC120002'), 'Cerveza Corona', 'Paquete de 6 cervezas Corona', 200, 9.99, 10.00, 5),
(UNHEX('739CDD44A93411EF893F0242AC120002'), 'Jugo de Naranja', 'Jugo 100% natural de naranja, sin azúcar', 150, 3.50, 5.00, 5),
(UNHEX('739CE191A93411EF893F0242AC120002'), 'Café Lavazza', 'Café en grano de origen italiano', 100, 15.99, 0.00, 5),
(UNHEX('739CE433A93411EF893F0242AC120002'), 'Agua Mineral Evian', 'Botella de 1 litro de agua mineral', 250, 1.99, 0.00, 5),
(UNHEX('739CE6BFA93411EF893F0242AC120002'), 'Raqueta de Tenis Wilson', 'Raqueta ligera para tenis profesional', 40, 129.99, 10.00, 6),
(UNHEX('739CE952A93411EF893F0242AC120002'), 'Bicicleta de Montaña', 'Bicicleta para aventuras al aire libre', 30, 399.99, 15.00, 6),
(UNHEX('739CED11A93411EF893F0242AC120002'), 'Pelota de Fútbol', 'Pelota oficial de fútbol para jugar en césped', 100, 19.99, 5.00, 6),
(UNHEX('739CEFC9A93411EF893F0242AC120002'), 'Kit de Pesca', 'Kit completo de pesca con caña, carrete y accesorios', 50, 69.99, 0.00, 6),
(UNHEX('739CF262A93411EF893F0242AC120002'), 'Juguete de Construcción', 'Juguete de bloques para niños mayores de 6 años', 150, 19.99, 5.00, 8),
(UNHEX('739CF4DFA93411EF893F0242AC120002'), 'Muñeca Barbie', 'Muñeca con accesorios y ropa de moda', 200, 24.99, 10.00, 8),
(UNHEX('739CF74CA93411EF893F0242AC120002'), 'Rompecabezas 500 Piezas', 'Rompecabezas desafiante para toda la familia', 80, 9.99, 5.00, 8),
(UNHEX('739CF9BCA93411EF893F0242AC120002'), 'Juguete de Peluche', 'Peluche de oso grande para niños', 120, 15.99, 10.00, 8);



  
  CALL sp_insert_sales_from_json('{
  "sales": [
    {
      "customer_payment_method_id": "299FF30EA93411EF893F0242AC120002", 
      "customer_type_discount": 0.00,
      "items": [
        {
          "item_id": "739CCE38A93411EF893F0242AC120002", 
          "quantity": 1, 
          "item_price": 79.99, 
          "item_discount": 5.00
        },
        {
          "item_id": "739CF74CA93411EF893F0242AC120002", 
          "quantity": 2, 
          "item_price": 24.99, 
          "item_discount": 10.00
        }
      ]
    }
  ]
}');   


