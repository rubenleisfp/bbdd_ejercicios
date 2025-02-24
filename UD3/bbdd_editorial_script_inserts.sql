-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: bbdd_editorial
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES ('123456789','Juan Perez','111111111',1),('654321987','Pedro Rodriguez','333333333',1),('987654321','María Lopez','222222222',2);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `escribe`
--

LOCK TABLES `escribe` WRITE;
/*!40000 ALTER TABLE `escribe` DISABLE KEYS */;
INSERT INTO `escribe` VALUES (1,'111111111'),(2,'222222222'),(3,'333333333');
/*!40000 ALTER TABLE `escribe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `numrevista`
--

LOCK TABLES `numrevista` WRITE;
/*!40000 ALTER TABLE `numrevista` DISABLE KEYS */;
INSERT INTO `numrevista` VALUES (1,1,20,'2024-01-01',1000),(1,2,22,'2024-02-01',1100),(2,1,18,'2024-01-15',800);
/*!40000 ALTER TABLE `numrevista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `periodista`
--

LOCK TABLES `periodista` WRITE;
/*!40000 ALTER TABLE `periodista` DISABLE KEYS */;
INSERT INTO `periodista` VALUES ('111111111','Laura Gómez','Calle Secundaria 456','444444444','Ciencia'),('222222222','Carlos Martínez','Avenida Periférica 789','555555555','Viajes'),('333333333','Ana García','Calle Central 987','666666666','Moda');
/*!40000 ALTER TABLE `periodista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `revista`
--

LOCK TABLES `revista` WRITE;
/*!40000 ALTER TABLE `revista` DISABLE KEYS */;
INSERT INTO `revista` VALUES (1,'Ciencia Hoy','Mensual','Científica',1),(2,'Viajes y Aventuras','Quincenal','Viajes',2),(3,'Moda & Estilo','Semanal','Moda',1);
/*!40000 ALTER TABLE `revista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sucursal`
--

LOCK TABLES `sucursal` WRITE;
/*!40000 ALTER TABLE `sucursal` DISABLE KEYS */;
INSERT INTO `sucursal` VALUES (1,'Calle Principal 123','123456789'),(2,'Avenida Central 456','987654321');
/*!40000 ALTER TABLE `sucursal` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-24 12:13:43
