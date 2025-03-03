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




-- Inserción de datos en la tabla 'articulo'
INSERT INTO `bbdd_repuestos_gamer`.`articulo` (`num_articulo`, `descripcion`, `precio`) VALUES
(1, 'Teclado mecánico', 50.00),
(2, 'Mouse óptico', 20.00),
(3, 'Monitor LED 24 pulgadas', 150.00);

-- Inserción de datos en la tabla 'cliente'
INSERT INTO `bbdd_repuestos_gamer`.`cliente` (`num_cliente`, `nif`, `nombre`, `apellido1`, `apellido2`, `limite_credito`, `saldo`) VALUES
(1, '12345678A', 'Juan', 'García', 'López', 500.00, 250.00),
(2, '98765432B', 'María', 'Martínez', 'Pérez', 1000.00, 750.00),
(3, '56781234C', 'Pedro', 'Fernández', 'Gómez', 800.00, 400.00);

-- Inserción de datos en la tabla 'direccione'
INSERT INTO `bbdd_repuestos_gamer`.`direccion` (`id_direccion`, `nombre_via`, `numero`, `piso`, `portal`, `cod_postal`, `ciudad`) VALUES
(1, 'Calle Mayor', '10', '1A', 'B', '28001', 'Madrid'),
(2, 'Avenida Libertad', '25', NULL, '2', '41001', 'Sevilla'),
(3, 'Calle Gran Vía', '50', NULL, '3C', '50001', 'Zaragoza');

-- Inserción de datos en la tabla 'direccione'
INSERT INTO `bbdd_repuestos_gamer`.`cliente_direccionenvio` (`numero_cliente`, `id_direccion`) VALUES (1,1),(2,2),(3,3);


-- Inserción de datos en la tabla 'pedido'
INSERT INTO `bbdd_repuestos_gamer`.`pedido` (`num_pedido`, `num_cliente`, `fecha`, `id_direccion`) VALUES
(1, 1, '2024-03-20', 1),
(2, 2, '2024-03-19', 2),
(3, 3, '2024-03-18', 3);

-- Inserción de datos en la tabla 'linea_pedido'
INSERT INTO `bbdd_repuestos_gamer`.`linea_pedido` (`num_pedido`, `num_articulo`, `cantidad`) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 1, 3),
(3, 2, 2),
(3, 3, 2);


-- Inserción de datos en la tabla 'fabrica'
INSERT INTO `bbdd_repuestos_gamer`.`fabrica` (`num_fabrica`, `telefono`) VALUES
(1, '123456789'),
(2, '987654321'),
(3, '555555555');

-- Inserción de datos en la tabla 'fabricaarticulo'
INSERT INTO `bbdd_repuestos_gamer`.`fabrica_articulo` (`num_fabrica`, `num_articulo`, `cantidad_comprada`) VALUES
(1, 1, 100),
(1, 2, 200),
(2, 2, 150),
(2, 3, 100),
(3, 1, 50),
(3, 3, 75);