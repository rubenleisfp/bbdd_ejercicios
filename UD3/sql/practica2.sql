-- ########## PRACTICA 2. SAKILA CUSTOMER ############

-- Consulta 1:
-- Selecciona todos los clientes cuyos nombres empiezan con 'A' y que están activos.
-- Devuelve 44 resultados
SELECT * FROM customer WHERE first_name LIKE 'A%' AND active = 1;

-- Consulta 2:
-- Encuentra los clientes cuyas direcciones de correo electrónico contienen 'gmail' y que pertenecen a la tienda 1.
-- Devuelve 0 resultados
SELECT * FROM customer WHERE email LIKE '%gmail%' AND store_id = 1;

-- Consulta 3:
-- Muestra los clientes que tienen un id entre 25 y 35 y que pertenecen a la tienda 2.
-- Devuelve 7 resultados
SELECT * FROM customer WHERE customer_id BETWEEN 25 AND 35 AND store_id = 2;

-- Consulta 4:
-- Encuentra los clientes cuyo apellido termina con 'son' y que no están activos.
-- Devuelve 1 resultado
SELECT * FROM customer WHERE last_name LIKE '%son' AND active = 0;

-- Consulta 5:
-- Selecciona los clientes cuyo primer nombre tiene exactamente 6 caracteres y que están en la tienda 1.
-- Devuelve 83 resultados
SELECT * FROM customer WHERE LENGTH(first_name) = 6 AND store_id = 1;

-- Consulta 6:
-- Encuentra los clientes cuyo apellido comienzan con 'A' y que tienen un id entre 30 y 40
-- Devuelve 1 resultado
SELECT * FROM customer WHERE last_name LIKE 'A%' AND customer_id BETWEEN 30 AND 40;

-- Consulta 7:
-- Muestra los clientes que pertenecen a la tienda 2 y cuya fecha de creación está entre '2022-01-01' y '2023-01-01'.
-- Devuelve 0 resultados
SELECT * FROM customer WHERE store_id = 2 AND create_date BETWEEN '2022-01-01' AND '2023-01-01';

-- Consulta 8:
-- Selecciona los clientes cuyos nombres contienen la letra 'e' y que pertenecen a la tienda 1 o la tienda 2.
-- Devuelve 337 resultados
SELECT * FROM customer WHERE first_name LIKE '%e%' AND (store_id = 1 OR store_id = 2);

-- Consulta 9:
-- Encuentra los clientes que tienen un correo electrónico que termina con '.org' y que están en la tienda 1.
-- Devuelve 326 resultados
SELECT * FROM customer WHERE email LIKE '%.org' AND store_id = 1;

-- Consulta 10:
-- Muestra los clientes que no están activos y que pertenecen a la tienda 2 o tienen un id mayor de 40
-- Devuelve 560 resultados
SELECT * FROM customer WHERE (active = 0 AND store_id = 2) OR customer_id > 40;