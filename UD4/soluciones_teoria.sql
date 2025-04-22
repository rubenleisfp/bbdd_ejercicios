-- 4.1.a INSERT INTO VALUES
CREATE TABLE `customers` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(75) NOT NULL,
  `ContactName` varchar(75) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(45) NOT NULL,
  `PostalCode` varchar(45) DEFAULT NULL,
  `Country` varchar(45) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES
('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway'),
('Greasy Burger', 'Per Olsen', 'Gateveien 15', 'Sandnes', '4306', 'Norway'),
('Tasty Tee', 'Finn Egan', 'Streetroad 19B', 'Liverpool', 'L1 0AA', 'UK');

-- 4.1.b INSERT INTO VALUES
CREATE TABLE `persons` (
  `ID` int NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `persons` (`ID`,`LastName`,`FirstName`,`Age`) VALUES (1,'Fariña','Ramón',21);
INSERT INTO `persons` (`ID`,`LastName`,`FirstName`,`Age`) VALUES (2,'Catoira','Juan',26);

-- 4.1c INSERT INTO VALUES. EVENTOS DAM
INSERT INTO `bbdd_eventos_dam`.`artista` (`id_categoria`, `nombre`, `fecha_nac`,telefono, `email`) VALUES (2,'Ringo Star','1945-01-01','657829382', 'RingoStar@gmail.com');
INSERT INTO `bbdd_eventos_dam`.`artista` (`id_categoria`, `nombre`, `fecha_nac`,`email`) VALUES (2,'Paul McCartney','1945-01-01', 'McCartney@gmail.com');
INSERT INTO `bbdd_eventos_dam`.`evento`(`nombre`,`fecha_evento`,`ubicacion`) VALUES ('Homenaje Beattles','2024-07-01','Londres');
INSERT INTO `bbdd_eventos_dam`.`artista_evento`(`artista_id_categoria`,`artista_nombre`,`evento_nombre`,`salario`) VALUES (2,'Paul McCartney','Homenaje Beattles',0);

-- 4.2.a UPDATE PERSONS
update `persons` set age=27 where LastName = 'Catoira';

update `persons` set FirstName = UPPER(FirstName) where LastName = 'Catoira';
update `persons` set age=20 where FirstName like '%A%';
select * from `persons`;


-- 4.2.b UPDATE EVENTOS_DAM

-- A) Actualiza la información para que la EmpresaX sea la patrocinadora de todos los artistas

select * from `bbdd_eventos_dam`.`patrocinador_artistas`;

select * from `bbdd_eventos_dam`.`patrocinador`;
update `bbdd_eventos_dam`.`patrocinador_artistas` set razon_social='Empresa X' where id_categoria>1;

-- B) Actualiza la información de los eventos para que todos aquellos posteriores al 2024-07-01 se celebren en el Estadio XYZ
select * from bbdd_eventos_dam.evento;
update `bbdd_eventos_dam`.`evento` set ubicacion='Estadio XYZ' where fecha_evento>'2024-07-01';

-- C) Actualiza en una sola sentencia la fecha de nacimiento de Freddie Mercury y su teléfono. Nueva info: 1946-09-04 y 987654322
update `bbdd_eventos_dam`.`artista` set fecha_nac='1946-09-04', telefono='987654322' where nombre='Freddie Mercury';
select * from bbdd_eventos_dam.artista;

-- D) Michael Jackson finalmente no acudirá al Festival de música, en cambio acudirá al Concierto de Rock.
update `bbdd_eventos_dam`.`artista_evento` set evento_nombre = 'Concierto de Rock' where evento_nombre='Festival de Música' and artista_nombre = 'Michael Jackson';
select * from bbdd_eventos_dam.artista_evento;

-- E) Todos los patrocinadores aportarán el mismo dinero a los eventos: 10000.
update `bbdd_eventos_dam`.`patrocinador_evento` set dinero=10000;

select * from patrocinador_evento;


-- 4.4.2 distinct
SELECT distinct length FROM sakila.film;

-- 4.4.3 order
SELECT distinct length FROM sakila.film order by length desc;
SELECT first_name from sakila.actor order by first_name asc;

-- 4.4.5.a where
-- A) Obtén todos los clientes cuyo nombre es igual a Mary. Resultados: 1
SELECT * FROM sakila.customer where first_name="MARY";

-- B) Obtén todos los clientes que no se dieron de baja y pertenecen a la tienda 2. Resultados: 266
SELECT * FROM sakila.customer where active = 1 and store_id=2;

-- C) Obtén todos los clientes que se llaman BARBARA o son de la tienda 1 y que además están activos. Resultados:  319
SELECT * FROM sakila.customer WHERE (first_name = 'BARBARA' OR store_id = 1) AND active = 1 order by first_name;

-- D) Obtén todos los clientes que se llaman KELLY TORRES o cuyo id es 100. Resultados:  2
SELECT * FROM sakila.customer WHERE first_name = 'KELLY' and last_name ='TORRES' or customer_id=100;

-- E) Obtén todos los clientes que se llaman KELLY TORRES, o cuyo id es 100 y  fueron dados de baja. Resultados:  1
SELECT *
FROM sakila.customer
WHERE (first_name = 'KELLY' AND last_name = 'TORRES')
   OR (customer_id = 100 AND active = 0);
   
-- F) Busca los clientes que no sean de la tienda 1. Resultados: 273
SELECT * FROM sakila.customer WHERE store_id != 1;

-- G) Busca los empleados que no sea de la tienda 1 y que tampoco se llamen BARBARA. Resultados: 272
SELECT * FROM sakila.customer WHERE store_id != 1 and first_name != 'BARBARA' order by first_name;


-- 4.4.5.b where
-- A) Clientes activos con nombre 'Juan'. Resultados 1
SELECT * FROM customer WHERE first_name = 'Juan' AND active = 1;

-- B) Clientes de la tienda 2 sin email. Resultados: 0
SELECT * FROM customer WHERE store_id = 2 AND email IS NULL;

-- C) Clientes con apellido 'Perez' o dirección 10. Resultados: 2
SELECT * FROM customer WHERE last_name = 'Perez' OR address_id = 10;

-- D) Clientes 'Perez' sin dirección. Resultados: 0
SELECT * FROM customer WHERE last_name = 'Perez' AND address_id <> 1;

-- E) Clientes creados después del 01/01/2005. Resultados: 599
SELECT * FROM customer WHERE create_date > '2005-01-01';


-- 4.4.6 null
SELECT * FROM sakila.address where address2 is null;
SELECT * FROM sakila.address where address2 is not null;
SELECT * FROM sakila.address where address2 = '';
SELECT * FROM sakila.address where address2 <> '';

-- 4.4.7 top
SELECT * FROM sakila.film LIMIT 5 OFFSET 10;

-- 4.4.8 count
SELECT count(distinct length) FROM sakila.film;
SELECT count(*) FROM sakila.film where rating='PG';
SELECT count(distinct length) FROM sakila.film where rating='PG';

-- 4.4.9a agregados

-- H) Obtén la consulta que indica cuántas copias totales hay en el inventario, agrupado por tienda.
-- A) Obtén el cliente con el menor id.
select min(customer_id) as id_minimo from sakila.customer;
-- B) Obtén el cliente con el menor id.
select max(customer_id) as id_maximo from sakila.customer;
-- C) Obtén el cliente con el menor id, que pertenece a la tienda 2.
select min(customer_id) as id_minimo from sakila.customer where store_id=2;
-- D) Obtén el cliente con el mayor id, que pertenece a la tienda 1.
select max(customer_id) as id_maximo from sakila.customer where store_id=1;
-- E) Obtén el importe total de los pagos realizados en Sakila.
SELECT SUM(amount) FROM sakila.payment;
-- F) ¿Cuánto se paga como media en cada pago de Sakila?
SELECT AVG(amount) FROM sakila.payment;
-- G) Obtén la consulta que indica cuántas copias totales hay en el inventario, agrupado por tienda.
SELECT COUNT(film_id), store_id FROM sakila.inventory group by store_id;
-- H) Obtén el número de copias de cada película agrupadas por tienda
SELECT COUNT(film_id), film_id, store_id FROM sakila.inventory group by store_id, film_id order by film_id;
-- I) Obtén el número de clientes agrupado por activo o no activo.
SELECT count(*), active FROM sakila.customer group by active;
-- J) Obtén el número de clientes que tienen el mismo nombre
SELECT count(*), first_name FROM sakila.customer group by first_name order by  count(*) desc;

-- 4.4.9b agregados
-- A) Obtener el año con más películas estrenadas. Resultado: 2006
SELECT release_year, COUNT(*) AS film_count FROM film GROUP BY release_year ORDER BY film_count DESC LIMIT 1;
-- B) Obtener la lista de ID de películas y el número de copias en el inventario
SELECT film_id, COUNT(*) AS inventory_count FROM inventory GROUP BY film_id;
-- C) Obtener la duración media de la películas. Resultado: 115.27 
SELECT AVG(length) AS average_length FROM film;
-- D) La duración media de las películas según la clasificación (rating)
SELECT film.rating AS clasificacion, AVG(film.length) AS promedio_duracion FROM film GROUP BY film.rating;


-- 4.4.10a having
-- A) Obtén la consulta que indica cuántas copias totales hay en el inventario, agrupado por tienda. Solo de las tiendas con un id mayor que 1. Resultados: 1 registro
SELECT COUNT(film_id), store_id FROM sakila.inventory group by store_id having store_id>1;
-- B) Obtén el número de copias de cada película agrupadas por tienda, solo de las peliculas con 3 copias o más. Resultados: 1014 registros
SELECT COUNT(film_id), film_id, store_id FROM sakila.inventory group by store_id, film_id  having COUNT(film_id)>=3 order by film_id;
-- C) Obtén aquellos clientes cuyo nombre es compartido por otro clientes, es decir, que hay al menos 2 con el mismo nombre. Resultados: 8 registros
SELECT count(*), first_name FROM sakila.customer group by first_name having count(*)>1 order by  count(*) desc;


-- 4.4.10b having
-- A) Obtener el numero de peliculas por año posteriores al 2000
SELECT release_year, COUNT(*) AS film_count FROM sakila.film GROUP BY release_year having release_year > 200 ORDER BY film_count DESC LIMIT 1;
-- B) Obtener la lista de ID de películas y el número de copias en el inventario de las peliculas con id menor de 10
SELECT film_id, COUNT(*) AS inventory_count FROM sakila.inventory GROUP BY film_id having film_id <10;
-- C) La duración media de las películas según la clasificación (rating) menos de la clasificación PG
SELECT film.rating AS clasificacion, AVG(film.length) AS promedio_duracion FROM sakila.film GROUP BY film.rating having rating <> 'PG';

-- 4.4.11 LIKE Y WILDCARDS
-- A) Busca los clientes cuyo nombre comience por R. Resultados: 41 registros
SELECT * FROM sakila.customer where first_name like 'R%';

-- B) Busca los clientes cuyo email empiece por RU. Resultados: 4 registros
SELECT * FROM sakila.customer where first_name like 'RU%';

-- C) Busca los clientes de la tienda 1, cuyo nombre empiece por M. Resultados: 30 registros
SELECT * FROM sakila.customer where store_id=1 and first_name like 'M%';

-- D) Busca los clientes de la tienda 1 o cuyo nombre empiece por M. Resultados: 347 registros
SELECT * FROM sakila.customer where store_id=1 or first_name like 'M%'; 

-- E) Busca los clientes cuyo nombre acabe en alter. Resultados: 1 registro
SELECT * FROM sakila.customer where first_name like '%ALTER'; 

-- F) Busca los clientes de 4 letras que empiece por MAR. Resultados: 3 registros
SELECT * FROM sakila.customer where first_name like 'MAR_'; 

-- E) Busca los clientes de 5 letras que terminen por INDA. Resultados: 1 registro
SELECT * FROM sakila.customer where first_name like '_INDA'; 

-- F) Busca los clientes de 5 letras con una R en medio.sResultados: 27 registros
SELECT * FROM sakila.customer where first_name like '__R__'; 


-- 4.4.12 select in
select * from sakila.film where rating in ('PG','G');
select * from sakila.film where rating not in ('PG');

-- 4.4.13.a alias
select * from sakila.customer as NUM_CLIENTES_RU where email like 'RU%';

-- Ejemplo algebra relacional
DROP TABLE IF EXISTS `r`;
CREATE TABLE `r` (
  `Id` int NOT NULL,
  `X` char(1) NOT NULL,
  `N` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `r` WRITE;
INSERT INTO `r` VALUES (1,'a',1),(2,'a',2),(3,'b',3);
UNLOCK TABLES;

CREATE TABLE `s` (
  `Id` int NOT NULL,
  `X` char(1) DEFAULT NULL,
  `N` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `s` WRITE;
INSERT INTO `s` VALUES (1,'a',2),(2,'b',4);
UNLOCK TABLES;

LOCK TABLES `tipos_datos` WRITE;

UNLOCK TABLES;


--Producto cartesiano
select r.x, r.n, s.x,r.n from r inner join s

--Producto cartesiano con condicion
select r.x, r.n, s.x,r.n from r inner join s where r.x = s.x

--Ejemplo paises
select * from city inner join country
on city.CountryCode = country.Code
where country.Name = 'Spain'


-- 4.4.14a inner join
-- A) Muestra las ciudades con su país correspondiente al lado, ordenadas alfabeticamente.
SELECT city, country FROM sakila.city inner join sakila.country on city.country_id = country.country_id order by city;


-- B) Copia la query anterior y filtra los resultados para obtener solo aquellas que pertenecen a España ordenadas alfabeticamente por ciudad
SELECT city, country FROM sakila.city inner join sakila.country on city.country_id = country.country_id
	where country = 'Spain' order by city;

SELECT city 
FROM sakila.city 
WHERE country_id IN (SELECT country_id FROM sakila.country WHERE country = 'Spain') 
ORDER BY city;

-- C) Muestra el email de los clientes y el id del manager de la tienda a la que pertenecen
SELECT email, manager_staff_id FROM sakila.customer c inner join sakila.store s on c.store_id = s.store_id;

-- D) Cuenta el numero de clientes que pertenecen a la tienda cuyo manager tiene el id 2 (resultado: 273)
SELECT count(*) FROM sakila.customer c inner join sakila.store s on c.store_id = s.store_id
	where manager_staff_id=2;

-- E) Muestra el email de los clientes y el nombre de su direccion
SELECT email, address FROM sakila.customer c inner join sakila.address a on c.address_id = a.address_id;


-- TODO: FALTAN POR CORREGIR ESTAS
-- F) Muestra el email de los clientes y el nombre de su direccion.  Muestra solo aquellos cuya email empieza por M (51 resultados)
SELECT email, address FROM sakila.customer c inner join sakila.address a on c.address_id = a.address_id
	where email like 'M%';

-- G) Muestra las peliculas con su titulo y el nombre de la categoria a la que pertenecen, ordenadas alfabeticamente por el titulo
SELECT title, name FROM sakila.film inner join sakila.film_category on film.film_id = film_category.film_id
									inner join sakila.category on film_category.category_id=category.category_id
                                    order by title asc;
                                    
-- H) Obten peliculas que solo son documentales. Resultado: 68 registros
SELECT title, name FROM sakila.film inner join sakila.film_category on film.film_id = film_category.film_id
									inner join sakila.category on film_category.category_id=category.category_id
                                    where name="Documentary"
                                    order by title asc;

-- 4.4.14b inner join optativa
-- A) Obten el total de peliculas del inventario de la tienda 1. Resultados: 2270 registros
SELECT count(*) FROM sakila.inventory inner join sakila.store on inventory.store_id =store.store_id
	where  inventory.store_id=1;
    
-- B) Muestra todos los titulos distintos de peliculas del inventario de la tienda 1. Resultados: 759
SELECT distinct(title) FROM sakila.inventory inner join sakila.store on inventory.store_id =store.store_id
							   inner join sakila.film on inventory.film_id = film.film_id
	where  inventory.store_id=1;
    
-- C) Muestra el nombre todos los actores que han participado en la pelicula ALABAMA DEVIL ordenados por nombre. Resultados: 9 registros
SELECT first_name, title FROM sakila.actor inner join sakila.film_actor on actor.actor_id = film_actor.actor_id  
					inner join sakila.film on film_actor.film_id = film.film_id
                    where title = 'ALABAMA DEVIL' order by first_name;

-- D) Muestra todos los actores que hayan participado en alguna peliculas de animación. Resultados: 361 registros
SELECT * FROM sakila.actor inner join sakila.film_actor on actor.actor_id = film_actor.actor_id  
					inner join sakila.film on film_actor.film_id = film.film_id
					inner join sakila.film_category on film.film_id = film_category.film_id
					inner join sakila.category on film_category.category_id=category.category_id
                    where category.name = "Animation" order by first_name, last_name;

                    
-- E) Muestra todas los titulos de las peliculas alquiladas por el cliente con email JOEL.FRANCISCO@sakilacustomer.org
-- en orden alfabetico inverso
select  title, email from sakila.customer inner join sakila.rental on customer.customer_id = rental.customer_id 
					   inner join sakila.inventory on rental.inventory_id = inventory.inventory_id
                       inner join sakila.film on inventory.film_id =  film.film_id where email='JOEL.FRANCISCO@sakilacustomer.org'
                       order by title desc;
					
-- F) La suma total de los importes pagados por el cliente con el email JOEL.FRANCISCO@sakilacustomer.org. Resultado: 
select SUM(amount) from sakila.customer inner join sakila.payment on customer.customer_id=payment.customer_id
where email='JOEL.FRANCISCO@sakilacustomer.org';


-- Ejemplos de LEFT JOIN y RIGHT JOIN
select * from clientes inner join pedidos on pedidos.cliente_id = clientes.id;
select * from clientes left join pedidos on pedidos.cliente_id = clientes.id;
select * from pedidos right join clientes on pedidos.cliente_id = clientes.id;

-- 4.4.15a left join
-- A) Dentro de la BBDD bbdd_tienda. Obtén el nombre, apellido de todos los clientes y de aquellos que hayan comprado algo, el nombre del producto.
SELECT clientes.nombre, clientes.apellido, pedidos.producto FROM bbdd_tienda.clientes LEFT JOIN bbdd_tienda.pedidos ON clientes.id = pedidos.cliente_id;

SELECT nombre, apellido
FROM bbdd_tienda.clientes
WHERE id NOT IN (
    SELECT cliente_id
    FROM bbdd_tienda.pedidos
);

-- B) Dentro de la BBDD bbdd_tienda. Cómo podrías filtrar para obtener aquellos clientes que no han realizado ninguna compra.
SELECT clientes.nombre, clientes.apellido, pedidos.producto FROM bbdd_tienda.clientes LEFT JOIN bbdd_tienda.pedidos ON clientes.id = pedidos.cliente_id
where producto is null;

-- C) Busca en Sakila peliculas sin categoria asignada ¿Hay alguna?
SELECT title, film_category.category_id FROM sakila.film left join sakila.film_category on film.film_id = film_category.film_id
where category_id is null;

SELECT name FROM sakila.category
	WHERE category_id NOT IN (
		SELECT category_id
		FROM film_category
	);
    
-- 4.4.16 subqueries
-- A) Muestra las ciudades que pertenecen a España
SELECT *
FROM sakila.city 
WHERE country_id IN (SELECT country_id FROM sakila.country WHERE country = 'Spain') 
ORDER BY city;

-- B) Cuenta el numero de clientes que pertenecen a la tienda cuyo manager tiene el id 2 (resultado: 273)
SELECT count(*) 
FROM sakila.customer 
WHERE store_id IN (SELECT store_id FROM sakila.store WHERE manager_staff_id = 2);

-- C) Muestra el email de los clientes y el nombre de su direccion.  Muestra solo aquellos cuya email empieza por M (19 resultados)
SELECT email
FROM sakila.customer 
WHERE address_id IN (SELECT address_id FROM sakila.address WHERE email LIKE '%M%');

-- D) Busca en Sakila peliculas sin categoria asignada. Resultados: 0 registros
SELECT name FROM sakila.category
	WHERE category_id NOT IN (
		SELECT category_id
		FROM film_category
	);