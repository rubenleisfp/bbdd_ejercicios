-- =====================================================================
-- Tienda online TechNova — Datos de prueba (MySQL 8.0.16+)
-- Requiere haber ejecutado antes technova.sql (estructura).
-- Script reejecutable: vacía las tablas y vuelve a insertar los datos.
-- =====================================================================

USE technova;

-- ---------------------------------------------------------------------
-- Vaciado previo (TRUNCATE no admite tablas referenciadas por FK,
-- por eso se desactiva temporalmente la comprobación de claves)
-- ---------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE LineaPedido;
TRUNCATE TABLE Pago;
TRUNCATE TABLE Pedido;
TRUNCATE TABLE Suministra;
TRUNCATE TABLE ProductoDigital;
TRUNCATE TABLE ProductoFisico;
TRUNCATE TABLE Producto;
TRUNCATE TABLE Proveedor;
TRUNCATE TABLE Direccion;
TRUNCATE TABLE Cliente;
TRUNCATE TABLE Categoria;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------
-- Categoria (jerarquía: las categorías padre se insertan antes)
--   1 Electrónica ── 2 Informática ── 3 Portátiles
--                 │                └─ 4 Periféricos
--                 └─ 6 Audio
--   5 Software (raíz)      7 Formación (raíz)
-- ---------------------------------------------------------------------
INSERT INTO Categoria (codigo_categoria, nombre, descripcion, codigo_categoria_padre) VALUES
(1, 'Electrónica', 'Dispositivos y componentes electrónicos', NULL),
(5, 'Software',    'Licencias y programas',                   NULL),
(7, 'Formación',   'Cursos y material formativo digital',     NULL),
(2, 'Informática', 'Equipos y accesorios informáticos',       1),
(6, 'Audio',       'Auriculares, altavoces y micrófonos',     1),
(3, 'Portátiles',  'Ordenadores portátiles',                  2),
(4, 'Periféricos', 'Teclados, ratones y monitores',           2);

-- ---------------------------------------------------------------------
-- Cliente
-- ---------------------------------------------------------------------
INSERT INTO Cliente (dni, nombre, apellido1, apellido2, fecha_nacimiento, email, telefono) VALUES
('12345678Z', 'Ana',   'García',   'Pérez',    '1990-04-12', 'ana.garcia@example.com',   '600111222'),
('23456789D', 'Luis',  'Fernández','Souto',    '1985-11-03', 'luis.fernandez@example.com','611222333'),
('34567890V', 'Marta', 'López',    'Rodríguez','1998-07-25', 'marta.lopez@example.com',  NULL),
('45678901G', 'Pablo', 'Vázquez',  'Núñez',    '1979-01-30', 'pablo.vazquez@example.com','622333444'),
('56789012B', 'Elena', 'Castro',   'Míguez',   '2001-09-18', 'elena.castro@example.com', NULL);

-- ---------------------------------------------------------------------
-- Direccion (Pablo no tiene ninguna: solo compra productos digitales)
-- ---------------------------------------------------------------------
INSERT INTO Direccion (dni_cliente, numero_direccion, calle, ciudad, codigo_postal, pais) VALUES
('12345678Z', 1, 'Rúa Real 45',                 'A Coruña',  '15003',    'España'),
('12345678Z', 2, 'Avenida de Lugo 8',           'Santiago',  '15702',    'España'),
('23456789D', 1, 'Calle Príncipe 23',           'Vigo',      '36202',    'España'),
('23456789D', 2, 'Rúa Nova 5',                  'Lugo',      '27001',    'España'),
('34567890V', 1, 'Rúa do Vilar 17',             'Santiago',  '15705',    'España'),
('34567890V', 2, 'Rúa Maior 3',                 'Burela',    '27880',    'España'),
('56789012B', 1, 'Praza de España 2',           'Ferrol',    '15401',    'España'),
('56789012B', 2, 'Rua de Santa Catarina 100',   'Porto',     '4000-441', 'Portugal');

-- ---------------------------------------------------------------------
-- Proveedor
-- ---------------------------------------------------------------------
INSERT INTO Proveedor (cif, nombre, email, telefono) VALUES
('B12345674', 'IberTech Distribuciones S.L.', 'pedidos@ibertech.example.com', '981000111'),
('A98765432', 'Componentes del Norte S.A.',   'ventas@cnorte.example.com',    '982000222'),
('B55667788', 'SoftLicencias S.L.',           NULL,                           '911000333'),
('B11223344', 'AudioPro Europa S.L.',         'info@audiopro.example.com',    NULL);

-- ---------------------------------------------------------------------
-- Producto (supertipo)
-- ---------------------------------------------------------------------
INSERT INTO Producto (sku, nombre, descripcion, precio, stock, codigo_categoria) VALUES
('LAP-001',    'Portátil UltraBook 14"',          'Ultrabook 14", 16 GB RAM, SSD 512 GB',        899.00, 15, 3),
('LAP-002',    'Portátil Gaming 15,6"',           'Portátil gaming con GPU dedicada y 144 Hz',  1299.00,  8, 3),
('MON-001',    'Monitor 27" 4K',                  'Monitor IPS 27" resolución 3840x2160',        349.90, 20, 4),
('TEC-001',    'Teclado mecánico',                'Teclado mecánico con retroiluminación',        79.95, 40, 4),
('RAT-001',    'Ratón inalámbrico',               NULL,                                           29.99, 60, 4),
('AUR-001',    'Auriculares Bluetooth',           'Auriculares con cancelación de ruido',         59.90, 35, 6),
('SW-OFF-01',  'Suite ofimática (licencia anual)','Licencia anual para 1 usuario',                69.00, 9999, 5),
('SW-AV-01',   'Antivirus 1 año / 3 equipos',     'Protección para 3 dispositivos durante 1 año', 39.90, 9999, 5),
('CUR-SQL-01', 'Curso de SQL con MySQL',          'Curso online de 40 horas',                     49.00, 9999, 7),
('EBK-BD-01',  'Ebook: Diseño de bases de datos', NULL,                                           14.90, 9999, 7);

-- ---------------------------------------------------------------------
-- ProductoFisico (subtipo)
-- ---------------------------------------------------------------------
INSERT INTO ProductoFisico (sku, peso_kg, dimensiones) VALUES
('LAP-001', 1.250, '31x21x1.5 cm'),
('LAP-002', 2.350, '36x25x2.4 cm'),
('MON-001', 5.800, '62x37x20 cm'),
('TEC-001', 0.950, NULL),
('RAT-001', 0.090, '11x6x3 cm'),
('AUR-001', 0.250, NULL);

-- ---------------------------------------------------------------------
-- ProductoDigital (subtipo)
-- ---------------------------------------------------------------------
INSERT INTO ProductoDigital (sku, tamano_mb, enlace_descarga) VALUES
('SW-OFF-01',  1850.00, 'https://descargas.technova.example.com/suite-ofimatica'),
('SW-AV-01',    420.50, 'https://descargas.technova.example.com/antivirus'),
('CUR-SQL-01', 3200.00, 'https://descargas.technova.example.com/curso-sql'),
('EBK-BD-01',     8.40, 'https://descargas.technova.example.com/ebook-bbdd');

-- ---------------------------------------------------------------------
-- Suministra (N:M Proveedor - Producto)
-- ---------------------------------------------------------------------
INSERT INTO Suministra (cif_proveedor, sku, precio_compra, plazo_entrega_dias) VALUES
('B12345674', 'LAP-001',    720.00, 5),
('B12345674', 'LAP-002',   1050.00, 7),
('A98765432', 'MON-001',    270.00, 4),
('A98765432', 'TEC-001',     52.00, 3),
('A98765432', 'RAT-001',     17.50, 3),
('B11223344', 'AUR-001',     38.00, 6),
('B12345674', 'RAT-001',     18.20, 2),
('B55667788', 'SW-OFF-01',   45.00, 1),
('B55667788', 'SW-AV-01',    24.00, 1);

-- ---------------------------------------------------------------------
-- Pedido
--  · Pedidos 4, 5 y 8: solo productos digitales → sin dirección de envío
--  · Pedido 7 cancelado y pedido 6 pendiente: sin pagos
-- ---------------------------------------------------------------------
INSERT INTO Pedido (numero_pedido, fecha_pedido, estado, dni_cliente, numero_direccion_envio) VALUES
(1, '2026-09-03 10:15:00', 'ENTREGADO', '12345678Z', 1),
(2, '2026-09-15 18:40:00', 'ENVIADO',   '23456789D', 1),
(3, '2026-10-02 09:05:00', 'PAGADO',    '34567890V', 2),
(4, '2026-10-10 21:30:00', 'ENTREGADO', '12345678Z', NULL),
(5, '2026-10-21 12:00:00', 'PAGADO',    '45678901G', NULL),
(6, '2026-11-05 16:20:00', 'PENDIENTE', '23456789D', 2),
(7, '2026-11-18 11:45:00', 'CANCELADO', '34567890V', 1),
(8, '2026-11-24 20:10:00', 'PAGADO',    '56789012B', NULL);

-- ---------------------------------------------------------------------
-- Pago (el pedido 2 se paga en dos plazos)
-- ---------------------------------------------------------------------
INSERT INTO Pago (numero_pedido, numero_pago, fecha_pago, importe, metodo_pago) VALUES
(1, 1, '2026-09-03 10:17:00',  958.98, 'TARJETA'),
(2, 1, '2026-09-15 18:42:00',  200.00, 'TARJETA'),
(2, 2, '2026-09-20 08:00:00',  229.85, 'TRANSFERENCIA'),
(3, 1, '2026-10-02 09:30:00', 1299.00, 'TRANSFERENCIA'),
(4, 1, '2026-10-10 21:32:00',   83.90, 'PAYPAL'),
(5, 1, '2026-10-21 12:01:00',   88.90, 'BIZUM'),
(8, 1, '2026-11-24 20:11:00',   39.00, 'TARJETA');

-- ---------------------------------------------------------------------
-- LineaPedido (precio_unitario = precio aplicado en el momento de la
-- compra; en el pedido 8 es una oferta distinta del precio actual)
-- ---------------------------------------------------------------------
INSERT INTO LineaPedido (numero_pedido, sku, cantidad, precio_unitario) VALUES
(1, 'LAP-001',    1,  899.00),
(1, 'RAT-001',    2,   29.99),
(2, 'TEC-001',    1,   79.95),
(2, 'MON-001',    1,  349.90),
(3, 'LAP-002',    1, 1299.00),
(4, 'SW-OFF-01',  1,   69.00),
(4, 'EBK-BD-01',  1,   14.90),
(5, 'CUR-SQL-01', 1,   49.00),
(5, 'SW-AV-01',   1,   39.90),
(6, 'AUR-001',    1,   59.90),
(6, 'RAT-001',    1,   29.99),
(7, 'MON-001',    2,  349.90),
(8, 'CUR-SQL-01', 1,   39.00);