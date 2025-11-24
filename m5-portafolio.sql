
-- Evaluación de Portafolio - Gestión de BD Relacional
-- Este archivo integra todos los ítems de la pauta en un solo proyecto

-- ÍTEM 1 y 2: Distinguir características y usar DDL
-- Creación de tablas con claves primarias y foráneas

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,   -- PK
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    correo_electronico VARCHAR(120) UNIQUE
);

CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,    -- PK
    id_cliente INT NOT NULL,         -- FK hacia clientes
    fecha DATE NOT NULL,
    estado VARCHAR(50),
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(12,2) NOT NULL CHECK (precio > 0),
    cantidad_inventario INT NOT NULL DEFAULT 0 CHECK (cantidad_inventario >= 0)
);

CREATE TABLE transacciones (
    id_transaccion SERIAL PRIMARY KEY,
    tipo VARCHAR(10) CHECK (tipo IN ('compra','venta')),
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    id_producto INT NOT NULL,
    id_cliente INT NOT NULL,
    CONSTRAINT fk_tx_producto FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto) ON DELETE RESTRICT,
    CONSTRAINT fk_tx_cliente FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente) ON DELETE CASCADE
);