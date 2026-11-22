CREATE VIEW v_catalogo AS
SELECT id, titulo, fecha_estreno AS anio, productora, director
FROM pelicula;

CREATE VIEW v_peliculas_espanolas AS
SELECT id, titulo, fecha_estreno AS anio, director
FROM pelicula
WHERE nacionalidad = 'España';

CREATE VIEW v_peliculas_recientes AS
SELECT id, titulo, fecha_estreno AS anio
FROM pelicula
WHERE fecha_estreno >= '2000'
ORDER BY fecha_estreno DESC;

CREATE VIEW v_alquileres_sin_devolver AS
SELECT dni, id_peli, numero AS ejemplar, fecha_alquiler
FROM alquila
WHERE fecha_devolucion IS NULL;

CREATE VIEW v_ejemplares_buen_estado AS
SELECT id_peli, numero, estado
FROM ejemplar
WHERE estado IN ('Nuevo', 'Bueno');

CREATE VIEW v_actores_espanoles AS
SELECT nombre, sexo
FROM actor
WHERE nacionalidad = 'España';