-- ########## Ejercicio 3.3.1.2a OPERADORES ############
select length("ruben");
select length(null);
select concat(concat("ruben"," leis")," rodriguez") as nombre_apellidos;
select lower("ruben");
select upper(concat("hola"," mundo"));

-- ########## Ejercicio 3.3.1.3a OPERADORES ############
select 4+ 5.8 as resultado;
select 4+5 as resultado;
select 5/0 as resultado;

select "hola" + 5 as resultado;
select "hola" + 5.8 as resultado;
select cast("hola" as DECIMAL(5,2)) + 5.8 as resultado;

select power(2,1000) as resultado;
select power(2,1023) as resultado;
-- no funciona
-- select power(2,1024) as resultado;

-- ########## Ejercicio 3.3.1.4a FECHAS ############
-- Fecha dentro de 7 dias
SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY) AS FechaDentro7Dias;

SELECT DATE_ADD('2025-02-05', INTERVAL 7 DAY) AS FechaDentro7Dias;
-- Diferencia en dias entre 3 fechas
SELECT DATEDIFF('2007-12-31','2005-7-30') AS DiferenciaEnDias;


-- ########## Ejercicio 3.3.1.4b FECHAS ############
-- Paso 1: Obtener la fecha actual
SELECT CURDATE() AS FechaActual;

-- Paso 2: Calcular la fecha de hace 30 días
SELECT DATE_SUB(CURDATE(), INTERVAL 30 DAY) AS FechaHace30Dias;

-- Paso 3: Mostrar ambas fechas y calcular la diferencia en días
SELECT
    CURDATE() AS FechaActual,
    DATE_SUB(CURDATE(), INTERVAL 30 DAY) AS FechaHace30Dias,
    DATEDIFF(CURDATE(), DATE_SUB(CURDATE(), INTERVAL 30 DAY)) AS DiferenciaEnDias;
    
-- ########## Ejercicio 3.3.1.5 PIXABAY ############
-- Imagen 586 kb
-- MEDIUMBLOB	For BLOBs (Binary Large OBjects). Holds up to 16,777,215 bytes of data


-- ########## Ejercicio 3.3.2.5 OPERADORES COMPARACION ############
SELECT * FROM ud3bbdd1.empleado where nombre = "LOLA"; -- a
SELECT * FROM ud3bbdd1.empleado where horas >=10; -- b
SELECT * FROM ud3bbdd1.empleado where horas <11; -- c
SELECT * FROM ud3bbdd1.empleado where nombre NOT IN ('PEPE', 'EDUARDO'); -- d
SELECT * FROM ud3bbdd1.empleado where horas between 8 and 10; -- e


-- ########## Ejercicio 3.3.2.7 OPERADOR LIKE ############
-- Busca los empleados que empiecen por P. Deberías obtener 2 resultados.
SELECT * FROM ud3bbdd1.empleado where nombre like 'P%';
-- Busca los empleados que empiecen por ANTONI usando el operador _. Deberías obtener 2 resultados
SELECT * FROM ud3bbdd1.empleado where nombre like 'ANTONI_';


-- Busca los empleados que acaben por la letra A.  Deberías obtener 3 resultados
SELECT * FROM ud3bbdd1.empleado where nombre like '%A';
-- Busca empleados que no acaben por NI_.  Deberías obtener 4 resultados
SELECT * FROM ud3bbdd1.empleado where nombre not like '%NI_';


-- ########## Ejercicio 3.3.2.8 OPERADOR IS NULL ############
SELECT * FROM ud3bbdd1.empleado where fecha is null;

-- ########## Ejercicio 3.3.2.9.a OPERADOR AND/OR ############
-- Ley de DeMorgan: 
-- !(A || B) => !A && !B
-- !(A && B) => !A || !B
-- a) ¿Hay registros que cumplan que el nombre sea PEPE y horas >11? 
SELECT * FROM ud3bbdd1.empleado where nombre = 'PEPE' and  horas >11;
-- b) ¿Hay registros que cumpla que el nombre sea pepe o horas>11?
SELECT * FROM ud3bbdd1.empleado where nombre = 'PEPE' or horas >11;
-- c) ¿Hay registros cuyo nombre sea PEPE o tenga 12 horas? 
SELECT * FROM ud3bbdd1.empleado where nombre = 'PEPE' or horas =12;
-- d) ¿Hay registros cuyo nombre no sea PEPE ni tenga 12 horas?
SELECT * FROM ud3bbdd1.empleado where nombre != 'PEPE' and horas !=12;


-- CLASE
-- ########## Ejercicio 3.3.5.1.a w3shools ############
CREATE TABLE Persons (
    PersonID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (PersonID)
);

CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);



-- ########## Ejercicio 3.3.5.1b  ud3bbdd1.usuarios ############
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombreUsuario` varchar(50) NOT NULL,
  `numTotalLikesRecibidos` bigint DEFAULT NULL,
  `fechaAlta` datetime NOT NULL,
  `edad` int NOT NULL,
  `dineroGanado` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `usuarios_chk_1` CHECK ((`edad` >= 18))
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- ########## Ejercicio 3.3.5.4  Drop ############
CREATE TABLE `ud3bbdd1`.`borrame` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(50) NULL,
  PRIMARY KEY (`id`));
  
truncate table borrame;
drop table borrame;


-- ########## Ejercicio 3.3.5.4  Alter ############
CREATE TABLE `ud3bbdd1`.`borrame` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(50) NULL,
  PRIMARY KEY (`id`));
  
  ALTER TABLE `ud3bbdd1`.`borrame` 
ADD COLUMN `descripcion` VARCHAR(50) NULL AFTER `nombre`;



-- ########## Ejercicio 3.3.6.1  Vistas ############

-- CREATE [ OR REPLACE ] VIEW nombre_vista [ (alias1 [, alias2] ...) ]
-- AS SELECT ...

CREATE VIEW jubilacion as select * from empleado where fecha < '1994-1-1';


-- ########## Ejercicio 3.3.7  Indices ############
SELECT * FROM bbdd_performance.datos where ciudad = 'Ciudad1001';

CREATE INDEX ciudad_idx
ON datos (ciudad);

-- mysqldump.exe -u root -p castelao bbdd_backup > bbdd_backup.sql


-- ########## Ejercicio 3.4.1   ############
-- CREATE_USER


-- ########## Ejercicio 3.4.2.1   ############
CREATE USER 'finley'@'localhost' IDENTIFIED BY 'password'; GRANT ALL ON *.* TO 'finley'@'localhost' WITH GRANT OPTION;
CREATE USER 'agente_secreto'@'localhost' IDENTIFIED BY 'password'; GRANT ALL ON  bbdd_secreta.* TO 'agente_secreto'@'localhost' WITH GRANT OPTION;

DROP USER 'finley'@'localhost';
DROP USER 'oscar'@'localhost';
DROP USER 'agente_secreto'@'localhost';

SHOW GRANTS FOR 'finley'@'localhost';
SHOW GRANTS FOR 'agente_secreto'@'localhost';

-- ########## Ejercicio 3.4.2.b   ############
CREATE USER 'compañero'@'192.68.2.4' IDENTIFIED BY 'password'; GRANT ALL ON *.* TO 'compañero'@'192.68.2.4' WITH GRANT OPTION;


