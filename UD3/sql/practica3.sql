-- ########## PRACTICA 3. ESCUELA ############
-- Tabla ALUMNO
CREATE TABLE ALUMNO (
  Num_Matricula     INT,
  Nombre            VARCHAR(50),
  FechaNacimiento   DATE,
  Telefono          VARCHAR(15),
  PRIMARY KEY (Num_Matricula)
);
-- Tabla PROFESOR
CREATE TABLE PROFESOR (
  IdProfesor             INT,
  NIF_P             VARCHAR(15) UNIQUE,
  Nombre            VARCHAR(50),
  Especialidad      VARCHAR(50),
  Telefono          VARCHAR(15),
  PRIMARY KEY (IdProfesor )
);
-- Tabla ASIGNATURA
CREATE TABLE ASIGNATURA (
  Codigo_asignatura INT,
  Nombre            VARCHAR(50),
  IdProfesor  INT,
  PRIMARY KEY (Codigo_asignatura),
  FOREIGN KEY (IdProfesor )
      REFERENCES PROFESOR(IdProfesor)
);
-- Tabla RECIBE (relación N:M entre ALUMNO y ASIGNATURA)
CREATE TABLE RECIBE (
  Num_Matricula     INT,
  Codigo_asignatura INT,
 Curso_escolar INT,
  PRIMARY KEY (Num_Matricula, Codigo_asignatura),
  FOREIGN KEY (Num_Matricula)
      REFERENCES ALUMNO(Num_Matricula),
  FOREIGN KEY (Codigo_asignatura)
      REFERENCES ASIGNATURA(Codigo_asignatura));

-- Inserts para la tabla ALUMNO
INSERT INTO ALUMNO (Num_Matricula, Nombre, FechaNacimiento, Telefono)
VALUES
  (1, 'Juan Pérez', '1990-05-15', '123-456-7890'),
  (2, 'María Gómez', '1992-08-21', '987-654-3210'),
  (3, 'Carlos Rodríguez', '1988-03-10', '555-123-4567');
-- Inserts para la tabla PROFESOR
INSERT INTO PROFESOR (IdProfesor, NIF_P, Nombre, Especialidad, Telefono)
VALUES
  (1, '12345678A', 'Profesor1', 'Matemáticas', '111-222-3333'),
  (2, '87654321B', 'Profesor2', 'Historia', '444-555-6666'),
  (3, '98765432C', 'Profesor3', 'Inglés', '777-888-9999');


-- Inserts para la tabla ASIGNATURA
INSERT INTO ASIGNATURA (Codigo_asignatura, Nombre, IdProfesor)
VALUES
  (101, 'Matemáticas',1),
  (102, 'Historia',1),
  (103, 'Inglés',2);


-- Inserts para la tabla RECIBE
INSERT INTO RECIBE (Num_Matricula, Codigo_asignatura, Curso_escolar )
VALUES
  (1, 101,2023),
  (1, 102,2023),
  (2, 103,2022),
  (3, 101, 2023),
  (3, 103, 2023);
