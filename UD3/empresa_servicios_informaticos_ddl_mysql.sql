/*
===============================================================================
UNIDAD 3 · DEFINICIÓN Y GESTIÓN DE ESTRUCTURAS EN MYSQL
Caso práctico: empresa de servicios informáticos
SGBD: MySQL 8.0 (CHECK se aplica desde MySQL 8.0.16)

MODELO DE TRABAJO (4 tablas):
  departamentos 1 ─── N empleados
  empleados     N ─── M proyectos  (resuelta mediante asignaciones)

IMPORTANTE:
- Ejecutar el archivo desde el principio y en orden.
- El bloque de preparación elimina las cuatro tablas si ya existen.
  ¡No ejecutes ese bloque sobre una base de datos con información que quieras
  conservar!
- Los bloques de DROP/TRUNCATE del final usan una tabla TEMPORARY de prueba.
- Las sentencias comentadas con "ALTERNATIVA" son ejemplos para explicar;
  no es necesario ejecutarlas todas durante una misma demostración.
===============================================================================
*/


-- ============================================================================
-- 3.3.1 · DE LOS DIAGRAMAS A LAS SENTENCIAS
-- ============================================================================
-- Cada entidad del modelo se transforma en una tabla.
-- Cada atributo se transforma en una columna con un tipo de dato.
-- Las relaciones se implementan mediante claves foráneas.
--
-- departamentos (1) ───────── (N) empleados
-- empleados     (N) ───────── (M) proyectos
-- La relación N:M se transforma en la tabla intermedia asignaciones.
--
-- En el modelo relacional:
-- - Cada tabla debe tener una clave que identifique sus filas.
-- - Las claves foráneas conectan filas de tablas diferentes.
-- - Las restricciones ayudan a impedir datos incoherentes.


-- ============================================================================
-- 3.3.2 · CREAR Y ELIMINAR BASES DE DATOS
-- ============================================================================
-- CREATE DATABASE crea una base de datos.
-- IF NOT EXISTS evita un error si ya existe.
CREATE DATABASE IF NOT EXISTS empresa_ti
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

-- USE selecciona la base de datos sobre la que trabajarán las siguientes
-- sentencias.
USE empresa_ti;

-- Para eliminar una base de datos completa:
-- DROP DATABASE empresa_ti;
-- ¡PELIGRO! Elimina la base de datos y todas sus tablas y datos.
-- IF EXISTS evita el error si no existe:
-- DROP DATABASE IF EXISTS empresa_ti;


-- ============================================================================
-- PREPARACIÓN DEL EJERCICIO
-- ============================================================================
-- Este bloque permite volver a ejecutar el script desde cero.
-- DROP TABLE elimina la estructura y los datos de una tabla.
-- Primero eliminamos las tablas dependientes y después las tablas referenciadas.
-- Si es la primera ejecución, los mensajes "doesn't exist" se evitan con
-- IF EXISTS.
DROP TABLE IF EXISTS asignaciones;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS proyectos;
DROP TABLE IF EXISTS departamentos;


-- ============================================================================
-- 3.3.3 · CREAR TABLAS: CREATE TABLE
-- ============================================================================
-- Empezamos creando las tablas sin todas sus restricciones.
-- En los siguientes apartados iremos incorporando claves, relaciones y reglas.
--
-- Una tabla se define indicando:
-- 1. Nombre de la tabla.
-- 2. Columnas.
-- 3. Tipo de dato de cada columna.
-- 4. Restricciones, cuando corresponda.

CREATE TABLE departamentos (
    id_departamento INT,
    nombre          VARCHAR(60)
) ENGINE = InnoDB;

-- Insertamos algunos departamentos inmediatamente después de crear la tabla.
-- Indicamos los identificadores manualmente porque todavía no hemos explicado
-- AUTO_INCREMENT.
INSERT INTO departamentos (id_departamento, nombre) VALUES
    (1, 'Desarrollo'),
    (2, 'Sistemas'),
    (3, 'Administración');

-- Consultamos la tabla para ver las filas que acabamos de insertar.
SELECT * FROM departamentos;


CREATE TABLE empleados (
    id_empleado     INT,
    dni             CHAR(9),
    nombre          VARCHAR(80),
    apellidos       VARCHAR(120),
    email           VARCHAR(120),
    salario         DECIMAL(10,2),
    fecha_alta      DATE,
    departamento_id INT
) ENGINE = InnoDB;

-- Insertamos empleados. departamento_id contiene, por ahora, valores que
-- coinciden con los identificadores de departamentos, aunque todavía no
-- hemos creado formalmente la clave foránea.
INSERT INTO empleados
    (id_empleado, dni, nombre, apellidos, email, salario, fecha_alta, departamento_id)
VALUES
    (1, '11111111A', 'Ana', 'López Pérez', 'ana@empresa.test', 29000, '2024-02-01', 1),
    (2, '22222222B', 'Luis', 'Martínez Díaz', 'luis@empresa.test', 32000, '2023-06-15', 1),
    (3, '33333333C', 'Marta', 'Pérez Souto', 'marta@empresa.test', 27500, '2025-01-10', 2),
    (4, '44444444D', 'Diego', 'Fernández Gil', 'diego@empresa.test', 25000, '2025-09-01', 3);

SELECT * FROM empleados;


CREATE TABLE proyectos (
    id_proyecto INT,
    codigo      VARCHAR(12),
    nombre      VARCHAR(100),
    presupuesto DECIMAL(12,2),
    estado      VARCHAR(20)
) ENGINE = InnoDB;

-- Insertamos proyectos con identificadores manuales.
INSERT INTO proyectos (id_proyecto, codigo, nombre, presupuesto, estado) VALUES
    (1, 'PR-001', 'Portal corporativo', 18000, 'En curso'),
    (2, 'PR-002', 'Migración de servidores', 24000, 'Planificado'),
    (3, 'PR-003', 'Sistema de gestión interna', 35000, 'En curso');

SELECT * FROM proyectos;


-- La tabla intermedia representa la relación N:M entre empleados y proyectos.
-- Todavía no añadimos las claves foráneas.
CREATE TABLE asignaciones (
    empleado_id  INT,
    proyecto_id  INT,
    fecha_inicio DATE,
    horas_semana DECIMAL(4,1)
) ENGINE = InnoDB;

-- Insertamos asignaciones usando los identificadores existentes.
-- La relación N:M se entiende mejor observando varias filas por empleado
-- y varias filas por proyecto.
INSERT INTO asignaciones (empleado_id, proyecto_id, fecha_inicio, horas_semana) VALUES
    (1, 1, '2026-01-12', 15),
    (2, 1, '2026-01-12', 10),
    (2, 2, '2026-02-01', 12),
    (3, 2, '2026-02-01', 20),
    (1, 3, '2026-03-01', 10),
    (4, 3, '2026-03-01', 25);

SELECT * FROM asignaciones;


-- ============================================================================
-- 3.3.4 · ¿QUÉ ES UNA CLAVE Y PARA QUÉ SIRVE?
-- ============================================================================
-- Una clave permite identificar una fila o establecer una regla de unicidad.
-- No debe confundirse una clave con el dato que simplemente parece importante.
--
-- 3.3.4.1 · CLAVE PRIMARIA: PRIMARY KEY
-- Una PRIMARY KEY identifica de forma única cada fila.
-- No admite valores duplicados ni NULL.
--
-- Añadimos las claves primarias a las tablas ya creadas con ALTER TABLE.
ALTER TABLE departamentos
    ADD CONSTRAINT pk_departamentos PRIMARY KEY (id_departamento);

ALTER TABLE empleados
    ADD CONSTRAINT pk_empleados PRIMARY KEY (id_empleado);

ALTER TABLE proyectos
    ADD CONSTRAINT pk_proyectos PRIMARY KEY (id_proyecto);


-- 3.3.4.2 · NATURAL O ARTIFICIAL: ¿QUÉ COLUMNA ELIJO?
-- Clave natural: procede de un dato del mundo real, por ejemplo el DNI.
-- Clave artificial: se crea específicamente para identificar la fila,
-- por ejemplo id_empleado.
--
-- En empleados elegimos id_empleado como PK artificial.
-- El DNI también identifica a una persona en este escenario, pero lo
-- conservaremos como clave alternativa mediante UNIQUE.
-- Motivos: el DNI tiene significado externo, puede requerir correcciones
-- administrativas y no conviene propagarlo como identificador interno.


-- 3.3.4.3 · AUTO_INCREMENT
-- AUTO_INCREMENT genera automáticamente un nuevo valor entero al insertar
-- una fila si no proporcionamos el identificador.
-- La columna debe estar indexada (normalmente será la PRIMARY KEY).
ALTER TABLE departamentos
    MODIFY id_departamento INT NOT NULL AUTO_INCREMENT;

ALTER TABLE empleados
    MODIFY id_empleado INT NOT NULL AUTO_INCREMENT;

ALTER TABLE proyectos
    MODIFY id_proyecto INT NOT NULL AUTO_INCREMENT;

-- Ejemplo: al insertar sin id_empleado, MySQL genera el identificador.
-- INSERT INTO empleados (dni, nombre, apellidos, email, salario, fecha_alta)
-- VALUES ('12345678A', 'Ana', 'López Pérez', 'ana@empresa.test', 28000, '2026-01-15');


-- 3.3.4.4 · CLAVE PRIMARIA COMPUESTA
-- En asignaciones no necesitamos necesariamente un identificador artificial.
-- La combinación empleado_id + proyecto_id identifica una asignación
-- empleado-proyecto en este modelo: un empleado aparece una sola vez por
-- proyecto.
-- Una PK compuesta está formada por más de una columna.
ALTER TABLE asignaciones
    MODIFY empleado_id INT NOT NULL,
    MODIFY proyecto_id INT NOT NULL,
    ADD CONSTRAINT pk_asignaciones
        PRIMARY KEY (empleado_id, proyecto_id);


-- 3.3.4.5 · CLAVES ALTERNATIVAS: UNIQUE
-- UNIQUE impide que dos filas tengan el mismo valor en esa columna
-- (o combinación de columnas).
-- A diferencia de PRIMARY KEY, una tabla puede tener varias restricciones
-- UNIQUE. En MySQL, una columna UNIQUE nullable puede admitir varios NULL.
ALTER TABLE empleados
    ADD CONSTRAINT uq_empleados_dni UNIQUE (dni),
    ADD CONSTRAINT uq_empleados_email UNIQUE (email);

ALTER TABLE proyectos
    ADD CONSTRAINT uq_proyectos_codigo UNIQUE (codigo);

-- También puede existir una clave alternativa compuesta:
-- ALTER TABLE tabla_ejemplo
--     ADD CONSTRAINT uq_ejemplo_dos_columnas UNIQUE (columna1, columna2);


-- 3.3.4.6 · AÑADIR Y ELIMINAR CLAVES DE UNA TABLA EXISTENTE
-- Para añadir una clave primaria: ALTER TABLE ... ADD PRIMARY KEY (...).
-- Para eliminar una clave primaria: ALTER TABLE ... DROP PRIMARY KEY.
-- ¡No ejecutamos el siguiente ejemplo sobre nuestras tablas principales,
-- porque necesitan conservar su clave primaria!
--
-- Ejemplo conceptual:
-- ALTER TABLE tabla_prueba ADD PRIMARY KEY (id);
-- ALTER TABLE tabla_prueba DROP PRIMARY KEY;
--
-- Para una restricción UNIQUE se utiliza su nombre:
-- ALTER TABLE empleados DROP INDEX uq_empleados_email;
-- Si se ejecutase, dejaría de exigirse que el email fuese único.
-- La volvemos a crear inmediatamente si se prueba:
-- ALTER TABLE empleados
--     ADD CONSTRAINT uq_empleados_email UNIQUE (email);


-- 3.3.4.7 · CON WORKBENCH
-- En MySQL Workbench:
-- 1. Abrir la tabla con clic derecho > Alter Table.
-- 2. En Columns se crean o modifican columnas y tipos.
-- 3. Marcar PK para definir la clave primaria.
-- 4. Marcar NN para NOT NULL.
-- 5. Marcar AI para AUTO_INCREMENT.
-- 6. En Indexes se gestionan índices PRIMARY, UNIQUE y normales.
-- 7. En Foreign Keys se configuran las relaciones.
-- 8. Aplicar los cambios y revisar el SQL que Workbench propone ejecutar.


-- 3.3.4.8 · ERRORES FRECUENTES
-- - Intentar crear una PK sobre una columna que contiene NULL o duplicados.
-- - Definir AUTO_INCREMENT en una columna que no está indexada.
-- - Elegir como PK un dato que puede cambiar.
-- - Crear una clave compuesta sin comprender qué combinación identifica
--   realmente una fila.
-- - Olvidar que una tabla solo puede tener una PRIMARY KEY, aunque esta
--   pueda estar formada por varias columnas.


-- ============================================================================
-- 3.3.5 · CREAR RELACIONES: LA CLAVE FORÁNEA
-- ============================================================================
-- Una FOREIGN KEY exige que el valor referenciado exista en la tabla padre.
-- En InnoDB, la columna referenciada debe estar indexada (normalmente PK).
-- Las columnas relacionadas deben tener tipos compatibles.
--
-- 3.3.5.1 · INTRODUCCIÓN
-- Primero creamos las tablas; después establecemos las relaciones.
-- Así se ve claramente que una relación se implementa mediante una FK.

-- 3.3.5.2 · RELACIÓN 1:N
-- Un departamento puede tener muchos empleados.
-- Cada empleado pertenece a un departamento como máximo.
-- La FK se coloca en el lado N: empleados.
ALTER TABLE empleados
    ADD CONSTRAINT fk_empleados_departamentos
    FOREIGN KEY (departamento_id)
    REFERENCES departamentos (id_departamento);

-- 3.3.5.3 · RELACIÓN N:M
-- Un empleado puede participar en varios proyectos.
-- Un proyecto puede contar con varios empleados.
-- La tabla asignaciones resuelve la relación mediante dos FKs.
ALTER TABLE asignaciones
    ADD CONSTRAINT fk_asignaciones_empleados
    FOREIGN KEY (empleado_id)
    REFERENCES empleados (id_empleado),
    ADD CONSTRAINT fk_asignaciones_proyectos
    FOREIGN KEY (proyecto_id)
    REFERENCES proyectos (id_proyecto);

-- 3.3.5.4 · OTROS PATRONES
-- 1:1: se implementa normalmente con una FK que además tenga UNIQUE.
-- Autorrelación: una FK apunta a otra fila de la misma tabla.
-- Relación N:M con atributos: la tabla intermedia puede incluir datos propios,
-- como fecha_inicio y horas_semana en asignaciones.
--
-- Ejemplo conceptual de relación 1:1:
-- ALTER TABLE tabla_dependiente
--   ADD CONSTRAINT uq_relacion_1a1 UNIQUE (tabla_principal_id);


-- ============================================================================
-- 3.3.6 · MODIFICAR TABLAS: ALTER TABLE
-- ============================================================================
-- ALTER TABLE cambia la estructura de una tabla existente.
-- Añadimos una columna para almacenar el teléfono corporativo.
ALTER TABLE empleados
    ADD COLUMN telefono VARCHAR(20) NULL;

-- Modificamos el tipo/tamaño de una columna.
ALTER TABLE empleados
    MODIFY telefono VARCHAR(25) NULL;

-- Cambiamos el nombre de una columna (MySQL 8).
-- Ejemplo conceptual:
-- ALTER TABLE empleados RENAME COLUMN telefono TO telefono_corporativo;
-- Si se ejecuta, las siguientes referencias a telefono deben actualizarse.

-- Eliminamos una columna de ejemplo.
-- No eliminamos telefono porque puede ser útil en el modelo.
-- ALTER TABLE empleados DROP COLUMN columna_que_ya_no_se_necesita;

-- Añadimos una columna con valor predeterminado a proyectos.
ALTER TABLE proyectos
    ADD COLUMN fecha_creacion DATE NOT NULL DEFAULT (CURRENT_DATE);


-- ============================================================================
-- 3.5 · RESTRICCIONES
-- ============================================================================
-- Las restricciones hacen que sea la propia base de datos la que proteja
-- la coherencia de los datos, incluso si distintas aplicaciones escriben
-- en ella.
--
-- 3.5.1 / 3.5.2 · ¿POR QUÉ PROTEGER LOS DATOS? MAPA DE RESTRICCIONES
-- NOT NULL: obliga a proporcionar un valor.
-- DEFAULT: asigna un valor si no se indica otro.
-- UNIQUE: evita duplicados.
-- PRIMARY KEY: identifica cada fila.
-- FOREIGN KEY: mantiene la integridad referencial.
-- CHECK: valida una condición sobre los valores.


-- 3.5.3 · NOT NULL Y NULL
-- NOT NULL impide almacenar NULL.
-- NULL significa desconocido, no disponible o no aplicable; no equivale a 0
-- ni a una cadena vacía.
ALTER TABLE departamentos
    MODIFY nombre VARCHAR(60) NOT NULL;

ALTER TABLE empleados
    MODIFY dni CHAR(9) NOT NULL,
    MODIFY nombre VARCHAR(80) NOT NULL,
    MODIFY apellidos VARCHAR(120) NOT NULL,
    MODIFY email VARCHAR(120) NOT NULL,
    MODIFY salario DECIMAL(10,2) NOT NULL,
    MODIFY fecha_alta DATE NOT NULL;

ALTER TABLE proyectos
    MODIFY codigo VARCHAR(12) NOT NULL,
    MODIFY nombre VARCHAR(100) NOT NULL,
    MODIFY presupuesto DECIMAL(12,2) NOT NULL,
    MODIFY estado VARCHAR(20) NOT NULL;

ALTER TABLE asignaciones
    MODIFY fecha_inicio DATE NOT NULL,
    MODIFY horas_semana DECIMAL(4,1) NOT NULL;


-- 3.5.4 · DEFAULT
-- DEFAULT establece el valor que se utilizará cuando el INSERT omita
-- esa columna (o indique DEFAULT).
ALTER TABLE proyectos
    MODIFY estado VARCHAR(20) NOT NULL DEFAULT 'Planificado';

-- Ejemplo:
-- INSERT INTO proyectos (codigo, nombre, presupuesto)
-- VALUES ('PR-001', 'Portal corporativo', 18000);
-- La columna estado tomará el valor 'Planificado'.


-- 3.5.5 · CHECK
-- CHECK obliga a que una expresión sea verdadera o UNKNOWN.
-- Para evitar que NULL permita saltarse una validación, combinamos CHECK
-- con NOT NULL cuando el dato es obligatorio.
ALTER TABLE empleados
    ADD CONSTRAINT ck_empleados_salario
        CHECK (salario > 0);

ALTER TABLE proyectos
    ADD CONSTRAINT ck_proyectos_presupuesto
        CHECK (presupuesto >= 0),
    ADD CONSTRAINT ck_proyectos_estado
        CHECK (estado IN ('Planificado', 'En curso', 'Pausado', 'Finalizado'));

ALTER TABLE asignaciones
    ADD CONSTRAINT ck_asignaciones_horas
        CHECK (horas_semana > 0 AND horas_semana <= 40);

-- Ejemplo de CHECK con fechas:
-- CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
-- Las restricciones CHECK no son el mecanismo adecuado para validar
-- condiciones que dependen de otras filas o de otras tablas.


-- ============================================================================
-- 3.5.6 · INTEGRIDAD REFERENCIAL: ON DELETE Y ON UPDATE
-- ============================================================================
-- ON DELETE define qué sucede al borrar la fila referenciada.
-- ON UPDATE define qué sucede si cambia su clave.
--
-- Opciones habituales:
-- RESTRICT / NO ACTION: impide la operación si existen filas dependientes.
-- CASCADE: propaga el borrado o la modificación.
-- SET NULL: pone la FK a NULL; la columna debe admitir NULL.
-- SET DEFAULT: no está soportado por InnoDB como acción referencial.
--
-- Ajustamos las relaciones para mostrar decisiones distintas:
--
-- Departamento -> empleados:
-- Si se elimina un departamento, los empleados permanecen sin departamento.
-- Por eso departamento_id debe admitir NULL y usamos ON DELETE SET NULL.
ALTER TABLE empleados
    MODIFY departamento_id INT NULL;

ALTER TABLE empleados
    DROP FOREIGN KEY fk_empleados_departamentos;

ALTER TABLE empleados
    ADD CONSTRAINT fk_empleados_departamentos
    FOREIGN KEY (departamento_id)
    REFERENCES departamentos (id_departamento)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Empleado -> asignaciones:
-- Si se elimina un empleado, sus asignaciones dejan de tener sentido.
-- ON DELETE CASCADE elimina automáticamente esas asignaciones.
ALTER TABLE asignaciones
    DROP FOREIGN KEY fk_asignaciones_empleados;

ALTER TABLE asignaciones
    ADD CONSTRAINT fk_asignaciones_empleados
    FOREIGN KEY (empleado_id)
    REFERENCES empleados (id_empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Proyecto -> asignaciones:
-- Si se elimina un proyecto, eliminamos sus asignaciones.
ALTER TABLE asignaciones
    DROP FOREIGN KEY fk_asignaciones_proyectos;

ALTER TABLE asignaciones
    ADD CONSTRAINT fk_asignaciones_proyectos
    FOREIGN KEY (proyecto_id)
    REFERENCES proyectos (id_proyecto)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


-- 3.5.7 · CÓMO DECIDIR LA ACCIÓN
-- Preguntas para decidir:
-- - ¿La fila hija puede existir sin la fila padre?
-- - ¿Tiene sentido conservarla si desaparece el padre?
-- - ¿Borrar el padre debe borrar también los datos dependientes?
-- - ¿La clave referenciada debería cambiar alguna vez?
--
-- En este ejemplo:
-- - Departamento eliminado: conservamos empleados y dejamos departamento_id
--   a NULL.
-- - Empleado eliminado: eliminamos sus asignaciones.
-- - Proyecto eliminado: eliminamos sus asignaciones.
-- En otros sistemas puede ser preferible RESTRICT para impedir borrados
-- accidentales o conservar registros históricos.


-- 3.5.8 · GESTIONAR RESTRICCIONES CON ALTER TABLE
-- Añadir:
-- ALTER TABLE empleados
--   ADD CONSTRAINT uq_empleados_telefono UNIQUE (telefono);
--
-- Eliminar una FK:
-- ALTER TABLE empleados DROP FOREIGN KEY nombre_fk;
--
-- Eliminar una CHECK:
-- ALTER TABLE empleados DROP CHECK nombre_check;
--
-- Eliminar una UNIQUE:
-- ALTER TABLE empleados DROP INDEX nombre_indice_unique;
--
-- Modificar una restricción normalmente implica eliminarla y crearla de nuevo.


-- 3.5.9 · LO QUE EL DISEÑO NO PUEDE EXPRESAR
-- Algunas reglas necesitan lógica adicional:
-- - Que un empleado no supere 40 horas semanales sumando TODOS sus proyectos.
-- - Que no existan solapamientos de fechas entre asignaciones.
-- - Que el presupuesto restante no sea negativo tras sumar operaciones.
-- Estas reglas pueden requerir transacciones, procedimientos, triggers o
-- validaciones de la aplicación. Un CHECK no puede consultar otras filas.


-- ============================================================================
-- COMPROBACIÓN DE LOS DATOS
-- ============================================================================
-- Los datos ya se insertaron justo después de crear cada tabla.
-- Ahora que hemos añadido claves y restricciones, volvemos a consultar
-- las tablas para comprobar que conservan su contenido.
SELECT * FROM departamentos;
SELECT * FROM empleados;
SELECT * FROM proyectos;
SELECT * FROM asignaciones;


-- ============================================================================
-- 3.4 · ÍNDICES
-- ============================================================================
-- 3.4.1 · EJEMPLO DIDÁCTICO
-- Una búsqueda sin índice puede requerir revisar muchas filas.
-- EXPLAIN permite observar el plan que MySQL estima para una consulta.
EXPLAIN
SELECT *
FROM empleados
WHERE apellidos = 'López Pérez';

-- 3.4.2 · DEFINICIÓN
-- Un índice es una estructura auxiliar que permite localizar filas con
-- mayor eficiencia. Ocupa espacio y añade trabajo en INSERT, UPDATE y DELETE.
--
-- 3.4.3 · ¿CUÁNDO CREAR UN ÍNDICE?
-- Tiene sentido en columnas utilizadas habitualmente en:
-- - Condiciones WHERE.
-- - Combinaciones JOIN.
-- - Ordenaciones ORDER BY.
-- - Agrupaciones GROUP BY.
--
-- Creamos un índice para búsquedas por apellidos.
CREATE INDEX idx_empleados_apellidos
    ON empleados (apellidos);

-- Creamos un índice para filtrar proyectos por estado.
CREATE INDEX idx_proyectos_estado
    ON proyectos (estado);

-- Las PK y UNIQUE ya generan índices automáticamente.
-- Las FK suelen necesitar índices en las columnas hijas; InnoDB puede
-- crearlos automáticamente si no existe uno adecuado.
--
-- Comprobamos el plan después de crear el índice.
EXPLAIN
SELECT *
FROM empleados
WHERE apellidos = 'López Pérez';

-- Consultar índices:
SHOW INDEX FROM empleados;

-- Eliminar un índice:
-- DROP INDEX idx_empleados_apellidos ON empleados;


-- ============================================================================
-- 3.6 · VISTAS
-- ============================================================================
-- 3.6.1 · ¿QUÉ ES UNA VISTA Y PARA QUÉ SIRVE?
-- Una VIEW es una consulta SELECT almacenada con nombre.
-- Normalmente no almacena una copia de los datos: consulta las tablas
-- subyacentes cuando se utiliza.
--
-- 3.6.2 · LAS SELECT QUE NECESITAS
-- Antes de crear vistas, practicamos consultas que combinan tablas.

-- Empleados junto con el nombre de su departamento.
SELECT
    e.id_empleado,
    e.nombre,
    e.apellidos,
    d.nombre AS departamento
FROM empleados AS e
LEFT JOIN departamentos AS d
    ON e.departamento_id = d.id_departamento;

-- Proyectos y número de empleados asignados.
SELECT
    p.codigo,
    p.nombre,
    COUNT(a.empleado_id) AS numero_empleados
FROM proyectos AS p
LEFT JOIN asignaciones AS a
    ON p.id_proyecto = a.proyecto_id
GROUP BY p.id_proyecto, p.codigo, p.nombre;

-- Carga semanal asignada a cada empleado.
SELECT
    e.id_empleado,
    e.nombre,
    e.apellidos,
    COALESCE(SUM(a.horas_semana), 0) AS horas_semana
FROM empleados AS e
LEFT JOIN asignaciones AS a
    ON e.id_empleado = a.empleado_id
GROUP BY e.id_empleado, e.nombre, e.apellidos;


-- 3.6.3 · CREAR, MODIFICAR Y ELIMINAR VISTAS
-- CREATE VIEW guarda una consulta con un nombre.
CREATE OR REPLACE VIEW v_empleados_departamento AS
SELECT
    e.id_empleado,
    e.nombre,
    e.apellidos,
    e.email,
    d.nombre AS departamento
FROM empleados AS e
LEFT JOIN departamentos AS d
    ON e.departamento_id = d.id_departamento;

-- Consultar una vista es como consultar una tabla:
SELECT * FROM v_empleados_departamento;

-- CREATE OR REPLACE VIEW permite crearla o reemplazar su definición.
CREATE OR REPLACE VIEW v_proyectos_resumen AS
SELECT
    p.id_proyecto,
    p.codigo,
    p.nombre,
    p.estado,
    COUNT(a.empleado_id) AS numero_empleados,
    COALESCE(SUM(a.horas_semana), 0) AS horas_semana
FROM proyectos AS p
LEFT JOIN asignaciones AS a
    ON p.id_proyecto = a.proyecto_id
GROUP BY p.id_proyecto, p.codigo, p.nombre, p.estado;

SELECT * FROM v_proyectos_resumen;

-- DROP VIEW elimina la vista, no las tablas ni los datos originales.
-- DROP VIEW IF EXISTS v_proyectos_resumen;


-- 3.6.4 · VISTAS DE LA EMPRESA
-- Vista de información de proyectos y equipos.
CREATE OR REPLACE VIEW v_equipo_proyectos AS
SELECT
    p.codigo AS codigo_proyecto,
    p.nombre AS proyecto,
    e.id_empleado,
    CONCAT(e.nombre, ' ', e.apellidos) AS empleado,
    a.fecha_inicio,
    a.horas_semana
FROM asignaciones AS a
INNER JOIN empleados AS e
    ON a.empleado_id = e.id_empleado
INNER JOIN proyectos AS p
    ON a.proyecto_id = p.id_proyecto;

SELECT * FROM v_equipo_proyectos;


-- 3.6.5 · LAS VISTAS COMO CAPA DE SEGURIDAD
-- Una vista puede mostrar solo las columnas necesarias para un perfil.
-- Por ejemplo, esta vista no expone DNI ni salario.
CREATE OR REPLACE VIEW v_directorio_interno AS
SELECT
    nombre,
    apellidos,
    email,
    telefono
FROM empleados;

SELECT * FROM v_directorio_interno;

-- La vista por sí sola no concede permisos.
-- Para usarla como capa de seguridad hay que gestionar privilegios:
-- GRANT SELECT ON empresa_ti.v_directorio_interno TO 'usuario_consulta'@'%';
-- Evitar conceder SELECT sobre las tablas originales a ese usuario si se
-- pretende limitar la información visible.


-- 3.6.6 · VISTAS ACTUALIZABLES Y WITH CHECK OPTION
-- Una vista sencilla basada en una sola tabla y sin agregaciones suele poder
-- actualizarse. No todas las vistas son actualizables.
--
-- Esta vista muestra únicamente empleados del departamento 1.
CREATE OR REPLACE VIEW v_empleados_desarrollo AS
SELECT
    id_empleado,
    dni,
    nombre,
    apellidos,
    email,
    salario,
    fecha_alta,
    departamento_id,
    telefono
FROM empleados
WHERE departamento_id = 1
WITH CASCADED CHECK OPTION;

-- WITH CHECK OPTION impide insertar o modificar desde la vista una fila
-- que deje de cumplir el WHERE de la propia vista.
SELECT * FROM v_empleados_desarrollo;

-- Ejemplo de actualización que mantiene la condición:
-- UPDATE v_empleados_desarrollo
-- SET telefono = '600999999'
-- WHERE id_empleado = 1;
--
-- Ejemplo que debe ser rechazado por CHECK OPTION:
-- UPDATE v_empleados_desarrollo
-- SET departamento_id = 2
-- WHERE id_empleado = 1;


-- 3.6.7 · QUÉ PASA CUANDO CAMBIAN LAS TABLAS
-- Las vistas dependen de las tablas y columnas usadas en su definición.
-- Si eliminamos o renombramos una columna utilizada por una vista, esta puede
-- dejar de funcionar. Hay que revisar y adaptar las vistas dependientes.
-- Evitar SELECT * en vistas estables: es preferible enumerar las columnas.


-- 3.6.8 · METADATOS DE LAS VISTAS
-- SHOW FULL TABLES permite distinguir tablas y vistas.
SHOW FULL TABLES IN empresa_ti;

-- SHOW CREATE VIEW muestra la sentencia con la que se definió una vista.
SHOW CREATE VIEW v_empleados_departamento;

-- INFORMATION_SCHEMA permite consultar metadatos del esquema.
SELECT
    TABLE_NAME,
    VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'empresa_ti';


-- 3.6.9 · CON WORKBENCH
-- En MySQL Workbench:
-- 1. En el panel SCHEMAS, desplegar Views.
-- 2. Clic derecho sobre Views > Create View.
-- 3. Escribir la consulta SELECT.
-- 4. Aplicar los cambios y revisar el SQL generado.
-- 5. Para modificarla, usar Alter View o editar su definición.


-- 3.6.10 · BUENAS PRÁCTICAS
-- - Elegir nombres descriptivos y consistentes.
-- - Seleccionar explícitamente las columnas.
-- - No crear índices sin justificar su utilidad.
-- - Recordar que los índices aceleran lecturas, pero penalizan escrituras.
-- - Definir las restricciones en la base de datos, no solo en la aplicación.
-- - Diseñar ON DELETE con cuidado: CASCADE puede borrar muchas filas.
-- - No utilizar vistas como sustituto de un sistema completo de permisos.


-- ============================================================================
-- 3.3.7 · ELIMINAR Y VACIAR TABLAS
-- ============================================================================
-- Diferencias:
-- DELETE: elimina filas; puede llevar WHERE. Es DML.
-- TRUNCATE TABLE: vacía todas las filas; no admite WHERE. Es DDL en MySQL.
-- DROP TABLE: elimina la tabla completa (estructura y datos).
--
-- Para practicar sin destruir las tablas principales, usamos una tabla
-- TEMPORARY. Solo existe durante la conexión actual.

CREATE TEMPORARY TABLE prueba_vaciado (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(80)
);

INSERT INTO prueba_vaciado (descripcion) VALUES
    ('Fila de prueba 1'),
    ('Fila de prueba 2'),
    ('Fila de prueba 3');

-- DELETE elimina filas seleccionadas.
DELETE FROM prueba_vaciado
WHERE id = 1;

-- DELETE sin WHERE elimina todas las filas, pero conserva la tabla.
-- DELETE FROM prueba_vaciado;

-- TRUNCATE elimina todas las filas de la tabla de prueba.
TRUNCATE TABLE prueba_vaciado;

-- DROP elimina la estructura de la tabla temporal.
DROP TEMPORARY TABLE prueba_vaciado;

-- ¡No ejecutar sobre las tablas principales salvo que se quiera perder
-- deliberadamente su contenido!
-- TRUNCATE TABLE empleados;
-- DROP TABLE empleados;


-- ============================================================================
-- 3.3.8 · TRABAJAR CON SCRIPTS
-- ============================================================================
-- Un script SQL es un archivo de texto con sentencias SQL.
-- Ventajas:
-- - Repetibilidad y documentación.
-- - Automatización de tareas.
-- - Control de versiones.
-- - Posibilidad de ejecutar el esquema en otro equipo.
--
-- Recomendaciones:
-- - Guardar el archivo con extensión .sql y codificación UTF-8.
-- - Separar secciones con comentarios.
-- - Ejecutar y probar por bloques.
-- - Revisar cuidadosamente DROP, TRUNCATE y DELETE.
-- - Mantener copias de seguridad antes de cambios destructivos.


-- ============================================================================
-- 3.3.9 / 3.3.10 · CON WORKBENCH Y ERRORES FRECUENTES
-- ============================================================================
-- En Workbench:
-- - Abrir el archivo desde File > Open SQL Script.
-- - Seleccionar la conexión y la base de datos.
-- - Ejecutar la sentencia actual o la selección.
-- - Revisar Action Output para localizar errores.
--
-- Errores frecuentes:
-- - No seleccionar la base de datos con USE.
-- - Crear una FK antes de que exista la tabla referenciada.
-- - Referenciar columnas con tipos incompatibles.
-- - Insertar una FK cuyo valor no existe en la tabla padre.
-- - Añadir UNIQUE cuando ya hay valores duplicados.
-- - Añadir NOT NULL cuando existen filas con NULL.
-- - Borrar una tabla padre mientras existen tablas hijas que la referencian.
-- - Olvidar el punto y coma que separa sentencias.
-- - Ejecutar solo una parte del script sin haber ejecutado sus dependencias.


-- ============================================================================
-- 3.5.13 / 3.6.13 · AUTOEVALUACIÓN RÁPIDA
-- ============================================================================
-- 1. ¿Por qué id_empleado es una clave artificial y dni una clave natural?
-- 2. ¿Por qué asignaciones necesita dos claves foráneas?
-- 3. ¿Qué diferencia hay entre PRIMARY KEY y UNIQUE?
-- 4. ¿Qué ocurre al eliminar un departamento que tiene empleados?
-- 5. ¿Qué diferencia hay entre DELETE, TRUNCATE y DROP?
-- 6. ¿Qué ventaja aporta un índice y qué coste tiene?
-- 7. ¿Una vista almacena necesariamente una copia de los datos?
-- 8. ¿Qué impide WITH CHECK OPTION?
-- 9. ¿Por qué un CHECK no sirve para sumar las horas de un empleado en
--    diferentes filas?
-- 10. ¿Qué riesgo tiene ON DELETE CASCADE?


-- ============================================================================
-- 3.3.11 / 3.4 / 3.5 / 3.6 · COMPROBACIÓN FINAL
-- ============================================================================
-- Mostrar las tablas y vistas:
SHOW FULL TABLES IN empresa_ti;

-- Mostrar la estructura de las tablas:
DESCRIBE departamentos;
DESCRIBE empleados;
DESCRIBE proyectos;
DESCRIBE asignaciones;

-- Mostrar las restricciones:
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'empresa_ti'
ORDER BY TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME;

-- Mostrar los índices:
SHOW INDEX FROM empleados;
SHOW INDEX FROM proyectos;

-- Consultar las vistas:
SELECT * FROM v_empleados_departamento;
SELECT * FROM v_proyectos_resumen;
SELECT * FROM v_equipo_proyectos;
SELECT * FROM v_directorio_interno;
SELECT * FROM v_empleados_desarrollo;

-- FIN DEL SCRIPT
