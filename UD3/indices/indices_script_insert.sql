-- Procedimiento que cada vez que se ejecuta intenta inserta n elementos. Ejecutar este comando una vez hasta la linea 18 para que cree dicho procedimiento
use bbdd_performance

DELIMITER //

CREATE PROCEDURE insert_data (IN num_records INT)
BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= num_records DO
    INSERT INTO datos (nombre, edad, ciudad, salario)
    VALUES (CONCAT('Nombre', i), RAND() * 100, CONCAT('Ciudad', i), RAND() * 10000);

    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;

--  Ejecutar el procedimiento anteriormente creado, agregando 3000000 filas a la tabla. Ejecutar esta línea al menos 3 veces para insertar muchos elementos
CALL insert_data(300000);
