--- ####################### TEORIA #####################
-- #### PROCEDIMIENTO ALMACENADO ####
-- Creacion del procedimiento almacenado
DELIMITER //
CREATE PROCEDURE SeleccionarClientes (IN ciudad VARCHAR(50))
BEGIN
    SELECT * FROM bbdd_tienda.clientes WHERE ciudad = ciudad;
END //
DELIMITER ;

-- Ejecutar procedimiento almacenado
CALL SeleccionarClientes('Madrid');


-- #### TRIGGER ####
DELIMITER //

CREATE TRIGGER insertar_auditoria_despues_insert
AFTER INSERT ON bbdd_w3shools.persons
FOR EACH ROW
BEGIN
    INSERT INTO bbdd_w3shools.auditoria (username, date) VALUES (USER(), NOW());
END;
//
DELIMITER ;

--- ####################### PRACTICA #####################
-- 5.1 Procedimientos almacenados
-- A) Crea un procedimiento almacenado llamado CitiesBeginWithA que devuelva las ciudades que empiezan por la letra A
DELIMITER //
CREATE PROCEDURE CitiesBeginWithA ()
BEGIN
   SELECT * FROM city WHERE city LIKE 'A%';
END //
DELIMITER ;
-- B) Crea un procedimiento almacenado llamado CityGetById que devuelva el nombre de la ciudad que coincida con el id recibido como argumento
DELIMITER //
CREATE PROCEDURE CityGetById (IN city_id INT)
BEGIN
   SELECT city FROM city WHERE ID = city_id;
END //
DELIMITER ;

-- C) Crea un procedimiento almacenado llamado CitiesFromCountry que reciba como argumento el nombre de un pais y devuelta todas las ciudades del mismo
DELIMITER //
CREATE PROCEDURE CitiesFromCountry (IN country_name VARCHAR(255))
BEGIN
   SELECT city FROM city WHERE country = country_name;
END //
DELIMITER ;


DELIMITER ;

DROP PROCEDURE IF EXISTS CitiesBeginWith;

-- 5.2 Procedimientos almacenados
-- A) Crea un procedimiento almacenado llamado CitiesFromCountry que devuelva todas las ciudades que comiencen por una letra recibida como argumento
-- Vas a necesitar crear una variable dentro de tu procedimiento dónde concatenes el porcentaje letter y %
DELIMITER //

CREATE PROCEDURE CitiesBeginWith (IN letter VARCHAR(1))
BEGIN
   SET @query = CONCAT(letter, '%');
   SELECT * FROM city WHERE city LIKE @query;
END //


-- B) Crea un procedimiento almacenado llamado GetCityByID que reciba un cityId.
-- Si existe la ciudad, devuelve información de la ciudad y del pais
-- Sino existe devolvera el siguiente texto "City not found"
DELIMITER //

CREATE PROCEDURE GetCityByID(IN city_id INT)
BEGIN
    DECLARE city_name VARCHAR(50);
    DECLARE country_name VARCHAR(50);

    SELECT city, country
    INTO city_name, country_name
    FROM city
    INNER JOIN country ON city.country_id = country.country_id
    WHERE city_id = city_id;

    IF city_name IS NOT NULL THEN
        SELECT city_name AS City, country_name AS Country;
    ELSE
        SELECT 'City not found' AS Message;
    END IF;
END;
//
DELIMITER ;

-- 5.3a Triggers
-- Es el de teoria
-- 5.3b Triggers
DELIMITER //

CREATE TRIGGER modificar_auditoria_despues_update
AFTER UPDATE ON persons
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (username, date) VALUES (USER(), NOW());
END;
//
DELIMITER ;