📝 Ejercicios
✏️ Ejercicio 3.6.a · Verdadero o falso
	Respuesta	Justificación
1	Falso	Guarda la consulta, no los datos.
2	Verdadero	Cada consulta a la vista ejecuta su SELECT sobre el estado actual de la tabla.
3	Falso	Comparten espacio de nombres: error 1050.
4	Verdadero	Error 1369 si la fila no cumple el WHERE de la vista.
5	Falso	El * se expande al crear la vista; la columna nueva no aparece.
6	Falso	Solo elimina la definición; los datos de la tabla quedan intactos.
7	Verdadero	Aunque conviene no anidar muchos niveles.
8	Falso	Si la consulta que usa la vista pone su propio orden, el de la vista se ignora.
9	Falso	Si el usuario tiene SELECT sobre la tabla, puede leerla directamente. La vista protege solo si no hay permiso sobre la tabla.
10	Falso	Por defecto se ejecuta con los privilegios de su creador (SQL SECURITY DEFINER).
✏️ Ejercicio 3.6.b · ¿Vista, tabla o consulta suelta?
	Elección	Razón
1	Consulta suelta	No se reutiliza. Crear una vista no aporta nada.
2	Vista	La definición vive en un único sitio; si cambia el criterio, se cambia una vez.
3	Tabla (copia)	Una vista refleja siempre el estado actual: no congela nada. Hace falta guardar una copia.
4	Vista + privilegios (3.7)	Muestra solo las columnas permitidas (dni, nombre).
5	No resuelve el problema	Una vista no es materializada: ejecuta la consulta cada vez. La solución está en los índices (3.4) o en reescribir la consulta.
6	Vista de compatibilidad	CREATE VIEW actores AS SELECT nombre, nacionalidad, sexo FROM actor; La aplicación antigua sigue funcionando (y, al ser una vista simple, incluso puede escribir).
✏️ Ejercicio 3.6.c · ¿Qué ve el usuario?
Vista	Columnas	Filas
v1	id_peli, numero	(2, 1) y (4, 1)
v2	ejemplar, estado	(2, Deteriorado) y (1, Bueno) (orden descendente por número)
v3	id_peli, numero	(1, 1), (1, 2) y (3, 1)
v4	id_peli, numero	(1, 2) y (4, 2)

2. Qué falta en v3: la fila (4, 2). Su estado es NULL, y NULL <> 'Nuevo' es desconocido, no verdadero; WHERE solo devuelve las filas verdaderas. Para incluirla habría que escribir WHERE estado <> 'Nuevo' OR estado IS NULL.

3. Efecto del UPDATE:

v1 gana una fila: (3, 1) pasa a ser 'Nuevo' y entra en la vista (quedan 3 filas).
v3 pierde esa fila (quedan (1, 1) y (1, 2)).
Demuestra que la vista refleja el estado actual de la tabla sin intervención.

4. Columna nueva: ninguna de las dos formas mostraría ubicacion. Con SELECT *, el * se expande al crear la vista (las columnas se fijan en ese momento), así que la columna nueva no aparece. Y la vista tal como está definida lista las columnas por nombre. La conclusión es evitar SELECT *.

✏️ Ejercicio 3.6.d · ¿Es actualizable?
Nº	UPDATE	INSERT	DELETE	Justificación
1	✅	✅	✅	Una tabla y columnas simples; incluye las obligatorias (id_peli, numero). Sin WITH CHECK OPTION se pueden crear filas que la vista no muestra.
2	✅	❌	✅ (†)	INSERT falla: faltan id, productora y director, que son obligatorias y sin valor por defecto (error 1423 †). DELETE es posible, pero Safe Updates exigiría filtrar por una clave que la vista no incluye.
3	✅	✅	✅	dni es la clave y nombre es opcional; las demás columnas de socio admiten NULL, así que el INSERT funciona.
4	✅	❌	✅	INSERT falla por productora y director (obligatorias y ausentes). El UPDATE de titulo funciona; WITH CHECK OPTION solo se activa si la fila deja de cumplir nacionalidad = 'España'.
5	✅	❌	✅ (†)	INSERT falla: falta id_peli (parte de la clave). UPDATE de estado o ejemplar funciona. El DELETE con filtro solo por ejemplar no usa la clave completa (†).

💡 Mensaje para el aula: que una vista sea "actualizable" no significa que toda operación funcione. Además de la forma de la SELECT, hay que incluir las columnas obligatorias sin valor por defecto.

✏️ Ejercicio 3.6.e · Casos de soporte
	Causa	Solución
1	La vista guarda los nombres de columna; al renombrar una, queda inválida.	CREATE OR REPLACE VIEW con el nombre nuevo. Antes de renombrar, buscar las vistas afectadas. Alternativa: dejar una vista de compatibilidad.
2	Dos columnas con el mismo nombre en la SELECT.	Alias distintos: SELECT nombre, nacionalidad AS nacionalidad_director FROM director;
3	La vista no tiene WITH CHECK OPTION.	Añadirlo, para que las escrituras deban cumplir el WHERE.
4	El SELECT * se expandió al crear la vista.	Recrearla con la columna nueva y evitar * en vistas.
5	Tiene permiso directo sobre socio: puede consultar la tabla sin pasar por la vista.	Retirar el permiso sobre la tabla y conceder solo sobre la vista (3.7).
6	El orden de una vista no se garantiza: la consulta que la usa puede imponer el suyo, o ninguno.	Ordenar siempre en la consulta final.
7	Las vistas y las tablas comparten espacio de nombres y ya existe la tabla actor.	Prefijo v_ (por ejemplo, v_actor).
8	La vista no incluye columnas obligatorias de la tabla (productora, director).	Incluirlas en la vista, o insertar directamente en la tabla.
✏️ Ejercicio 3.6.f · Vistas como capa de seguridad

Respuesta modelo (se admiten variantes justificadas):

Perfil	Vista(s)	Columnas y filas	Escritura	Justificación
Recepción	v_alquileres_sin_devolver y v_socio_basico	Alquileres sin devolver (dni, id_peli, ejemplar, fecha_alquiler); socios (dni, nombre). Sin dirección ni teléfono.	Solo lectura	Necesitan operar, no ver datos de contacto.
Dirección	v_catalogo	Todas las películas, con columnas legibles	❌	Consulta; no necesita modificar.
Proveedor externo	v_catalogo y v_ejemplares_buen_estado	Películas y estado de ejemplares. Sin datos de socios ni alquileres.	❌	Solo debe ver el catálogo.
Auditoría	v_historial_alquileres	Todas las filas de alquila, sin filtrar	❌	Necesita el historial completo.
Si recepción tiene SELECT sobre socio: puede consultar la tabla directamente y ver dirección y teléfono. La vista no sirve de barrera si el usuario puede saltársela.
En el 3.7: conceder SELECT solo sobre las vistas y no sobre las tablas. Como las vistas se ejecutan por defecto con los privilegios de su creador, el usuario las usa sin acceso a las tablas.
Datos personales en alquila: contiene dni, que identifica al socio y es un dato personal (RGPD y LOPDGDD). Dos decisiones razonables:
Dárselo a auditoría si necesita saber quién alquiló qué, justificándolo por el principio de minimización (acceso solo a lo necesario, solo para quien lo necesita, con trazabilidad).
Ocultarlo si solo interesan las fechas y los títulos (la vista omite dni). Es la opción más prudente si no se justifica el acceso.
✏️ Ejercicio 3.6.g · Un script de vistas con fallos
Nº	Problema
1	peliculas no lleva el prefijo v_ y se confunde con la tabla pelicula.
2	SELECT * en peliculas: el * se expande al crear y no es explícito.
3	ORDER BY dentro de la vista: no es fiable.
4	v_alquileres tiene un nombre ambiguo: son los pendientes (v_alquileres_sin_devolver).
5	v_peliculas_espanolas se usará para altas pero no tiene WITH CHECK OPTION: se podrían insertar películas no españolas que luego no se verían.
6	La misma vista no incluye las columnas obligatorias (productora, director): el INSERT falla (error 1423 †).
7	v_directores: alias duplicado nombre, error 1060.
8	v_ejemplares_disponibles usa SELECT *.
9	Su nombre promete "disponibles", pero la vista solo conoce el estado físico; no sabe si el ejemplar está alquilado. Sin comparar con alquila no puede afirmarlo (se verá en el RA de consultas). Se renombra v_ejemplares_buen_estado.
10	estado = 'Nuevo' OR estado = 'Bueno' es más claro con IN ('Nuevo','Bueno') (mejora de estilo).
11	v_socio_publico incluye telefono, contra su propósito (proveedor externo sin datos de contacto).

Versión corregida:

sql
CREATE VIEW v_catalogo AS
SELECT id, titulo, fecha_estreno AS anio, productora, director
FROM pelicula;

CREATE VIEW v_alquileres_sin_devolver AS
SELECT dni, id_peli, numero AS ejemplar, fecha_alquiler
FROM alquila
WHERE fecha_devolucion IS NULL;

CREATE VIEW v_peliculas_espanolas AS
SELECT id, titulo, productora, nacionalidad, fecha_estreno AS anio, director
FROM pelicula
WHERE nacionalidad = 'España'
WITH CHECK OPTION;

CREATE VIEW v_directores AS
SELECT nombre, nacionalidad AS nacionalidad_director
FROM director;

CREATE VIEW v_ejemplares_buen_estado AS
SELECT id_peli, numero, estado
FROM ejemplar
WHERE estado IN ('Nuevo', 'Bueno');

CREATE VIEW v_socio_publico AS
SELECT dni, nombre
FROM socio;

📝 Criterio: nota completa con 8 problemas justificados. El nº 9 es el que distingue un buen diseño: el nombre de una vista es un contrato con quien la usa.

💻 Prácticas
✏️ Práctica 3.6.a · Datos de partida y primeras consultas

Totales esperados tras el script:

Tabla	Filas
director	5
pelicula	6
ejemplar	8
actor	7
actua	8
socio	5
alquila	8

Consultas de referencia:

sql
SELECT * FROM pelicula WHERE nacionalidad = 'España';                    -- 1) 4 filas
SELECT * FROM pelicula WHERE fecha_estreno >= '2000';                    -- 2) 4 filas
SELECT * FROM alquila WHERE fecha_devolucion IS NULL;                    -- 3) 5 filas
SELECT * FROM socio WHERE avalador IS NULL;                              -- 4) 1 fila (Ana)
SELECT * FROM ejemplar WHERE estado IN ('Nuevo', 'Bueno');               -- 5) 7 filas
SELECT * FROM actor WHERE nacionalidad = 'España';                       -- 6) 4 filas
SELECT titulo FROM pelicula
ORDER BY fecha_estreno DESC, titulo LIMIT 3;                             -- 7) 3 filas
SELECT * FROM alquila WHERE dni = '22222222B';                           -- 8) 2 filas

Consulta 7: El laberinto del fauno, Volver, Mar adentro (por ese orden: 2006, 2006 y 2004; en el empate de 2006 desempata el título).

✏️ Práctica 3.6.b · Crear las vistas básicas
sql
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
Vista	Filas esperadas
v_catalogo	6
v_peliculas_espanolas	4
v_peliculas_recientes	4
v_alquileres_sin_devolver	5
v_ejemplares_buen_estado	7
v_actores_espanoles	4

SHOW CREATE VIEW: el servidor reescribe la definición: nombres de esquema y tabla calificados, comillas inversas, alias de columna, y una cabecera con ALGORITHM=UNDEFINED, DEFINER= y SQL SECURITY DEFINER. No guarda tu texto original.

Reto:

sql
CREATE VIEW v_peliculas_espanolas_recientes AS
SELECT id, titulo, anio
FROM v_peliculas_espanolas
WHERE anio >= '2005';

Devuelve 2 filas: El laberinto del fauno y Volver (ambas de 2006).

✏️ Práctica 3.6.c · Una vista que se rompe
Paso	Resultado
1	Ambas devuelven las mismas 6 filas.
2	v_copia_estrella no muestra sinopsis: el * se expandió al crear la vista.
3	Ambas fallan con ERROR 1356 (referencian fecha_estreno, que ya no existe).
4	CHECK TABLE v_copia; devuelve una fila con Msg_type = Error y el mensaje del 1356.
5	Reparación válida: ver abajo.
6	DROP TABLE funciona (MySQL permite eliminar una tabla con vistas dependientes). Las vistas siguen existiendo y fallan con el 1356.
7	DROP VIEW v_copia, v_copia_estrella;
sql
CREATE OR REPLACE VIEW v_copia AS
SELECT id, titulo, anio AS fecha_estreno FROM pelicula_copia;

Paso 8 (detectar dependencias antes de renombrar):

sql
SELECT TABLE_NAME
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'bbdd_videoclub'
  AND VIEW_DEFINITION LIKE '%fecha_estreno%';
  
✏️ Práctica 3.6.d · Vistas actualizables y WITH CHECK OPTION
Paso	Resultado
2	El UPDATE funciona: en la tabla estado = 'Bueno', y el ejemplar desaparece de la vista (ya no cumple el WHERE).
3	El INSERT de (4, 2, 'Bueno') funciona: la fila está en ejemplar, pero no se ve en la vista.

Paso 4:

sql
CREATE OR REPLACE VIEW v_ejemplares_nuevos AS
SELECT id_peli, numero, estado
FROM ejemplar
WHERE estado = 'Nuevo'
WITH CHECK OPTION;
Sentencia	Resultado
UPDATE … SET estado = 'Bueno' WHERE id_peli = 2 AND numero = 1;	❌ 1369 CHECK OPTION failed
INSERT … VALUES (4, 2, 'Bueno');	❌ 1369
INSERT … VALUES (4, 2, 'Nuevo');	✅ Éxito
DELETE FROM v_ejemplares_nuevos WHERE id_peli = 4 AND numero = 2;	✅ Éxito (el CHECK OPTION solo controla INSERT y UPDATE)

Paso 5 (a través de v_catalogo):

Sentencia	Resultado
UPDATE v_catalogo SET titulo = 'Jaws' WHERE id = 1;	✅ 1 fila. SELECT titulo FROM pelicula WHERE id = 1; muestra 'Jaws'.
UPDATE v_catalogo SET titulo = 'Tiburón' WHERE id = 1;	✅ Restaura el título.
INSERT INTO v_catalogo (id, titulo, anio, productora, director) VALUES (7, …);	✅ La fila aparece en pelicula con fecha_estreno = '2020'.
DELETE FROM v_catalogo WHERE id = 7;	✅

Por qué funciona con anio: la vista es solo un renombrado; anio es un alias de fecha_estreno, y MySQL traduce la escritura a la columna original. El INSERT tiene éxito porque v_catalogo incluye todas las columnas obligatorias de pelicula (id, titulo, productora, director); nacionalidad y fecha_estreno son opcionales.

Paso 6: el INSERT en v_peliculas_espanolas falla con el error 1423 † (Field of view … underlying table doesn't have a default value). Motivo: la vista no incluye productora, que es obligatoria y sin valor por defecto. v_catalogo sí la incluye.

Paso 7 · information_schema.VIEWS:

Vista	IS_UPDATABLE	CHECK_OPTION
v_ejemplares_nuevos	YES	CASCADED
Resto de vistas de una tabla	YES	NONE

📝 Conviene comentar: IS_UPDATABLE = YES no significa que todas las operaciones funcionen: v_peliculas_espanolas es actualizable pero no admite el INSERT del paso 6. Cruza con el ejercicio 3.6.d.

✏️ Práctica 3.6.e · Vistas de seguridad
sql
CREATE VIEW v_socio_basico AS
SELECT dni, nombre FROM socio;

CREATE VIEW v_socio_contacto AS
SELECT dni, nombre, telefono FROM socio;

CREATE SQL SECURITY INVOKER VIEW v_socio_basico_invoker AS
SELECT dni, nombre FROM socio;

Paso 3:

TABLE_NAME	SECURITY_TYPE
v_socio_basico	DEFINER
v_socio_contacto	DEFINER
v_socio_basico_invoker	INVOKER

El DEFINER es el usuario que las creó (por ejemplo, root@localhost).

Respuestas:

Columnas ocultas: direccion, telefono y avalador.
DEFINER frente a INVOKER: con DEFINER (por defecto) la vista se ejecuta con los privilegios de su creador: un usuario puede ver datos de una tabla a la que no tiene acceso directo. Con INVOKER se ejecuta con los privilegios de quien la consulta: necesita permiso sobre la tabla.
Si recepción tiene SELECT sobre socio: la vista no sirve de barrera, porque puede consultar la tabla directamente. En el 3.7 se concede permiso solo sobre las vistas.
Filas frente a columnas: ocultar filas protege información que no corresponde al usuario (por ejemplo, el historial ya cerrado); ocultar columnas protege los atributos sensibles (dirección, teléfono).
✏️ Práctica 3.6.f · Metadatos de las vistas
sql
-- 1) Todas las vistas
SHOW FULL TABLES IN bbdd_videoclub WHERE Table_type = 'VIEW';

-- 2) Actualizables y con CHECK OPTION
SELECT TABLE_NAME, IS_UPDATABLE, CHECK_OPTION
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'bbdd_videoclub';

-- 3) Vistas que mencionan la tabla socio
SELECT TABLE_NAME FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'bbdd_videoclub' AND VIEW_DEFINITION LIKE '%socio%';

-- 4) Vistas que usan fecha_estreno
SELECT TABLE_NAME FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'bbdd_videoclub' AND VIEW_DEFINITION LIKE '%fecha_estreno%';

-- 5) SHOW CREATE VIEW v_alquileres_sin_devolver;

-- 6) Tablas y vistas del esquema
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'bbdd_videoclub' AND TABLE_TYPE = 'BASE TABLE';
SELECT COUNT(*) FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'bbdd_videoclub' AND TABLE_TYPE = 'VIEW';

-- 7) Vistas que usan telefono
SELECT TABLE_NAME FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'bbdd_videoclub' AND VIEW_DEFINITION LIKE '%telefono%';
Pregunta	Respuesta esperable
3	v_socio_basico, v_socio_contacto y v_socio_basico_invoker
4	v_catalogo, v_peliculas_espanolas y v_peliculas_recientes. No aparece v_peliculas_espanolas_recientes (la del reto), porque se define sobre otra vista y usa anio.
5	Definición reescrita, con nombres calificados y comillas inversas
6	Tablas: 7 (más pelicula_copia si no se ha eliminado). Vistas: tantas como hayas creado (por ejemplo, 11 si tienes las de las prácticas b, d y e).
7	v_socio_contacto

💡 Punto didáctico (paso 4): la búsqueda por texto detecta dependencias directas, pero no las indirectas (vista sobre vista). Por eso conviene no anidar demasiadas.

✏️ Práctica 3.6.g · Gimnasio
sql
CREATE VIEW v_horario_clases AS
SELECT nombre, dia_semana, hora, aforo
FROM clase;

CREATE VIEW v_clases_grandes AS
SELECT id_clase, nombre, dia_semana, hora, aforo
FROM clase
WHERE aforo >= 20
WITH CHECK OPTION;

CREATE VIEW v_socio_basico AS
SELECT dni, nombre
FROM socio;

CREATE VIEW v_socios_con_email AS
SELECT id_socio, nombre, email
FROM socio
WHERE email IS NOT NULL;

CREATE VIEW v_reservas_sin_asistencia AS
SELECT id_socio, id_clase, fecha
FROM reserva
WHERE asistio = FALSE;

Actualizables: las cinco son YES.

Paso 3 · el INSERT en v_clases_grandes:

Intento	Resultado
Con la vista tal como está definida (sin id_monitor)	❌ 1423 † en ambos casos (aforo 10 y 25): falta id_monitor, obligatoria
Tras añadir id_monitor a la vista, aforo 10	❌ 1369: no cumple aforo >= 20
Con id_monitor incluido y aforo 25	✅ (con un monitor existente, y día y hora que no choquen con la restricción UNIQUE del 3.4)

💡 Conclusión útil para el aula: hay dos filtros distintos. Primero se comprueba que el INSERT aporte las columnas obligatorias, y solo entonces se aplica el CHECK OPTION.

Pregunta 4: v_socio_basico muestra solo dni y nombre, ocultando email y fecha_alta, así que sirve para un proveedor externo. Para que de verdad sea una barrera, el proveedor no debe tener permiso sobre la tabla socio (3.7). Además, el DNI es ya un dato personal: conviene valorar si el proveedor necesita incluso ese dato.

✏️ Práctica 3.6.h · Proyecto: la capa de consulta del videoclub

Vistas propias esperables (todas sobre una sola tabla):

sql
CREATE VIEW v_ejemplares_deteriorados AS
SELECT id_peli, numero
FROM ejemplar
WHERE estado = 'Deteriorado';

CREATE VIEW v_alquileres_noviembre AS
SELECT dni, id_peli, numero AS ejemplar, fecha_alquiler, fecha_devolucion
FROM alquila
WHERE fecha_alquiler BETWEEN '2026-11-01' AND '2026-11-30';

CREATE VIEW v_peliculas_spielberg AS
SELECT id, titulo, fecha_estreno AS anio
FROM pelicula
WHERE director = 'Steven Spielberg';

CREATE VIEW v_actrices AS
SELECT nombre, nacionalidad
FROM actor
WHERE sexo = 'F';

Los tres errores a propósito:

Error	Cómo provocarlo
1060	CREATE VIEW v_error AS SELECT nombre, nacionalidad AS nombre FROM director;
1356	Renombrar una columna en una copia de la tabla, como en la práctica 3.6.c
1369	Un INSERT o UPDATE fuera del WHERE de v_ejemplares_nuevos

Resultados con los datos de partida (comprobaciones):

v_ejemplares_deteriorados: 1 fila (1, 2).
v_alquileres_noviembre: 6 filas (todos menos los de octubre: 2026-10-20 y 2026-10-28).
v_peliculas_spielberg: 2 filas (Tiburón y Parque Jurásico).
v_actrices: 4 filas (Nicole Kidman, Ivana Baquero, Maribel Verdú y Penélope Cruz).

Ejemplo de tabla de documentación:

Vista	Propósito	Tabla	Oculta	¿Actualizable?	Perfil
v_socio_basico	Búsqueda de socios	socio	Columnas (direccion, telefono, avalador)	Sí	Recepción
v_alquileres_sin_devolver	Control de devoluciones	alquila	Filas (las devueltas)	Sí	Recepción
v_catalogo	Consulta del catálogo	pelicula	Columnas (nacionalidad)	Sí	Dirección, proveedor
v_ejemplares_buen_estado	Catálogo de ejemplares	ejemplar	Filas	Sí	Proveedor

Rúbrica orientativa (10 puntos):

Criterio	Puntos
Script reejecutable y las ocho vistas obligatorias correctas	3
Tres vistas propias útiles, con INVOKER y vista sobre vista	2
Tabla de documentación completa	1,5
Pruebas y los tres errores con captura	1,5
Diagrama EER con vistas	0,5
Reflexión sobre cambios del esquema que rompen vistas	1
📊 Rúbrica de la entrega completa (10 puntos)
Bloque	Puntos
Ejercicios 3.6.a a 3.6.g	3
Prácticas 3.6.a y 3.6.b	1,5
Prácticas 3.6.c y 3.6.d	2
Prácticas 3.6.e y 3.6.f	1
Práctica 3.6.g (gimnasio)	0,5
Práctica 3.6.h (proyecto)	2

El 3.6 queda cerrado. Quedan 3.7 (usuarios y privilegios) y 3.8 (cierre integrador). En el 3.7 retomaremos las vistas de seguridad: v_socio_basico y v_alquileres_sin_devolver serán lo único a lo que tengan acceso los perfiles de recepción y proveedor.