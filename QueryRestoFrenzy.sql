CREATE DATABASE dbrestofrenzy;
USE dbrestofrenzy;
/*ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES;
*/
CREATE TABLE `cliente` (

idCliente  int NOT NULL AUTO_INCREMENT,
nombres    varchar(50) NOT NULL,
apellidos  varchar(50) NOT NULL,
correo     varchar(255) NOT NULL,
telefono   varchar(12) NOT NULL,
PRIMARY KEY (idCliente)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `categoria` (

idCategoria  int NOT NULL AUTO_INCREMENT,
nombre       varchar(50) NOT NULL,
descripcion  varchar(255) NOT NULL,
PRIMARY KEY (idCategoria)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `producto` (

idProducto   int NOT NULL AUTO_INCREMENT,
nombre       varchar(50) NOT NULL,
precio       numeric(18,0) NOT NULL,
descripcion  varchar(255) NOT NULL,
idCategoria  int NOT NULL,
PRIMARY KEY (idProducto),
KEY `FK_Producto_Categoria` (idCategoria),
CONSTRAINT `FK_Producto_Categoria` FOREIGN KEY (idCategoria) REFERENCES `categoria` (idCategoria)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `sucursal` (

idSucursal  int NOT NULL AUTO_INCREMENT,
nombre      varchar(50) NOT NULL,
ubicacion   varchar(50) NOT NULL,
telefono    varchar(50) NOT NULL,
PRIMARY KEY (idSucursal)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tipoempleo` (

idTipoEmpleado  int NOT NULL AUTO_INCREMENT,
empleo          varchar(50) NOT NULL,
PRIMARY KEY (idTipoEmpleado)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `cargo` (

idCargo  int NOT NULL AUTO_INCREMENT,
cargo    varchar(50) NOT NULL,
PRIMARY KEY (idCargo)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `empleado` (

idEmpleado      int NOT NULL AUTO_INCREMENT,
idAdmin         int NOT NULL,
nombres         varchar(50) NOT NULL,
apellidos       varchar(50) NOT NULL,
salario         varchar(50) NOT NULL,
nacimiento      varchar(50) NOT NULL,
direccion       varchar(50) NOT NULL,
telefono        varchar(50) NOT NULL,
correo          varchar(50) NOT NULL,
usuario         varchar(50) NOT NULL,
contraseña		varchar(50) NOT NULL,
idSucursal      int NOT NULL,
idCargo         int NOT NULL,
idTipoEmpleado  int NOT NULL,
PRIMARY KEY (idEmpleado),
KEY `FK_Empleado_Sucursal` (idSucursal),
KEY `FK_Empleado_Cargo` (idCargo),
KEY `FK_Empleado_TipoEmpleado` (idTipoEmpleado),
CONSTRAINT `FK_Empleado_Sucursal` FOREIGN KEY (idSucursal) REFERENCES `sucursal` (idSucursal),
CONSTRAINT `FK_Empleado_Cargo` FOREIGN KEY (idCargo) REFERENCES `cargo` (idCargo),
CONSTRAINT `FK_Empleado_TipoEmpleado` FOREIGN KEY (idTipoEmpleado) REFERENCES `tipoempleo` (idTipoEmpleado)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `registrojornada` (

horaEntrada  datetime NOT NULL,
horaSalida   datetime NOT NULL,
idEmpleado   int NOT NULL,
KEY `FK_RegistroJornada_Empleado` (idEmpleado),
CONSTRAINT `FK_RegistroJornada_Empleado` FOREIGN KEY (idEmpleado) REFERENCES `empleado` (idEmpleado)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `reservacion` (

idReserva  int NOT NULL AUTO_INCREMENT,
fechaHora  datetime NOT NULL,
idCliente  int NOT NULL,
PRIMARY KEY (idReserva),
KEY `FK_Reservacion_Cliente` (idCliente),
CONSTRAINT `FK_Reservacion_Cliente` FOREIGN KEY (idCliente) REFERENCES `cliente` (idCliente)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `mesa` (

idMesa      int NOT NULL AUTO_INCREMENT,
capacidad   int NOT NULL,
idSucursal  int NOT NULL,
PRIMARY KEY (idMesa),
KEY `FK_Mesa_Sucursal` (idSucursal),
CONSTRAINT `FK_Mesa_Sucursal` FOREIGN KEY (idSucursal) REFERENCES `sucursal` (idSucursal)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `pago` (

idPago      int NOT NULL AUTO_INCREMENT,
formaPago   varchar(50) NOT NULL,
PRIMARY KEY (idPago)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
select * from cargo;
CREATE TABLE `factura` (

idFactura   int NOT NULL AUTO_INCREMENT,
fecha       date NOT NULL,
monto       numeric(18,0) NOT NULL,
igv         numeric(18,0) NOT NULL,
totalPagar  numeric(18,0) NOT NULL,
efectivo    numeric(18,0) NOT NULL,
cambio      numeric(18,0) NOT NULL,
idCliente   int NOT NULL,
idPago      int NOT NULL,
PRIMARY KEY (idFactura),
KEY `FK_Factura_Cliente` (idCliente),
KEY `FK_Factura_Pago` (idPago),
CONSTRAINT `FK_Factura_Cliente` FOREIGN KEY (idCliente) REFERENCES `cliente` (idCliente),
CONSTRAINT `FK_Factura_Pago` FOREIGN KEY (idPago) REFERENCES `pago` (idPago)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `banco` (

idBanco  int NOT NULL AUTO_INCREMENT,
nombre   varchar(50) NOT NULL,
PRIMARY KEY (idBanco)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `pagotarjeta` (

idPagoTarjeta   int NOT NULL AUTO_INCREMENT,
moneda          varchar(50) NOT NULL,
numTransaccion  int NOT NULL,
idFactura       int NOT NULL,
idBanco         int NOT NULL,
PRIMARY KEY (idPagoTarjeta),
KEY `FK_PagoTarjeta_Factura` (idFactura),
KEY `FK_PagoTarjeta_Banco` (idBanco),
CONSTRAINT `FK_PagoTarjeta_Factura` FOREIGN KEY (idFactura) REFERENCES `factura` (idFactura),
CONSTRAINT `FK_PagoTarjeta_Banco` FOREIGN KEY (idBanco) REFERENCES `banco` (idBanco)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `mesa_reservacion` (

idMesa      int NOT NULL,
idReserva   int NOT NULL,
KEY `FK_Mesa_Reservacion` (idMesa),
KEY `FK_Reservacion_Mesa` (idReserva),
CONSTRAINT `FK_Mesa_Reservacion` FOREIGN KEY (idMesa) REFERENCES `mesa` (idMesa),
CONSTRAINT `FK_Reservacion_Mesa` FOREIGN KEY (idReserva) REFERENCES `reservacion` (idReserva)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `orden` (

idOrden     int NOT NULL,
idMesa      int NOT NULL,
idReserva   int NOT NULL,
idProducto  int NOT NULL,
KEY `FK_Orden_Mesa` (idMesa),
KEY `FK_Orden_Reserva` (idReserva),
KEY `FK_Orden_Producto` (idProducto),
CONSTRAINT `FK_Orden_Mesa` FOREIGN KEY (idMesa) REFERENCES `mesa` (idMesa),
CONSTRAINT `FK_Orden_Reserva` FOREIGN KEY (idReserva) REFERENCES `reservacion` (idReserva),
CONSTRAINT `FK_Orden_Producto` FOREIGN KEY (idProducto) REFERENCES `producto` (idProducto)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO cliente (nombres, apellidos, correo, telefono)
VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '123456789'),
('María', 'García', 'maria.garcia@email.com', '987654321'),
('Ana', 'González', 'ana.gonzalez@email.com', '123456789'),
('Pedro', 'Rodríguez', 'pedro.rodriguez@email.com', '987654321'),
('Lucía', 'Fernández', 'lucia.fernandez@email.com', '123456789'),
('Carlos', 'Gómez', 'carlos.gomez@email.com', '987654321'),
('Sofía', 'Martínez', 'sofia.martinez@email.com', '123456789'),
('Javier', 'Hernández', 'javier.hernandez@email.com', '987654321'),
('Isabel', 'López', 'isabel.lopez@email.com', '123456789'),
('Miguel', 'Álvarez', 'miguel.alvarez@email.com', '987654321'),
('Laura', 'Romero', 'laura.romero@email.com', '123456789'),
('Luis', 'Gutiérrez', 'luis.gutierrez@email.com', '567890123'),
('Elena', 'Díaz', 'elena.diaz@email.com', '678901234'),
('Andrés', 'Silva', 'andres.silva@email.com', '789012345'),
('Marta', 'Vargas', 'marta.vargas@email.com', '890123456'),
('Rosa', 'Martínez', 'rosa.martinez@email.com', '987654321'),
('Luis', 'González', 'luis.gonzalez@email.com', '123456789'),
('Fernanda', 'Hernández', 'fernanda.hernandez@email.com', '987654321'),
('Diego', 'Pérez', 'diego.perez@email.com', '123456789'),
('Carolina', 'Romero', 'carolina.romero@email.com', '987654321');



INSERT INTO categoria (nombre, descripcion)
VALUES
('Entradas', 'Platos pequeños para comenzar la comida'),
('Platos fuertes', 'Platos principales para satisfacer el apetito'),
('Postres', 'Deliciosos dulces para terminar la comida'),
('Bebidas', 'Refrescantes bebidas para acompañar la comida'),
('Especiales', 'Platos especiales del día o de la temporada');

INSERT INTO producto (nombre, precio, descripcion, idCategoria)
VALUES
('Ceviche', 25, 'Pescado blanco marinado en limón con cebolla y ají', 1),
('Lomo Saltado', 30, 'Tiras de carne salteadas con cebolla, tomate y ajíes', 2),
('Aji de Gallina', 20, 'Guiso de pollo en salsa picante', 2),
('Pollo a la Brasa', 15, 'Pollo asado al estilo peruano', 2),
('Causa Rellena', 10, 'Ensalada de papa con capas de relleno', 1),
('Rocoto Relleno', 12, 'Ají picante relleno con carne y queso', 1),
('Seco de Carne', 28, 'Guiso de carne con cilantro', 2),
('Tiradito de Pescado', 22, 'Sashimi al estilo peruano con salsa picante', 1),
('Anticuchos', 18, 'Brochetas de corazón de res a la parrilla', 1),
('Arroz con Mariscos', 32, 'Paella peruana con mariscos frescos', 2);

INSERT INTO sucursal (nombre, ubicacion, telefono)
VALUES
('Sucursal 1', 'Av. Larco 123, Miraflores', '01 1234567'),
('Sucursal 2', 'Av. Arequipa 456, Lince', '01 2345678'),
('Sucursal 3', 'Av. Brasil 789, Jesús María', '01 3456789'),
('Sucursal 4', 'Av. Javier Prado 012, San Isidro', '01 4567890'),
('Sucursal 5', 'Av. La Marina 345, San Miguel', '01 5678901');

INSERT INTO tipoempleo (empleo)
VALUES
('Front of House'),
('Back of House');

INSERT INTO cargo (cargo)
VALUES
('Gerente'),
('Cocinero'),
('Mesero'),
('Bartender'),
('Cajero'),
('Ayudante de cocina'),
('Jefe de meseros'),
('Recepcionista'),
('Sommelier');

INSERT INTO empleado (idAdmin, nombres, apellidos, salario, nacimiento, direccion, telefono, correo, usuario, contraseña, idSucursal, idCargo, idTipoEmpleado)
VALUES
  (1, 'Carlos', 'Rodríguez', '2200', '1992-11-02', 'Jr. Lima 789', '456789123', 'carlos@example.com', 'carlos123', 'contraseña3', 1, 2, 2),
  (1, 'Ana', 'López', '1900', '1995-03-10', 'Av. Amazonas 321', '789456123', 'ana@example.com', 'ana123', 'contraseña4', 1, 6, 2),
  (1, 'Luis', 'Ramírez', '2100', '1985-08-25', 'Av. Brasil 567', '159357852', 'luis@example.com', 'luis123', 'contraseña5', 1, 3, 1),
  (1, 'Laura', 'Torres', '1950', '1991-07-12', 'Calle 456', '753951852', 'laura@example.com', 'laura123', 'contraseña6', 1, 5, 2),
  (1, 'José', 'Sánchez', '1800', '1993-06-30', 'Jr. Arequipa 852', '456789123', 'jose@example.com', 'jose123', 'contraseña7', 1, 3, 1),
  (1, 'Patricia', 'Castro', '2000', '1994-04-17', 'Av. Brasil 123', '753951852', 'patricia@example.com', 'patricia123', 'contraseña8', 1, 7, 2),
  (1, 'Andrés', 'Pérez', '2100', '1992-09-03', 'Av. Larco 456', '456789123', 'andres@example.com', 'andres123', 'contraseña9', 1, 3, 1),
  (1, 'Paola', 'Gutiérrez', '1900', '1990-12-28', 'Jr. Lima 852', '753951852', 'paola@example.com', 'paola123', 'contraseña10', 1, 8, 2),
  (1, 'Daniel', 'Fernández', '1800', '1987-11-05', 'Av. Brasil 789', '456789123', 'daniel@example.com', 'daniel123', 'contraseña11', 1, 3, 1),
  (1, 'Carolina', 'Vargas', '1950', '1991-07-15', 'Calle 789', '753951852', 'carolina@example.com', 'carolina123', 'contraseña12', 1, 3, 2),
  (1, 'Miguel', 'Castro', '2200', '1988-04-30', 'Jr. Arequipa 852', '456789123', 'miguel@example.com', 'miguel123', 'contraseña13', 1, 2, 1),
  (1, 'Gabriela', 'Díaz', '2000', '1993-06-17', 'Av. Brasil 123', '753951852', 'gabriela@example.com', 'gabriela123', 'contraseña14', 1, 4, 2),
  (1, 'Marco', 'Paredes', '2100', '1992-09-22', 'Av. Larco 456', '456789123', 'marco@example.com', 'marco123', 'contraseña15', 1, 3, 1),
  (2, 'Nelson', 'Jamanca', '2100', '1992-09-22', 'Av. Larco 456', '456789123', 'nelson@example.com', 'nelson123', 'contraseña15', 1, 3, 1);

INSERT INTO registrojornada (horaEntrada, horaSalida, idEmpleado)
VALUES
('2023-08-01 08:00:00', '2023-08-01 16:00:00', 1),
('2023-08-01 09:30:00', '2023-08-01 17:30:00', 2),
('2023-08-01 10:00:00', '2023-08-01 18:00:00', 3),
('2023-08-01 08:30:00', '2023-08-01 16:30:00', 4),
('2023-08-01 09:00:00', '2023-08-01 17:00:00', 5),
('2023-08-01 08:00:00', '2023-08-01 16:00:00', 6),
('2023-08-01 09:30:00', '2023-08-01 17:30:00', 7),
('2023-08-01 10:00:00', '2023-08-01 18:00:00', 8),
('2023-08-01 08:30:00', '2023-08-01 16:30:00', 9),
('2023-08-01 09:00:00', '2023-08-01 17:00:00', 10),
('2023-08-01 08:00:00', '2023-08-01 16:00:00', 11),
('2023-08-01 09:30:00', '2023-08-01 17:30:00', 12),
('2023-08-01 10:00:00', '2023-08-01 18:00:00', 13);


INSERT INTO reservacion (fechaHora, idCliente)
VALUES
('2023-08-01 12:00:00', 1),
('2023-08-02 15:30:00', 2),
('2023-08-03 18:00:00', 3),
('2023-08-04 13:30:00', 4),
('2023-08-05 20:00:00', 5),
('2023-08-06 12:30:00', 6),
('2023-08-07 16:00:00', 7),
('2023-08-08 19:30:00', 8),
('2023-08-09 14:00:00', 9),
('2023-08-10 17:30:00', 10),
('2023-08-11 12:00:00', 11),
('2023-08-12 15:30:00', 12),
('2023-08-13 18:00:00', 13),
('2023-08-14 13:30:00', 14),
('2023-08-15 20:00:00', 15);

-- Registros para la sucursal 1
INSERT INTO mesa (capacidad, idSucursal)
VALUES
(4, 1),
(2, 1),
(6, 1),
(8, 1),
(2, 1),
-- Registros para la sucursal 2
(4, 2),
(6, 2),
(2, 2),
(8, 2),
(4, 2),
-- Registros para la sucursal 3
(2, 3),
(4, 3),
(6, 3),
(8, 3),
(2, 3),
-- Registros para la sucursal 4
(6, 4),
(2, 4),
(4, 4),
(8, 4),
(2, 4),
-- Registros para la sucursal 5
(8, 5),
(6, 5),
(2, 5),
(4, 5),
(2, 5);

INSERT INTO pago (formaPago)
VALUES
('Efectivo'),
('Tarjeta de crédito'),
('Tarjeta de débito'),
('Transferencia bancaria'),
('Pago móvil'),
('Cheque');


INSERT INTO factura (fecha, monto, igv, totalPagar, efectivo, cambio, idCliente, idPago)
VALUES
('2023-08-01', 100, 18, 118, 118, 0, 1, 1),
('2023-08-02', 200, 18, 236, 236, 0, 2, 1),
('2023-08-03', 300, 18, 354, 354, 0, 3, 1),
('2023-08-04', 400, 18, 472, 472, 0, 4, 1),
('2023-08-05', 500, 18, 590, 590, 0, 5, 1),
('2023-08-06', 600, 18, 708, 708, 0, 6, 1),
('2023-08-07', 700, 18, 826, 826, 0, 7, 1),
('2023-08-08', 800, 18, 944, 944, 0, 8, 1),
('2023-08-09', 900, 18, 1062, 1062, 0, 9, 1),
('2023-08-10', 1000, 18, 1180, 1180, 0, 10, 1),
('2023-08-11', 1100, 18, 1298, 1298, 0, 11, 1),
('2023-08-12', 1200, 18, 1404, 1404, 0, 12, 1),
('2023-08-13', 1300, 18, 1526, 1526, 0, 13, 1),
('2023-08-14', 1400, 18, 1648, 1648, 0, 14, 1),
('2023-08-15', 1500, 18, 1770, 1770, 0, 15, 1),
('2023-08-16', 200, 18, 236, 0, 0, 16, 2), 
('2023-08-17', 300, 18, 354, 0, 0, 17, 3),
('2023-08-18', 400, 18, 472, 0, 0, 18, 4),
('2023-08-19', 500, 18, 590, 0, 0, 19, 5),
('2023-08-20', 600, 18, 708, 0, 0, 20, 6);

INSERT INTO banco (nombre)
VALUES
('Banco de Crédito del Perú'),
('Interbank'),
('Scotiabank Perú'),
('BBVA Continental'),
('Banco Pichincha Perú'),
('Banco Ripley Perú'),
('Banco Financiero del Perú'),
('MiBanco'),
('Caja Arequipa'),
('Caja Huancayo'),
('Caja Metropolitana'),
('Banco GNB Perú'),
('Banco Azteca del Perú'),
('Banco Falabella Perú'),
('Caja Cusco');

INSERT INTO pagotarjeta (moneda, numTransaccion, idFactura, idBanco)
VALUES
('PEN', 123456, 1, 1),
('USD', 789012, 2, 2),
('PEN', 345678, 3, 3),
-- Registros para el cliente 2
('PEN', 111111, 4, 4),
('USD', 222222, 5, 5),
-- Registros para el cliente 3
('PEN', 333333, 6, 1),
('USD', 444444, 7, 2),
-- Registros para el cliente 4
('PEN', 555555, 8, 3),
-- Registros para el cliente 5
('USD', 666666, 9, 4);

INSERT INTO orden (idOrden, idMesa, idReserva, idProducto)
VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5),
(6, 1, 6, 6),
(7, 2, 7, 7),
(8, 3, 8, 8),
(9, 4, 9, 9),
(10, 5, 10, 10);

INSERT INTO mesa_reservacion (idMesa, idReserva)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

