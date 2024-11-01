CREATE DATABASE  IF NOT EXISTS `michangarro` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `michangarro`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: michangarro
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` varbinary(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `birth_date` date NOT NULL,
  `customer_type_id` smallint unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `customer_type_id` (`customer_type_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`customer_type_id`) REFERENCES `customer_type` (`customer_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_interests`
--

DROP TABLE IF EXISTS `customer_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_interests` (
  `customer_id` int unsigned NOT NULL,
  `interest_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`customer_id`,`interest_id`),
  KEY `interest_id` (`interest_id`),
  CONSTRAINT `customer_interests_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `customer_interests_ibfk_2` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_interests`
--

LOCK TABLES `customer_interests` WRITE;
/*!40000 ALTER TABLE `customer_interests` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_payment_method`
--

DROP TABLE IF EXISTS `customer_payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_payment_method`
--

LOCK TABLES `customer_payment_method` WRITE;
/*!40000 ALTER TABLE `customer_payment_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_type`
--

DROP TABLE IF EXISTS `customer_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_type` (
  `customer_type_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `customer_type_discount` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`customer_type_id`),
  CONSTRAINT `customer_type_chk_1` CHECK (((`customer_type_discount` >= 0) and (`customer_type_discount` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_type`
--

LOCK TABLES `customer_type` WRITE;
/*!40000 ALTER TABLE `customer_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_closure`
--

DROP TABLE IF EXISTS `department_closure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_closure` (
  `ancestor` smallint unsigned NOT NULL,
  `descendant` smallint unsigned NOT NULL,
  `depth` int DEFAULT NULL,
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `descendant` (`descendant`),
  CONSTRAINT `department_closure_ibfk_1` FOREIGN KEY (`ancestor`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `department_closure_ibfk_2` FOREIGN KEY (`descendant`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_closure`
--

LOCK TABLES `department_closure` WRITE;
/*!40000 ALTER TABLE `department_closure` DISABLE KEYS */;
INSERT INTO `department_closure` VALUES (1,1,0),(1,2,1),(1,6,1),(1,10,1),(1,13,1),(1,16,1),(1,20,1),(2,3,2),(2,4,2),(2,5,2),(6,7,2),(6,8,2),(6,9,2),(10,11,2),(10,12,2),(13,14,2),(13,15,2),(16,17,2),(16,18,2),(16,19,2),(20,21,2),(20,22,2),(23,23,0),(23,24,1),(23,27,1),(23,30,1),(24,25,2),(24,26,2),(27,28,2),(27,29,2),(31,31,0),(31,32,1),(31,36,1),(31,37,1),(31,40,1),(32,33,2),(32,34,2),(32,35,2),(37,38,2),(37,39,2),(40,41,2),(40,42,2),(43,43,0),(43,44,1),(43,45,1),(45,46,2),(45,47,2),(48,48,0),(48,49,1),(48,52,1),(48,55,1),(49,50,2),(49,51,2),(52,53,2),(52,54,2),(55,56,2),(55,57,2),(58,58,0),(58,59,1),(58,60,1),(58,61,1),(62,62,0),(62,63,1),(62,64,1),(62,65,1),(66,66,0),(66,67,1),(66,68,1),(69,69,0),(69,70,1),(69,73,1),(69,74,1),(70,71,2),(70,72,2),(75,75,0),(75,76,1),(75,77,1),(75,78,1);
/*!40000 ALTER TABLE `department_closure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_interests`
--

DROP TABLE IF EXISTS `department_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_interests` (
  `department_id` smallint unsigned NOT NULL,
  `interest_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`department_id`,`interest_id`),
  KEY `fk_interest` (`interest_id`),
  CONSTRAINT `fk_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_interest` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`interest_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_interests`
--

LOCK TABLES `department_interests` WRITE;
/*!40000 ALTER TABLE `department_interests` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Electrónicos','Todo lo relacionado con tecnología y dispositivos electrónicos.'),(2,'Electrodomésticos','Electrodomésticos para el hogar.'),(3,'Cocinas','Cocinas para preparar alimentos.'),(4,'Refrigeradores','Refrigeradores para conservar alimentos.'),(5,'Lavadoras','Lavadoras para el cuidado de la ropa.'),(6,'Tecnología Móvil','Dispositivos móviles y accesorios.'),(7,'Teléfonos','Teléfonos móviles de diversas marcas.'),(8,'Tabletas','Tabletas para entretenimiento y trabajo.'),(9,'Accesorios Móviles','Fundas, cargadores y otros accesorios móviles.'),(10,'Electrónica de Consumo','Gadgets y dispositivos electrónicos para uso diario.'),(11,'Televisores','Televisores de diferentes tamaños y tecnologías.'),(12,'Audio y Video','Equipos de audio y video para entretenimiento.'),(13,'Cámaras y Fotografía','Cámaras y accesorios para la fotografía.'),(14,'Cámaras Digitales','Cámaras digitales para capturar momentos.'),(15,'Accesorios de Fotografía','Lentes, trípodes y otros accesorios fotográficos.'),(16,'Videojuegos','Consolas y videojuegos de diversas plataformas.'),(17,'Consolas','Consolas de videojuegos populares.'),(18,'Juegos','Juegos para diferentes consolas y plataformas.'),(19,'Accesorios para Videojuegos','Controles, headsets y otros accesorios.'),(20,'Música','Instrumentos musicales y equipos de audio.'),(21,'Instrumentos Musicales','Instrumentos para músicos de todos los niveles.'),(22,'Equipos de Audio','Altavoces y sistemas de sonido.'),(23,'Ropa','Vestimenta para hombres, mujeres y niños.'),(24,'Ropa Deportiva','Vestimenta especializada para actividades deportivas.'),(25,'Calzado Deportivo','Calzado diseñado para el deporte.'),(26,'Accesorios Deportivos','Artículos complementarios para deportes.'),(27,'Ropa Casual','Vestimenta informal para el día a día.'),(28,'Vestidos','Vestidos para diferentes ocasiones.'),(29,'Camisetas','Camisetas para hombres, mujeres y niños.'),(30,'Accesorios de Moda','Bolsos, joyas y otros complementos.'),(31,'Hogar y Muebles','Muebles y artículos para el hogar.'),(32,'Muebles','Muebles de diversas categorías.'),(33,'Sofás','Sofás y sillones para la sala.'),(34,'Mesas','Mesas de comedor y de centro.'),(35,'Sillas','Sillas para diferentes usos.'),(36,'Artículos de Limpieza','Productos de limpieza para el hogar.'),(37,'Jardinería','Plantas y herramientas para el jardín.'),(38,'Plantas','Plantas decorativas y de interior.'),(39,'Herramientas de Jardín','Herramientas para cuidar el jardín.'),(40,'Cocina','Utensilios y accesorios para la cocina.'),(41,'Utensilios','Utensilios esenciales para cocinar.'),(42,'Electrodomésticos de Cocina','Electrodomésticos para facilitar la cocina.'),(43,'Alimentos y Bebidas','Productos alimenticios y bebidas.'),(44,'Alimentos Frescos','Frutas y verduras frescas.'),(45,'Bebidas','Bebidas alcohólicas y no alcohólicas.'),(46,'Bebidas Alcohólicas','Bebidas con contenido Alcohólico'),(47,'Bebidas No Alcohólicas','Bebidas sin alcohol'),(48,'Salud y Belleza','Productos de cuidado personal y belleza.'),(49,'Cuidado Personal','Artículos para la higiene y el cuidado personal.'),(50,'Productos para el Cabello','Champús, acondicionadores y tratamientos.'),(51,'Productos para la Piel','Cremas y lociones para el cuidado de la piel.'),(52,'Salud y Bienestar','Suplementos y productos de bienestar.'),(53,'Suplementos','Suplementos de Salud'),(54,'Productos Naturales','Productos Naturistas'),(55,'Cuidado del Bebé','Productos y accesorios para bebés.'),(56,'Alimentos para Bebés','Comida y fórmulas para bebés.'),(57,'Accesorios para Bebés','Artículos para la comodidad de los bebés.'),(58,'Juguetes','Juguetes y juegos para niños.'),(59,'Juguetes Educativos','Juguetes que fomentan el aprendizaje.'),(60,'Juguetes para Bebés','Juguetes diseñados para los más pequeños.'),(61,'Juguetes de Construcción','Juguetes que estimulan la creatividad.'),(62,'Deportes y Aire Libre','Equipamiento deportivo y artículos para actividades al aire libre.'),(63,'Equipos Deportivos','Equipamiento para diversos deportes.'),(64,'Ropa de Camping','Vestimenta adecuada para actividades al aire libre.'),(65,'Accesorios de Pesca','Artículos para la pesca recreativa.'),(66,'Automotriz','Accesorios y productos para automóviles.'),(67,'Accesorios para Automóviles','Artículos para mejorar la experiencia automotriz.'),(68,'Herramientas para Automóviles','Herramientas para el mantenimiento de vehículos.'),(69,'Libros y Papelería','Libros, material de oficina y artículos de papelería.'),(70,'Libros','Libros de diferentes géneros.'),(71,'Ficción','Novelas y cuentos de ficción.'),(72,'No Ficción','Libros de historia, biografías y más.'),(73,'Material de Oficina','Artículos para el trabajo en oficina.'),(74,'Papelería','Útiles escolares y de oficina.'),(75,'Productos para Mascotas','Alimentos y accesorios para mascotas.'),(76,'Alimentos para Mascotas','Comida para perros, gatos y otros animales.'),(77,'Accesorios para Mascotas','Juguetes y accesorios para el cuidado de mascotas.'),(78,'Juguetes para Mascotas','Juguetes diseñados para entretener a las mascotas.');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interests`
--

DROP TABLE IF EXISTS `interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interests` (
  `interest_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_interest_id` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`interest_id`),
  KEY `fk_parent_interest` (`parent_interest_id`),
  CONSTRAINT `fk_parent_interest` FOREIGN KEY (`parent_interest_id`) REFERENCES `interests` (`interest_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interests`
--

LOCK TABLES `interests` WRITE;
/*!40000 ALTER TABLE `interests` DISABLE KEYS */;
INSERT INTO `interests` VALUES (1,'Electrónica','Gadgets y dispositivos',NULL),(2,'Ropa y Moda','Vestimenta y accesorios',NULL),(3,'Hogar y Muebles','Artículos para el hogar',NULL),(4,'Cuidado Personal y Belleza','Productos de belleza y cuidado personal',NULL),(5,'Alimentos y Bebidas','Comida y bebidas',NULL),(6,'Deportes y Aire Libre','Equipamiento y ropa para actividades al aire libre',NULL),(7,'Productos para Mascotas','Alimentos y accesorios para mascotas',NULL),(8,'Juguetes y Juegos','Artículos de entretenimiento para niños',NULL),(9,'Libros y Papelería','Material de lectura y oficina',NULL),(10,'Salud y Bienestar','Productos para mejorar la salud',NULL),(11,'Ofertas','Promociones y descuentos especiales',NULL),(12,'Eventos Especiales','Ofertas en ocasiones especiales',NULL),(13,'Tendencias y Novedades','Nuevos productos y tendencias del mercado',NULL),(14,'Televisores y Audio','Dispositivos de entretenimiento',1),(15,'Tecnología Móvil','Teléfonos y accesorios móviles',1),(16,'Ropa para Hombres','Ropa diseñada para hombres',2),(17,'Ropa para Mujeres','Ropa diseñada para mujeres',2),(18,'Ropa para Niños','Ropa diseñada para niños',2),(19,'Ropa Deportiva','Vestimenta para actividades deportivas',2),(20,'Accesorios de Moda','Complementos de vestimenta',2),(21,'Muebles para el Hogar','Muebles de diversas categorías',3),(22,'Decoración y Artículos de Limpieza','Elementos decorativos y de limpieza',3),(23,'Herramientas de Jardinería','Herramientas y accesorios para el jardín',3),(24,'Cosméticos y Maquillaje','Productos para el rostro y cuerpo',4),(25,'Productos para el Cuidado de la Piel','Cremas y lociones para la piel',4),(26,'Artículos de Higiene Personal','Productos para la higiene diaria',4),(27,'Comida Fresca','Frutas y verduras frescas',5),(28,'Productos Gourmet','Alimentos de alta calidad',5),(29,'Snacks y Golosinas','Aperitivos y dulces',5),(30,'Equipamiento Deportivo','Artículos para diversos deportes',6),(31,'Ropa de Camping','Vestimenta adecuada para actividades al aire libre',6),(32,'Accesorios para Actividades al Aire Libre','Equipos complementarios para actividades al aire libre',6),(33,'Alimentos para Mascotas','Comida para perros, gatos y otros animales',7),(34,'Juguetes y Accesorios','Artículos para el entretenimiento de mascotas',7),(35,'Cuidado y Salud de Mascotas','Productos para la salud de las mascotas',7),(36,'Juguetes Educativos','Juguetes que fomentan el aprendizaje',8),(37,'Juegos de Mesa y Video','Diversión para toda la familia',8),(38,'Artículos para Fiestas','Decoraciones y juegos para celebraciones',8),(39,'Libros','Literatura de diversos géneros',9),(40,'Material de Oficina','Artículos para el trabajo en oficina',9),(41,'Artículos Escolares','Útiles escolares para estudiantes',9),(42,'Suplementos y Vitaminas','Productos para complementar la dieta',10),(43,'Productos de Fitness','Equipos y artículos para ejercicio',10),(44,'Equipos de Salud y Cuidado','Dispositivos para el monitoreo de salud',10),(45,'Ofertas Semanales','Descuentos que cambian semanalmente',11),(46,'Descuentos por Temporada','Promociones específicas de temporada',11),(47,'Programas de Lealtad','Beneficios para clientes frecuentes',11),(48,'Buen Fin','Promociones especiales en el fin de semana largo',12),(49,'Ofertas de Regreso a Clases','Descuentos en productos escolares',12),(50,'Ventas de Temporada','Ofertas por festividades y estaciones',12),(51,'Nuevos Lanzamientos','Productos recién disponibles en el mercado',13),(52,'Tendencias de Moda','Lo último en moda y estilo',13),(53,'Innovaciones en Tecnología','Avances en tecnología y gadgets',13);
/*!40000 ALTER TABLE `interests` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tr_check_interest_before_insert` BEFORE INSERT ON `interests` FOR EACH ROW BEGIN
    DECLARE cycle_detected BOOLEAN;

    -- Llamar a la función fn_check_interest_cycle
    SET cycle_detected = fn_check_interest_cycle(NEW.parent_interest_id, NEW.interest_id);

    IF cycle_detected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ciclo detectado en la jerarquía de intereses.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tr_check_interest_before_update` BEFORE UPDATE ON `interests` FOR EACH ROW BEGIN
    DECLARE cycle_detected BOOLEAN;

    -- Llamar a la función check_interest_cycle
    SET cycle_detected = fn_check_interest_cycle(NEW.parent_interest_id, NEW.interest_id);

    IF cycle_detected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ciclo detectado en la jerarquía de intereses.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method` (
  `payment_method_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sold_items`
--

DROP TABLE IF EXISTS `sold_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sold_items`
--

LOCK TABLES `sold_items` WRITE;
/*!40000 ALTER TABLE `sold_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sold_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_departments`
--

DROP TABLE IF EXISTS `v_departments`;
/*!50001 DROP VIEW IF EXISTS `v_departments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_departments` AS SELECT 
 1 AS `department_id`,
 1 AS `department_name`,
 1 AS `department_description`,
 1 AS `subdepartment_id`,
 1 AS `subdepartment_name`,
 1 AS `subdepartment_description`,
 1 AS `depth`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_interests`
--

DROP TABLE IF EXISTS `v_interests`;
/*!50001 DROP VIEW IF EXISTS `v_interests`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_interests` AS SELECT 
 1 AS `interest_id`,
 1 AS `interest_name`,
 1 AS `description`,
 1 AS `parent_name`,
 1 AS `parent_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'michangarro'
--

--
-- Dumping routines for database 'michangarro'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_check_interest_cycle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_check_interest_cycle`(parent_id smallint unsigned,current_id smallint unsigned) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE cycle_detected boolean DEFAULT false;
    DECLARE temp_parent_id SMALLINT UNSIGNED;

    myloop: WHILE parent_id IS NOT NULL DO
        -- Comprobar si el parent_id es igual al current_id
        IF parent_id = current_id THEN
            SET cycle_detected = true; -- Se detectó un ciclo
            LEAVE myloop; -- Salir del bucle
        END IF;

        -- Obtener el padre del current parent_id
        SELECT parent_interest_id INTO temp_parent_id FROM interests WHERE interest_id = parent_id;

        -- Actualizar parent_id para la siguiente iteración
        SET parent_id = temp_parent_id;
    END WHILE;

RETURN cycle_detected; -- Retorna 1 si hay ciclo, 0 si no
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetDepartmentBranchById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetDepartmentBranchById`(IN departmentId SMALLINT UNSIGNED)
BEGIN
    IF departmentId IS NULL THEN
        SELECT d.*
        FROM departments d;
    ELSE
        SELECT d.*, dc.depth
        FROM departments d
        JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE dc.ancestor = departmentId OR d.department_id = departmentId;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetDepartmentById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetDepartmentById`(IN departmentId SMALLINT UNSIGNED)
BEGIN
    IF departmentId IS NULL THEN
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant;
    ELSE
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE d.department_id = departmentId;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetDepartmentByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetDepartmentByName`(IN departmentName VARCHAR(100))
BEGIN
    IF departmentName IS NULL THEN
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant;
    ELSE
        SELECT d.*, dc.ancestor, dc.depth
        FROM departments d
        LEFT JOIN department_closure dc ON d.department_id = dc.descendant
        WHERE d.name LIKE CONCAT('%', departmentName, '%');
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_test_cycle_simulation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_test_cycle_simulation`(current_id SMALLINT UNSIGNED)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE cycle_detected BOOLEAN;
    DECLARE max_id SMALLINT;
    
    SELECT MAX(interest_id) INTO max_id FROM interests;
    
    -- Crear tabla temporal para almacenar resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        parent_id SMALLINT,
        cycle BOOLEAN
    );

    -- Simula un bucle con valores de ejemplo
    WHILE i < max_id DO
        SET cycle_detected = fn_check_interest_cycle(i, current_id); -- Llamada a la función
        -- Insertar el resultado en la tabla temporal
        INSERT INTO temp_results (parent_id,cycle) 
        VALUES (i, cycle_detected);
        SET i = i + 1;
    END WHILE;

    -- Mostrar resultados al final
    SELECT tr.parent_id as interest_id, i.name FROM temp_results tr 
    INNER JOIN interests i 
    ON tr.parent_id = i.interest_id
    WHERE cycle = true;

    DROP TEMPORARY TABLE IF EXISTS temp_results;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_departments`
--

/*!50001 DROP VIEW IF EXISTS `v_departments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_departments` AS select `d1`.`department_id` AS `department_id`,`d1`.`name` AS `department_name`,`d1`.`description` AS `department_description`,`d2`.`department_id` AS `subdepartment_id`,`d2`.`name` AS `subdepartment_name`,`d2`.`description` AS `subdepartment_description`,`dc`.`depth` AS `depth` from ((`departments` `d1` left join `department_closure` `dc` on((`d1`.`department_id` = `dc`.`ancestor`))) left join `departments` `d2` on((`dc`.`descendant` = `d2`.`department_id`))) order by `d1`.`department_id`,`dc`.`depth` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_interests`
--

/*!50001 DROP VIEW IF EXISTS `v_interests`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_interests` AS select `i`.`interest_id` AS `interest_id`,`i`.`name` AS `interest_name`,`i`.`description` AS `description`,`p`.`name` AS `parent_name`,`p`.`interest_id` AS `parent_id` from (`interests` `i` left join `interests` `p` on((`i`.`parent_interest_id` = `p`.`interest_id`))) where (`p`.`name` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-31 21:28:18
