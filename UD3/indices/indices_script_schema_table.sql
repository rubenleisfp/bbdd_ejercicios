-- Crea la BBDD y la tabla sobre la cual se haran pruebas de inserciones masivas y consultas con indices
CREATE SCHEMA bbdd_performance;

use bbdd_performance;

CREATE TABLE datos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  edad INT,
  ciudad VARCHAR(50),
  salario DECIMAL(10, 2)
);