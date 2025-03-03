CREATE DATABASE  IF NOT EXISTS `bbdd_empleados_regiones` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bbdd_empleados_regiones`;

-- ########## PRACTICA 5. REGIONES ############
-- Tabla REGION/COMUNIDAD
DROP TABLE IF EXISTS REGION;
CREATE TABLE REGION (
  CodRegion     	INT,
  Nombre            VARCHAR(50),
  PRIMARY KEY (CodRegion)
);

-- Tabla PROVINCIA
DROP TABLE IF EXISTS PROVINCIA;
CREATE TABLE PROVINCIA (
  CodProvincia     	INT,
  Nombre            VARCHAR(50),
  CodRegion     	INT,

  PRIMARY KEY (CodProvincia),
  FOREIGN KEY (CodRegion)
      REFERENCES REGION(CodRegion) ON DELETE CASCADE
);

-- Tabla LOCALIDAD
DROP TABLE IF EXISTS LOCALIDAD;
CREATE TABLE LOCALIDAD (
  CodLocalidad     	INT,
  Nombre            VARCHAR(50),
  CodProvincia 		INT,
  
  PRIMARY KEY (CodLocalidad),
    FOREIGN KEY (CodProvincia)
      REFERENCES PROVINCIA(CodProvincia)ON DELETE CASCADE
);

-- Tabla EMPLEADO
DROP TABLE IF EXISTS EMPLEADO;
CREATE TABLE EMPLEADO (
  ID     			INT,
  DNI       		VARCHAR(9),
  Nombre            VARCHAR(50),
  FechaNac			DATE,
  Telefono			VARCHAR(15),
  Salario			DECIMAL(8,2),
  CodLocalidad      INT,
  
  PRIMARY KEY (ID),
    FOREIGN KEY (CodLocalidad)
      REFERENCES LOCALIDAD(CodLocalidad) ON DELETE CASCADE
);


/*
-- Query: SELECT * FROM bbdd_empleados_regiones.region
-- Date: 2024-03-12 12:32
*/
INSERT INTO `REGION` (`CodRegion`,`Nombre`) VALUES (12,'Galicia');

INSERT INTO `PROVINCIA` (`CodProvincia`,`Nombre`,`CodRegion`) VALUES (15,'A Coruña',12);
INSERT INTO `PROVINCIA` (`CodProvincia`,`Nombre`,`CodRegion`) VALUES (27,'Lugo',12);

INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (9,'Betanzos',15);
INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (19,'Carballo',15);
INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (31,'Monforte',27);
INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (902,'Burela',27);

INSERT INTO `EMPLEADO` (`ID`,`DNI`,`Nombre`,`FechaNac`,`Telefono`,`Salario`,`CodLocalidad`) VALUES (1,'34795209T','Ruben Leis','1983-04-12','614051949',15000.00,9);
INSERT INTO `EMPLEADO` (`ID`,`DNI`,`Nombre`,`FechaNac`,`Telefono`,`Salario`,`CodLocalidad`) VALUES (2,'34798197T','Lucas Perez','1990-05-11','615879852',300000.53,19);
