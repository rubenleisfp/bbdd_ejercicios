-- 1. Selecciona todos los productos
SELECT * FROM product;

-- 2. Selecciona el nombre y precio de los productos
SELECT title, price FROM product;

-- 3. Selecciona todos los clientes con sus nombres
SELECT first_name, last_name FROM customer;

-- 4. Selecciona productos con un precio mayor a 100
SELECT * FROM product WHERE price > 100;

-- 5. Selecciona clientes cuyo apellido sea 'Gómez'
SELECT * FROM customer WHERE last_name = 'Gómez';

-- 6. Contar el número total de productos en la tabla `product`
SELECT COUNT(*) FROM product;

-- 7. Selecciona productos con un precio menor a 50
SELECT title, price FROM product WHERE price < 50;

-- 8. Selecciona todos los productos de la categoría "Electrónicos"
SELECT * FROM product WHERE category_id = 1;

-- 9. Selecciona los clientes que viven en "Avenida Siempre Viva"
SELECT * FROM customer WHERE address = 'Avenida Siempre Viva 456';

-- 10. Selecciona productos con una calificación mayor a 4.5
SELECT title, rating FROM product WHERE rating > 4.5;

-- 11. Contar cuántos clientes tienen un teléfono que empieza con "555-1"
SELECT COUNT(*) FROM customer WHERE phone_number LIKE '555-1%';

-- 12. Selecciona el nombre de los clientes ordenados por apellido
SELECT first_name, last_name FROM customer ORDER BY last_name;

-- 13. Selecciona productos de más de 50 en stock
SELECT title, stock FROM product WHERE stock > 50;

-- 14. Selecciona los 5 productos más caros
SELECT title, price FROM product ORDER BY price DESC LIMIT 5;

-- 15. Selecciona los 5 productos más baratos
SELECT title, price FROM product ORDER BY price ASC LIMIT 5;

-- 16. Selecciona los productos de la categoría "Ropa"
SELECT title, price FROM product WHERE category_id = 2;

-- 17. Selecciona los clientes con nombre "Juan"
SELECT * FROM customer WHERE first_name = 'Juan';

-- 18. Selecciona productos cuyo nombre contenga "Smart"
SELECT * FROM product WHERE title LIKE '%Smart%';

-- 19. Contar el número de productos por categoría
SELECT category_id, COUNT(*) FROM product GROUP BY category_id;

-- 20. Selecciona productos con un stock entre 20 y 100
SELECT title, stock FROM product WHERE stock BETWEEN 20 AND 100;

-- 21. Sumar los precios de todos los productos
SELECT SUM(price) FROM product;

-- 22. Selecciona el producto más caro
SELECT title, price FROM product ORDER BY price DESC LIMIT 1;

-- 23. Selecciona los clientes que tienen un número de teléfono que termina en "01"
SELECT * FROM customer WHERE phone_number LIKE '%01';

-- 24. Contar los productos por categoría con un stock mayor a 50
SELECT category_id, COUNT(*) FROM product WHERE stock > 50 GROUP BY category_id;

-- 25. Selecciona el nombre y el correo de los clientes cuyo nombre empieza con "M"
SELECT first_name, email FROM customer WHERE first_name LIKE 'M%';

-- 26. Mostrar los productos con una calificación entre 4 y 5
SELECT title, rating FROM product WHERE rating BETWEEN 4 AND 5;

-- 27. Selecciona el precio promedio de los productos
SELECT AVG(price) FROM product;

-- 28. Selecciona los productos que no tienen stock disponible
SELECT title FROM product WHERE stock = 0;

-- 29. Selecciona clientes que viven en "Avenida Bosque" y "Calle Flor"
SELECT * FROM customer WHERE address IN ('Avenida Bosque 808', 'Calle Flor 909');

-- 30. Selecciona los productos cuya descripción contenga "cámara"
SELECT title FROM product WHERE description LIKE '%cámara%';

-- 31. Contar los productos por categoría con un stock mayor a 50
SELECT category_id, COUNT(*) FROM product WHERE stock > 50 GROUP BY category_id;

-- 32. Selecciona los productos con una calificación superior a la media
SELECT title, rating FROM product WHERE rating > (SELECT AVG(rating) FROM product);

-- 33. Selecciona el nombre y precio de los productos con más de 50 en stock y precio superior a 100
SELECT title, price FROM product WHERE stock > 50 AND price > 100;

-- 34. Mostrar los clientes con nombre y apellido que comienzan con la letra "J"
SELECT first_name, last_name FROM customer WHERE first_name LIKE 'J%' AND last_name LIKE 'J%';

-- 35. Selecciona los productos de la categoría "Deportes" y "Ropa"
SELECT title FROM product WHERE category_id IN (4, 2);

-- 36. Selecciona los productos más caros por categoría
SELECT category_id, title, price FROM product WHERE price = (SELECT MAX(price) FROM product WHERE category_id = product.category_id) ORDER BY category_id;

-- 37. Selecciona los productos con precio superior al promedio de la categoría "Electrónicos"
SELECT title, price FROM product WHERE category_id = 1 AND price > (SELECT AVG(price) FROM product WHERE category_id = 1);

-- 38. Selecciona los productos que no están en stock y actualiza su precio
SELECT title, price FROM product WHERE stock = 0;

-- 39. Selecciona el total gastado por cada cliente
SELECT customer_id, SUM(price) FROM orders GROUP BY customer_id;

-- 40. Selecciona el cliente que ha comprado el producto más caro
SELECT customer.first_name, customer.last_name FROM customer JOIN orders ON customer.customer_id = orders.customer_id JOIN product ON orders.product_id = product.product_id ORDER BY product.price DESC LIMIT 1;

-- 41. Selecciona los productos que tienen una calificación superior a 4.5
SELECT title, rating FROM product WHERE rating > 4.5;

-- 42. Selecciona los productos que tienen menos de 10 unidades en stock y una calificación superior a 4
SELECT title, stock, rating FROM product WHERE stock < 10 AND rating > 4;

-- 43. Mostrar los productos con una calificación de 5 estrellas
SELECT title, rating FROM product WHERE rating = 5;

-- 44. Selecciona los productos más vendidos de la categoría "Electrónicos"
SELECT title FROM product WHERE category_id = 1 ORDER BY stock DESC LIMIT 3;

-- 45. Mostrar todos los productos cuyo precio esté entre 100 y 500
SELECT title, price FROM product WHERE price BETWEEN 100 AND 500;

-- 46. Selecciona los productos que tienen una calificación de 5 estrellas y un precio mayor a 100
SELECT title, price FROM product WHERE rating = 5 AND price > 100;

-- 47. Selecciona los productos que son de la categoría "Hogar" y tienen un precio mayor a 50
SELECT title, price FROM product WHERE category_id = 3 AND price > 50;

-- 48. Selecciona los productos cuyo nombre empieza con "Super"
SELECT title FROM product WHERE title LIKE 'Super%';

-- 49. Selecciona el total de ventas por cada categoría
SELECT category_id, SUM(price) FROM product JOIN orders ON product.product_id = orders.product_id GROUP BY category_id;

-- 50. Selecciona los productos que tienen un stock de más de 100 unidades y una calificación mayor a 4
SELECT title, stock, rating FROM product WHERE stock > 100 AND rating > 4;

-- 51. Lista los productos de cada carrito indicando el nombre del cliente, el nombre del producto y la cantidad
SELECT c.first_name, c.last_name, p.title, ca.quantity
FROM cart ca
INNER JOIN customer c ON ca.customer_id = c.customer_id
INNER JOIN product p ON ca.product_id = p.product_id;

-- 52. Muestra cuántos productos distintos tiene cada cliente en su carrito
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT ca.product_id) AS total_productos
FROM cart ca
INNER JOIN customer c ON ca.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 53. Muestra solo los clientes que tienen más de 3 productos distintos en su carrito
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT ca.product_id) AS total_productos
FROM cart ca
INNER JOIN customer c ON ca.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT ca.product_id) > 3;


