-- =====================================================
-- BASE DE DATOS: istec - Tablas Catálogo (Simplificado)
-- Solo usando VARCHAR e INT
-- =====================================================

CREATE DATABASE istec;
USE istec;

-- =========================
-- 1. categorias_producto
-- =========================
CREATE TABLE categorias_producto (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
descripcion VARCHAR(200),
activo INT,
fecha_creacion VARCHAR(20)
);

-- =========================
-- 2. marcas
-- =========================
CREATE TABLE marcas (
id_marca INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
pais_origen VARCHAR(50),
activo INT,
fecha_registro VARCHAR(20)
);

-- =========================
-- 3. unidades_medida
-- =========================
CREATE TABLE unidades_medida (
id_unidad INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30),
abreviatura VARCHAR(10),
tipo VARCHAR(20),
activo INT
);

-- =========================
-- 4. monedas
-- =========================
CREATE TABLE monedas (
id_moneda INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30),
simbolo VARCHAR(10),
tipo_cambio INT,
vigente INT
);

-- =========================
-- 5. formas_pago
-- =========================
CREATE TABLE formas_pago (
id_forma_pago INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
aplica_recargo INT,
porcentaje_recargo INT,
fecha_vigencia VARCHAR(20)
);

-- =========================
-- 6. metodos_envio
-- =========================
CREATE TABLE metodos_envio (
id_envio INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
costo INT,
tiempo_entrega_dias INT,
activo INT
);

-- =========================
-- 7. almacenes
-- =========================
CREATE TABLE almacenes (
id_almacen INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
ubicacion VARCHAR(200),
capacidad INT,
activo INT
);

-- =========================
-- 8. estados_pedido
-- =========================
CREATE TABLE estados_pedido (
id_estado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30),
descripcion VARCHAR(200),
orden INT,
activo INT
);

-- =========================
-- 9. tipos_cliente
-- =========================
CREATE TABLE tipos_cliente (
id_tipo INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30),
descuento INT,
activo INT,
descripcion VARCHAR(200)
);

-- =========================
-- 10. proveedores
-- =========================
CREATE TABLE proveedores (
id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
nombre varchar(20),
ruc VARCHAR(11),
telefono VARCHAR(20),
direccion VARCHAR(200),
estado VARCHAR(20)
);