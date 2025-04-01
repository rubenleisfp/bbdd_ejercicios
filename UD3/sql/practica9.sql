-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bbdd_eventos_dam
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bbdd_eventos_dam` ;

-- -----------------------------------------------------
-- Schema bbdd_eventos_dam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbdd_eventos_dam` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bbdd_eventos_dam` ;

-- -----------------------------------------------------
-- Table `bbdd_eventos_dam`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_eventos_dam`.`categoria` ;

CREATE TABLE IF NOT EXISTS `bbdd_eventos_dam`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NOT NULL,
  `id_categoria_superior` INT NULL,
  PRIMARY KEY (`id_categoria`, `descripcion`),
  INDEX `fk_categoria_categoria1_idx` (`id_categoria_superior` ASC) VISIBLE,
  CONSTRAINT `fk_categoria_categoria1`
    FOREIGN KEY (`id_categoria_superior`)
    REFERENCES `bbdd_eventos_dam`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
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
  `salario` DECIMAL(10,2) NULL,
  INDEX `fk_artista_evento_artista1_idx` (`artista_id_categoria` ASC, `artista_nombre` ASC) VISIBLE,
  INDEX `fk_artista_evento_evento1_idx` (`evento_nombre` ASC) VISIBLE,
  PRIMARY KEY (`artista_id_categoria`, `artista_nombre`, `evento_nombre`),
  CONSTRAINT `fk_artista_evento_artista1`
    FOREIGN KEY (`artista_id_categoria` , `artista_nombre`)
    REFERENCES `bbdd_eventos_dam`.`artista` (`id_categoria` , `nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artista_evento_evento1`
    FOREIGN KEY (`evento_nombre`)
    REFERENCES `bbdd_eventos_dam`.`evento` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
    REFERENCES `bbdd_eventos_dam`.`evento` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  CONSTRAINT `fk_patrocinador_evento_patrocinador1`
    FOREIGN KEY (`razon_social`)
    REFERENCES `bbdd_eventos_dam`.`patrocinador` (`razon_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patrocinador_evento_evento1`
    FOREIGN KEY (`nombre_evento`)
    REFERENCES `bbdd_eventos_dam`.`evento` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  INDEX `fk_patrocinador_artistas_patrocinador1_idx` (`razon_social` ASC) VISIBLE,
  PRIMARY KEY (`id_categoria`, `nombre_artista`, `razon_social`),
  CONSTRAINT `fk_patrocinador_artistas_patrocinador1`
    FOREIGN KEY (`razon_social`)
    REFERENCES `bbdd_eventos_dam`.`patrocinador` (`razon_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patrocinador_artistas_artista1`
    FOREIGN KEY (`id_categoria` , `nombre_artista`)
    REFERENCES `bbdd_eventos_dam`.`artista` (`id_categoria` , `nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
