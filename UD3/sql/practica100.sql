-- 1. Encontrar películas estrenadas antes del 2007 con calificación "PG" o "G"
-- Filas devueltas: 372
SELECT *
FROM film
WHERE release_year < 2007
AND rating IN ('PG', 'G');


-- 2. Mostrar películas con título de más de 15 caracteres y con características especiales
-- Filas devueltas: 318
SELECT *
FROM film
WHERE length(title) > 15
AND special_features IS NOT NULL;

-- 3. Encontrar películas con precio de alquiler >= $3 y duración de la pelicula menor a 90 minutos
-- Filas devueltas: 106
SELECT *
FROM film
WHERE rental_rate >= 3
AND length < 90;


-- 4. Seleccionar películas estrenadas en año divisible por 4 
-- Filas devueltas: 0
SELECT *
FROM film
WHERE release_year % 4 = 0;

-- 5. Mostrar películas con "aven" en el título (mayúsculas/minúsculas no importan) y calificación "PG"
-- Filas devueltas: 1
SELECT *
FROM film
WHERE LOWER(title) LIKE '%aven%'
AND rating = 'PG';


-- 6. Encontrar películas con precio de rental rate < 10 o puntuacion igual a G
-- Filas devueltas: 1000
SELECT *
FROM film
WHERE rental_rate < 10
OR rating = 'G';


-- 7. Seleccionar películas estrenadas entre 2005 y 2008 (inclusive) con calificación que no sea G o PG
-- Filas devueltas: 628
SELECT *
FROM film
WHERE release_year BETWEEN 2005 AND 2008
AND rating NOT IN ('G', 'PG');


-- 8. Mostrar películas con título que comience con "C" o "D" y duración mayor a 120 minutos
-- Filas devueltas: 120
SELECT *
FROM film
WHERE title LIKE 'C%' OR title LIKE 'D%'
AND length > 120;


-- 9. Encontrar películas con idioma original diferente al idioma principal. Si es nulo su campo idioma original
-- no la tenemos en cuenta
-- Filas devueltas: 0 
SELECT *
FROM film
WHERE original_language_id is not null and original_language_id != language_id;

-- 10. Seleccionar películas con precio de alquiler > $2.5 y con comentarios como característica especial
-- Filas devueltas: 365
SELECT *
FROM film
WHERE rental_rate > 2.5
AND special_features LIKE '%Commentaries%';

-- 11. Encontrar películas estrenadas en año par, con calificación superior a 3.5 (si... incluso podemos comparar numeros con letras) y que el titulo no contenga "Comedia" o "Drama"
-- Filas devueltas: 405
SELECT * FROM film
WHERE release_year % 2 = 0
AND rating > 3.5
AND title NOT IN ('Comedy', 'Drama');

-- 12. Encontrar películas cuyo id sea 1 o 2 o que tengan un coste de 20, además deberán cumplir que su rating sea PG
-- Filas devueltas: 81
SELECT * FROM sakila.film where (film_id in (1,2) or replacement_cost > 20) and rating = 'PG';

-- 13. Encontrar películas cuyo id sea 1 o 2 o que tengan un coste de 20, además deberán cumplir que su rating sea PG o G
-- Filas devueltas: 165
SELECT * FROM sakila.film where (film_id in (1,2) or replacement_cost > 20) and (rating = 'PG' or rating = 'G');

-- 14. Encontrar películas cuyo id sea 1 o 2, o peliculas que tengan un coste de 20 y que su calificacion sea PG
-- Filas devueltas: 382
SELECT * FROM sakila.film where film_id in (1,2) or replacement_cost > 20 and rating = 'PG';


-- 15. Encontrar películas dónde la suma del tamaño de su descripcion y de la duracion del film sea mayor de 300
-- Filas devueltas: 1
SELECT * FROM sakila.film where length(description) + length > 300;




