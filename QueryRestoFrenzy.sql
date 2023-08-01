CREATE DATABASE dbrestrofrenzy;
USE dbrestrofrenzy;

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

CREATE TABLE `factura` (

idFactura   int NOT NULL AUTO_INCREMENT,
fecha       date NOT NULL,
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

CREATE TABLE `mesa_reservacion` (

idMesa      int NOT NULL,
idReserva   int NOT NULL,
KEY `FK_Mesa_Reservacion` (idMesa),
KEY `FK_Reservacion_Mesa` (idReserva),
CONSTRAINT `FK_Mesa_Reservacion` FOREIGN KEY (idMesa) REFERENCES `mesa` (idMesa),
CONSTRAINT `FK_Reservacion_Mesa` FOREIGN KEY (idReserva) REFERENCES `reservacion` (idReserva)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


