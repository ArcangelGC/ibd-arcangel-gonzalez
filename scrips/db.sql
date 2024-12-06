-- Base de datos
CREATE DATABASE IF NOT EXISTS abarrotestienda;
USE abarrotestienda;

-- Tabla Ciudad
CREATE TABLE Ciudad (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Pais VARCHAR(50)
);

-- Inserción de datos en la tabla Ciudad
INSERT INTO Ciudad (Nombre, Pais) VALUES
    ('Lima', 'Peru'),
    ('CDMX', 'Mexico'),
    ('Bogotá', 'Colombia'),
    ('Buenos Aires', 'Argentina'),
    ('Santiago', 'Chile'),
    ('Montevideo', 'Uruguay'),
    ('Quito', 'Ecuador'),
    ('Caracas', 'Venezuela'),
    ('La Paz', 'Bolivia'),
    ('Asunción', 'Paraguay');

-- Tabla Direccion
CREATE TABLE Direccion (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Calle VARCHAR(255),
    Ciudad_ID INT,
    FOREIGN KEY (Ciudad_ID) REFERENCES Ciudad(ID)
);

-- Inserción de datos en la tabla Direccion
INSERT INTO Direccion (Calle, Ciudad_ID) VALUES
    ('Av. Primavera', 1),
    ('Claudio Cruz', 2),
    ('RAM', 3),
    ('Benito Juarez', 4),
    ('Providencia', 5),
    ('Perú', 6),
    ('Av. Amazonas', 7),
    ('Morelos', 8),
    ('Hipodromo', 9),
    ('León', 10);

-- Tabla Cliente
CREATE TABLE Cliente (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Telefono CHAR(13),
    Direccion_ID INT,
    FOREIGN KEY (Direccion_ID) REFERENCES Direccion(ID)
);

-- Inserción de datos en la tabla Cliente
INSERT INTO Cliente (Nombre, Apellido, Telefono, Direccion_ID) VALUES
    ('Luis', 'Perez', '9534659863', 1),
    ('Maria', 'Gomez', '9533769912', 2),
    ('Carlos', 'Ramírez', '9567891234', 3),
    ('Ana', 'Fernández', '9549876543', 4),
    ('Lucía', 'Martínez', '9512345678', 5),
    ('Jorge', 'Silva', '9534123456', 6),
    ('Camila', 'Torres', '9542233445', 7),
    ('Fernando', 'Ruiz', '9511122334', 8),
    ('Elena', 'Castro', '9539988776', 9),
    ('Sofía', 'Vega', '9523344556', 10);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Telefono CHAR(13),
    Direccion_ID INT,
    FOREIGN KEY (Direccion_ID) REFERENCES Direccion(ID)
);

-- Inserción de datos en la tabla Proveedor
INSERT INTO Proveedor (Nombre, Telefono, Direccion_ID) VALUES
    ('Distribuidora ABC', '1234567890', 1),
    ('Proveedor XYZ', '9876543210', 2),
    ('Alimentos del Sur', '9876541111', 3),
    ('Comercial Andina', '9998887776', 4),
    ('Importadora Pacífico', '9443322110', 5),
    ('Mayorista del Centro', '9556677889', 6),
    ('Global Foods', '9311122233', 7),
    ('Productos Los Andes', '9412233445', 8),
    ('Mercado Libre', '9323344556', 9),
    ('Delicatessen Premium', '9214455667', 10);

-- Tabla Puesto
CREATE TABLE Puesto (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50)
);

-- Inserción de datos en la tabla Puesto
INSERT INTO Puesto (Nombre) VALUES
    ('Vendedor'),
    ('Cajero'),
    ('Gerente'),
    ('Supervisor'),
    ('Repartidor'),
    ('Almacenero'),
    ('Administrador'),
    ('Contador'),
    ('Recepcionista'),
    ('Auxiliar de Limpieza');

-- Tabla Empleado
CREATE TABLE Empleado (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Salario DECIMAL(10, 2),
    Puesto_ID INT,
    FOREIGN KEY (Puesto_ID) REFERENCES Puesto(ID)
);

-- Inserción de datos en la tabla Empleado
INSERT INTO Empleado (Nombre, Apellido, Salario, Puesto_ID) VALUES
    ('Juan', 'Martinez', 25000, 1),
    ('Ana', 'Garcia', 20000, 2),
    ('Diego', 'López', 35000, 3),
    ('Sofía', 'Torres', 28000, 4),
    ('Pedro', 'Castillo', 18000, 5),
    ('Claudia', 'Paredes', 22000, 6),
    ('Luis', 'Gutiérrez', 40000, 7),
    ('Mónica', 'Suárez', 30000, 8),
    ('Carlos', 'Ortíz', 19000, 9),
    ('Patricia', 'Aguilar', 17000, 10);

-- Tabla Producto
CREATE TABLE Producto (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Precio DECIMAL(10, 3),
    Categoria VARCHAR(50),
    Stock INT
);

-- Inserción de datos en la tabla Producto
INSERT INTO Producto (Nombre, Descripcion, Precio, Categoria, Stock) VALUES
    ('Arroz', 'Arroz blanco, paquete de 1kg', 25.990, 'Granos', 120),
    ('Frijoles', 'Frijoles negros, paquete de 500g', 18.500, 'Granos', 80),
    ('Aceite', 'Aceite vegetal, botella de 1L', 35.750, 'Aceites', 50),
    ('Azúcar', 'Azúcar refinada, paquete de 1kg', 20.000, 'Granos', 70),
    ('Sal', 'Sal fina, paquete de 1kg', 12.500, 'Condimentos', 90),
    ('Leche', 'Leche entera, litro', 15.000, 'Lácteos', 60),
    ('Queso', 'Queso mozzarella, 500g', 50.000, 'Lácteos', 40),
    ('Pan', 'Pan de caja, 500g', 30.000, 'Panadería', 100),
    ('Mantequilla', 'Mantequilla sin sal, 250g', 40.000, 'Lácteos', 50),
    ('Cereal', 'Cereal integral, 1kg', 55.000, 'Desayuno', 30);

-- Tabla Transaccion_Venta
CREATE TABLE Transaccion_Venta (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Fecha DATE,
    Cantidad INT,
    Precio_total DECIMAL(10, 2),
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

-- Inserción de datos en la tabla Transaccion_Venta
INSERT INTO Transaccion_Venta (Fecha, Cantidad, Precio_total, Cliente_ID) VALUES
    ('2024-04-25', 5, 150.75, 1),
    ('2024-04-25', 3, 90.50, 2),
    ('2024-05-01', 7, 210.25, 3),
    ('2024-05-03', 4, 120.00, 4),
    ('2024-05-05', 6, 180.30, 5),
    ('2024-05-10', 8, 300.00, 6),
    ('2024-05-15', 2, 60.50, 7),
    ('2024-05-20', 10, 500.00, 8),
    ('2024-05-25', 1, 30.00, 9),
    ('2024-05-30', 9, 270.75, 10);

-- Tabla Transaccion_Producto
CREATE TABLE Transaccion_Producto (
    Transaccion_ID INT,
    Producto_ID INT,
    Cantidad INT,
    PRIMARY KEY (Transaccion_ID, Producto_ID),
    FOREIGN KEY (Transaccion_ID) REFERENCES Transaccion_Venta(ID),
    FOREIGN KEY (Producto_ID) REFERENCES Producto(ID)
);

-- Inserción de datos en la tabla Transaccion_Producto
INSERT INTO Transaccion_Producto (Transaccion_ID, Producto_ID, Cantidad) VALUES
    (1, 1, 2),
    (1, 3, 3),
    (2, 2, 1),
    (3, 4, 4),
    (4, 5, 2),
    (5, 6, 6),
    (6, 7, 8),
    (7, 8, 2),
    (8, 9, 5),
    (9, 10, 1);
