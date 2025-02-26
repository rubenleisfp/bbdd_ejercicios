-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: bbdd_eventos_dam
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
-- Dumping data for table `artista`
--

LOCK TABLES `artista` WRITE;
/*!40000 ALTER TABLE `artista` DISABLE KEYS */;
INSERT INTO `artista` VALUES (2,'Freddie Mercury','1946-09-05','freddie.mercury@example.com','987654321'),(2,'John Lennon','1940-10-09','john.lennon@example.com','123456789'),(2,'Paul McCartney','1945-01-01','McCartney@gmail.com',NULL),(2,'Ringo Star','1945-01-01','RingoStar@gmail.com','657829382'),(3,'Michael Jackson','1958-08-29','michael.jackson@example.com','555555555');
/*!40000 ALTER TABLE `artista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `artista_evento`
--

LOCK TABLES `artista_evento` WRITE;
/*!40000 ALTER TABLE `artista_evento` DISABLE KEYS */;
INSERT INTO `artista_evento` VALUES (2,'Freddie Mercury','Concierto de Rock',3500.00),(2,'John Lennon','Concierto de Rock',3000.00),(2,'Paul McCartney','Homenaje Beattles',0.00),(3,'Michael Jackson','Festival de Música',4000.00),(3,'Michael Jackson','Gira de Pop',4500.00);
/*!40000 ALTER TABLE `artista_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Música',NULL),(2,'Rock',1),(3,'Pop',1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categoria_evento`
--

LOCK TABLES `categoria_evento` WRITE;
/*!40000 ALTER TABLE `categoria_evento` DISABLE KEYS */;
INSERT INTO `categoria_evento` VALUES (1,'Concierto de Rock'),(1,'Festival de Música'),(1,'Gira de Pop'),(2,'Concierto de Rock'),(3,'Festival de Música'),(3,'Gira de Pop');
/*!40000 ALTER TABLE `categoria_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES ('Concierto de Rock','2024-05-15','Estadio XYZ'),('Festival de Música','2024-07-20','Parque ABC'),('Gira de Pop','2024-09-10','Teatro DEF'),('Homenaje Beattles','2024-07-01','Londres');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `patrocinador`
--

LOCK TABLES `patrocinador` WRITE;
/*!40000 ALTER TABLE `patrocinador` DISABLE KEYS */;
INSERT INTO `patrocinador` VALUES ('Empresa X','555-1234'),('Empresa Y','555-5678');
/*!40000 ALTER TABLE `patrocinador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `patrocinador_artistas`
--

LOCK TABLES `patrocinador_artistas` WRITE;
/*!40000 ALTER TABLE `patrocinador_artistas` DISABLE KEYS */;
INSERT INTO `patrocinador_artistas` VALUES (2,'Freddie Mercury','Empresa X'),(2,'John Lennon','Empresa X'),(3,'Michael Jackson','Empresa Y');
/*!40000 ALTER TABLE `patrocinador_artistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `patrocinador_evento`
--

LOCK TABLES `patrocinador_evento` WRITE;
/*!40000 ALTER TABLE `patrocinador_evento` DISABLE KEYS */;
INSERT INTO `patrocinador_evento` VALUES ('Concierto de Rock','Empresa X',5000.00),('Festival de Música','Empresa Y',8000.00),('Gira de Pop','Empresa X',6000.00);
/*!40000 ALTER TABLE `patrocinador_evento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-24 12:21:16
