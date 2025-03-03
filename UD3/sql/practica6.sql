-- Crear tabla para las sucursales
CREATE TABLE Sucursal (
    codigo INT PRIMARY KEY,
    direccion VARCHAR(255),
    telefono VARCHAR(15)
);

-- Crear tabla para los empleados
CREATE TABLE Empleado (
    dni VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(15),
    sucursal INT,
    FOREIGN KEY (sucursal) REFERENCES Sucursal(codigo)
);

-- Crear tabla para las revistas
CREATE TABLE Revista (
    numero_registro INT PRIMARY KEY,
    titulo VARCHAR(255),
    periodicidad VARCHAR(50),
    tipo VARCHAR(50),
	sucursal INT,
    FOREIGN KEY (sucursal) REFERENCES Sucursal(codigo)
);

-- Crear tabla para los periodistas
CREATE TABLE Periodista (
    dni VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(100),
	direccion VARCHAR(255),
    telefono VARCHAR(15),
    especialidad VARCHAR(100)
);


-- Crear tabla para los ejemplares
CREATE TABLE NumRevista (
    numero_registro INT,
    numero INT,
    num_paginas INT,
    fecha DATE,
    cantidad_vendidas INT,
	PRIMARY KEY (numero_registro, numero),
    FOREIGN KEY (numero_registro) REFERENCES Revista(numero_registro)
);


-- Crear tabla para los ejemplares
CREATE TABLE Escribe (
    numero_registro INT,
    dni VARCHAR(9),
	PRIMARY KEY (numero_registro, dni),
    FOREIGN KEY (numero_registro) REFERENCES Revista(numero_registro),
    FOREIGN KEY (dni) REFERENCES Periodista(dni)
);



-- Inserción de datos en la tabla Sucursal
INSERT INTO Sucursal (codigo, direccion, telefono) VALUES
(1, 'Calle Principal 123', '123456789'),
(2, 'Avenida Central 456', '987654321');

-- Inserción de datos en la tabla Empleado
INSERT INTO Empleado (dni, nombre, telefono, sucursal) VALUES
('123456789', 'Juan Perez', '111111111', 1),
('987654321', 'María Lopez', '222222222', 2),
('654321987', 'Pedro Rodriguez', '333333333', 1);

-- Inserción de datos en la tabla Revista
INSERT INTO Revista (numero_registro, titulo, periodicidad, tipo, sucursal) VALUES
(1, 'Ciencia Hoy', 'Mensual', 'Científica', 1),
(2, 'Viajes y Aventuras', 'Quincenal', 'Viajes', 2),
(3, 'Moda & Estilo', 'Semanal', 'Moda', 1);

-- Inserción de datos en la tabla Periodista
INSERT INTO Periodista (dni, nombre, direccion, telefono, especialidad) VALUES
('111111111', 'Laura Gómez', 'Calle Secundaria 456', '444444444', 'Ciencia'),
('222222222', 'Carlos Martínez', 'Avenida Periférica 789', '555555555', 'Viajes'),
('333333333', 'Ana García', 'Calle Central 987', '666666666', 'Moda');

-- Inserción de datos en la tabla NumRevista
INSERT INTO NumRevista (numero_registro, numero, num_paginas, fecha, cantidad_vendidas) VALUES
(1, 1, 20, '2024-01-01', 1000),
(1, 2, 22, '2024-02-01', 1100),
(2, 1, 18, '2024-01-15', 800);

-- Inserción de datos en la tabla Escribe
INSERT INTO Escribe (numero_registro, dni) VALUES
(1, '111111111'),
(2, '222222222'),
(3, '333333333');


/*
¿Cuántos ejemplares tiene la revista "Ciencia Hoy"?

Respuesta: "Ciencia Hoy" tiene 2 ejemplares vendidos.
¿En qué sucursal trabaja Juan Pérez?

Respuesta: Juan Pérez trabaja en la sucursal con código 1.
¿Cuál es la especialidad de la periodista Laura Gómez?

Respuesta: La especialidad de Laura Gómez es ciencia.
¿Cuántos páginas tiene el segundo fascículo de la revista "Viajes y Aventuras"?

Respuesta: El segundo fascículo de "Viajes y Aventuras" tiene 18 páginas.
¿Quién escribió el primer artículo para la revista "Moda & Estilo"?

Respuesta: El primer artículo para la revista "Moda & Estilo" fue escrito por Ana García.

*/
