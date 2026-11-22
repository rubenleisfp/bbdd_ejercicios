-- ============================================================================
-- UD3 · 3.6 · Vistas
-- Datos de partida del esquema bbdd_videoclub (nombres estándar)
--
-- Requisito: tener creado el esquema bbdd_videoclub con sus siete tablas
-- (director, pelicula, ejemplar, actor, actua, socio, alquila).
--
-- Es reejecutable: vacía las tablas (de hijas a padres) y carga los mismos
-- datos. Úsalo para volver al punto de partida durante las prácticas.
-- Los datos son de prueba y el reparto es orientativo.
-- ============================================================================

USE bbdd_videoclub;

-- ----------------------------------------------------------------------------
-- 1) Vaciar (de hijas a padres). Safe Updates se desactiva solo en esta sesión.
-- ----------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;
DELETE FROM alquila;
DELETE FROM actua;
DELETE FROM ejemplar;
DELETE FROM pelicula;
DELETE FROM director;
DELETE FROM actor;
UPDATE socio SET avalador = NULL;      -- rompe las referencias entre socios
DELETE FROM socio;
SET SQL_SAFE_UPDATES = 1;

-- ----------------------------------------------------------------------------
-- 2) Cargar (de padres a hijas)
-- ----------------------------------------------------------------------------
INSERT INTO director (nombre, nacionalidad) VALUES
  ('Steven Spielberg',       'Estados Unidos'),
  ('Alejandro Amenábar',     'España'),
  ('Guillermo del Toro',     'México'),
  ('Pedro Almodóvar',        'España'),
  ('Director sin películas', 'España');

INSERT INTO pelicula (id, titulo, productora, nacionalidad, fecha_estreno, director) VALUES
  (1, 'Tiburón',                'Universal Pictures', 'Estados Unidos', '1975', 'Steven Spielberg'),
  (2, 'Los otros',              'Sogecine',           'España',         '2001', 'Alejandro Amenábar'),
  (3, 'El laberinto del fauno', 'Estudios Picasso',   'España',         '2006', 'Guillermo del Toro'),
  (4, 'Mar adentro',            'Sogecine',           'España',         '2004', 'Alejandro Amenábar'),
  (5, 'Parque Jurásico',        'Universal Pictures', 'Estados Unidos', '1993', 'Steven Spielberg'),
  (6, 'Volver',                 'El Deseo',           'España',         '2006', 'Pedro Almodóvar');

INSERT INTO ejemplar (id_peli, numero, estado) VALUES
  (1, 1, 'Bueno'), (1, 2, 'Deteriorado'), (2, 1, 'Nuevo'), (3, 1, 'Bueno'),
  (4, 1, 'Nuevo'), (5, 1, 'Bueno'),       (5, 2, 'Nuevo'), (6, 1, 'Nuevo');

INSERT INTO actor (nombre, nacionalidad, sexo) VALUES
  ('Roy Scheider',  'Estados Unidos', 'M'),
  ('Nicole Kidman', 'Australia',      'F'),
  ('Ivana Baquero', 'España',         'F'),
  ('Maribel Verdú', 'España',         'F'),
  ('Javier Bardem', 'España',         'M'),
  ('Sam Neill',     'Nueva Zelanda',  'M'),
  ('Penélope Cruz', 'España',         'F');

INSERT INTO actua (actor, id_peli, prota) VALUES
  ('Roy Scheider',  1, 1), ('Nicole Kidman', 2, 1), ('Ivana Baquero', 3, 1),
  ('Maribel Verdú', 3, 0), ('Javier Bardem', 4, 1), ('Sam Neill',     5, 1),
  ('Penélope Cruz', 6, 1), ('Maribel Verdú', 6, 0);

INSERT INTO socio (dni, nombre, direccion, telefono, avalador) VALUES
  ('11111111A', 'Ana Ruiz',   'C/ Mayor 1, A Coruña', '600000001', NULL),
  ('22222222B', 'Beto Gil',   'C/ Real 5, Ferrol',    '600000002', '11111111A'),
  ('33333333C', 'Carla Sanz', 'Av. Mar 20, Santiago', '600000003', '11111111A'),
  ('44444444D', 'Dani Roca',  'C/ Sol 8, Lugo',       '600000004', '22222222B'),
  ('55555555E', 'Eva Pardo',  'Rúa Nova 3, Viveiro',  '600000005', '22222222B');

INSERT INTO alquila (dni, id_peli, numero, fecha_alquiler, fecha_devolucion) VALUES
  ('22222222B', 1, 1, '2026-10-20', '2026-10-22'),
  ('33333333C', 2, 1, '2026-11-02', NULL),
  ('22222222B', 3, 1, '2026-11-05', NULL),
  ('44444444D', 5, 1, '2026-10-28', '2026-11-01'),
  ('44444444D', 5, 2, '2026-11-10', NULL),
  ('11111111A', 4, 1, '2026-11-12', '2026-11-14'),
  ('33333333C', 6, 1, '2026-11-15', NULL),
  ('55555555E', 1, 1, '2026-11-16', NULL);

-- ----------------------------------------------------------------------------
-- 3) Comprobación: director 5, pelicula 6, ejemplar 8, actor 7, actua 8,
--    socio 5, alquila 8
-- ----------------------------------------------------------------------------
SELECT COUNT(*) AS director FROM director;
SELECT COUNT(*) AS pelicula FROM pelicula;
SELECT COUNT(*) AS ejemplar FROM ejemplar;
SELECT COUNT(*) AS actor    FROM actor;
SELECT COUNT(*) AS actua    FROM actua;
SELECT COUNT(*) AS socio    FROM socio;
SELECT COUNT(*) AS alquila  FROM alquila;
