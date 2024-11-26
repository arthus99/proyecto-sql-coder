-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: michangarro
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `michangarro`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `michangarro` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `michangarro`;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` varbinary(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `birth_date` date NOT NULL,
  `customer_type_id` smallint unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  `salt` varbinary(16) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `customer_type_id` (`customer_type_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`customer_type_id`) REFERENCES `customer_type` (`customer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'jdoe',0xBBE10DF49562D66CC38171582B1A62A6F26A9FF1BCA13B15EC84D74987F7C46B,'John','Doe','jdoe@example.com','1990-01-15',1,'5551234567',0x493FF154A53F11EF88BB0242AC120002),(2,'asmith',0xD76F717C86B982AB49E9F13873DAE43729CABC6AA8969CECE87172A9344D09C5,'Alice','Smith','asmith@example.com','1985-05-22',2,'5559876543',0x4941451BA53F11EF88BB0242AC120002),(3,'mbrown',0x4CD98837CE6D7A16976857D3DB351C2635B0EE0420951CD39FC47F9108A0C547,'Mike','Brown','mbrown@example.com','1992-03-30',1,'5556543210',0x494183E2A53F11EF88BB0242AC120002),(4,'jwhite',0xACD5CE06A7F8B2F7663AE7BC801E1931B6B1ADD1D7CD51D1AC0CDF5428FE8C4D,'Jane','White','jwhite@example.com','1988-11-11',3,'5553210987',0x4941BF5AA53F11EF88BB0242AC120002),(5,'tlee',0x6AC6B16E71285BE0D96398F7E9065AFAAA686D7AF662C7BF327F9397B85B649D,'Tony','Lee','tlee@example.com','1995-07-08',1,'5557778888',0x4941FB55A53F11EF88BB0242AC120002),(6,'kchan',0x59BFAD4A8A13BF0EC4B797C4AC3318C75F13C69FE033256D4B707C676C213DD3,'Kathy','Chan','kchan@example.com','1982-12-12',2,'5552223333',0x494236BAA53F11EF88BB0242AC120002),(7,'pmoore',0x9EEC5A9168593E9CB8A4ACF1C644D4E084D447C0E83978D86A4FC98FC0223692,'Paul','Moore','pmoore@example.com','1993-02-20',1,'5555444555',0x49427459A53F11EF88BB0242AC120002),(8,'bthompson',0x5ED57877B60AB2F88F7C21010751967820D30C27818D8A43A641D437AA00573D,'Betty','Thompson','bthompson@example.com','1980-04-04',3,'5559888999',0x4942B095A53F11EF88BB0242AC120002),(9,'rjones',0x2FED0C1C22A365F7894E30C7634DE91A8617365A424C7CF3C4B22E52A56F0B6A,'Rachel','Jones','rjones@example.com','1989-09-19',2,'5550999000',0x494E17BEA53F11EF88BB0242AC120002),(10,'mclark',0x544D5F809640BCAC35409F2FBCF94FFEA10A615357C694380B4F0037E0FA5D44,'Michael','Clark','mclark@example.com','1991-06-30',1,'5552111222',0x494E587CA53F11EF88BB0242AC120002),(11,'jlopez',0xE4C92A4D8F2D9D6D7D6D2BEC78B1E9DA203575C476B6E7636C5AD79E1C8F527C,'José','López','jlopez@example.com','1990-01-15',1,'5557123456',0x494E973DA53F11EF88BB0242AC120002),(12,'asmendez',0x2378455FA76B778509FD48830DDEFBFFC3E1C283538993BB5D6BD14C27BF6128,'Ana','Méndez','asmendez@example.com','1985-05-22',2,'5553987654',0x494ED2F7A53F11EF88BB0242AC120002),(13,'mgarcia',0x5EE4AAB635B56DE0698438F5A6890BEA595D1368DFEF34752201691D40ACB7FB,'Miguel','García','mgarcia@example.com','1992-03-30',1,'5550654321',0x494F0F90A53F11EF88BB0242AC120002),(14,'jmartinez',0x5B4904FCFD1D03D5BEAB17D02654ED13BCA8899C4B3E15192813D80258F732F4,'Juana','Martínez','jmartinez@example.com','1988-11-11',3,'5557321098',0x494F4B1DA53F11EF88BB0242AC120002),(15,'tparra',0x5C57317DD4054C00D012DAFF4D1A7542A9E4E7C801E3730D07C6B417A07F5C84,'Tomas','Parra','tparra@example.com','1995-07-08',1,'5557877888',0x494F88EEA53F11EF88BB0242AC120002),(16,'kramirez',0xF665C3B0A0FEC0BB961E1BA0C806A9390E7F1B3AA213E12ED98C386CC9D17272,'Karina','Ramírez','kramirez@example.com','1982-12-12',2,'5553222333',0x494FC4EDA53F11EF88BB0242AC120002),(17,'pcastillo',0x80BED42D8B9E21768388E5EA9C3E6718E03EF21F3DB17AA116096A40AE0D30AD,'Pablo','Castillo','pcastillo@example.com','1993-02-20',1,'5554445555',0x49500382A53F11EF88BB0242AC120002),(18,'bfernandez',0x1BD436FA8226566995C58D0544410D6E158C10D4E5D992AA62CEBCD08E8EC6A0,'Beatriz','Fernández','bfernandez@example.com','1980-04-04',3,'5558889999',0x49503F8DA53F11EF88BB0242AC120002),(19,'rortiz',0xADD96FB8A35AB8B2E3824CF530121798BACF722F40A452D135A997960AD72A32,'Roberto','Ortiz','rortiz@example.com','1989-09-19',2,'5559990000',0x49507CA8A53F11EF88BB0242AC120002),(20,'mramirez',0x92858B743937EEEAAC14B7089DE96DE22C316F49A38994531EA2E5E3B58FB495,'María','Ramírez','mramirez@example.com','1991-06-30',1,'5551112222',0x4950B9AFA53F11EF88BB0242AC120002);
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
INSERT INTO `customer_interests` VALUES (1,1),(2,2),(6,2),(19,2),(3,3),(11,3),(4,4),(12,4),(1,5),(9,5),(20,5),(5,6),(13,6),(10,7),(7,8),(8,9),(18,9),(14,10),(15,11),(16,12),(17,13),(1,14),(2,16),(6,17),(19,20),(3,21),(11,22),(4,24),(12,25),(9,27),(20,29),(5,30),(13,31),(10,33),(7,36),(8,39),(18,40),(14,42),(15,45),(16,48),(17,51);
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
INSERT INTO `customer_payment_method` VALUES (0x299B2170A93411EF893F0242AC120002,1,1,0x4111111111111111),(0x299FC37AA93411EF893F0242AC120002,2,2,0x5105105105105100),(0x299FC86EA93411EF893F0242AC120002,3,3,NULL),(0x299FCD8EA93411EF893F0242AC120002,4,4,NULL),(0x299FD23CA93411EF893F0242AC120002,5,5,0x4111111111111111),(0x299FD8AEA93411EF893F0242AC120002,6,1,0x5105105105105100),(0x299FDD96A93411EF893F0242AC120002,7,2,0x4111111111111111),(0x299FE2BBA93411EF893F0242AC120002,8,3,NULL),(0x299FE763A93411EF893F0242AC120002,9,4,NULL),(0x299FEA6CA93411EF893F0242AC120002,10,5,0x5105105105105100),(0x299FED62A93411EF893F0242AC120002,11,1,0x4111111111111111),(0x299FF03BA93411EF893F0242AC120002,12,2,0x5105105105105100),(0x299FF30EA93411EF893F0242AC120002,13,3,NULL),(0x299FF5DCA93411EF893F0242AC120002,14,4,NULL),(0x299FF8AEA93411EF893F0242AC120002,15,5,0x4111111111111111),(0x299FFE8AA93411EF893F0242AC120002,16,1,0x5105105105105100),(0x29A001EAA93411EF893F0242AC120002,17,2,0x4111111111111111),(0x29A004C3A93411EF893F0242AC120002,18,3,NULL),(0x29A007E8A93411EF893F0242AC120002,19,4,NULL),(0x29A00C04A93411EF893F0242AC120002,20,5,0x5105105105105100);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_type`
--

LOCK TABLES `customer_type` WRITE;
/*!40000 ALTER TABLE `customer_type` DISABLE KEYS */;
INSERT INTO `customer_type` VALUES (1,'Empleado','Descuento de Empleados.',15.00),(2,'Cliente Regular','Compras regulares.',0.00),(3,'Cliente VIP','Compradores frecuentes que disfrutan de beneficios exclusivos.',5.00);
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
INSERT INTO `department_closure` VALUES (1,1,0),(1,2,1),(1,6,1),(1,10,1),(1,13,1),(1,16,1),(1,20,1),(2,3,2),(2,4,2),(2,5,2),(6,7,2),(6,8,2),(6,9,2),(10,11,2),(10,12,2),(13,14,2),(13,15,2),(16,17,2),(16,18,2),(16,19,2),(20,21,2),(20,22,2),(23,23,0),(23,24,1),(23,27,1),(23,30,1),(24,25,2),(24,26,2),(27,28,2),(27,29,2),(31,31,0),(31,32,1),(31,36,1),(31,37,1),(31,40,1),(32,33,2),(32,34,2),(32,35,2),(37,38,2),(37,39,2),(40,41,2),(40,42,2),(43,43,0),(43,44,1),(43,45,1),(45,46,2),(45,47,2),(48,48,0),(48,49,1),(48,52,1),(48,55,1),(49,50,2),(49,51,2),(52,53,2),(52,54,2),(55,56,2),(55,57,2),(58,58,0),(58,59,1),(58,60,1),(58,61,1),(62,62,0),(62,63,1),(62,64,1),(62,65,1),(66,66,0),(66,67,1),(66,68,1),(69,69,0),(69,70,1),(69,73,1),(69,74,1),(70,71,2),(70,72,2),(75,75,0),(75,76,1),(75,77,1),(75,78,1),(80,80,0),(80,81,1),(80,89,2),(81,81,0),(81,89,1),(87,87,0),(89,89,0);
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
INSERT INTO `department_interests` VALUES (1,1),(10,1),(23,2),(27,2),(28,2),(29,2),(2,3),(3,3),(4,3),(5,3),(31,3),(32,3),(33,3),(34,3),(35,3),(37,3),(38,3),(39,3),(40,3),(41,3),(36,4),(42,4),(48,4),(49,4),(50,4),(51,4),(55,4),(43,5),(44,5),(45,5),(62,6),(63,6),(65,6),(66,6),(67,6),(68,6),(74,7),(75,7),(76,7),(77,7),(16,8),(19,8),(58,8),(59,8),(78,8),(69,9),(70,9),(71,9),(72,9),(73,9),(20,10),(22,10),(1,14),(11,14),(12,14),(13,14),(1,15),(6,15),(7,15),(8,15),(9,15),(24,19),(25,19),(26,19),(30,20);
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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Electrónicos','Todo lo relacionado con tecnología y dispositivos electrónicos.'),(2,'Electrodomésticos','Electrodomésticos para el hogar.'),(3,'Cocinas','Cocinas para preparar alimentos.'),(4,'Refrigeradores','Refrigeradores para conservar alimentos.'),(5,'Lavadoras','Lavadoras para el cuidado de la ropa.'),(6,'Tecnología Móvil','Dispositivos móviles y accesorios.'),(7,'Teléfonos','Teléfonos móviles de diversas marcas.'),(8,'Tabletas','Tabletas para entretenimiento y trabajo.'),(9,'Accesorios Móviles','Fundas, cargadores y otros accesorios móviles.'),(10,'Electrónica de Consumo','Gadgets y dispositivos electrónicos para uso diario.'),(11,'Televisores','Televisores de diferentes tamaños y tecnologías.'),(12,'Audio y Video','Equipos de audio y video para entretenimiento.'),(13,'Cámaras y Fotografía','Cámaras y accesorios para la fotografía.'),(14,'Cámaras Digitales','Cámaras digitales para capturar momentos.'),(15,'Accesorios de Fotografía','Lentes, trípodes y otros accesorios fotográficos.'),(16,'Videojuegos','Consolas y videojuegos de diversas plataformas.'),(17,'Consolas','Consolas de videojuegos populares.'),(18,'Juegos','Juegos para diferentes consolas y plataformas.'),(19,'Accesorios para Videojuegos','Controles, headsets y otros accesorios.'),(20,'Música','Instrumentos musicales y equipos de audio.'),(21,'Instrumentos Musicales','Instrumentos para músicos de todos los niveles.'),(22,'Equipos de Audio','Altavoces y sistemas de sonido.'),(23,'Ropa','Vestimenta para hombres, mujeres y niños.'),(24,'Ropa Deportiva','Vestimenta especializada para actividades deportivas.'),(25,'Calzado Deportivo','Calzado diseñado para el deporte.'),(26,'Accesorios Deportivos','Artículos complementarios para deportes.'),(27,'Ropa Casual','Vestimenta informal para el día a día.'),(28,'Vestidos','Vestidos para diferentes ocasiones.'),(29,'Camisetas','Camisetas para hombres, mujeres y niños.'),(30,'Accesorios de Moda','Bolsos, joyas y otros complementos.'),(31,'Hogar y Muebles','Muebles y artículos para el hogar.'),(32,'Muebles','Muebles de diversas categorías.'),(33,'Sofás','Sofás y sillones para la sala.'),(34,'Mesas','Mesas de comedor y de centro.'),(35,'Sillas','Sillas para diferentes usos.'),(36,'Artículos de Limpieza','Productos de limpieza para el hogar.'),(37,'Jardinería','Plantas y herramientas para el jardín.'),(38,'Plantas','Plantas decorativas y de interior.'),(39,'Herramientas de Jardín','Herramientas para cuidar el jardín.'),(40,'Cocina','Utensilios y accesorios para la cocina.'),(41,'Utensilios','Utensilios esenciales para cocinar.'),(42,'Electrodomésticos de Cocina','Electrodomésticos para facilitar la cocina.'),(43,'Alimentos y Bebidas','Productos alimenticios y bebidas.'),(44,'Alimentos Frescos','Frutas y verduras frescas.'),(45,'Bebidas','Bebidas alcohólicas y no alcohólicas.'),(46,'Bebidas Alcohólicas','Bebidas con contenido Alcohólico'),(47,'Bebidas No Alcohólicas','Bebidas sin alcohol'),(48,'Salud y Belleza','Productos de cuidado personal y belleza.'),(49,'Cuidado Personal','Artículos para la higiene y el cuidado personal.'),(50,'Productos para el Cabello','Champús, acondicionadores y tratamientos.'),(51,'Productos para la Piel','Cremas y lociones para el cuidado de la piel.'),(52,'Salud y Bienestar','Suplementos y productos de bienestar.'),(53,'Suplementos','Suplementos de Salud'),(54,'Productos Naturales','Productos Naturistas'),(55,'Cuidado del Bebé','Productos y accesorios para bebés.'),(56,'Alimentos para Bebés','Comida y fórmulas para bebés.'),(57,'Accesorios para Bebés','Artículos para la comodidad de los bebés.'),(58,'Juguetes','Juguetes y juegos para niños.'),(59,'Juguetes Educativos','Juguetes que fomentan el aprendizaje.'),(60,'Juguetes para Bebés','Juguetes diseñados para los más pequeños.'),(61,'Juguetes de Construcción','Juguetes que estimulan la creatividad.'),(62,'Deportes y Aire Libre','Equipamiento deportivo y artículos para actividades al aire libre.'),(63,'Equipos Deportivos','Equipamiento para diversos deportes.'),(64,'Ropa de Camping','Vestimenta adecuada para actividades al aire libre.'),(65,'Accesorios de Pesca','Artículos para la pesca recreativa.'),(66,'Automotriz','Accesorios y productos para automóviles.'),(67,'Accesorios para Automóviles','Artículos para mejorar la experiencia automotriz.'),(68,'Herramientas para Automóviles','Herramientas para el mantenimiento de vehículos.'),(69,'Libros y Papelería','Libros, material de oficina y artículos de papelería.'),(70,'Libros','Libros de diferentes géneros.'),(71,'Ficción','Novelas y cuentos de ficción.'),(72,'No Ficción','Libros de historia, biografías y más.'),(73,'Material de Oficina','Artículos para el trabajo en oficina.'),(74,'Papelería','Útiles escolares y de oficina.'),(75,'Productos para Mascotas','Alimentos y accesorios para mascotas.'),(76,'Alimentos para Mascotas','Comida para perros, gatos y otros animales.'),(77,'Accesorios para Mascotas','Juguetes y accesorios para el cuidado de mascotas.'),(78,'Juguetes para Mascotas','Juguetes diseñados para entretener a las mascotas.'),(80,'PRUEB','Descripción del depa de pruebas'),(81,'Hijo departamento de prueba','Descripción del departamento de prueba hijo.'),(87,'Departamento sin Asignar','Esta situación se da si se borra un depto.'),(89,'Nieto departamento de prueba','Descripción del departamento de prueba nieto.');
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
INSERT INTO `items` VALUES (0x739C9E46A93411EF893F0242AC120002,'Smartphone Galaxy','Teléfono inteligente con pantalla AMOLED y cámara de 108MP',50,999.99,10.00,1),(0x739CABD0A93411EF893F0242AC120002,'Laptop HP','Portátil con procesador i7 y 16GB RAM',30,1299.99,5.00,1),(0x739CB056A93411EF893F0242AC120002,'Tablet Samsung','Tablet con pantalla de 10 pulgadas y 64GB de almacenamiento',70,349.99,0.00,1),(0x739CB4F3A93411EF893F0242AC120002,'Auriculares Sony','Auriculares inalámbricos con cancelación de ruido',100,149.99,20.00,1),(0x739CBC42A93411EF893F0242AC120002,'Jeans Levi\'s','Pantalones vaqueros de corte regular',200,59.99,15.00,2),(0x739CBF31A93411EF893F0242AC120002,'Camisa Polo','Camisa de algodón para hombre, talla L',150,39.99,10.00,2),(0x739CC1BAA93411EF893F0242AC120002,'Chaqueta de Cuero','Chaqueta de cuero para hombre, talla M',80,199.99,5.00,2),(0x739CC432A93411EF893F0242AC120002,'Vestido de Noche','Vestido de noche largo para mujer, color negro',50,129.99,10.00,2),(0x739CC6C5A93411EF893F0242AC120002,'Sofá reclinable','Sofá cómodo con reclinación manual',20,499.99,20.00,3),(0x739CC93DA93411EF893F0242AC120002,'Mesa de comedor','Mesa de madera para 6 personas',15,299.99,10.00,3),(0x739CCBAFA93411EF893F0242AC120002,'Lámpara de Escritorio','Lámpara LED regulable para oficina',50,39.99,0.00,3),(0x739CCE38A93411EF893F0242AC120002,'Estante para Libros','Estante de madera para libros y decoraciones',40,79.99,5.00,3),(0x739CD0BFA93411EF893F0242AC120002,'Shampoo Pantene','Shampoo nutritivo para cabello seco',100,8.99,5.00,4),(0x739CD343A93411EF893F0242AC120002,'Crema Nivea','Crema hidratante para piel seca',120,12.50,0.00,4),(0x739CD5C6A93411EF893F0242AC120002,'Gel de Baño Dove','Gel de baño suave y cremoso',90,6.99,0.00,4),(0x739CD840A93411EF893F0242AC120002,'Rímel Maybelline','Máscara de pestañas voluminosas',80,12.99,5.00,4),(0x739CDAC2A93411EF893F0242AC120002,'Cerveza Corona','Paquete de 6 cervezas Corona',200,9.99,10.00,5),(0x739CDD44A93411EF893F0242AC120002,'Jugo de Naranja','Jugo 100% natural de naranja, sin azúcar',150,3.50,5.00,5),(0x739CE191A93411EF893F0242AC120002,'Café Lavazza','Café en grano de origen italiano',100,15.99,0.00,5),(0x739CE433A93411EF893F0242AC120002,'Agua Mineral Evian','Botella de 1 litro de agua mineral',250,1.99,0.00,5),(0x739CE6BFA93411EF893F0242AC120002,'Raqueta de Tenis Wilson','Raqueta ligera para tenis profesional',40,129.99,10.00,6),(0x739CE952A93411EF893F0242AC120002,'Bicicleta de Montaña','Bicicleta para aventuras al aire libre',30,399.99,15.00,6),(0x739CED11A93411EF893F0242AC120002,'Pelota de Fútbol','Pelota oficial de fútbol para jugar en césped',100,19.99,5.00,6),(0x739CEFC9A93411EF893F0242AC120002,'Kit de Pesca','Kit completo de pesca con caña, carrete y accesorios',50,69.99,0.00,6),(0x739CF262A93411EF893F0242AC120002,'Juguete de Construcción','Juguete de bloques para niños mayores de 6 años',150,19.99,5.00,8),(0x739CF4DFA93411EF893F0242AC120002,'Muñeca Barbie','Muñeca con accesorios y ropa de moda',200,24.99,10.00,8),(0x739CF74CA93411EF893F0242AC120002,'Rompecabezas 500 Piezas','Rompecabezas desafiante para toda la familia',80,9.99,5.00,8),(0x739CF9BCA93411EF893F0242AC120002,'Juguete de Peluche','Peluche de oso grande para niños',120,15.99,10.00,8);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1,'Tarjeta de Crédito','Pago mediante tarjeta de crédito.'),(2,'Tarjeta de Débito','Pago mediante tarjeta de débito vinculada a una cuenta bancaria.'),(3,'PayPal','Pago mediante la plataforma PayPal, rápida y segura.'),(4,'Transferencia Bancaria','Pago realizado mediante transferencia desde una cuenta bancaria.'),(5,'Efectivo','Pago en efectivo al momento de recibir el producto o servicio.');
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
INSERT INTO `sales` VALUES (1,'2024-11-23 17:32:40',0x299FC37AA93411EF893F0242AC120002,10.00),(2,'2024-11-23 18:38:33',0x299FC37AA93411EF893F0242AC120002,10.00),(3,'2024-11-23 18:57:45',0x29A007E8A93411EF893F0242AC120002,0.00),(4,'2024-11-23 19:35:57',0x299FFE8AA93411EF893F0242AC120002,10.00);
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
INSERT INTO `sold_items` VALUES (1,0x739CD0BFA93411EF893F0242AC120002,2,8.99,5.00),(1,0x739CDAC2A93411EF893F0242AC120002,6,9.99,10.00),(2,0x739CD0BFA93411EF893F0242AC120002,2,8.99,5.00),(2,0x739CDAC2A93411EF893F0242AC120002,6,9.99,10.00),(3,0x739CABD0A93411EF893F0242AC120002,1,1299.99,0.00),(3,0x739CB4F3A93411EF893F0242AC120002,1,149.99,20.00),(3,0x739CCBAFA93411EF893F0242AC120002,1,39.99,0.00),(3,0x739CDAC2A93411EF893F0242AC120002,6,9.99,10.00),(4,0x739CBC42A93411EF893F0242AC120002,1,8.99,15.00),(4,0x739CC1BAA93411EF893F0242AC120002,1,199.99,5.00);
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
-- Dumping routines for database 'michangarro'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_authentication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_authentication`(
    p_username VARCHAR(150),
    p_password VARCHAR(150)
) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
	-- DECLARE hex_salt VARCHAR(32);
    DECLARE stored_salt VARBINARY(16);
    DECLARE stored_password VARBINARY(32);
    DECLARE hash_password VARBINARY(32);
    -- DECLARE hex_salt VARBINARY(32);

    -- Seleccionar el salt y la contraseña almacenados
    SELECT salt, password 
    INTO stored_salt, stored_password 
    FROM customer 
    WHERE username = p_username;  

    -- Verificar si se encontró un usuario
    IF stored_password IS NULL THEN
        RETURN FALSE;  -- Usuario no encontrado
    END IF;

    -- Hashear la contraseña ingresada con el salt
    SET hash_password = UNHEX(SHA2(CONCAT(p_password, hex(stored_salt)), 256));
    -- Comparar el hash generado con el almacenado
    IF hash_password = stored_password THEN
        RETURN TRUE;  -- Autenticación exitosa
    ELSE
        RETURN FALSE;  -- Autenticación fallida
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 DROP FUNCTION IF EXISTS `fn_is_birthday_valid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_is_birthday_valid`(p_birthday DATE) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	
    DECLARE century date;
    DECLARE ten_years date;
	DECLARE error_message VARCHAR(255) DEFAULT '';
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;   -- Capturamos el mensaje de error
		SET  error_message = concat('Error:',error_message);
		return error_message;
    END;

    SET century = DATE_SUB(curdate(),INTERVAL 100 YEAR) ;
    SET ten_years = DATE_SUB(curdate(),INTERVAL 10 YEAR) ;
  
	
    -- Verificar si la fecha es NULL
    IF p_birthday IS NULL THEN
       RETURN 'La fecha no puede ser nula.';  -- Indica que la fecha no es válida
    END IF;
    
    -- Verificar si la fecha está fuera de un rango permitido (ejemplo: entre 2000-01-01 y 2099-12-31)
    IF (p_birthday > century) AND (p_birthday < ten_years) THEN
        RETURN 'fecha válida.';
	ELSE
		RETURN 'La fecha no está en el rango permitido';
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_validate_phone_number` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_validate_phone_number`(
    phone VARCHAR(30) 
) RETURNS varchar(15) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE cleaned_phone VARCHAR(15);
    
    -- Limpiar el número de teléfono (eliminar caracteres no numéricos)
    SET cleaned_phone = REGEXP_REPLACE(phone, '[^0-9]', '');

    -- Validar que el número tenga entre 10 y 15 dígitos
    IF cleaned_phone REGEXP '^[0-9]{10,15}$' THEN
        RETURN cleaned_phone;  -- Devuelve el número limpio si es válido
    ELSE
        RETURN NULL;  -- Devuelve NULL si no es válido
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_add_customer`(
    p_username VARCHAR(150),
    p_password VARCHAR(150),
    p_name VARCHAR(100),
    p_lastname VARCHAR(100),
    p_email VARCHAR(150),
    p_birthday DATE,
    p_customer_type_id SMALLINT UNSIGNED,
    p_phone VARCHAR(30)
)
BEGIN
	
    DECLARE cleaned_phone VARCHAR(15);
    DECLARE hashed_password VARBINARY(32);
    DECLARE p_salt VARBINARY(16);
	
    -- Variables de validación
    DECLARE is_phone_number_valid BOOLEAN DEFAULt FALSE;
    DECLARE is_username_valid BOOLEAN DEFAULt FALSE;
    DECLARE is_pwd_valid BOOLEAN DEFAULt FALSE;
    DECLARE is_email_valid BOOLEAN DEFAULt FALSE;
    
    DECLARE phone_number_message TEXT;
    DECLARE username_message TEXT;
    DECLARE pwd_message TEXT;
    DECLARE email_message TEXT; 
    DECLARE birthday_message TEXT;
    
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
        
	DECLARE msg_error VARCHAR(255);
	DECLARE message_error VARCHAR(255) DEFAULT '';
	DECLARE full_error_message TEXT;
	
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;

		IF msg_error != message_error THEN
			SET full_error_message = CONCAT_WS(".", msg_error, message_error);
		ELSE
			SET full_error_message = msg_error;
		END IF;

		-- Si el mensaje concatenado es más largo de 255 caracteres, trunca con '...' al final
		IF LENGTH(full_error_message) > 255 THEN
			SET full_error_message = CONCAT(SUBSTRING(full_error_message, 1, 252), '...');
		END IF;

		-- Asegurar que `full_error_message` no exceda los 255 caracteres
		SET full_error_message = LEFT(full_error_message, 255);
		-- Imprimir para depuración 
		-- SELECT LENGTH(full_error_message) AS truncated_length, full_error_message AS truncated_message_check;

		-- Lanzar el error con el mensaje truncado
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = full_error_message;

		-- Actualizar el estado de la operación
		SET operation_successful = FALSE;
	END;

    
    -- Validar el nombre de usuarío
	CALL sp_is_username_valid (p_username, username_message,
				is_username_valid);
	IF NOT is_username_valid THEN 
		SET operation_successful = FALSE; 
		SET message_error = username_message;	
	END IF;
    
    IF operation_successful THEN
		-- Valida la fecha
		SET birthday_message = fn_is_birthday_valid(p_birthday);
		IF birthday_message != 'fecha válida.' THEN
			SET operation_successful = FALSE;
			SET message_error = birthday_message;
		END IF;
    END IF;
    
    IF operation_successful THEN
		-- Validar y limpiar el número de teléfono
		CALL sp_is_phone_number_valid(p_phone, phone_number_message,
					cleaned_phone, is_phone_number_valid);
		IF NOT is_phone_number_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,phone_number_message);
		END IF;
    END IF;
    
    IF operation_successful THEN
		-- Validar el correo
		CALL sp_is_email_valid (p_email, email_message, is_email_valid);
		IF NOT is_email_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,"Error:",email_message);
		END IF;
    END IF;
    IF operation_successful THEN
		-- Realizar el hash para el password
		call sp_hash_pwd(p_password,hashed_password, p_salt,pwd_message,is_pwd_valid);
		IF NOT is_pwd_valid THEN
			SET operation_successful = FALSE;
			IF LENGTH(pwd_message) > 255 THEN
				SET message_error = CONCAT(SUBSTRING(pwd_message, 1, 252), '...');
			else
				SET message_error = pwd_message;
			END IF;
			SET message_error = LEFT(message_error, 255);
		END IF;
		-- SELECT pwd_message,length(message_error),operation_successful;
   END IF;
   
	IF operation_successful THEN
        -- Inserta el nuevo cliente en la base de datos
        INSERT INTO customer (username, password, name, lastname, email, birth_date, customer_type_id, phone, salt)
        VALUES (p_username, hashed_password, p_name, p_lastname, p_email, p_birthday, p_customer_type_id, cleaned_phone, p_salt);
    ELSE
        -- Lanzar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_error;
    END IF;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_table_customer_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_create_table_customer_temp`()
BEGIN
	DROP TABLE IF EXISTS `customer_temp` ;
    
	CREATE TABLE `customer_temp` (
	`username` varchar(150) NOT NULL,
	`password` varchar(255) NOT NULL,
	`name` varchar(100) NOT NULL,
	`lastname` varchar(100) NOT NULL,
	`email` varchar(150) NOT NULL,
	`birth_date` date NOT NULL,
	`customer_type_id` smallint unsigned NOT NULL,
	`phone` varchar(30) NOT NULL
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`arturo`@`%` PROCEDURE `sp_delete_department`( depa_id INT)
BEGIN
    DECLARE not_department_asigned INT;
    DECLARE msg_error VARCHAR(255);
    DECLARE full_error_message TEXT;
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;
		/*
        SET full_error_message = CONCAT_WS(".", 'Error en el proceso de eliminación del departamento', msg_error);
		
        -- Si el mensaje concatenado es más largo de 255 caracteres, trunca con '...' al final
		IF LENGTH(full_error_message) > 255 THEN
			SET full_error_message = CONCAT(SUBSTRING(full_error_message, 1, 252), '...');
		END IF;
        -- Asegurar que `full_error_message` no exceda los 255 caracteres
		SET full_error_message = LEFT(full_error_message, 255);
        */
		-- Si hay un error, hacer rollback
        ROLLBACK;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error; -- full_error_message;
	END;

    -- Iniciar la transacción
    START TRANSACTION;
    
    -- Verificar si existe el departamento 'Departamento sin Asignar'
    IF NOT EXISTS (SELECT 1 FROM departments WHERE name = 'Departamento sin Asignar') THEN
        -- Si no existe, se llama al procedimiento para crear el departamento
        CALL sp_insert_department("Departamento sin Asignar",  -- dept_name
                                  "Esta situación se da si se borra un depto.",  -- dept_description
                                  NULL);  -- parent_id
        -- Obtener el ID del nuevo departamento insertado
        SET not_department_asigned = LAST_INSERT_ID();
    ELSE
        -- Si ya existe el departamento 'Departamento sin Asignar', obtener su ID
        SELECT department_id INTO not_department_asigned 
        FROM departments 
        WHERE name = 'Departamento sin Asignar';
    END IF;

    -- Eliminar todas las relaciones donde este departamento es ancestro o descendiente
    DELETE FROM department_closure WHERE ancestor = depa_id;
    DELETE FRoM department_closure WHERE descendant = depa_id;

    -- Eliminar las relaciones en department_interests donde el departamento sea el especificado
    DELETE FROM department_interests WHERE department_id = depa_id;

    -- Actualizar los items, asignando el nuevo departamento 'sin asignar' a los registros correspondientes
    UPDATE items SET department_id = not_department_asigned WHERE department_id = depa_id;

	-- Eliminamos el departamento.
    DELETE FROM departments WHERE department_id = depa_id;
    
    -- Confirmamos la transacción
    COMMIT;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_del_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_del_customer`(
    p_username VARCHAR(150)
)
BEGIN
    -- Validar el parámetro
    IF p_username IS NULL OR p_username = '' THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El nombre de usuario no puede ser nulo o vacío.';
    END IF;

    -- Eliminar el registro del cliente
    DELETE FROM customer WHERE username = p_username;

    -- Comprobar si se eliminó alguna fila
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El usuario no existe o no se pudo eliminar.';
    END IF;
    
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetInterestByDepId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetInterestByDepId`(depID SMALLINT UNSIGNED)
BEGIN
    SELECT di.department_id, d.name AS department_name, di.interest_id, i.name AS interest_name
	FROM department_interests di
	INNER JOIN departments d ON d.department_id = di.department_id
	INNER JOIN interests i ON di.interest_id = i.interest_id
	WHERE di.department_id = COALESCE(depID, di.department_id);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_sale_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`arturo`@`%` PROCEDURE `sp_get_sale_details`( p_sales_id BIGINT UNSIGNED)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_hash_pwd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_hash_pwd`(
    IN pwd VARCHAR(255),                         -- Entrada: contraseña
    OUT hashed_password VARBINARY(32),           -- Salida: contraseña hasheada
    OUT salt VARBINARY(16),                      -- Salida: salt en binario
    OUT pwd_message VARCHAR(255),                -- Mensaje de error o éxito
    OUT is_pwd_valid BOOLEAN                     -- Validación de la contraseña
)
BEGIN
	
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;  -- Variable de control para operaciones
    DECLARE error_message VARCHAR(255);                 -- Variable para almacenar el mensaje de error
    DECLARE hex_salt VARCHAR(32);
    DECLARE proc_name VARCHAR(50) DEFAULT 'sp_hash_pwd';
    
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              -- Capturamos el mensaje de error
        SET pwd_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET salt = NULL;                                -- Limpiamos los valores
        SET hashed_password = NULL;
        SET is_pwd_valid = FALSE;
        SET operation_successful = FALSE;
    END;
    
    -- Validación de la contraseña de entrada
    IF pwd IS NULL OR pwd = '' THEN
        SET salt = NULL;
        SET hashed_password = NULL;
        SET pwd_message = 'La clave no puede ser nula o vacía';
        SET is_pwd_valid = FALSE;
        SET operation_successful = FALSE;
    END IF;

    -- Si la operación es exitosa, realizar el hash y salt
    IF operation_successful THEN
		SET hex_salt = UPPER(REPLACE(UUID(), '-', ''));		-- En mayusculas
        SET salt = UNHEX(hex_salt);  -- Generar salt como binario (sin guiones, 16 bytes)
        SET hashed_password = UNHEX(SHA2(CONCAT(pwd, hex_salt), 256)); -- Hashear la contraseña con SHA2
        SET is_pwd_valid = TRUE;
        SET pwd_message = 'Contraseña procesada correctamente';
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`arturo`@`%` PROCEDURE `sp_insert_department`(
    IN dept_name VARCHAR(100),
    IN dept_description VARCHAR(255),
    IN parent_id SMALLINT UNSIGNED
)
BEGIN
    DECLARE new_department_id SMALLINT UNSIGNED;
    DECLARE msg_error VARCHAR(255);
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;
		-- Si hay un error, hacer rollback
        ROLLBACK;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
	END;
    
    -- Iniciar transacción para asegurar atomicidad
    START TRANSACTION;

    -- Insertar el nuevo departamento en la tabla 'departments'
    INSERT INTO departments (name, description)
    VALUES (dept_name, dept_description);

    -- Obtener el ID del nuevo departamento insertado
    SET new_department_id = LAST_INSERT_ID();
    
    -- Inserta el nuevo departamento como su propio ancestro con profundidad 0
	INSERT INTO department_closure (ancestor, descendant, depth)
    VALUES (new_department_id, new_department_id, 0);


    -- Si el departamento tiene un padre (parent_id no es NULL)
    IF parent_id IS NOT NULL THEN
    
		-- Verificar si el parent_id existe
        IF NOT EXISTS (SELECT 1 FROM departments WHERE department_id = parent_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El departamento padre no existe.';
        END IF;
        
        -- Agregar relaciones de cierre entre el nuevo departamento y su padre
        INSERT INTO department_closure (ancestor, descendant, depth)
        SELECT ancestor, new_department_id, depth + 1
        FROM department_closure
        WHERE descendant = parent_id;
        
        -- Insertar relaciones para todos los ancestros del `parent_id` (nietos, bisnietos, etc.)
        INSERT INTO department_closure (ancestor, descendant, depth)
        SELECT descendant, new_department_id, depth + 1
        FROM department_closure
        WHERE ancestor = parent_id;
        
	END IF;
	    
    -- Confirmar la transacción
    COMMIT;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_sales_from_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`arturo`@`%` PROCEDURE `sp_insert_sales_from_json`( sales_json JSON )
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

	DECLARE msg_error VARCHAR(255); -- Variable para almacenar el mensaje de error

	-- Manejador para manejar excepciones SQL
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Capturar el mensaje de error
		GET DIAGNOSTICS CONDITION 1 msg_error = MESSAGE_TEXT;
	
		-- Limitar el tamaño del mensaje de error a 120 caracteres (no agregamos más texto)
		SET msg_error = LEFT(msg_error, 120);  -- Truncar directamente el mensaje
		-- Realizar un rollback en caso de error
		ROLLBACK;
		-- Lanzar el error con el mensaje truncado
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
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
		
        -- SET current_sales_id = 1;

        SET current_sales_id = COALESCE((SELECT MAX(sales_id)+1 FROM sales), 1);
        
        -- Inserta la venta
		INSERT INTO sales (sales_id, customer_payment_method_id, customer_type_discount)
		VALUES (current_sales_id, current_payment_method_id, current_discount);
      
        -- SELECT current_sales_id, hex(current_payment_method_id),length(current_payment_method_id), current_discount;
                
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

			-- SELECT current_sales_id, current_item_id, current_quantity, current_item_price, current_item_discount;
            
            SET item_number = item_number + 1;
        END WHILE;
        
        SET current_sale= current_sale + 1;
    END WHILE;
    
     -- Confirmar la transacción si todo se realizó correctamente
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_is_email_valid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_is_email_valid`(
	p_email VARCHAR(150), 
    OUT email_message VARCHAR(150), 
    OUT is_email_valid BOOLEAN)
BEGIN
	DECLARE operation_successful BOOLEAN DEFAULT TRUE;
	DECLARE proc_name VARCHAR(50) DEFAULT 'sp_is_email_valid';
    DECLARE error_message VARCHAR(255) DEFAULT '';
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              	-- Capturamos el mensaje de error
        SET email_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET is_email_valid = FALSE;				-- Limpiamos los valores
        SET operation_successful = FALSE;
    END;
    
    
	IF p_email is NULL or p_email = '' then
		set email_message = 'El correo no puede estar vacio.';
        set is_email_valid = FALSE;
        SET operation_successful = FALSE;
    END IF;
    IF operation_successful THEN
		-- Verifica si el correo existe
		IF EXISTS (SELECT 1 FROM customer 
					WHERE email = p_email) THEN
			set email_message = 'Este correo ya existe.';
			set is_email_valid = FALSE;
		ELSE
			set email_message = 'Correo válido';
			set is_email_valid = TRUE;
		END IF;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_is_phone_number_valid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_is_phone_number_valid`(
	p_phone VARCHAR(30) , 
    OUT phone_number_message VARCHAR(255),
    OUT cleaned_phone VARCHAR(15),
    OUT is_phone_number_valid BOOLEAN)
BEGIN
	
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
    DECLARE proc_name VARCHAR(50) DEFAULT 'sp_is_phone_number_valid';
    DECLARE error_message VARCHAR(255);
    
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              	-- Capturamos el mensaje de error
        SET phone_number_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET is_phone_number_valid = FALSE;				-- Limpiamos los valores
        SET cleaned_phone = '';
        SET operation_successful = FALSE;
    END;
    
    SET is_phone_number_valid = FALSE;
    SET phone_number_message = '';
    
    -- Válida y limpia el número de teléfono
    SET cleaned_phone = REGEXP_REPLACE(p_phone, '[^0-9]', '');
    -- Validar que el número tenga entre 10 y 15 dígitos
    IF NOT (cleaned_phone REGEXP '^[0-9]{10,15}$') THEN
        SET operation_successful = FALSE;
        SET phone_number_message = 'El número de teléfono debe tener entre 10 y 15 dígitos.';
        SET is_phone_number_valid = FALSE;
    END IF;
	
    -- Verifica que el telefono sea único
    IF operation_successful THEN
		IF EXISTS(SELECT 1 FROM customer WHERE phone = cleaned_phone) THEN
			SET phone_number_message = 'Este número de teléfono ya esta registrado.';
			SET is_phone_number_valid = FALSE;
            SET operation_successful = FALSE;
		ELSE
			SET phone_number_message = 'Número de teléfono válido';
			SET is_phone_number_valid = TRUE;
		END IF;
	END IF;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_is_username_valid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_is_username_valid`(
	p_username VARCHAR(150), 
    OUT username_message VARCHAR(150), 
    OUT is_username_valid BOOLEAN)
BEGIN

    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
	DECLARE proc_name VARCHAR(50) DEFAULT 'sp_is_username_valid';
    DECLARE error_message VARCHAR(255) DEFAULT '';
    -- Capturar excepciones SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            error_message = MESSAGE_TEXT;              	-- Capturamos el mensaje de error
        SET username_message = CONCAT('Error: (', proc_name, '). ', error_message); -- Asignamos el mensaje de error
        SET is_username_valid = FALSE;				-- Limpiamos los valores
        SET operation_successful = FALSE;
    END;
    
	-- Válida que no este vacio.
    if p_username is NULL or p_username = '' then
		SET username_message = 'Error: El username no puede estar vacío.';
        SET is_username_valid = FALSE;
        SET operation_successful = FALSE;
	end if;
	
    IF operation_successful THEN    
		-- Si existe al menos un registro, no es único
        IF EXISTS (SELECT 1 FROM customer 
					WHERE username = p_username) THEN
			set username_message = 'Error: Este usuarío ya existe.';
			set is_username_valid = FALSE;
		ELSE
			set username_message = 'usuario válido';
			set is_username_valid = TRUE;
		END IF;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_manage_departments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`arturo`@`%` PROCEDURE `sp_manage_departments`(
    IN dept_id SMALLINT UNSIGNED,   -- ID del departamento a insertar o mover
    IN dept_name VARCHAR(100),      -- Nombre del departamento
    IN dept_description VARCHAR(255),  -- Descripción del departamento
    IN parent_id SMALLINT UNSIGNED  -- ID del ancestro o padre
)
BEGIN
    DECLARE existing_parent_id SMALLINT UNSIGNED;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        ROLLBACK;  -- En caso de error, hacer un rollback

    -- Iniciar la transacción
    START TRANSACTION;

    -- 1. Verificar si el departamento ya tiene alguna relación jerárquica con el parent_id en cualquier nivel
    SELECT ancestor INTO existing_parent_id
    FROM department_closure
    WHERE descendant = dept_id AND ancestor = parent_id;

    -- Si la relación existe (el dept_id ya está relacionado con el parent_id en cualquier nivel)
    IF existing_parent_id IS NOT NULL THEN
        -- 2. Si la relación existe, mover el departamento al nuevo ancestro
        CALL sp_move_department_to_new_ancestor(dept_id, parent_id);
    ELSE
        -- 3. Si la relación no existe, insertar el departamento
        CALL sp_sp_insert_department(dept_name, dept_description, parent_id);
    END IF;

    -- Confirmar la transacción si todo se realizó correctamente
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reset_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_reset_customers`()
BEGIN

	DECLARE done INT DEFAULT FALSE;
	DECLARE p_username VARCHAR(150);
	DECLARE p_password VARCHAR(150);
	DECLARE p_name VARCHAR(100);
	DECLARE p_lastname VARCHAR(100);
	DECLARE p_email VARCHAR(150);
	DECLARE p_birth_date DATE;
	DECLARE p_customer_type_id SMALLINT UNSIGNED;
	DECLARE p_phone VARCHAR(30);
    
	-- Cursor para recorrer los registros de la tabla temporal
	DECLARE cur CURSOR FOR
	SELECT username, password, name, lastname, email, birth_date, customer_type_id, phone 
	FROM customer_temp;

	-- Manejador para manejar excepciones (captura errores SQL)
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Capturar el mensaje de error
        GET DIAGNOSTICS CONDITION 1 
					@error_message = MESSAGE_TEXT;
		-- Mostrar el error
		SELECT CONCAT('Error: ', error_message) AS error_message;
		ROLLBACK;
	END;

	-- Manejador de terminación del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	-- Comienza la Transacción
    START TRANSACTION;
    
	-- Eliminar registros previos de la tabla customer
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM customer;
    ALTER TABLE customer AUTO_INCREMENT = 1;
    SET SQL_SAFE_UPDATES = 1;
    
    OPEN cur;

	read_loop: LOOP
		FETCH cur INTO p_username, 
						p_password, 
						p_name, 
						p_lastname, 
						p_email, 
						p_birth_date, 
						p_customer_type_id, 
						p_phone;
		IF done THEN
			LEAVE read_loop;
		END IF;

		-- Llamar al procedimiento almacenado
		CALL sp_add_customer(p_username,
					p_password,
					p_name,
					p_lastname,
					p_email,
					p_birth_date,
					p_customer_type_id,
					p_phone);
    
	END LOOP;

	CLOSE cur;
	
	DROP TABLE IF EXISTS customer_temp;
	COMMIT;
	CALL sp_sel_customer(NULL);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_sel_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_sel_customer`(
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_update_customer`(
    p_username VARCHAR(150),
    p_password VARCHAR(150),
    p_name VARCHAR(100),
    p_lastname VARCHAR(100),
    p_email VARCHAR(150),
    p_birthday DATE,
    p_customer_type_id SMALLINT UNSIGNED,
    p_phone VARCHAR(30),
    p_new_username VARCHAR(150)
)
BEGIN

    DECLARE cleaned_phone VARCHAR(15);
    DECLARE hashed_password VARBINARY(32);
    DECLARE p_salt VARBINARY(16);
    
    -- Variables de validación
    DECLARE is_phone_number_valid BOOLEAN;
    DECLARE is_username_valid BOOLEAN;
	DECLARE is_pwd_valid BOOLEAN DEFAULT FALSE;
    DECLARE email_message VARCHAR(150); 
    
    DECLARE phone_number_message VARCHAR(150);
    DECLARE username_message VARCHAR(150);
    DECLARE pwd_message TEXT;
    DECLARE birthday_message TEXT;
    DECLARE is_email_valid BOOLEAN;
    
    DECLARE operation_successful BOOLEAN DEFAULT TRUE;
    
	DECLARE msg_error VARCHAR(255);
    DECLARE message_error VARCHAR(255) DEFAULT '';
	DECLARE full_error_message TEXT;
    DECLARE proc_name VARCHAR(50) DEFAULT 'sp_update_customer';
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Obtener el mensaje de error
		GET DIAGNOSTICS CONDITION 1 
			msg_error = MESSAGE_TEXT;

		IF msg_error != message_error THEN
			SET full_error_message = CONCAT_WS(".", msg_error, message_error);
		ELSE
			SET full_error_message = msg_error;
		END IF;

		-- Si el mensaje concatenado es más largo de 255 caracteres, trunca con '...' al final
		IF LENGTH(full_error_message) > 255 THEN
			SET full_error_message = CONCAT(SUBSTRING(full_error_message, 1, 252), '...');
		END IF;

		-- Asegurar que `full_error_message` no exceda los 255 caracteres
		SET full_error_message = LEFT(full_error_message, 255);
		-- Imprimir para depuración 
		-- SELECT LENGTH(full_error_message) AS truncated_length, full_error_message AS truncated_message_check;

		-- Lanzar el error con el mensaje truncado
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = full_error_message;

		-- Actualizar el estado de la operación
		SET operation_successful = FALSE;
	END;
    
    IF p_username IS NULL OR p_username = '' THEN
		SET operation_successful = FALSE; 
        -- Lanzar el error 
		SET message_error = CONCAT("Error: (",proc_name,"). El nombre de usuario no puede ser nulo o vacio");
    END IF;
    
    IF p_new_username IS NOT NULL AND p_new_username !='' AND operation_successful THEN
		-- Validar el nuevo nombre de usuarío
		CALL sp_is_username_valid (p_new_username, username_message,
					is_username_valid);
		IF NOT is_username_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT("Error: (",proc_name,"). El nuevo nombre de usuario no es válido.");
		END IF;
    
		-- SELECT p_new_username, username_message,is_username_valid;
	END IF;
    
    IF p_birthday IS NOT NULL AND operation_successful THEN
		-- Valida la fecha
		SET birthday_message = fn_is_birthday_valid(p_birthday);
		IF birthday_message != 'fecha válida.' THEN
			SET operation_successful = FALSE;
			SET message_error = birthday_message;
		END IF;
    END IF;
    
	IF p_email IS NOT NULL AND p_email !='' AND operation_successful THEN
		-- Validar el correo
		CALL sp_is_email_valid (p_email, email_message, is_email_valid);
		IF NOT is_email_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,"Error:",email_message);
		END IF;
    END IF;
    
	IF p_password IS NOT NULL AND p_password !='' AND operation_successful THEN
		-- Realizar el hash para el password
		call sp_hash_pwd(p_password,hashed_password, p_salt,pwd_message,is_pwd_valid);
		IF NOT is_pwd_valid THEN
			SET operation_successful = FALSE;
			IF LENGTH(pwd_message) > 255 THEN
				SET message_error = CONCAT(SUBSTRING(pwd_message, 1, 252), '...');
			else
				SET message_error = pwd_message;
			END IF;
			SET message_error = LEFT(message_error, 255);
		END IF;
		-- SELECT pwd_message,length(message_error),operation_successful;
   END IF;

	IF p_phone IS NOT NULL AND p_phone !='' AND operation_successful THEN
		-- Validar y limpiar el número de teléfono
		CALL sp_is_phone_number_valid(p_phone, phone_number_message,
					cleaned_phone, is_phone_number_valid);
		IF NOT is_phone_number_valid THEN 
			SET operation_successful = FALSE; 
			SET message_error = CONCAT_WS(".",message_error,phone_number_message);
		END IF;
	END IF;
    
	IF operation_successful THEN
    
		-- Actualizar la información del cliente en la tabla
		UPDATE customer
		SET 
			username = COALESCE(p_new_username,p_username),
			password = COALESCE(hashed_password, password),
			salt = COALESCE(p_salt, salt),
			name = COALESCE(p_name, name),
			lastname = COALESCE(p_lastname, lastname),
			email = COALESCE(p_email, email),
			birth_date = COALESCE(p_birthday, birth_date),
			customer_type_id = COALESCE(p_customer_type_id, customer_type_id),
			phone = COALESCE(p_phone, phone)
		WHERE username = p_username;
    
		-- Comprobar si se actualizó alguna fila
		IF ROW_COUNT() = 0 THEN
			SET message_error = CONCAT('Error: (',proc_name,'). El usuario no existe.');
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = message_error;
		END IF;
      
      -- SELECT 'todo benne';
	ELSE
         -- Lanzar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_error;
	END IF;
    
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`arturo`@`%` PROCEDURE `sp_update_department`(
    p_dept_id INT UNSIGNED,           -- Departamento a actualizar
    new_dept_name VARCHAR(100),       -- Nuevo nombre
    new_dept_description VARCHAR(255), -- Nueva descripción
    IN new_ancestor_id INT UNSIGNED   -- Nuevo ancestro para el departamento
)
BEGIN
    DECLARE msg_error VARCHAR(255);
    DECLARE old_parent_id SMALLINT UNSIGNED;
    DECLARE old_parent_depth INT UNSIGNED;
    DECLARE new_ancestor_depth INT UNSIGNED;
    
    -- Manejo de errores
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Obtener el mensaje de error
        GET DIAGNOSTICS CONDITION 1 
            msg_error = MESSAGE_TEXT;
        -- Si hay un error, hacer rollback
        ROLLBACK;
        -- Mostrar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_error;
    END;

    -- Iniciar transacción para asegurar atomicidad
    START TRANSACTION;

    -- 1. Actualizar los detalles del departamento (nombre y descripción)
    UPDATE departments d
    SET name = COALESCE(new_dept_name, name),
        description = COALESCE(new_dept_description, description)
    WHERE d.department_id = p_dept_id;

    -- 2. Obtener el antiguo `parent_id` y `depth` del departamento
    SELECT ancestor, depth INTO old_parent_id, old_parent_depth
    FROM department_closure
    WHERE descendant = p_dept_id AND depth = 1 LIMIT 1;

    -- Obtener el `depth` del nuevo ancestro
    SELECT depth INTO new_ancestor_depth
    FROM department_closure
    WHERE descendant = new_ancestor_id AND ancestor = new_ancestor_id;

	select new_ancestor_id,old_parent_id;
    -- 3. Verificar si el nuevo ancestro es diferente al antiguo
    IF new_ancestor_id <> old_parent_id THEN
		SELECT "ENTRA";
        -- Verificar si el nuevo ancestro es un descendiente del departamento (prevención de ciclos)
        IF EXISTS (
            SELECT 1
            FROM department_closure
            WHERE ancestor = p_dept_id AND descendant = new_ancestor_id
        ) THEN
            -- Si es así, no se puede mover a este ancestro (ciclo).
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: El nuevo ancestro es un descendiente del departamento.';
        ELSE
            -- 4. Eliminar las relaciones anteriores del departamento (relaciones con el viejo ancestro)
            DELETE FROM department_closure
            WHERE descendant = p_dept_id;

            -- 5. Insertar las nuevas relaciones con el nuevo ancestro
            -- Relacionamos el departamento con todos los ancestros existentes y el nuevo ancestro
            INSERT INTO department_closure (ancestor, descendant, depth)
            SELECT ancestor, p_dept_id, depth + new_ancestor_depth - old_parent_depth
            FROM department_closure
            WHERE descendant = new_ancestor_id;

            -- Insertamos también la relación del departamento consigo mismo (depth=0)
            INSERT INTO department_closure (ancestor, descendant, depth)
            VALUES (p_dept_id, p_dept_id, 0);

            -- 6. Actualizar los descendientes
            -- La diferencia de profundidad entre los dos ancestros será aplicada a los descendientes
            UPDATE department_closure dc
            JOIN department_closure dc_parent ON dc.ancestor = dc_parent.descendant
            SET dc.depth = dc_parent.depth + (new_ancestor_depth - old_parent_depth)
            WHERE dc.descendant IN (
                SELECT descendant
                FROM department_closure
                WHERE ancestor = p_dept_id
            ) AND dc_parent.ancestor = new_ancestor_id;

        END IF;
    END IF;

    -- Confirmar la transacción
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `michangarro`
--

USE `michangarro`;

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

-- Dump completed on 2024-11-25  0:27:44
