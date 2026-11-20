-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bbdd_videoclub
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bbdd_videoclub` ;

-- -----------------------------------------------------
-- Schema bbdd_videoclub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbdd_videoclub` DEFAULT CHARACTER SET utf8mb3 ;
USE `bbdd_videoclub` ;

-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`actor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`actor` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`actor` (
  `nombre` VARCHAR(125) NOT NULL,
  `nacionalidad` VARCHAR(125) NULL DEFAULT NULL,
  `sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`actua`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`actua` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`actua` (
  `actor` VARCHAR(125) NOT NULL,
  `id_peli` INT NOT NULL,
  `prota` TINYINT NOT NULL,
  PRIMARY KEY (`actor`, `id_peli`),
  INDEX `fk_Actua_Actores1_idx` (`actor` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`alquila`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`alquila` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`alquila` (
  `dni` CHAR(9) NOT NULL,
  `id_peli` INT NOT NULL,
  `numero` INT NOT NULL,
  `fecha_alquiler` DATE NOT NULL,
  `fecha_devolucion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`dni`, `id_peli`, `numero`, `fecha_alquiler`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`director` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`director` (
  `nombre` VARCHAR(125) NOT NULL,
  `nacionalidad` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`ejemplar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`ejemplar` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`ejemplar` (
  `id_peli` INT NOT NULL,
  `numero` INT NOT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_peli`, `numero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`pelicula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`pelicula` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`pelicula` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(125) NOT NULL,
  `productora` VARCHAR(75) NOT NULL,
  `nacionalidad` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_estreno` CHAR(4) NULL DEFAULT NULL,
  `director` VARCHAR(125) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`socio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`socio` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`socio` (
  `dni` CHAR(9) NOT NULL,
  `nombre` VARCHAR(125) NULL DEFAULT NULL,
  `direccion` VARCHAR(225) NULL DEFAULT NULL,
  `telefono` VARCHAR(10) NULL DEFAULT NULL,
  `avalador` CHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
