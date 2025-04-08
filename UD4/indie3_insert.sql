use indie3; 

delete from order_item where order_id>0;
delete from orders where order_id>0;
delete from shipment where shipment_id>0;
delete from payment where payment_id>0;
delete from whislist where whislist_id>0;
delete from cart where cart_id>0;
delete from images where image_id>0;
delete from product where product_id>0;
delete from customer where customer_id>0;
delete from category where category_id>0;


-- Insertar datos en la tabla category
INSERT INTO `category` (`category_id`, `name`) VALUES
(1, 'Electrónicos'),
(2, 'Ropa'),
(3, 'Hogar'),
(4, 'Deportes'),
(5, 'Juguetes'),
(6, 'Libros'),
(7, 'Belleza'),
(8, 'Alimentos'),
(9, 'Muebles'),
(10, 'Jardín'),
(11, 'Automóviles'),
(12, 'Salud'),
(13, 'Oficina'),
(14, 'Mascotas'),
(15, 'Bebés');

-- Insertar datos en la tabla customer (20 clientes)
INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `email`, `password`, `address`, `phone_number`) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@email.com', 'password123', 'Calle Falsa 123', '555-1234'),
(2, 'María', 'Gómez', 'maria.gomez@email.com', 'securepass', 'Avenida Siempre Viva 456', '555-5678'),
(3, 'Carlos', 'López', 'carlos.lopez@email.com', 'mypassword', 'Boulevard Los Sueños 789', '555-9012'),
(4, 'Ana', 'Martínez', 'ana.martinez@email.com', 'ana1234', 'Calle Luna 101', '555-3456'),
(5, 'Luis', 'Rodríguez', 'luis.rodriguez@email.com', 'luispass', 'Avenida Sol 202', '555-7890'),
(6, 'Laura', 'Hernández', 'laura.hernandez@email.com', 'laura456', 'Calle Estrella 303', '555-2345'),
(7, 'Pedro', 'García', 'pedro.garcia@email.com', 'pedro789', 'Boulevard Nubes 404', '555-6789'),
(8, 'Sofía', 'Díaz', 'sofia.diaz@email.com', 'sofiapass', 'Avenida Arcoiris 505', '555-0123'),
(9, 'Jorge', 'Moreno', 'jorge.moreno@email.com', 'jorge123', 'Calle Montaña 606', '555-4567'),
(10, 'Elena', 'Álvarez', 'elena.alvarez@email.com', 'elena456', 'Boulevard Río 707', '555-8901'),
(11, 'Miguel', 'Romero', 'miguel.romero@email.com', 'miguelpass', 'Avenida Bosque 808', '555-2345'),
(12, 'Isabel', 'Torres', 'isabel.torres@email.com', 'isabel123', 'Calle Flor 909', '555-6789'),
(13, 'Fernando', 'Sánchez', 'fernando.sanchez@email.com', 'ferpass', 'Boulevard Mar 1010', '555-0123'),
(14, 'Carmen', 'Ruiz', 'carmen.ruiz@email.com', 'carmen456', 'Avenida Cielo 1111', '555-4567'),
(15, 'Ricardo', 'Jiménez', 'ricardo.jimenez@email.com', 'ricardopass', 'Calle Nube 1212', '555-8901'),
(16, 'Patricia', 'Mendoza', 'patricia.mendoza@email.com', 'patricia123', 'Boulevard Viento 1313', '555-2345'),
(17, 'Roberto', 'Castro', 'roberto.castro@email.com', 'robertopass', 'Avenida Lluvia 1414', '555-6789'),
(18, 'Lucía', 'Ortega', 'lucia.ortega@email.com', 'lucia456', 'Calle Trueno 1515', '555-0123'),
(19, 'Daniel', 'Vargas', 'daniel.vargas@email.com', 'danielpass', 'Boulevard Relámpago 1616', '555-4567'),
(20, 'Adriana', 'Flores', 'adriana.flores@email.com', 'adriana123', 'Avenida Tormenta 1717', '555-8901');

-- Insertar datos en la tabla product (100 productos)
INSERT INTO `product` (`product_id`, `title`, `description`, `price`, `rating`, `stock`, `brand`, `category_id`) VALUES
(1, 'Smartphone X', 'Último modelo con cámara de 48MP', 899.99, 4.5, 50, 'TechBrand', 1),
(2, 'Laptop Pro', '16GB RAM, 512GB SSD', 1299.99, 4.7, 30, 'TechBrand', 1),
(3, 'Auriculares Inalámbricos', 'Cancelación de ruido', 199.99, 4.3, 100, 'SoundMaster', 1),
(4, 'Smart TV 55"', '4K UHD, HDR', 699.99, 4.6, 25, 'VisionPlus', 1),
(5, 'Tablet 10"', '128GB almacenamiento', 349.99, 4.2, 40, 'TechBrand', 1),
(6, 'Camiseta Básica', 'Algodón 100%, varios colores', 19.99, 4.0, 200, 'FashionWear', 2),
(7, 'Jeans Slim Fit', 'Color azul oscuro', 49.99, 4.1, 150, 'DenimCo', 2),
(8, 'Zapatos Deportivos', 'Para running, tallas 38-45', 79.99, 4.4, 80, 'SportStep', 2),
(9, 'Chaqueta Impermeable', 'Resistente al agua', 89.99, 4.3, 60, 'OutdoorGear', 2),
(10, 'Vestido Elegante', 'Para ocasiones especiales', 59.99, 4.2, 45, 'FashionWear', 2),
(11, 'Sartén Antiadherente', '28cm, mango ergonómico', 29.99, 4.5, 70, 'HomeChef', 3),
(12, 'Juego de Sábanas', 'Algodón egipcio, rey', 89.99, 4.6, 40, 'SleepWell', 3),
(13, 'Aspiradora Robot', 'Programable, conexión WiFi', 299.99, 4.3, 30, 'CleanHome', 3),
(14, 'Juego de Cubiertos', 'Acero inoxidable, 24 piezas', 49.99, 4.4, 60, 'HomeChef', 3),
(15, 'Lámpara de Mesa', 'LED, regulable', 39.99, 4.2, 50, 'LightStyle', 3),
(16, 'Balón de Fútbol', 'Talla 5, oficial', 29.99, 4.5, 90, 'SportStar', 4),
(17, 'Raqueta de Tenis', 'Grafito, grip cómodo', 89.99, 4.3, 40, 'SportStar', 4),
(18, 'Bicicleta Montañera', '21 velocidades, suspensión', 499.99, 4.7, 20, 'BikePro', 4),
(19, 'Mancuernas Ajustables', '5-25kg, neopreno', 79.99, 4.4, 35, 'FitGear', 4),
(20, 'Colchoneta Yoga', 'Antideslizante, 6mm', 24.99, 4.2, 80, 'FitGear', 4),
(21, 'Set de Lego', 'Edificio modular, 2500 piezas', 149.99, 4.8, 25, 'Lego', 5),
(22, 'Muñeca Articulada', 'Con accesorios', 39.99, 4.3, 50, 'ToyFun', 5),
(23, 'Coche Teledirigido', 'Control remoto, 1:10', 59.99, 4.5, 40, 'ToyFun', 5),
(24, 'Puzzle 1000 Piezas', 'Paisaje montañoso', 19.99, 4.2, 60, 'BrainGame', 5),
(25, 'Kit de Magia', '50 trucos para principiantes', 29.99, 4.1, 45, 'ToyFun', 5),
(26, 'El Principito', 'Edición especial ilustrada', 14.99, 4.7, 80, 'BookHouse', 6),
(27, 'Cien Años de Soledad', 'Novela clásica', 12.99, 4.8, 60, 'BookHouse', 6),
(28, 'Aprende Python', 'Guía para principiantes', 24.99, 4.5, 40, 'TechBooks', 6),
(29, 'Atlas del Mundo', 'Edición actualizada', 34.99, 4.6, 30, 'GeoBooks', 6),
(30, 'Cocina Saludable', '200 recetas fáciles', 19.99, 4.4, 50, 'FoodBooks', 6),
(31, 'Crema Hidratante', 'Para piel seca, 200ml', 24.99, 4.3, 100, 'BeautyCare', 7),
(32, 'Labial Mate', 'Larga duración, varios tonos', 14.99, 4.5, 120, 'BeautyCare', 7),
(33, 'Paleta de Sombras', '12 colores mate y brillo', 29.99, 4.4, 60, 'BeautyCare', 7),
(34, 'Perfume Florar', 'Fragancia fresca, 50ml', 49.99, 4.6, 40, 'LuxuryScents', 7),
(35, 'Cepillo Profesional', 'Cerdas naturales', 19.99, 4.2, 80, 'BeautyCare', 7),
(36, 'Café Orgánico', '500g, molido', 12.99, 4.7, 150, 'FoodGood', 8),
(37, 'Aceite de Oliva', 'Extra virgen, 1L', 15.99, 4.6, 100, 'FoodGood', 8),
(38, 'Miel Pura', '100% natural, 500g', 9.99, 4.8, 120, 'FoodGood', 8),
(39, 'Pasta Integral', 'Paquete de 1kg', 3.99, 4.3, 200, 'FoodGood', 8),
(40, 'Chocolate Negro', '85% cacao, 200g', 6.99, 4.7, 180, 'FoodGood', 8),
(41, 'Sofá de Tela', '3 plazas, color gris', 599.99, 4.5, 15, 'HomeComfort', 9),
(42, 'Mesa de Centro', 'Madera de roble, 120x60cm', 199.99, 4.4, 20, 'HomeComfort', 9),
(43, 'Silla de Oficina', 'Ergonómica, ajustable', 149.99, 4.6, 30, 'HomeComfort', 9),
(44, 'Estantería Modular', '5 niveles, blanco', 129.99, 4.3, 25, 'HomeComfort', 9),
(45, 'Cama King Size', 'Estructura de madera', 799.99, 4.7, 10, 'HomeComfort', 9),
(46, 'Cortadora de Césped', 'Eléctrica, 40cm', 199.99, 4.4, 20, 'GardenPro', 10),
(47, 'Set de Herramientas', '12 piezas para jardinería', 49.99, 4.5, 40, 'GardenPro', 10),
(48, 'Hamaca', 'Resistente a la intemperie', 79.99, 4.6, 30, 'GardenPro', 10),
(49, 'Macetero Grande', 'Cerámica, 40cm diámetro', 39.99, 4.3, 50, 'GardenPro', 10),
(50, 'Regadera de Metal', 'Capacidad 5L', 24.99, 4.2, 60, 'GardenPro', 10),
(51, 'Aceite de Motor', 'Sintético, 5W-30, 1L', 12.99, 4.5, 100, 'AutoCare', 11),
(52, 'Batería para Auto', '12V, 60Ah', 129.99, 4.4, 30, 'AutoCare', 11),
(53, 'Neumáticos (4)', 'All-season, 205/55R16', 399.99, 4.7, 20, 'TireMaster', 11),
(54, 'Kit de Limpieza', 'Para interior de auto', 19.99, 4.3, 80, 'AutoCare', 11),
(55, 'Cargador USB para Auto', 'Doble puerto, 3.1A', 14.99, 4.6, 120, 'AutoTech', 11),
(56, 'Termómetro Digital', 'Resultado en 10 segundos', 9.99, 4.5, 150, 'HealthPlus', 12),
(57, 'Tensiómetro', 'Brazo digital', 49.99, 4.6, 40, 'HealthPlus', 12),
(58, 'Vitamina C', '1000mg, 120 tabletas', 14.99, 4.7, 100, 'HealthPlus', 12),
(59, 'Mascarillas Quirúrgicas', 'Paquete de 50', 12.99, 4.4, 200, 'HealthPlus', 12),
(60, 'Báscula Digital', 'Precisión 100g, 150kg', 19.99, 4.5, 80, 'HealthPlus', 12),
(61, 'Monitor 24"', 'Full HD, 75Hz', 159.99, 4.6, 40, 'OfficePro', 13),
(62, 'Teclado Inalámbrico', 'Ergonómico, español', 39.99, 4.4, 60, 'OfficePro', 13),
(63, 'Silla Ejecutiva', 'Respaldo alto, giratoria', 199.99, 4.5, 25, 'OfficePro', 13),
(64, 'Organizador de Escritorio', '5 compartimentos', 24.99, 4.3, 50, 'OfficePro', 13),
(65, 'Calculadora Financiera', '240 funciones', 29.99, 4.7, 30, 'OfficePro', 13),
(66, 'Comida para Perros', 'Pollo y arroz, 10kg', 49.99, 4.8, 60, 'PetLove', 14),
(67, 'Arena para Gatos', 'Aglutinante, 10L', 14.99, 4.6, 100, 'PetLove', 14),
(68, 'Correa Retráctil', 'Hasta 5m, resistencia 50kg', 19.99, 4.5, 80, 'PetLove', 14),
(69, 'Juguete para Gatos', 'Varita con plumas', 9.99, 4.4, 120, 'PetLove', 14),
(70, 'Cama para Mascotas', 'Suave, lavable, 60x50cm', 29.99, 4.7, 50, 'PetLove', 14),
(71, 'Pañales Talla 3', 'Pack de 60 unidades', 24.99, 4.6, 80, 'BabyCare', 15),
(72, 'Toallitas Húmedas', 'Hipoalergénicas, 80 unidades', 9.99, 4.7, 120, 'BabyCare', 15),
(73, 'Biberón Anticólico', '250ml, 2 unidades', 14.99, 4.5, 100, 'BabyCare', 15),
(74, 'Chupete Ortodóntico', 'Silicona, 0-6 meses', 5.99, 4.4, 150, 'BabyCare', 15),
(75, 'Mordedor Refrescante', 'Alivio para la dentición', 7.99, 4.6, 100, 'BabyCare', 15),
(76, 'Smartwatch Pro', 'Monitor de frecuencia cardíaca', 199.99, 4.7, 40, 'TechBrand', 1),
(77, 'Altavoz Bluetooth', 'Resistente al agua', 79.99, 4.5, 60, 'SoundMaster', 1),
(78, 'Cámara Deportiva', '4K, resistente al agua', 249.99, 4.6, 30, 'TechBrand', 1),
(79, 'Disco Duro Externo', '2TB, USB 3.0', 89.99, 4.4, 50, 'TechBrand', 1),
(80, 'Router WiFi', 'Doble banda, 3000Mbps', 129.99, 4.5, 35, 'TechBrand', 1),
(81, 'Chaqueta de Cuero', 'Auténtica piel de oveja', 299.99, 4.8, 20, 'FashionWear', 2),
(82, 'Reloj Analógico', 'Acero inoxidable, resistente al agua', 149.99, 4.6, 40, 'FashionWear', 2),
(83, 'Gafas de Sol', 'Protección UV400', 59.99, 4.5, 60, 'FashionWear', 2),
(84, 'Mochila Urbana', 'Resistente al agua, 30L', 49.99, 4.7, 50, 'FashionWear', 2),
(85, 'Cinturón de Cuero', 'Ajustable, varios colores', 29.99, 4.4, 80, 'FashionWear', 2),
(86, 'Robot Aspirador', 'Programable, mapeo láser', 399.99, 4.7, 25, 'CleanHome', 3),
(87, 'Purificador de Aire', 'Filtro HEPA, 40m²', 199.99, 4.6, 30, 'CleanHome', 3),
(88, 'Cafetera Automática', '15 bares de presión', 149.99, 4.8, 20, 'HomeChef', 3),
(89, 'Batidora Profesional', '1000W, 10 velocidades', 89.99, 4.7, 35, 'HomeChef', 3),
(90, 'Set de Cuchillos', '6 piezas, acero inoxidable', 79.99, 4.5, 40, 'HomeChef', 3),
(91, 'Cinta de Correr', 'Motor 2.5HP, 12 programas', 799.99, 4.8, 15, 'FitGear', 4),
(92, 'Mancuernas Hexagonales', 'Par de 10kg', 49.99, 4.6, 50, 'FitGear', 4),
(93, 'Bicicleta Estática', '8 niveles de resistencia', 349.99, 4.7, 20, 'FitGear', 4),
(94, 'Set de Golf', '12 palos, bolsa incluida', 499.99, 4.5, 10, 'SportStar', 4),
(95, 'Tabla de Surf', 'Epoxy', 399.99, 4.9, 8, 'SportStar', 4),
(96, 'Set de Construcción', '300 piezas, bloques', 39.99, 4.7, 60, 'ToyFun', 5),
(97, 'Muñeca Interactiva', 'Habla y camina', 59.99, 4.5, 40, 'ToyFun', 5),
(98, 'Kit de Ciencia', '50 experimentos', 29.99, 4.6, 50, 'ToyFun', 5),
(99, 'Pizarra Mágica', 'Dibuja y borra fácil', 19.99, 4.4, 80, 'ToyFun', 5),
(100, 'Pelota Saltarina', 'Con asa, 55cm', 14.99, 4.3, 100, 'ToyFun', 5);

-- Insertar datos en la tabla images (3 imágenes por producto como mínimo)
INSERT INTO `images` (`image_id`, `url`, `product_id`, `thumbnail`) VALUES
-- Producto 1
(1, 'https://example.com/images/smartphone_x_1.jpg', 1, 1),
(2, 'https://example.com/images/smartphone_x_2.jpg', 1, 0),
(3, 'https://example.com/images/smartphone_x_3.jpg', 1, 0),
-- Producto 2
(4, 'https://example.com/images/laptop_pro_1.jpg', 2, 1),
(5, 'https://example.com/images/laptop_pro_2.jpg', 2, 0),
(6, 'https://example.com/images/laptop_pro_3.jpg', 2, 0),
-- Producto 3
(7, 'https://example.com/images/auriculares_1.jpg', 3, 1),
(8, 'https://example.com/images/auriculares_2.jpg', 3, 0),
(9, 'https://example.com/images/auriculares_3.jpg', 3, 0),
-- Producto 4
(10, 'https://example.com/images/smart_tv_1.jpg', 4, 1),
(11, 'https://example.com/images/smart_tv_2.jpg', 4, 0),
(12, 'https://example.com/images/smart_tv_3.jpg', 4, 0),
-- Producto 5
(13, 'https://example.com/images/tablet_1.jpg', 5, 1),
(14, 'https://example.com/images/tablet_2.jpg', 5, 0),
(15, 'https://example.com/images/tablet_3.jpg', 5, 0),
-- Producto 6
(16, 'https://example.com/images/camiseta_1.jpg', 6, 1),
(17, 'https://example.com/images/camiseta_2.jpg', 6, 0),
(18, 'https://example.com/images/camiseta_3.jpg', 6, 0),
-- Producto 7
(19, 'https://example.com/images/jeans_1.jpg', 7, 1),
(20, 'https://example.com/images/jeans_2.jpg', 7, 0),
(21, 'https://example.com/images/jeans_3.jpg', 7, 0),
-- Producto 8
(22, 'https://example.com/images/zapatos_1.jpg', 8, 1),
(23, 'https://example.com/images/zapatos_2.jpg', 8, 0),
(24, 'https://example.com/images/zapatos_3.jpg', 8, 0),
-- Producto 9
(25, 'https://example.com/images/chaqueta_1.jpg', 9, 1),
(26, 'https://example.com/images/chaqueta_2.jpg', 9, 0),
(27, 'https://example.com/images/chaqueta_3.jpg', 9, 0),
-- Producto 10
(28, 'https://example.com/images/vestido_1.jpg', 10, 1),
(29, 'https://example.com/images/vestido_2.jpg', 10, 0),
(30, 'https://example.com/images/vestido_3.jpg', 10, 0),
-- Continuar con imágenes para los demás productos...
(31, 'https://example.com/images/sarten_1.jpg', 11, 1),
(32, 'https://example.com/images/sarten_2.jpg', 11, 0),
(33, 'https://example.com/images/sarten_3.jpg', 11, 0),
(34, 'https://example.com/images/sabanas_1.jpg', 12, 1),
(35, 'https://example.com/images/sabanas_2.jpg', 12, 0),
(36, 'https://example.com/images/sabanas_3.jpg', 12, 0),
(37, 'https://example.com/images/aspiradora_1.jpg', 13, 1),
(38, 'https://example.com/images/aspiradora_2.jpg', 13, 0),
(39, 'https://example.com/images/aspiradora_3.jpg', 13, 0),
(40, 'https://example.com/images/cubiertos_1.jpg', 14, 1),
(41, 'https://example.com/images/cubiertos_2.jpg', 14, 0),
(42, 'https://example.com/images/cubiertos_3.jpg', 14, 0),
(43, 'https://example.com/images/lampara_1.jpg', 15, 1),
(44, 'https://example.com/images/lampara_2.jpg', 15, 0),
(45, 'https://example.com/images/lampara_3.jpg', 15, 0),
(46, 'https://example.com/images/balon_1.jpg', 16, 1),
(47, 'https://example.com/images/balon_2.jpg', 16, 0),
(48, 'https://example.com/images/balon_3.jpg', 16, 0),
(49, 'https://example.com/images/raqueta_1.jpg', 17, 1),
(50, 'https://example.com/images/raqueta_2.jpg', 17, 0),
(51, 'https://example.com/images/raqueta_3.jpg', 17, 0),
(52, 'https://example.com/images/bicicleta_1.jpg', 18, 1),
(53, 'https://example.com/images/bicicleta_2.jpg', 18, 0),
(54, 'https://example.com/images/bicicleta_3.jpg', 18, 0),
(55, 'https://example.com/images/mancuernas_1.jpg', 19, 1),
(56, 'https://example.com/images/mancuernas_2.jpg', 19, 0),
(57, 'https://example.com/images/mancuernas_3.jpg', 19, 0),
(58, 'https://example.com/images/colchoneta_1.jpg', 20, 1),
(59, 'https://example.com/images/colchoneta_2.jpg', 20, 0),
(60, 'https://example.com/images/colchoneta_3.jpg', 20, 0),
-- Continuar con el mismo patrón para los demás productos...
(61, 'https://example.com/images/lego_1.jpg', 21, 1),
(62, 'https://example.com/images/lego_2.jpg', 21, 0),
(63, 'https://example.com/images/lego_3.jpg', 21, 0),
(64, 'https://example.com/images/muneca_1.jpg', 22, 1),
(65, 'https://example.com/images/muneca_2.jpg', 22, 0),
(66, 'https://example.com/images/muneca_3.jpg', 22, 0),
(67, 'https://example.com/images/coche_1.jpg', 23, 1),
(68, 'https://example.com/images/coche_2.jpg', 23, 0),
(69, 'https://example.com/images/coche_3.jpg', 23, 0);

-- Insertar datos en la tabla cart (20 carritos de compra)
INSERT INTO `cart` (`cart_id`, `quantity`, `customer_id`, `product_id`) VALUES
(1, 1, 1, 5),
(2, 2, 1, 12),
(1, 1, 2, 8),
(2, 1, 2, 15),
(3, 3, 2, 22),
(1, 1, 3, 3),
(2, 1, 3, 7),
(1, 2, 4, 18),
(1, 1, 5, 45),
(1, 1, 6, 33),
(2, 2, 6, 56),
(1, 1, 7, 29),
(1, 3, 8, 14),
(2, 1, 8, 27),
(1, 1, 9, 9),
(1, 2, 10, 11),
(2, 1, 10, 19),
(1, 1, 11, 25),
(1, 1, 12, 31),
(1, 2, 13, 42),
(1, 1, 14, 53),
(1, 1, 15, 61),
(1, 1, 16, 72),
(1, 2, 17, 84),
(1, 1, 18, 91),
(1, 1, 19, 96),
(1, 1, 20, 100);

-- Insertar datos en la tabla whislist (20 listas de deseos)
INSERT INTO `whislist` (`whislist_id`, `customer_id`, `product_id`) VALUES
(1, 1, 18),
(2, 1, 76),
(1, 2, 41),
(1, 3, 91),
(1, 4, 26),
(1, 5, 53),
(1, 6, 12),
(1, 7, 88),
(1, 8, 63),
(1, 9, 22),
(1, 10, 34),
(1, 11, 77),
(1, 12, 45),
(1, 13, 19),
(1, 14, 81),
(1, 15, 92),
(1, 16, 57),
(1, 17, 29),
(1, 18, 94),
(1, 19, 67),
(1, 20, 99);

-- Insertar datos en la tabla payment (10 pagos)
INSERT INTO `payment` (`payment_id`, `payment_date`, `payment_method`, `amount`, `customer_id`) VALUES
(1, '2023-01-15 10:30:00', 'Tarjeta de crédito', 129.98, 1),
(2, '2023-01-16 14:45:00', 'PayPal', 89.99, 2),
(3, '2023-01-17 09:15:00', 'Tarjeta de débito', 249.98, 3),
(4, '2023-01-18 16:20:00', 'Transferencia bancaria', 599.99, 4),
(5, '2023-01-19 11:30:00', 'Tarjeta de crédito', 79.99, 5),
(6, '2023-01-20 13:45:00', 'PayPal', 149.97, 6),
(7, '2023-01-21 10:00:00', 'Tarjeta de débito', 29.99, 7),
(8, '2023-01-22 15:30:00', 'Transferencia bancaria', 199.99, 8),
(9, '2023-01-23 12:15:00', 'Tarjeta de crédito', 49.99, 9),
(10, '2023-01-24 14:00:00', 'PayPal', 89.99, 10);

-- Insertar datos en la tabla shipment (10 envíos)
INSERT INTO `shipment` (`shipment_id`, `shipment_date`, `address`, `city`, `state`, `country`, `zip_code`, `customer_id`) VALUES
(1, '2023-01-16 08:00:00', 'Calle Falsa 123', 'Madrid', 'Madrid', 'España', '28001', 1),
(2, '2023-01-17 09:00:00', 'Avenida Siempre Viva 456', 'Barcelona', 'Barcelona', 'España', '08001', 2),
(3, '2023-01-18 10:00:00', 'Boulevard Los Sueños 789', 'Valencia', 'Valencia', 'España', '46001', 3),
(4, '2023-01-19 11:00:00', 'Calle Luna 101', 'Sevilla', 'Sevilla', 'España', '41001', 4),
(5, '2023-01-20 12:00:00', 'Avenida Sol 202', 'Zaragoza', 'Zaragoza', 'España', '50001', 5),
(6, '2023-01-21 13:00:00', 'Calle Estrella 303', 'Málaga', 'Málaga', 'España', '29001', 6),
(7, '2023-01-22 14:00:00', 'Boulevard Nubes 404', 'Murcia', 'Murcia', 'España', '30001', 7),
(8, '2023-01-23 15:00:00', 'Avenida Arcoiris 505', 'Palma', 'Baleares', 'España', '07001', 8),
(9, '2023-01-24 16:00:00', 'Calle Montaña 606', 'Bilbao', 'Vizcaya', 'España', '48001', 9),
(10, '2023-01-25 17:00:00', 'Calle Falsa 123','Madrid', 'Madrid','España', 28001, 1);

-- Insertar datos en la tabla order (10 pedidos)
INSERT INTO `orders` (`order_id`, `order_date`, `total_price`, `customer_id`, `payment_id`, `shipment_id`) VALUES
(1, '2023-01-15 10:15:00', 459.97, 1, 1, 1),
(2, '2023-01-16 14:30:00', 159.98, 2, 2, 2),
(3, '2023-01-17 09:00:00', 299.97, 3, 3, 3),
(4, '2023-01-18 16:00:00', 699.98, 4, 4, 4),
(5, '2023-01-19 11:15:00', 129.98, 5, 5, 5),
(6, '2023-01-20 13:30:00', 199.97, 6, 6, 6),
(7, '2023-01-21 09:45:00', 89.99, 7, 7, 7),
(8, '2023-01-22 15:15:00', 349.98, 8, 8, 8),
(9, '2023-01-23 12:00:00', 179.99, 9, 9, 9),
(10, '2023-01-24 13:45:00', 249.97, 10, 10, 10);

-- Insertar datos en la tabla order_item (artículos para cada pedido)
INSERT INTO `order_item` (`order_item_id`, `quantity`, `price`, `product_id`, `order_id`) VALUES
-- Pedido 1 (Cliente 1)
(1, 1, 899.99, 1, 1),
(2, 2, 19.99, 6, 1),
-- Pedido 2 (Cliente 2)
(3, 1, 199.99, 3, 2),
(4, 1, 49.99, 7, 2),
-- Pedido 3 (Cliente 3)
(5, 1, 1299.99, 2, 3),
(6, 1, 29.99, 11, 3),
-- Pedido 4 (Cliente 4)
(7, 1, 499.99, 18, 4),
(8, 1, 199.99, 42, 4),
-- Pedido 5 (Cliente 5)
(9, 1, 79.99, 8, 5),
(10, 1, 49.99, 14, 5),
-- Pedido 6 (Cliente 6)
(11, 1, 24.99, 31, 6),
(12, 1, 149.99, 21, 6),
(13, 1, 24.99, 56, 6),
-- Pedido 7 (Cliente 7)
(14, 1, 14.99, 26, 7),
(15, 1, 49.99, 34, 7),
(16, 1, 24.99, 35, 7),
-- Pedido 8 (Cliente 8)
(17, 1, 299.99, 41, 8),
(18, 1, 49.99, 47, 8),
-- Pedido 9 (Cliente 9)
(19, 1, 59.99, 10, 9),
(20, 1, 119.99, 22, 9),
-- Pedido 10 (Cliente 10)
(21, 1, 199.99, 86, 10),
(22, 1, 49.99, 47, 10);