-- 1. Selecciona todos los productos
SELECT * FROM product;

-- 2. Selecciona el nombre y precio de los productos
SELECT title, price FROM product;

-- 3. Selecciona todos los clientes con sus nombres
SELECT first_name, last_name FROM customer;

-- 4. Selecciona clientes cuyo apellido sea 'Gómez' (Resultados: 1 fila)
SELECT * FROM customer WHERE last_name = 'Gómez';

-- 5. Contar el número total de productos en la tabla `product`
SELECT COUNT(*) FROM product;

-- 6. Selecciona productos con un precio menor a 50 (Resultados: 56 filas)
SELECT title, price FROM product WHERE price < 50;

-- 7. Selecciona todos los productos de la categoría "Electrónicos" (Resultados: 10 filas)
SELECT * FROM product WHERE category_id = 1;

-- 8. Selecciona los clientes que viven en "Avenida Siempre Viva"; o se llame Daniel y su teléfono sea '555-4567 (Resultados: 2 filas)
SELECT * FROM customer WHERE address = 'Avenida Siempre Viva 456' or first_name = 'Daniel' and phone_number='555-4567';

-- 9. Contar cuántos clientes tienen un teléfono que empieza con "555-1" (Resultados: 1)
SELECT COUNT(*) FROM customer WHERE phone_number LIKE '555-1%';

-- 10. Selecciona el nombre y apellido de los clientes, cuyo apellido es mayor de 5 ordenados por la longitud de su apellido de forma descendente
-- (Resultados: 18 filas)
SELECT first_name, last_name FROM customer where length(last_name)>5 ORDER BY length(last_name) desc;

-- 11. Selecciona productos de más de 50 en stock o su titulo tenga exactamente 10 caracteres que empiezan por L o T (Resultados: 47 filas)
SELECT title, stock FROM product WHERE stock > 50 or title like 'L_________' or   title like 'T_________';

-- 12. Selecciona los 5 productos más caros
SELECT title, price FROM product ORDER BY price DESC LIMIT 5;

-- 13. Selecciona los 5 productos más baratos
SELECT title, price FROM product ORDER BY price ASC LIMIT 5;

-- 14. Selecciona los productos de la categoría "Ropa" (Resultados: 10 filas)
SELECT title, price FROM product WHERE category_id = 2;

-- 15. Selecciona productos cuyo nombre contenga "Smart" y cuyo precio sea mayor de 500 o cualquier producto cuyo precio sea menor de 10
-- (Resultados: 10 filas)
SELECT * FROM product WHERE (title LIKE '%Smart%' and price > 500) or price <10;

-- 16. Contar el número de productos por categoría
SELECT category_id, COUNT(*) FROM product GROUP BY category_id;

-- 17. Selecciona productos con un stock entre 20 y 100 (Resultados: 82 filas)
SELECT title, stock FROM product WHERE stock BETWEEN 20 AND 100;

-- 18. Sumar los precios de todos los productos
SELECT SUM(price) FROM product;

-- 19. Selecciona el producto más caro
SELECT title, price FROM product ORDER BY price DESC LIMIT 1;

-- 20. Selecciona los clientes que tienen un número de teléfono que termina en "01"  (Resultados: 3 filas)
SELECT * FROM customer WHERE phone_number LIKE '%01';

-- 21. Contar los productos por categoría con un stock mayor a 50 (Resultados: 14 filas)
SELECT category_id, COUNT(*) FROM product WHERE stock > 50 GROUP BY category_id;

-- 22. Selecciona el nombre y el correo de los clientes cuyo nombre empieza con "M" (Resultados: 2 filas)
SELECT first_name, email FROM customer WHERE first_name LIKE 'M%';

-- 23. Mostrar los productos con una calificación entre 4 y 5 (Resultados: 100 filas)
SELECT title, rating FROM product WHERE rating BETWEEN 4 AND 5;

-- 24. Selecciona el precio promedio de los productos
SELECT AVG(price) FROM product;

-- 25. Selecciona los productos que no tienen stock disponible (Resultados: 0 filas)
SELECT title FROM product WHERE stock = 0;

-- 26. Selecciona clientes que viven en "Avenida Bosque" y "Calle Flor" (Resultados: 10 filas)
SELECT * FROM customer WHERE address IN ('Avenida Bosque 808', 'Calle Flor 909'); 

-- 27. Selecciona los productos cuya descripción contenga "cámara" (Resultados: 1 filas)
SELECT title FROM product WHERE description LIKE '%cámara%'; 

-- 28. Contar los productos por categoría con un stock mayor a 50 (Resultados: 14 filas)
SELECT category_id, COUNT(*) FROM product WHERE stock > 50 GROUP BY category_id;

-- 29. Selecciona los productos con una calificación superior a la media (Resultados: 43 filas)
SELECT title, rating FROM product WHERE rating > (SELECT AVG(rating) FROM product);

-- 30. Selecciona el nombre y precio de los productos con más de 50 en stock y precio superior a 100 (Resultados: 1 filas)
SELECT title, price FROM product WHERE stock > 50 AND price > 100;

-- 31. Mostrar los clientes con nombre y apellido que comienzan con la letra "J" (Resultados: 1 filas)
SELECT first_name, last_name FROM customer WHERE first_name LIKE 'R%' AND last_name LIKE 'C%';

-- 32. Selecciona los productos de la categoría "Deportes" y "Ropa" --(Resultados: 20 filas)
SELECT title FROM product WHERE category_id IN (4, 2);

-- 33. Selecciona los productos más caros por categoría
SELECT p.*
FROM product p
INNER JOIN (
    SELECT category_id, MAX(price) AS max_price
    FROM product
    GROUP BY category_id
) sub ON p.category_id = sub.category_id AND p.price = sub.max_price;

-- 34. Selecciona los productos con precio superior al promedio de la categoría "Electrónicos" (Resultados: 3 filas)
SELECT title, price FROM product WHERE category_id = 1 AND price > (SELECT AVG(price) FROM product WHERE category_id = 1);

-- 35. Selecciona los productos que no están en stock o su brand contiene la palabra BLE o PYTHON (Resultados: 4 filas)
SELECT title, price FROM product WHERE stock = 0 or title like '%BLE%' or  brand like '%PYTHON%';

-- 36. Selecciona el total gastado por cada cliente
SELECT cu.customer_id, cu.first_name, cu.last_name, 
       SUM(oi.quantity * oi.price) AS total_gastado
FROM customer cu
INNER JOIN orders o ON cu.customer_id = o.customer_id
INNER JOIN order_item oi ON o.order_id = oi.order_id
GROUP BY cu.customer_id, cu.first_name, cu.last_name
ORDER BY total_gastado DESC;

-- 37. Selecciona el cliente que ha comprado el producto más caro (Resultados: 1299€ Carlos Lopez)
SELECT cu.first_name, cu.last_name, p.title AS producto, p.price
FROM customer cu
INNER JOIN orders o ON cu.customer_id = o.customer_id
INNER JOIN order_item oi ON o.order_id = oi.order_id
INNER JOIN product p ON oi.product_id = p.product_id
WHERE p.price = (SELECT MAX(price) FROM product)
LIMIT 1;

-- 38. Selecciona los productos que tienen una calificación superior a 4.5 (Resultados: 43 filas)
SELECT title, rating FROM product WHERE rating > 4.5;

-- 39. Selecciona los productos que tienen menos de 10 unidades en stock y una calificación superior a 4 (Resultados: 1 fila)
SELECT title, stock, rating FROM product WHERE stock < 10 AND rating > 4;

-- 40. Mostrar los productos con una calificación de 5 estrellas  (Resultados: 1 fila)
SELECT title, rating FROM product WHERE rating = 5;

-- 41. Selecciona los productos más vendidos de la categoría "Electrónicos" (Resultados: 3 filas)
SELECT title FROM product WHERE category_id = 1 ORDER BY stock DESC LIMIT 3;

-- 42. Mostrar todos los productos cuyo precio esté entre 100 y 500  (Resultados: 24 filas)
SELECT title, price FROM product WHERE price BETWEEN 100 AND 500;

-- 43. Selecciona los productos que tienen una calificación de 5 estrellas y un precio mayor a 100  (Resultados: 0 filas)
SELECT title, price FROM product WHERE rating = 5 AND price > 100;

-- 44. Selecciona los productos que son de la categoría "Hogar" y tienen un precio mayor a 50  (Resultados: 7 filas)
SELECT title, price FROM product WHERE category_id = 3 AND price > 50;

-- 45. Selecciona los productos cuyo nombre empieza con "Laptop"  (Resultados: 1 filas)
SELECT title FROM product WHERE title LIKE 'Laptop%';

-- 46. Selecciona el total de ventas por cada categoría
SELECT c.name AS categoria, SUM(oi.quantity * oi.price) AS total_ventas
FROM category c
INNER JOIN product p ON c.category_id = p.category_id
INNER JOIN order_item oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.name
ORDER BY total_ventas DESC;

-- 47. Selecciona los productos que tienen un stock de más de 100 unidades y una calificación mayor a 4   (Resultados: 12 filas)
SELECT title, stock, rating FROM product WHERE stock > 100 AND rating > 4;

-- 48. Lista los productos de cada carrito indicando el nombre del cliente, el nombre del producto y la cantidad
SELECT c.first_name, c.last_name, p.title, ca.quantity
FROM cart ca
INNER JOIN customer c ON ca.customer_id = c.customer_id
INNER JOIN product p ON ca.product_id = p.product_id;

-- 49. Muestra cuántos productos distintos tiene cada cliente en su carrito
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT ca.product_id) AS total_productos
FROM cart ca
INNER JOIN customer c ON ca.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 50. Muestra solo los clientes que tienen más de 3 productos distintos en su carrito (Resultados: 1 filas)
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT ca.product_id) AS total_productos
FROM cart ca
INNER JOIN customer c ON ca.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT ca.product_id) > 2;
