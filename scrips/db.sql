CREATE DATABASE IF NOT EXISTS tiendadeabarrotes;
USE tiendadeabarrotes;

-- Tabla Producto 
CREATE TABLE Producto (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Precio DECIMAL(10, 3),
    Categoria VARCHAR(50),
    Stock INT
);

-- Tabla Cliente 
CREATE TABLE Cliente (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Telefono CHAR(13),
    Direccion VARCHAR(255)
);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Telefono CHAR(13),
    Direccion VARCHAR(255)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Puesto VARCHAR(50),
    Salario DECIMAL(10, 2)
);

-- Tabla Transaccion_Venta
CREATE TABLE Transaccion_Venta (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Fecha DATE,
    Cantidad INT,
    Precio_total DECIMAL(10, 2),
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

-- Tabla Transaccion_Producto
CREATE TABLE Transaccion_Producto (
    Transaccion_ID INT,
    Producto_ID INT,
    Cantidad INT,
    PRIMARY KEY (Transaccion_ID, Producto_ID),
    FOREIGN KEY (Transaccion_ID) REFERENCES Transaccion_Venta(ID),
    FOREIGN KEY (Producto_ID) REFERENCES Producto(ID)
);


-- Inserción de datos en mi tabla Cliente
INSERT INTO Cliente (Nombre, Apellido, Telefono, Direccion)
VALUES 
('Luis Perez', 'Gonzalez', '9534659863', 'Tlaxiaco, Oaxaca'),
('Maria Gomez', 'Hernandez', '9533769912', 'Oaxaca, Oaxaca'),
('Pedro Hernandez', 'Lopez', '9535479899', 'Puebla, Puebla');

-- Inserción de datos en mi tabla Empleado
INSERT INTO Empleado (Nombre, Apellido, Puesto, Salario)
VALUES 
('Juan Martinez', 'Garcia', 'Vendedor', 25000),
('Ana Garcia', 'Martinez', 'Cajero', 20000),
('Diego Lopez', 'Perez', 'Gerente', 35000);

-- Inserción de datos en mi tabla Producto
INSERT INTO Producto (Nombre, Descripcion, Precio, Categoria, Stock)
VALUES 
('Arroz', 'Arroz blanco, paquete de 1kg', 25.99, 'Granos', 120),
('Frijoles', 'Frijoles negros, paquete de 500g', 18.50, 'Granos', 80),
('Aceite', 'Aceite vegetal, botella de 1L', 35.75, 'Aceites', 50);

-- Inserción de datos en mi tabla Proveedor
INSERT INTO Proveedor (Nombre, Telefono, Direccion)
VALUES 
('Distribuidora ABC', '1234567890', 'Calle Principal #123'),
('Proveedor XYZ', '9876543210', 'Avenida Central #456'),
('Suministros EFG', '2468101214', 'Boulevard Norte #789');

-- Insercion de datos en mi tabla Transaccion_Venta
INSERT INTO Transaccion_Venta (Fecha, Cantidad, Precio_total, Cliente_ID)
VALUES 
('2024-04-24', 5, 150.75, 1),
('2024-04-25', 3, 90.50, 2),
('2024-04-26', 2, 60.25, 3);

-- Insercion de datos en mi tabla de Transaccion_Producto
INSERT INTO Transaccion_Producto (Transaccion_ID, Producto_ID, Cantidad)
VALUES 
(1, 1, 2),
(2, 2, 1),
(3, 3, 2);

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

-- Consulta con JOIN y condiciones adicionales
SELECT e.Nombre AS empleado, d.Nombre AS departamento
FROM Empleado e
JOIN Departamento d ON e.Departamento_ID = d.ID
WHERE e.Salario > 50000;

-- Consulta con subconsultas correlacionadas
SELECT e.Nombre AS empleado, e.Salario
FROM Empleado e
WHERE e.Salario > (
    SELECT AVG(Salario) FROM Empleado WHERE Departamento_ID = e.Departamento_ID
);

-- Consulta con funciones de agregación y GROUP BY
SELECT Departamento_ID, AVG(Salario) AS salario_promedio
FROM Empleado
GROUP BY Departamento_ID;

-- Consulta con funciones de fecha
SELECT Nombre, Fecha_Contratacion
FROM Empleado
WHERE YEAR(Fecha_Contratacion) = 2023;

-- Consulta con UNION para combinar resultados
SELECT Nombre, 'Empleado' AS tipo
FROM Empleado
UNION
SELECT Nombre, 'Cliente' AS tipo
FROM Cliente;

-- Consulta con operadores LIKE para búsqueda de texto parcial
SELECT Nombre, Direccion
FROM Cliente
WHERE Direccion LIKE '%Calle%';

-- Consulta con subconsultas y operadores EXISTS o NOT EXISTS
SELECT Nombre
FROM Producto
WHERE EXISTS (
    SELECT 1 FROM Transaccion_Venta WHERE Producto_ID = Producto.ID
);

-- Consulta con ordenamiento y paginación
SELECT Nombre, Salario
FROM Empleado
ORDER BY Salario DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;