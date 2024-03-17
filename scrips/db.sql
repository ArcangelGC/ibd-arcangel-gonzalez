CREATE DATABASE tiendadeabarrotes;
USE tiendadeabarrotes;

-- Tabla Producto
CREATE TABLE Producto (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion TEXT, O VARCHAR(n) 
    Precio DECIMAL(10, 2),
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

-- Crear la tabla Transaccion_Producto (relación muchos a muchos entre Transaccion_Venta y Producto)
CREATE TABLE Transaccion_Producto (
    Transaccion_ID INT,
    Producto_ID INT,
    Cantidad INT,
    PRIMARY KEY (Transaccion_ID, Producto_ID),
    FOREIGN KEY (Transaccion_ID) REFERENCES Transaccion_Venta(ID),
    FOREIGN KEY (Producto_ID) REFERENCES Producto(ID)
);
