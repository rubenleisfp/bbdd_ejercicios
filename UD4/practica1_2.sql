#  --------------------------- Practica 1. Junior  --------------------------
-- https://www.discoduroderoer.es/ejercicios-propuestos-y-resueltos-sakila-mysql/
-- 1. Actores que tienen de primer nombre ‘Scarlett’.
SELECT * 
FROM actor 
WHERE upper(first_name) = 'SCARLETT';

-- 2. Actores que tienen de apellido ‘Johansson’.
SELECT * 
FROM actor 
WHERE upper(last_name) = 'JOHANSSON';

-- 3. Actores que contengan una ‘O’ en su nombre.
SELECT * 
FROM actor 
WHERE upper(first_name) LIKE '%O%';

-- 4. Actores que contengan una ‘O’ en su nombre y en una ‘A’ en su apellido. Resultados: 16 registros.
SELECT * 
FROM actor 
WHERE upper(first_name) LIKE '%O%'
AND upper(last_name) LIKE '%A%';

-- 5. Actores que contengan dos ‘O’ en su nombre y en una ‘A’ en su apellido. Resultados: 3 registros.
SELECT * 
FROM actor 
WHERE upper(first_name) LIKE '%O%O%'
AND upper(last_name) LIKE '%A%';

-- 6. Actores donde su tercera letra sea ‘B’.
SELECT * 
FROM actor 
WHERE upper(first_name) LIKE '__B%';

-- 7. Ciudades que empiezan por ‘a’.
SELECT * 
FROM city 
WHERE upper(city) LIKE 'A%';

-- 8. Ciudades que acaban por ‘s’.
SELECT * 
FROM city 
WHERE upper(city) LIKE '%S';

-- 9. Ciudades del country 61.
SELECT * 
FROM city 
WHERE country_id = 61;

-- 11. Ciudades con nombres compuestos. Resultado: 92 registros
SELECT * 
FROM city 
WHERE city LIKE '% %';

-- 12. Películas con una duración entre 80 y 100. Resultado: 147 registros
SELECT * 
FROM film 
WHERE length >= 80 and length <= 100;


-- 13. Peliculas con un rental_rate entre 1 y 3. Resultado: 323 registros
SELECT * 
FROM film 
WHERE rental_rate >= 1 
AND rental_rate <= 3;

-- 15. Peliculas con un rating de PG o G. Resultados: 372 registros
SELECT * 
FROM film 
WHERE rating = 'PG'
OR rating = 'G';

-- 16. Peliculas que no tengan un rating de NC-17. Resultados: 790 registros
SELECT * 
FROM film 
WHERE rating <> 'NC-17';

-- 17. Peliculas con un rating PG y duracion de más de 120. Resultados: 82 registros
SELECT * 
FROM film 
WHERe rating = 'PG'
AND length >= 120;

-- 18. ¿Cuantos actores hay?
SELECT COUNT(*) as num_actor 
FROM actor;

-- 20. ¿Cuántos countries hay que empiezan por ‘a’? Resultado: 10
SELECT COUNT(*) as num_countries 
FROM country 
WHERE upper(country) LIKE 'A%';

-- 21. Media de duración de peliculas con PG. Resultado: 112 
SELECT AVG(length) as media_duracion 
FROM film 
WHERE rating = 'PG';

-- 22. Suma de rental_rate de todas las peliculas. Resultado: 2980
SELECT SUM(rental_rate) as suma_rental 
FROM film;

-- 23. Pelicula con mayor duración.
SELECT MAX(length) as mayor_duracion 
FROM film;

-- 24. Película con menor duración.
SELECT MIN(length) as mayor_duracion 
FROM film;




#  --------------------------- Practica 2. Senior --------------------------
-- https://github.com/ashok-bidani/MySQL-Sakila-queries-and-joins/blob/master/MySQL%20-%20Sakila%20Queries%20and%20Joins.sql
-- 1. Películas con un titulo de más de 12 letras. Resultado: 691
SELECT title, length(title) as longitud 
FROM film 
WHERE length(title) > 12;

-- 2. Numero de películas de cada rating. Resultado: Ej PG 194
SELECT rating, count(*)
FROM film
GROUP BY rating;

-- 3. Media de duración de las películas cada categoría. Resultado: Ej: Action 111.6094
SELECT c.name, avg(f.length) as media_duracion FROM category c 
	inner join film_category fc on fc.category_id = c.category_id
    inner join film f on fc.film_id = f.film_id
    group by c.name;
		

-- 4. Mostrar el nombre de la película y el de sus categorías.
SELECT f.title, c.name  FROM category c 
	inner join film_category fc on fc.category_id = c.category_id
    inner join film f on fc.film_id = f.film_id
ORDER BY f.title;


-- 5.Queremos lanzar una campaña de marketing en Canada. Necesitamos los nombres y direcciones de los clientes canadienses. Resultado: 5 registros
  SELECT c.first_name, c.last_name, c.email, a.address
  FROM customer c
  inner JOIN address a ON (c.address_id = a.address_id)
  inner JOIN city ci ON (a.city_id = ci.city_id)
  inner JOIN country ctr ON (ci.country_id = ctr.country_id)
  WHERE ctr.country = 'canada';

-- 6. Mostrar el country, la ciudad y dirección de cada miembro del staff. Resultado: 2 registros
SELECT co.country, c.city, a.address, a.address2, s.first_name, s.last_name
FROM country co
INNER JOIN city c ON co.country_id = c.country_id
INNER JOIN address a ON a.city_id = c.city_id
INNER JOIN staff s ON s.address_id = a.address_id;


-- 7. Mostrar el nombre de la película y el nombre de los actores. Resultado: 37 registros
SELECT f.title, a.first_name, a.last_name
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
ORDER BY f.title;

-- 8. Lista cada pelicula y el numero de actores que han participado en ella ordenadas de mas actores a menos. Resultado: Ej: ACADEMY ... 10
  SELECT f.title, COUNT(a.actor_id) AS 'Number of Actors'
  FROM film f
  INNER join film_actor a 
  ON (f.film_id = a.film_id)
  GROUP BY f.title
  ORDER BY 'Number of Actors' DESC;

-- 9. Ventas quiere dar promoción a todas las peliculas familiares. Identificalas. Resultado: 69 registros
  SELECT title, c.name
  FROM film f
  JOIN film_category fc
  ON (f.film_id = fc.film_id)
  JOIN category c
  ON (c.category_id = fc.category_id)
  WHERE name = 'family';

-- 10. Muestra las peliculas mas alquiladas por orden descendente de alquileres. Resultados: Ej Bucket... 34
  SELECT title, COUNT(title) as 'Rentals'
  FROM film
  JOIN inventory
  ON (film.film_id = inventory.film_id)
  JOIN rental
  ON (inventory.inventory_id = rental.inventory_id)
  GROUP by title
  ORDER BY rentals desc;

-- 11. Cuantas películas ha realizado el actor ED CHASE. Resultado: 22
SELECT first_name, last_name, count(*)
FROM actor a, film f, film_actor fa
WHERE f.film_id = fa.film_id 
AND a.actor_id = fa.actor_id
AND first_name = 'ED'
AND last_name = 'CHASE'
GROUP BY first_name, last_name;

-- 12. ¿Cuántas ciudades tiene el country ‘Spain’? Resultado: 5 registros
SELECT COUNT(*) as num_cities 
FROM city 
WHERE country_id = (SELECT country_id from country where upper(country) = 'SPAIN');


-- Más:
-- https://datamastery.gitlab.io/exercises/sakila-queries.html