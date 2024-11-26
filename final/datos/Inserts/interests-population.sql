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

