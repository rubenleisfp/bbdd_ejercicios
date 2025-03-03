-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bbdd_videoclub
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bbdd_videoclub` ;

-- -----------------------------------------------------
-- Schema bbdd_videoclub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbdd_videoclub` DEFAULT CHARACTER SET utf8 ;
USE `bbdd_videoclub` ;

-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`Director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`Director` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`Director` (
  `Nombre` VARCHAR(125) NOT NULL,
  `Nacionalidad` VARCHAR(45) NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`Pelicula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`Pelicula` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`Pelicula` (
  `ID` INT NOT NULL,
  `Titulo` VARCHAR(125) NOT NULL,
  `Productora` VARCHAR(75) NOT NULL,
  `Nacionalidad` VARCHAR(45) NULL,
  `Fecha` CHAR(4) NULL,
  `Director` VARCHAR(125) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Pelicula_Director1_idx` (`Director` ASC) VISIBLE,
  CONSTRAINT `fk_Pelicula_Director1`
    FOREIGN KEY (`Director`)
    REFERENCES `bbdd_videoclub`.`Director` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`Actores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`Actores` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`Actores` (
  `Nombre` VARCHAR(125) NOT NULL,
  `Nacionalidad` VARCHAR(125) NULL,
  `Sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`Actua`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`Actua` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`Actua` (
  `Actor` VARCHAR(125) NOT NULL,
  `ID_Peli` INT NOT NULL,
  `Prota` TINYINT NOT NULL,
  INDEX `fk_Actua_Pelicula_idx` (`ID_Peli` ASC) VISIBLE,
  INDEX `fk_Actua_Actores1_idx` (`Actor` ASC) VISIBLE,
  PRIMARY KEY (`Actor`, `ID_Peli`),
  CONSTRAINT `fk_Actua_Pelicula`
    FOREIGN KEY (`ID_Peli`)
    REFERENCES `bbdd_videoclub`.`Pelicula` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actua_Actores1`
    FOREIGN KEY (`Actor`)
    REFERENCES `bbdd_videoclub`.`Actores` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`Socio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`Socio` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`Socio` (
  `DNI` CHAR(9) NOT NULL,
  `Nombre` VARCHAR(125) NULL,
  `Direccion` VARCHAR(225) NULL,
  `Telefono` VARCHAR(10) NULL,
  `Avalador` CHAR(9) NULL,
  PRIMARY KEY (`DNI`),
  INDEX `fk_Socio_Socio1_idx` (`Avalador` ASC) VISIBLE,
  CONSTRAINT `fk_Socio_Socio1`
    FOREIGN KEY (`Avalador`)
    REFERENCES `bbdd_videoclub`.`Socio` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`Ejemplar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`Ejemplar` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`Ejemplar` (
  `ID_Peli` INT NOT NULL,
  `Numero` INT NOT NULL,
  `Estado` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_Peli`, `Numero`),
  INDEX `fk_Ejemplar_Pelicula1_idx` (`ID_Peli` ASC) VISIBLE,
  CONSTRAINT `fk_Ejemplar_Pelicula1`
    FOREIGN KEY (`ID_Peli`)
    REFERENCES `bbdd_videoclub`.`Pelicula` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbdd_videoclub`.`alquila`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbdd_videoclub`.`alquila` ;

CREATE TABLE IF NOT EXISTS `bbdd_videoclub`.`alquila` (
  `DNI` CHAR(9) NOT NULL,
  `ID_Peli` INT NOT NULL,
  `Numero` INT NOT NULL,
  `FechaAlquiler` DATE NOT NULL,
  `FechaDevolucion` DATE NULL,
  PRIMARY KEY (`DNI`, `ID_Peli`, `Numero`, `FechaAlquiler`),
  INDEX `fk_alquila_Ejemplar1_idx` (`ID_Peli` ASC, `Numero` ASC) VISIBLE,
  CONSTRAINT `fk_alquila_Socio1`
    FOREIGN KEY (`DNI`)
    REFERENCES `bbdd_videoclub`.`Socio` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alquila_Ejemplar1`
    FOREIGN KEY (`ID_Peli` , `Numero`)
    REFERENCES `bbdd_videoclub`.`Ejemplar` (`ID_Peli` , `Numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Actores
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Marlon Brando','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Al Pacino','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Robert De Niro','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('John Travolta','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Samuel L. Jackson','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Uma Thurman','USA','M');

-- Director
INSERT INTO `bbdd_videoclub`.`director` (`Nombre`, `Nacionalidad`) VALUES ('Francis Ford Coppola','USA');
INSERT INTO `bbdd_videoclub`.`director` (`Nombre`, `Nacionalidad`) VALUES ('Martin Scorsese','USA');
INSERT INTO `bbdd_videoclub`.`director` (`Nombre`, `Nacionalidad`) VALUES ('Quentin Tarantino','USA');

-- Pelicula
INSERT INTO `bbdd_videoclub`.`pelicula` (`ID`,`Titulo`,`Productora`,`Nacionalidad`,`Fecha`,`Director`) VALUES (1,'El Padrino','Paramount', 'USA','1972','Francis Ford Coppola');
INSERT INTO `bbdd_videoclub`.`pelicula` (`ID`,`Titulo`,`Productora`,`Nacionalidad`,`Fecha`,`Director`) VALUES (2,'Uno de los nuestros','Warner', 'USA','1990','Martin Scorsese');
INSERT INTO `bbdd_videoclub`.`pelicula` (`ID`,`Titulo`,`Productora`,`Nacionalidad`,`Fecha`,`Director`) VALUES (3,'Pulp Fiction','Miramax', 'USA','1994','Quentin Tarantino');

-- Actua
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Marlon Brando',1,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Al Pacino',1,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Al Pacino',2,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Robert De Niro',2,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('John Travolta',3,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Samuel L. Jackson',3,0);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Uma Thurman',3,1);

-- Ejemplares
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (1,1, 'Nuevo');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (1,2, 'Segunda mano');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (2,1, 'Nuevo');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (2,2, 'Segunda mano');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (3,1, 'Nuevo');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (3,2, 'Segunda mano');

-- Socio
INSERT INTO `bbdd_videoclub`.`socio` (`DNI`,`Nombre`,`Direccion`,`Telefono`,`Avalador`) VALUES('34895298U', 'Raul Sanchez Gomez', 'Calle Rosal 32, A Coruña 15007', '615054879',null);
INSERT INTO `bbdd_videoclub`.`socio` (`DNI`,`Nombre`,`Direccion`,`Telefono`,`Avalador`) VALUES('45214786T', 'Sandra Pérez Fernández', 'Calle Rosal 34, A Coruña 15007', '632547979',null);

-- Alquila
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('34895298U',3,2,'2023-05-04',null);
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('34895298U',2,1,'2023-05-05',null);
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('45214786T',1,1,'2023-05-03','2023-05-04');
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('45214786T',2,2,'2023-05-04','2023-05-05');

-- ¿Qué película/películas dirigió Martin Scorsese?
SELECT * FROM bbdd_videoclub.pelicula where Director = 'Martin Scorsese';

-- ¿Qué actores han participado en Pulp Fiction?
SELECT * FROM ACTUA WHERE ID_PELI =3;

-- ¿Cuántos ejemplares hay de “Uno de los nuestros”?
SELECT COUNT(*) FROM EJEMPLAR WHERE ID_PELI = 2;

-- ¿Qué películas alquiló el DNI 45214786T? ¿Ya las devolvió?
select * FROM ALQUILA WHERE DNI='45214786T';

