
-- =====================================================
-- BASE DE DATOS: bbdd_videoclub
-- =====================================================

-- Eliminación previa de las tablas
DROP TABLE IF EXISTS `actua`;
DROP TABLE IF EXISTS `alquila`;
DROP TABLE IF EXISTS `ejemplar`;
DROP TABLE IF EXISTS `pelicula`;
DROP TABLE IF EXISTS `socio`;
DROP TABLE IF EXISTS `actor`;
DROP TABLE IF EXISTS `director`;

-- =====================================================
-- FASE 1. CREACIÓN DE TODAS LAS TABLAS
-- =====================================================

CREATE TABLE `actor` (
  `nombre` varchar(125) NOT NULL,
  `nacionalidad` varchar(125) DEFAULT NULL,
  `sexo` char(1) NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `actua` (
  `actor` varchar(125) NOT NULL,
  `id_peli` int NOT NULL,
  `prota` tinyint NOT NULL,
  PRIMARY KEY (`actor`,`id_peli`),
  KEY `fk_Actua_Actores1_idx` (`actor`),
  KEY `fk_actua_pelicula` (`id_peli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `alquila` (
  `dni` char(9) NOT NULL,
  `id_peli` int NOT NULL,
  `numero` int NOT NULL,
  `fecha_alquiler` date NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  PRIMARY KEY (`dni`,`id_peli`,`numero`,`fecha_alquiler`),
  KEY `fk_alquila_ejemplar` (`id_peli`,`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `director` (
  `nombre` varchar(125) NOT NULL,
  `nacionalidad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `ejemplar` (
  `id_peli` int NOT NULL,
  `numero` int NOT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_peli`,`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `pelicula` (
  `id` int NOT NULL,
  `titulo` varchar(125) NOT NULL,
  `productora` varchar(75) NOT NULL,
  `nacionalidad` varchar(45) DEFAULT NULL,
  `fecha_estreno` char(4) DEFAULT NULL,
  `director` varchar(125) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pelicula_director` (`director`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `socio` (
  `dni` char(9) NOT NULL,
  `nombre` varchar(125) DEFAULT NULL,
  `direccion` varchar(225) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `avalador` char(9) DEFAULT NULL,
  PRIMARY KEY (`dni`),
  KEY `fk_socio_avalador` (`avalador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- =====================================================
-- FASE 2. ESTABLECIMIENTO DE LAS CLAVES FORÁNEAS
-- =====================================================

-- Tabla ACTUA
ALTER TABLE `actua`
  ADD CONSTRAINT `fk_actua_actor`
    FOREIGN KEY (`actor`) REFERENCES `actor` (`nombre`),
  ADD CONSTRAINT `fk_actua_pelicula`
    FOREIGN KEY (`id_peli`) REFERENCES `pelicula` (`id`);


-- Tabla ALQUILA
ALTER TABLE `alquila`
  ADD CONSTRAINT `fk_alquila_ejemplar`
    FOREIGN KEY (`id_peli`, `numero`)
    REFERENCES `ejemplar` (`id_peli`, `numero`),
  ADD CONSTRAINT `fk_alquila_socio`
    FOREIGN KEY (`dni`) REFERENCES `socio` (`dni`);


-- Tabla EJEMPLAR
ALTER TABLE `ejemplar`
  ADD CONSTRAINT `fk_ejemplar_pelicula`
    FOREIGN KEY (`id_peli`) REFERENCES `pelicula` (`id`);


-- Tabla PELICULA
ALTER TABLE `pelicula`
  ADD CONSTRAINT `fk_pelicula_director`
    FOREIGN KEY (`director`) REFERENCES `director` (`nombre`);


-- Tabla SOCIO
ALTER TABLE `socio`
  ADD CONSTRAINT `fk_socio_avalador`
    FOREIGN KEY (`avalador`) REFERENCES `socio` (`dni`);

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================
