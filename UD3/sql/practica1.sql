-- ########## PRACTICA 1. EMPLEADO UD3BBDD1 ############


-- Consulta 1:
-- Muestra los empleados que trabajaron más de 10 horas y cuyo nombre contiene la letra 'A' o 'O'.
-- Debería devolver los empleados con id:[4]
SELECT * FROM empleado WHERE horas > 10 AND (nombre LIKE '%A%' OR nombre LIKE '%O%');

-- Consulta 2:
-- Selecciona los empleados que trabajaron menos de 9 horas o cuya fecha fue antes de '1995-01-01'.
-- Debería devolver los empleados con id:[1,2,3,4,5,6]
SELECT * FROM empleado WHERE horas < 9 OR fecha < '1995-01-01';

-- Consulta 3:
-- Encuentra los empleados cuyo nombre no es 'ANTONIO' y que trabajaron entre 7 y 10 horas.
-- Debería devolver los empleados con id:[2,3,5]
SELECT * FROM empleado WHERE nombre != 'ANTONIO' AND horas BETWEEN 7 AND 10;

-- Consulta 4:
-- Muestra los empleados que trabajaron más de 10 horas o cuya fecha es posterior a '1996-01-01' y cuyo nombre contiene la letra 'E'.
-- Debería devolver los empleados con id:[1,4]
SELECT * FROM empleado WHERE horas > 10 OR (fecha > '1996-01-01' AND nombre LIKE '%E%');

-- Consulta 5:
-- Selecciona los empleados que trabajaron exactamente 8 horas o cuyo nombre empieza con 'JO' y la fecha es nula.
-- Debería devolver los empleados con id:[3,5,6]
SELECT * FROM empleado WHERE (horas = 8) OR (nombre LIKE 'JO%' AND fecha IS NULL);

