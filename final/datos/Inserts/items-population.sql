INSERT INTO `items` (`item_id`, `item_name`, `item_description`, `item_stock`, `item_price`, `item_discount`, `department_id`) VALUES
  (UUID_TO_BIN(UUID()), 'Smartphone Galaxy', 'Teléfono inteligente con pantalla AMOLED y cámara de 108MP', 50, 999.99, 10.00, 1),  -- Electrónica
  (UUID_TO_BIN(UUID()), 'Laptop HP', 'Portátil con procesador i7 y 16GB RAM', 30, 1299.99, 5.00, 1),  -- Electrónica
  (UUID_TO_BIN(UUID()), 'Tablet Samsung', 'Tablet con pantalla de 10 pulgadas y 64GB de almacenamiento', 70, 349.99, 0.00, 1),  -- Electrónica
  (UUID_TO_BIN(UUID()), 'Auriculares Sony', 'Auriculares inalámbricos con cancelación de ruido', 100, 149.99, 20.00, 1),  -- Electrónica
  
  (UUID_TO_BIN(UUID()), 'Jeans Levi\'s', 'Pantalones vaqueros de corte regular', 200, 59.99, 15.00, 2),  -- Ropa y Moda
  (UUID_TO_BIN(UUID()), 'Camisa Polo', 'Camisa de algodón para hombre, talla L', 150, 39.99, 10.00, 2),  -- Ropa y Moda
  (UUID_TO_BIN(UUID()), 'Chaqueta de Cuero', 'Chaqueta de cuero para hombre, talla M', 80, 199.99, 5.00, 2),  -- Ropa y Moda
  (UUID_TO_BIN(UUID()), 'Vestido de Noche', 'Vestido de noche largo para mujer, color negro', 50, 129.99, 10.00, 2),  -- Ropa y Moda
  
  (UUID_TO_BIN(UUID()), 'Sofá reclinable', 'Sofá cómodo con reclinación manual', 20, 499.99, 20.00, 3),  -- Hogar y Muebles
  (UUID_TO_BIN(UUID()), 'Mesa de comedor', 'Mesa de madera para 6 personas', 15, 299.99, 10.00, 3),  -- Hogar y Muebles
  (UUID_TO_BIN(UUID()), 'Lámpara de Escritorio', 'Lámpara LED regulable para oficina', 50, 39.99, 0.00, 3),  -- Hogar y Muebles
  (UUID_TO_BIN(UUID()), 'Estante para Libros', 'Estante de madera para libros y decoraciones', 40, 79.99, 5.00, 3),  -- Hogar y Muebles
  
  (UUID_TO_BIN(UUID()), 'Shampoo Pantene', 'Shampoo nutritivo para cabello seco', 100, 8.99, 5.00, 4),  -- Cuidado Personal y Belleza
  (UUID_TO_BIN(UUID()), 'Crema Nivea', 'Crema hidratante para piel seca', 120, 12.50, 0.00, 4),  -- Cuidado Personal y Belleza
  (UUID_TO_BIN(UUID()), 'Gel de Baño Dove', 'Gel de baño suave y cremoso', 90, 6.99, 0.00, 4),  -- Cuidado Personal y Belleza
  (UUID_TO_BIN(UUID()), 'Rímel Maybelline', 'Máscara de pestañas voluminosas', 80, 12.99, 5.00, 4),  -- Cuidado Personal y Belleza
  
  (UUID_TO_BIN(UUID()), 'Cerveza Corona', 'Paquete de 6 cervezas Corona', 200, 9.99, 10.00, 5),  -- Alimentos y Bebidas
  (UUID_TO_BIN(UUID()), 'Jugo de Naranja', 'Jugo 100% natural de naranja, sin azúcar', 150, 3.50, 5.00, 5),  -- Alimentos y Bebidas
  (UUID_TO_BIN(UUID()), 'Café Lavazza', 'Café en grano de origen italiano', 100, 15.99, 0.00, 5),  -- Alimentos y Bebidas
  (UUID_TO_BIN(UUID()), 'Agua Mineral Evian', 'Botella de 1 litro de agua mineral', 250, 1.99, 0.00, 5),  -- Alimentos y Bebidas
  
  (UUID_TO_BIN(UUID()), 'Raqueta de Tenis Wilson', 'Raqueta ligera para tenis profesional', 40, 129.99, 10.00, 6),  -- Deportes y Aire Libre
  (UUID_TO_BIN(UUID()), 'Bicicleta de Montaña', 'Bicicleta para aventuras al aire libre', 30, 399.99, 15.00, 6),  -- Deportes y Aire Libre
  (UUID_TO_BIN(UUID()), 'Pelota de Fútbol', 'Pelota oficial de fútbol para jugar en césped', 100, 19.99, 5.00, 6),  -- Deportes y Aire Libre
  (UUID_TO_BIN(UUID()), 'Kit de Pesca', 'Kit completo de pesca con caña, carrete y accesorios', 50, 69.99, 0.00, 6),  -- Deportes y Aire Libre
  
  (UUID_TO_BIN(UUID()), 'Juguete de Construcción', 'Juguete de bloques para niños mayores de 6 años', 150, 19.99, 5.00, 8),  -- Juguetes y Juegos
  (UUID_TO_BIN(UUID()), 'Muñeca Barbie', 'Muñeca con accesorios y ropa de moda', 200, 24.99, 10.00, 8),  -- Juguetes y Juegos
  (UUID_TO_BIN(UUID()), 'Rompecabezas 500 Piezas', 'Rompecabezas desafiante para toda la familia', 80, 9.99, 5.00, 8),  -- Juguetes y Juegos
  (UUID_TO_BIN(UUID()), 'Juguete de Peluche', 'Peluche de oso grande para niños', 120, 15.99, 10.00, 8);  -- Juguetes y Juegos
