-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: bbdd_tienda_magica
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
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES ('Crookshanks',300,400),('Hedwig',150,200);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('Harry Potter','1990-07-31','Gandalf'),('Hermione Granger','1980-09-19','Merlín');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cliente_hechizos`
--

LOCK TABLES `cliente_hechizos` WRITE;
/*!40000 ALTER TABLE `cliente_hechizos` DISABLE KEYS */;
INSERT INTO `cliente_hechizos` VALUES ('Harry Potter','Expelliarmus'),('Hermione Granger','Expecto Patronum');
/*!40000 ALTER TABLE `cliente_hechizos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `gnomo`
--

LOCK TABLES `gnomo` WRITE;
/*!40000 ALTER TABLE `gnomo` DISABLE KEYS */;
INSERT INTO `gnomo` VALUES ('Filius');
/*!40000 ALTER TABLE `gnomo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `gnomo_hechizos`
--

LOCK TABLES `gnomo_hechizos` WRITE;
/*!40000 ALTER TABLE `gnomo_hechizos` DISABLE KEYS */;
INSERT INTO `gnomo_hechizos` VALUES ('Filius','Expecto Patronum');
/*!40000 ALTER TABLE `gnomo_hechizos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `hechizo`
--

LOCK TABLES `hechizo` WRITE;
/*!40000 ALTER TABLE `hechizo` DISABLE KEYS */;
INSERT INTO `hechizo` VALUES ('Expecto Patronum',3,'Ahuyentar Dementores'),('Expelliarmus',2,'Desarmar al oponente');
/*!40000 ALTER TABLE `hechizo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mago`
--

LOCK TABLES `mago` WRITE;
/*!40000 ALTER TABLE `mago` DISABLE KEYS */;
INSERT INTO `mago` VALUES ('Gandalf'),('Merlín');
/*!40000 ALTER TABLE `mago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mascota`
--

LOCK TABLES `mascota` WRITE;
/*!40000 ALTER TABLE `mascota` DISABLE KEYS */;
INSERT INTO `mascota` VALUES ('Crookshanks','Hermione Granger',40),('Filius','Hermione Granger',60),('Hedwig','Harry Potter',50);
/*!40000 ALTER TABLE `mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `varita`
--

LOCK TABLES `varita` WRITE;
/*!40000 ALTER TABLE `varita` DISABLE KEYS */;
INSERT INTO `varita` VALUES ('Varita de Fresno','Hermione Granger','Fresno',25),('Varita de Saúco','Harry Potter','Saúco',30);
/*!40000 ALTER TABLE `varita` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-26 12:27:49
