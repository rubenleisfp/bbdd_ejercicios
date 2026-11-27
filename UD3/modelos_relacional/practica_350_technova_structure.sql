-- =====================================================================
-- Tienda online TechNova — Modelo relacional (MySQL 8.0.16+)
-- Script reejecutable: crea la BD si no existe y recrea las tablas
-- (elimina primero las tablas en orden inverso a las dependencias).
-- ATENCIÓN: al ejecutarlo se pierden los datos de estas tablas.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS technova
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE technova;

-- ---------------------------------------------------------------------
-- Borrado previo (hijas primero, padres después)
-- ---------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS LineaPedido;
DROP TABLE IF EXISTS Pago;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Suministra;
DROP TABLE IF EXISTS ProductoDigital;
DROP TABLE IF EXISTS ProductoFisico;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Direccion;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Categoria;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------
-- Categoria (relación reflexiva: categoría padre)
-- ---------------------------------------------------------------------
CREATE TABLE Categoria (
    codigo_categoria        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre                  VARCHAR(100) NOT NULL,
    descripcion             VARCHAR(255) NULL,
    codigo_categoria_padre  INT UNSIGNED NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (codigo_categoria),
    CONSTRAINT fk_categoria_padre FOREIGN KEY (codigo_categoria_padre)
        REFERENCES Categoria (codigo_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Cliente
-- ---------------------------------------------------------------------
CREATE TABLE Cliente (
    dni              CHAR(9)      NOT NULL,
    nombre           VARCHAR(50)  NOT NULL,
    apellido1        VARCHAR(50)  NOT NULL,
    apellido2        VARCHAR(50)  NOT NULL,
    fecha_nacimiento DATE         NOT NULL,
    email            VARCHAR(100) NOT NULL,
    telefono         VARCHAR(15)  NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (dni)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Direccion (entidad débil de Cliente)
-- ---------------------------------------------------------------------
CREATE TABLE Direccion (
    dni_cliente      CHAR(9)      NOT NULL,
    numero_direccion INT UNSIGNED NOT NULL,
    calle            VARCHAR(150) NOT NULL,
    ciudad           VARCHAR(80)  NOT NULL,
    codigo_postal    VARCHAR(10)  NOT NULL,
    pais             VARCHAR(60)  NOT NULL,
    CONSTRAINT pk_direccion PRIMARY KEY (dni_cliente, numero_direccion),
    CONSTRAINT fk_direccion_cliente FOREIGN KEY (dni_cliente)
        REFERENCES Cliente (dni)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Proveedor
-- ---------------------------------------------------------------------
CREATE TABLE Proveedor (
    cif      CHAR(9)      NOT NULL,
    nombre   VARCHAR(100) NOT NULL,
    email    VARCHAR(100) NULL,
    telefono VARCHAR(15)  NULL,
    CONSTRAINT pk_proveedor PRIMARY KEY (cif)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Producto (supertipo de la especialización)
-- ---------------------------------------------------------------------
CREATE TABLE Producto (
    sku              VARCHAR(20)   NOT NULL,
    nombre           VARCHAR(100)  NOT NULL,
    descripcion      TEXT          NULL,
    precio           DECIMAL(10,2) NOT NULL,
    stock            INT UNSIGNED  NOT NULL DEFAULT 0,
    codigo_categoria INT UNSIGNED  NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (sku),
    CONSTRAINT ck_producto_precio CHECK (precio >= 0),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (codigo_categoria)
        REFERENCES Categoria (codigo_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- ProductoFisico (subtipo)
-- ---------------------------------------------------------------------
CREATE TABLE ProductoFisico (
    sku         VARCHAR(20)   NOT NULL,
    peso_kg     DECIMAL(8,3)  NOT NULL,
    dimensiones VARCHAR(50)   NULL,
    CONSTRAINT pk_productofisico PRIMARY KEY (sku),
    CONSTRAINT ck_productofisico_peso CHECK (peso_kg >= 0),
    CONSTRAINT fk_productofisico_producto FOREIGN KEY (sku)
        REFERENCES Producto (sku)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- ProductoDigital (subtipo)
-- ---------------------------------------------------------------------
CREATE TABLE ProductoDigital (
    sku             VARCHAR(20)   NOT NULL,
    tamano_mb       DECIMAL(10,2) NOT NULL,
    enlace_descarga VARCHAR(255)  NOT NULL,
    CONSTRAINT pk_productodigital PRIMARY KEY (sku),
    CONSTRAINT ck_productodigital_tamano CHECK (tamano_mb >= 0),
    CONSTRAINT fk_productodigital_producto FOREIGN KEY (sku)
        REFERENCES Producto (sku)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Suministra (N:M Proveedor - Producto)
-- ---------------------------------------------------------------------
CREATE TABLE Suministra (
    cif_proveedor      CHAR(9)       NOT NULL,
    sku                VARCHAR(20)   NOT NULL,
    precio_compra      DECIMAL(10,2) NOT NULL,
    plazo_entrega_dias SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT pk_suministra PRIMARY KEY (cif_proveedor, sku),
    CONSTRAINT ck_suministra_precio CHECK (precio_compra >= 0),
    CONSTRAINT fk_suministra_proveedor FOREIGN KEY (cif_proveedor)
        REFERENCES Proveedor (cif)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_suministra_producto FOREIGN KEY (sku)
        REFERENCES Producto (sku)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Pedido
--  · dni_cliente: cliente que realiza el pedido
--  · (dni_cliente, numero_direccion_envio): FK compuesta a Direccion, así
--    la dirección de envío siempre pertenece al mismo cliente.
--    Si numero_direccion_envio es NULL (pedido solo digital) MySQL no
--    comprueba la FK compuesta.
-- ---------------------------------------------------------------------
CREATE TABLE Pedido (
    numero_pedido          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fecha_pedido           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado                 VARCHAR(20)  NOT NULL,
    dni_cliente            CHAR(9)      NOT NULL,
    numero_direccion_envio INT UNSIGNED NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (numero_pedido),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (dni_cliente)
        REFERENCES Cliente (dni)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_pedido_direccion_envio FOREIGN KEY (dni_cliente, numero_direccion_envio)
        REFERENCES Direccion (dni_cliente, numero_direccion)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Pago (entidad débil de Pedido)
-- ---------------------------------------------------------------------
CREATE TABLE Pago (
    numero_pedido INT UNSIGNED  NOT NULL,
    numero_pago   INT UNSIGNED  NOT NULL,
    fecha_pago    DATETIME      NOT NULL,
    importe       DECIMAL(10,2) NOT NULL,
    metodo_pago   VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY (numero_pedido, numero_pago),
    CONSTRAINT ck_pago_importe CHECK (importe >= 0),
    CONSTRAINT fk_pago_pedido FOREIGN KEY (numero_pedido)
        REFERENCES Pedido (numero_pedido)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- LineaPedido (N:M Pedido - Producto, relación "Contiene")
-- El total del pedido NO se almacena (atributo derivado):
-- SUM(cantidad * precio_unitario)
-- ---------------------------------------------------------------------
CREATE TABLE LineaPedido (
    numero_pedido   INT UNSIGNED  NOT NULL,
    sku             VARCHAR(20)   NOT NULL,
    cantidad        INT UNSIGNED  NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_lineapedido PRIMARY KEY (numero_pedido, sku),
    CONSTRAINT ck_lineapedido_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_lineapedido_precio CHECK (precio_unitario >= 0),
    CONSTRAINT fk_lineapedido_pedido FOREIGN KEY (numero_pedido)
        REFERENCES Pedido (numero_pedido)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_lineapedido_producto FOREIGN KEY (sku)
        REFERENCES Producto (sku)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;
