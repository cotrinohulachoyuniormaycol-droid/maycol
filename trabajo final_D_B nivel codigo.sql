CREATE DATABASE autoexpres_lima;
use autoexpres_lima;
-- ============
-- TABLA CLIENTE
-- ==========

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    documento_identidad VARCHAR(20) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100)
);

-- =================
-- TABLA VEHICULO
-- ===================

CREATE TABLE vehiculo (
    placa VARCHAR(100) PRIMARY KEY,
    id_cliente INT NOT NULL,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    anio_fabricacion YEAR,
    color VARCHAR(30),
    tipo VARCHAR(30),

    CONSTRAINT fk_vehiculo_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ==============
-- TABLA ORDEN DE TRABAJO
-- ================

CREATE TABLE orden_trabajo (
    id_orden INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_entrega_estimada DATE,
    kilometraje INT,
    descripcion_problema TEXT NOT NULL,

    CONSTRAINT fk_orden_vehiculo
    FOREIGN KEY (placa)
    REFERENCES vehiculo(placa)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- ==============
-- TABLA MECANICO
-- ===============

CREATE TABLE mecanico (
    id_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    codigo_empleado VARCHAR(20) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    fecha_ingreso DATE
);

-- ===========
-- TABLA ASIGNACION
-- ==============

CREATE TABLE asignacion (
    id_orden INT NOT NULL,
    id_mecanico INT NOT NULL,
    horas_trabajadas DECIMAL(5,2) NOT NULL,
    observacion_tecnica TEXT,

    PRIMARY KEY (id_orden, id_mecanico),

    CONSTRAINT fk_asignacion_orden
    FOREIGN KEY (id_orden)
    REFERENCES orden_trabajo(id_orden)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_asignacion_mecanico
    FOREIGN KEY (id_mecanico)
    REFERENCES mecanico(id_mecanico)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- ==========
-- TABLA REPUEST
-- ===============
CREATE TABLE repuesto (
    id_repuesto INT PRIMARY KEY AUTO_INCREMENT,
    codigo_repuesto VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(45) NOT NULL,
    marca VARCHAR(50),
    precio_unitario DECIMAL(10,2) NOT NULL,
    stock_disponible INT NOT NULL
);

-- ==========
-- TABLA DETALLE ORDEN
-- ==========

CREATE TABLE detalle_orden (
    id_orden INT NOT NULL,
    id_repuesto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_orden, id_repuesto),

    CONSTRAINT fk_detalle_orden
    FOREIGN KEY (id_orden)
    REFERENCES orden_trabajo(id_orden)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_detalle_repuesto
    FOREIGN KEY (id_repuesto)
    REFERENCES repuesto(id_repuesto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- ==========
-- TABLA PAGO
-- =========

CREATE TABLE pago (
    id_orden INT NOT NULL,
    numero_cuota INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto_pagado DECIMAL(10,2) NOT NULL,
    medio_pago VARCHAR(30) NOT NULL,

    PRIMARY KEY (id_orden, numero_cuota),

    CONSTRAINT fk_pago_orden
    FOREIGN KEY (id_orden)
    REFERENCES orden_trabajo(id_orden)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ====
INSERT INTO cliente
(documento_identidad, nombres, apellidos, telefono, correo_electronico)
VALUES
('72654321', 'Juan', 'Perez Lopez', '987654321', 'juan@gmail.com'),
('71456789', 'Maria', 'Garcia Torres', '986543210', 'maria@gmail.com');
-- =========000
INSERT INTO vehiculo
(placa, id_cliente, marca, modelo, anio_fabricacion, color, tipo)
VALUES
('ABC-123', 1, 'Toyota', 'Corolla', 2020, 'Rojo', 'Auto'),
('XYZ-456', 1, 'Honda', 'Civic', 2019, 'Negro', 'Auto'),
('DEF-789', 2, 'Nissan', 'Frontier', 2021, 'Blanco', 'Camioneta');
-- ============00
INSERT INTO orden_trabajo
(placa, fecha_ingreso, fecha_entrega_estimada, kilometraje, descripcion_problema)
VALUES
('ABC-123', '2026-07-01', '2026-07-03', 45000,
'Revisión del motor y cambio de aceite'),

('XYZ-456', '2026-07-05', '2026-07-07', 60000,
'Problemas en el sistema eléctrico');
-- ===========================================
INSERT INTO mecanico
(codigo_empleado, nombres, apellidos, especialidad, fecha_ingreso)
VALUES
('MEC001', 'Carlos', 'Ramirez', 'Motor', '2024-01-10'),
('MEC002', 'Pedro', 'Sanchez', 'Electricidad', '2024-03-15');
-- =================================000000
INSERT INTO repuesto
(codigo_repuesto, nombre, marca, precio_unitario, stock_disponible)
VALUES
('REP001', 'Filtro de aceite', 'Toyota', 35.00, 20),
('REP002', 'Pastillas de freno', 'Bosch', 180.00, 15),
('REP003', 'Aceite de motor', 'Castrol', 120.00, 30);
-- =================================0
INSERT INTO asignacion
(id_orden, id_mecanico, horas_trabajadas, observacion_tecnica)
VALUES
(1, 1, 4.5, 'Se realizó revisión completa del motor'),
(2, 2, 3.0, 'Se revisó el sistema eléctrico');
-- ===================000====================00
INSERT INTO detalle_orden
(id_orden, id_repuesto, cantidad, precio_venta)
VALUES
(1, 1, 1, 35.00),
(1, 3, 4, 120.00),
(2, 2, 1, 180.00);
-- ======================00000000
INSERT INTO pago
(id_orden, numero_cuota, fecha_pago, monto_pagado, medio_pago)
VALUES
(1, 1, '2026-07-03', 300.00, 'Efectivo'),
(1, 2, '2026-07-04', 200.00, 'Tarjeta'),
(2, 1, '2026-07-07', 180.00, 'Transferencia');
-- ============================00
-- CONSULTAS IMPORTANTES
SELECT
    c.nombres,
    c.apellidos,
    v.placa,
    v.marca,
    v.modelo
FROM cliente c
INNER JOIN vehiculo v
ON c.id_cliente = v.id_cliente;
-- ===============================0
SELECT
    v.placa,
    v.marca,
    v.modelo,
    o.id_orden,
    o.fecha_ingreso,
    o.descripcion_problema
FROM vehiculo v
INNER JOIN orden_trabajo o
ON v.placa = o.placa
WHERE v.placa = 'ABC-123';
-- ========================00==========
SELECT
    o.id_orden,
    m.nombres,
    m.apellidos,
    m.especialidad,
    a.horas_trabajadas,
    a.observacion_tecnica
FROM asignacion a
INNER JOIN mecanico m
ON a.id_mecanico = m.id_mecanico
INNER JOIN orden_trabajo o
ON a.id_orden = o.id_orden;
-- ===================================
SELECT
    o.id_orden,
    r.nombre,
    d.cantidad,
    d.precio_venta,
    d.cantidad * d.precio_venta AS subtotal
FROM detalle_orden d
INNER JOIN repuesto r
ON d.id_repuesto = r.id_repuesto
INNER JOIN orden_trabajo o
ON d.id_orden = o.id_orden;
-- ==================================000 
SELECT
    id_orden,
    numero_cuota,
    fecha_pago,
    monto_pagado,
    medio_pago
FROM pago
WHERE id_orden = 1;