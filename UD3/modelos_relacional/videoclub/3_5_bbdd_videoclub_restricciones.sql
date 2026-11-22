USE bbdd_videoclub;

ALTER TABLE actor
  ADD CONSTRAINT chk_actores_sexo CHECK (sexo IN ('M','F'));

ALTER TABLE alquila
  ADD CONSTRAINT chk_alquila_fechas
  CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_alquiler);

ALTER TABLE pelicula
  ADD CONSTRAINT chk_pelicula_fecha_estreno CHECK (fecha_estreno REGEXP '^[0-9]{4}$');

ALTER TABLE ejemplar ALTER COLUMN estado SET DEFAULT 'Nuevo';
ALTER TABLE alquila  ALTER COLUMN fecha_alquiler SET DEFAULT (CURRENT_DATE);
ALTER TABLE actua    ALTER COLUMN prota SET DEFAULT 0;
