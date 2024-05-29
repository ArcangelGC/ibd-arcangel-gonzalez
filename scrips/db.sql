-- Active: 1715192259552@@localhost@3306@abarrotestienda
CREATE DATABASE IF NOT EXISTS abarrotestienda;
USE abarrotestienda;

-- Tabla Ciudad
CREATE TABLE Ciudad (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Pais VARCHAR(50)
);

-- Inserción de datos en mi tabla Ciudad
INSERT INTO Ciudad (Nombre, Pais)
VALUES 
('Lima', 'Peru'),
('CDMX', 'Mexico');

-- Tabla Direccion
CREATE TABLE Direccion (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Calle VARCHAR(255),
    Ciudad_ID INT,
    FOREIGN KEY (Ciudad_ID) REFERENCES Ciudad(ID)
);

-- Inserción de datos en mi tabla Direccion
INSERT INTO Direccion (Calle, Ciudad_ID)
VALUES 
('Calle 1', 1),
('Calle 2', 2);

-- Tabla Cliente 
CREATE TABLE Cliente (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Telefono CHAR(13),
    Direccion_ID INT,
    FOREIGN KEY (Direccion_ID) REFERENCES Direccion(ID)
);

-- Inserción de datos en mi tabla Cliente
INSERT INTO Cliente (Nombre, Apellido, Telefono, Direccion_ID)
VALUES 
('Luis Perez', 'Gonzalez', '9534659863', 1),
('Maria Gomez', 'Hernandez', '9533769912', 2);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Telefono CHAR(13),
    Direccion_ID INT,
    FOREIGN KEY (Direccion_ID) REFERENCES Direccion(ID)
);

-- Inserción de datos en mi tabla Proveedor
INSERT INTO Proveedor (Nombre, Telefono, Direccion_ID)
VALUES 
('Distribuidora ABC', '1234567890', 1),
('Proveedor XYZ', '9876543210', 2);

-- Tabla Puesto
CREATE TABLE Puesto (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50)
);

-- Inserción de datos en la tabla Puesto
INSERT INTO Puesto (Nombre)
VALUES 
('Vendedor'),
('Cajero'),
('Gerente');

-- Tabla Empleado
CREATE TABLE Empleado (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Puesto VARCHAR(50),
    Salario DECIMAL(10, 2),
    Puesto_ID INT,
    FOREIGN KEY (Puesto_ID) REFERENCES Puesto(ID)
);

-- Inserción de datos en mi tabla Empleado
INSERT INTO Empleado (Nombre, Apellido, Puesto, Salario, Puesto_ID)
VALUES 
('Juan Martinez', 'Garcia', 'Vendedor', 25000, 1),
('Ana Garcia', 'Martinez', 'Cajero', 20000, 2),
('Diego Lopez', 'Perez', 'Gerente', 35000, 3);

-- Tabla Producto 
CREATE TABLE Producto (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Precio DECIMAL(10, 3),
    Categoria VARCHAR(50),
    Stock INT
);

-- Inserción de datos en mi tabla Producto
INSERT INTO Producto (Nombre, Descripcion, Precio, Categoria, Stock)
VALUES 
('Arroz', 'Arroz blanco, paquete de 1kg', 25.99, 'Granos', 120),
('Frijoles', 'Frijoles negros, paquete de 500g', 18.50, 'Granos', 80),
('Aceite', 'Aceite vegetal, botella de 1L', 35.75, 'Aceites', 50);

-- Tabla Transaccion_Venta
CREATE TABLE Transaccion_Venta (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Fecha DATE,
    Cantidad INT,
    Precio_total DECIMAL(10, 2),
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

-- Insercion de datos en mi tabla Transaccion_Venta
INSERT INTO Transaccion_Venta (Fecha, Cantidad, Precio_total, Cliente_ID)
VALUES 
('2024-04-24', 5, 150.75, 1),
('2024-04-25', 3, 90.50, 2);

-- Tabla Transaccion_Producto
CREATE TABLE Transaccion_Producto (
    Transaccion_ID INT,
    Producto_ID INT,
    Cantidad INT,
    PRIMARY KEY (Transaccion_ID, Producto_ID),
    FOREIGN KEY (Transaccion_ID) REFERENCES Transaccion_Venta(ID),
    FOREIGN KEY (Producto_ID) REFERENCES Producto(ID)
);

-- Insercion de datos en mi tabla de Transaccion_Producto
INSERT INTO Transaccion_Producto (Transaccion_ID, Producto_ID, Cantidad)
VALUES 
(1, 1, 2),
(2, 2, 1);

-- Seleccionar todos los datos de una tabla
SELECT * FROM Producto;

-- Seleccionar datos específicos de una tabla
SELECT Nombre, Descripcion FROM Producto;

-- Seleccionar datos filtrados por una condición
SELECT * FROM Empleado WHERE Salario > 50000;

-- Ordenar resultados en orden ascendente o descendente
SELECT * FROM Producto ORDER BY Precio DESC;

-- Contar el número de filas en una tabla
SELECT COUNT(*) FROM Cliente;

-- Sumar valores de una columna
SELECT SUM(Stock) FROM Producto;

-- Obtener el valor máximo y mínimo de una columna
SELECT MAX(Salario), MIN(Salario) FROM Empleado;

-- Unir dos tablas usando INNER JOIN
SELECT Cliente.Nombre, Transaccion_Venta.Fecha
FROM Cliente
INNER JOIN Transaccion_Venta ON Cliente.ID = Transaccion_Venta.Cliente_ID;


-- Consulta con subconsultas correlacionadas
select * from empleado;


-- Consulta con funciones de fecha
SELECT c.Nombre, tv.Fecha
FROM Transaccion_Venta tv
inner join cliente c on c.`ID` = tv.`Cliente_ID`
WHERE YEAR(tv.Fecha) = 2023;

-- Consulta con UNION para combinar resultados
SELECT Nombre, 'Empleado' AS tipo
FROM Empleado
UNION
SELECT Nombre, 'Cliente' AS tipo
FROM Cliente;

-- Consulta con operadores LIKE para búsqueda de texto parcial
SELECT Nombre, Direccion_ID
FROM Cliente
WHERE Direccion_ID IN (
    SELECT ID FROM Direccion WHERE Calle LIKE '%Calle%'
);

-- Consulta con subconsultas y operadores EXISTS o NOT EXISTS
SELECT Nombre
FROM Producto
WHERE EXISTS (
    SELECT 1 
    FROM Transaccion_Producto 
    WHERE Transaccion_Producto.Producto_ID = Producto.ID
);

-- Consulta con ordenamiento y paginación
SELECT Nombre, Salario
FROM Empleado
ORDER BY Salario DESC
LIMIT 10 OFFSET 10;