-- Inserción de datos en la tabla 'articulo'
INSERT INTO `bbdd_repuestos_gamer`.`articulo` (`num_articulo`, `descripcion`, `precio`) VALUES
(1, 'Teclado mecánico', 50.00),
(2, 'Mouse óptico', 20.00),
(3, 'Monitor LED 24 pulgadas', 150.00);

-- Inserción de datos en la tabla 'cliente'
INSERT INTO `bbdd_repuestos_gamer`.`cliente` (`num_cliente`, `nif`, `nombre`, `apellido1`, `apellido2`, `limite_credito`, `saldo`) VALUES
(1, '12345678A', 'Juan', 'García', 'López', 500.00, 250.00),
(2, '98765432B', 'María', 'Martínez', 'Pérez', 1000.00, 750.00),
(3, '56781234C', 'Pedro', 'Fernández', 'Gómez', 800.00, 400.00);

-- Inserción de datos en la tabla 'direccione'
INSERT INTO `bbdd_repuestos_gamer`.`direccion` (`id_direccion`, `nombre_via`, `numero`, `piso`, `portal`, `cod_postal`, `ciudad`) VALUES
(1, 'Calle Mayor', '10', '1A', 'B', '28001', 'Madrid'),
(2, 'Avenida Libertad', '25', NULL, '2', '41001', 'Sevilla'),
(3, 'Calle Gran Vía', '50', NULL, '3C', '50001', 'Zaragoza');

-- Inserción de datos en la tabla 'direccione'
INSERT INTO `bbdd_repuestos_gamer`.`cliente_direccionenvio` (`numero_cliente`, `id_direccion`) VALUES (1,1),(2,2),(3,3);


-- Inserción de datos en la tabla 'pedido'
INSERT INTO `bbdd_repuestos_gamer`.`pedido` (`num_pedido`, `num_cliente`, `fecha`, `id_direccion`) VALUES
(1, 1, '2024-03-20', 1),
(2, 2, '2024-03-19', 2),
(3, 3, '2024-03-18', 3);

-- Inserción de datos en la tabla 'linea_pedido'
INSERT INTO `bbdd_repuestos_gamer`.`linea_pedido` (`num_pedido`, `num_articulo`, `cantidad`) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 1, 3),
(3, 2, 2),
(3, 3, 2);


-- Inserción de datos en la tabla 'fabrica'
INSERT INTO `bbdd_repuestos_gamer`.`fabrica` (`num_fabrica`, `telefono`) VALUES
(1, '123456789'),
(2, '987654321'),
(3, '555555555');

-- Inserción de datos en la tabla 'fabricaarticulo'
INSERT INTO `bbdd_repuestos_gamer`.`fabrica_articulo` (`num_fabrica`, `num_articulo`, `cantidad_comprada`) VALUES
(1, 1, 100),
(1, 2, 200),
(2, 2, 150),
(2, 3, 100),
(3, 1, 50),
(3, 3, 75);