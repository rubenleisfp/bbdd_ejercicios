-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bbdd_repuestos_gamer
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bbdd_repuestos_gamer` ;

-- -----------------------------------------------------
-- Schema bbdd_repuestos_gamer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbdd_repuestos_gamer` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema bbdd_eventos_dam
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bbdd_eventos_dam` ;

-- -----------------------------------------------------
-- Schema bbdd_eventos_dam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbdd_eventos_dam` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bbdd_repuestos_gamer` ;

-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`articulo` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`articulo` (
  `num_articulo` INT NOT NULL,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`num_articulo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`cliente` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`cliente` (
  `num_cliente` INT NOT NULL,
  `nif` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido1` VARCHAR(100) NOT NULL,
  `apellido2` VARCHAR(100) NULL DEFAULT NULL,
  `limite_credito` DECIMAL(10,2) NULL DEFAULT NULL,
  `saldo` DECIMAL(10,2) NULL DEFAULT NULL,
  `descuento` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`num_cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`direccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`direccion` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `nombre_via` VARCHAR(255) NULL DEFAULT NULL,
  `numero` VARCHAR(10) NULL DEFAULT NULL,
  `piso` VARCHAR(10) NULL DEFAULT NULL,
  `portal` VARCHAR(10) NULL DEFAULT NULL,
  `cod_postal` VARCHAR(10) NULL DEFAULT NULL,
  `ciudad` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_direccion`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`cliente_direccionenvio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`cliente_direccionenvio` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`cliente_direccionenvio` (
  `numero_cliente` INT NOT NULL,
  `id_direccion` INT NOT NULL,
  PRIMARY KEY (`numero_cliente`, `id_direccion`),
  INDEX `fk_cliente_has_direccionenvio_direccionenvio1_idx` (`id_direccion` ASC) VISIBLE,
  INDEX `fk_cliente_has_direccionenvio_cliente1_idx` (`numero_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_has_direccionenvio_cliente1`
    FOREIGN KEY (`numero_cliente`)
    REFERENCES `bbdd_repuestos_gamer`.`cliente` (`num_cliente`),
  CONSTRAINT `fk_cliente_has_direccionenvio_direccionenvio1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `bbdd_repuestos_gamer`.`direccion` (`id_direccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`fabrica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`fabrica` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`fabrica` (
  `num_fabrica` INT NOT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`num_fabrica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`fabrica_articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`fabrica_articulo` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`fabrica_articulo` (
  `num_fabrica` INT NOT NULL,
  `num_articulo` INT NOT NULL,
  `cantidad_comprada` INT NULL DEFAULT NULL,
  PRIMARY KEY (`num_fabrica`, `num_articulo`),
  INDEX `numero_articulo` (`num_articulo` ASC) VISIBLE,
  CONSTRAINT `fabricaarticulo_ibfk_1`
    FOREIGN KEY (`num_fabrica`)
    REFERENCES `bbdd_repuestos_gamer`.`fabrica` (`num_fabrica`),
  CONSTRAINT `fabricaarticulo_ibfk_2`
    FOREIGN KEY (`num_articulo`)
    REFERENCES `bbdd_repuestos_gamer`.`articulo` (`num_articulo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`pedido` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`pedido` (
  `num_pedido` INT NOT NULL,
  `num_cliente` INT NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `id_direccion` INT NOT NULL,
  PRIMARY KEY (`num_pedido`),
  INDEX `numero_cliente` (`num_cliente` ASC) VISIBLE,
  INDEX `fk_pedido_direccionenvio1_idx` (`id_direccion` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_direccionenvio1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `bbdd_repuestos_gamer`.`direccion` (`id_direccion`),
  CONSTRAINT `pedido_ibfk_1`
    FOREIGN KEY (`num_cliente`)
    REFERENCES `bbdd_repuestos_gamer`.`cliente` (`num_cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_repuestos_gamer`.`linea_pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_repuestos_gamer`.`linea_pedido` ;

CREATE TABLE IF NOT EXISTS `bbdd_repuestos_gamer`.`linea_pedido` (
  `num_pedido` INT NOT NULL,
  `num_articulo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`num_pedido`, `num_articulo`),
  INDEX `fk_detallepedido_articulo1_idx` (`num_articulo` ASC) VISIBLE,
  INDEX `fk_linea_pedido_pedido1_idx` (`num_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_detallepedido_articulo1`
    FOREIGN KEY (`num_articulo`)
    REFERENCES `bbdd_repuestos_gamer`.`articulo` (`num_articulo`),
  CONSTRAINT `fk_linea_pedido_pedido1`
    FOREIGN KEY (`num_pedido`)
    REFERENCES `bbdd_repuestos_gamer`.`pedido` (`num_pedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `bbdd_eventos_dam` ;

-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`categoria` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NOT NULL,
  `id_categoria_superior` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`, `descripcion`),
  INDEX `fk_categoria_categoria1_idx` (`id_categoria_superior` ASC) VISIBLE,
  CONSTRAINT `fk_categoria_categoria1`
    FOREIGN KEY (`id_categoria_superior`)
    REFERENCES `bbdd_eventos_dam`.`categoria` (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`artista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`artista` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`artista` (
  `id_categoria` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`, `nombre`),
  INDEX `id_categoria` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `artista_ibfk_1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `bbdd_eventos_dam`.`categoria` (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`evento` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`evento` (
  `nombre` VARCHAR(255) NOT NULL,
  `fecha_evento` DATE NOT NULL,
  `ubicacion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`artista_evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`artista_evento` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`artista_evento` (
  `artista_id_categoria` INT NOT NULL,
  `artista_nombre` VARCHAR(100) NOT NULL,
  `evento_nombre` VARCHAR(255) NOT NULL,
  `salario` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`artista_id_categoria`, `artista_nombre`, `evento_nombre`),
  INDEX `fk_artista_evento_artista1_idx` (`artista_id_categoria` ASC, `artista_nombre` ASC) VISIBLE,
  INDEX `fk_artista_evento_evento1_idx` (`evento_nombre` ASC) VISIBLE,
  CONSTRAINT `fk_artista_evento_artista1`
    FOREIGN KEY (`artista_id_categoria` , `artista_nombre`)
    REFERENCES `bbdd_eventos_dam`.`artista` (`id_categoria` , `nombre`),
  CONSTRAINT `fk_artista_evento_evento1`
    FOREIGN KEY (`evento_nombre`)
    REFERENCES `bbdd_eventos_dam`.`evento` (`nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`categoria_evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`categoria_evento` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`categoria_evento` (
  `id_categoria` INT NOT NULL,
  `nombre_evento` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_categoria`, `nombre_evento`),
  INDEX `id_categoria` (`id_categoria` ASC) VISIBLE,
  INDEX `fk_categoria_evento_evento1_idx` (`nombre_evento` ASC) VISIBLE,
  CONSTRAINT `evento_categoria_ibfk_2`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `bbdd_eventos_dam`.`categoria` (`id_categoria`),
  CONSTRAINT `fk_categoria_evento_evento1`
    FOREIGN KEY (`nombre_evento`)
    REFERENCES `bbdd_eventos_dam`.`evento` (`nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`patrocinador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`patrocinador` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`patrocinador` (
  `razon_social` VARCHAR(255) NOT NULL,
  `telefono_contacto` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`razon_social`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`patrocinador_artistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`patrocinador_artistas` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`patrocinador_artistas` (
  `id_categoria` INT NOT NULL,
  `nombre_artista` VARCHAR(100) NOT NULL,
  `razon_social` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_categoria`, `nombre_artista`, `razon_social`),
  INDEX `fk_patrocinador_artistas_patrocinador1_idx` (`razon_social` ASC) VISIBLE,
  CONSTRAINT `fk_patrocinador_artistas_artista1`
    FOREIGN KEY (`id_categoria` , `nombre_artista`)
    REFERENCES `bbdd_eventos_dam`.`artista` (`id_categoria` , `nombre`),
  CONSTRAINT `fk_patrocinador_artistas_patrocinador1`
    FOREIGN KEY (`razon_social`)
    REFERENCES `bbdd_eventos_dam`.`patrocinador` (`razon_social`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`patrocinador_evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`patrocinador_evento` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`patrocinador_evento` (
  `nombre_evento` VARCHAR(255) NOT NULL,
  `razon_social` VARCHAR(255) NOT NULL,
  `dinero` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`nombre_evento`, `razon_social`),
  INDEX `fk_patrocinador_evento_patrocinador1_idx` (`razon_social` ASC) VISIBLE,
  INDEX `fk_patrocinador_evento_evento1_idx` (`nombre_evento` ASC) VISIBLE,
  CONSTRAINT `fk_patrocinador_evento_evento1`
    FOREIGN KEY (`nombre_evento`)
    REFERENCES `bbdd_eventos_dam`.`evento` (`nombre`),
  CONSTRAINT `fk_patrocinador_evento_patrocinador1`
    FOREIGN KEY (`razon_social`)
    REFERENCES `bbdd_eventos_dam`.`patrocinador` (`razon_social`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `bbdd_repuestos_gamer` ;

-- -----------------------------------------------------
-- procedure insert_data
-- -----------------------------------------------------

USE `bbdd_repuestos_gamer`;
DROP procedure IF EXISTS `bbdd_repuestos_gamer`.`insert_data`;

DELIMITER $$
USE `bbdd_repuestos_gamer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_data`(IN num_records INT)
BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= num_records DO
    INSERT INTO datos (nombre, edad, ciudad, salario)
    VALUES (CONCAT('Nombre', i), RAND() * 100, CONCAT('Ciudad', i), RAND() * 10000);

    SET i = i + 1;
  END WHILE;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




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

-- Dump completed on 2025-03-03 18:25:49
