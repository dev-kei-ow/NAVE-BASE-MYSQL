CREATE DATABASE bdsoldadoras;
USE bdsoldadoras;

CREATE TABLE `trabajadores` (

idTrabajador  INT not null AUTO_INCREMENT,
nombre        VARCHAR(20) not null,
apellido      VARCHAR(20) not null,
edad          INT not null,
correo        VARCHAR(50) not null,
cargo         VARCHAR(50) not null,
dni           INT not null,
PRIMARY KEY (idTrabajador)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usuarios` (

idUsuario  INT not null AUTO_INCREMENT,
nombre     VARCHAR(20) not null,
apellido   VARCHAR(20) not null,
correo     VARCHAR(50) not null,
pass       VARCHAR(250) not null,
direccion  VARCHAR(50) not null,
empresa    VARCHAR(50) not null,
tipo       VARCHAR(50) null,
PRIMARY KEY (idUsuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productos` (

idProducto   INT not null AUTO_INCREMENT,
nombre       VARCHAR(50) not null,
precio       DOUBLE not null,
descripcion  VARCHAR(500) not null,
imagen       VARCHAR(255) not null,
cantidad     INT not null,
idUsuario    INT not null,
PRIMARY KEY (idProducto),
KEY `FK_Productos_Usuarios` (idUsuario),
CONSTRAINT `FK_Productos_Usuarios` FOREIGN KEY (idUsuario) REFERENCES `usuarios` (idUsuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `ordenes` (

idOrden        INT not null AUTO_INCREMENT,
numero         VARCHAR(20) not null,
fechaCreacion  DATE not null,
fechaRecibida  DATE not null,
total          DOUBLE not null,
idUsuario      INT not null,
PRIMARY KEY (idOrden),
KEY `FK_Ordenes_Usuario` (idUsuario),
CONSTRAINT `FK_Ordenes_Usuario` FOREIGN KEY (idUsuario) REFERENCES `usuarios` (idUsuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `detalleordenes` (

idDetalle    INT not null AUTO_INCREMENT,
nombre       VARCHAR(50) not null,
cantidad     INT not null,
precio       DOUBLE not null,
precioTotal  DOUBLE not null,
idProducto   INT not null,
idOrden      INT not null,
PRIMARY KEY (idDetalle),
KEY `FK_DetalleOrden_Productos` (idProducto),
CONSTRAINT `FK_DetalleOrden_Productos` FOREIGN KEY (idProducto) REFERENCES `productos` (idProducto),
KEY `FK_DetalleOrden_Ordenes` (idOrden),
CONSTRAINT `FK_DetalleOrden_Ordenes` FOREIGN KEY (idOrden) REFERENCES `ordenes` (idOrden)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `pagos` (

idPago      INT not null AUTO_INCREMENT,
tipoPago    VARCHAR(50) not null,
fecha       DATE not null,
igv         DOUBLE not null,
montototal  DOUBLE not null,
idDetalle   INT not null,
PRIMARY KEY (idPago),
KEY `FK_Pagos_Detalles` (idDetalle),
CONSTRAINT `FK_Pagos_Detalles` FOREIGN KEY (idDetalle) REFERENCES `detalleordenes` (idDetalle)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `citas` (

idCita         INT not null AUTO_INCREMENT,
tipoCita       VARCHAR(50) not null,
fechaRecibida  DATE not null,
descripcion    VARCHAR(500) not null,
idUsuario      INT not null,
PRIMARY KEY (idCita),
KEY `FK_Citas_Usuario` (idUsuario),
CONSTRAINT `FK_Citas_Usuario` FOREIGN KEY (idUsuario) REFERENCES `usuarios` (idUsuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `detallecitas` (

fechaRecibida    DATE not null,
fechaProgramada  DATE not null,
descripcion      VARCHAR(50) not null,
idCita           INT not null,
KEY `FK_DetCitas_Citas` (idCita),
CONSTRAINT `FK_DetCitas_Citas` FOREIGN KEY (idCita) REFERENCES `citas` (idCita)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- INSERTS --------------------------------------------------------------------------------------------------------------------

INSERT INTO `usuarios` VALUES (1,'Nelson','Jamanca Lovera','nel@gmail','$2a$10$w89N16hJtPVm93pv.tWBgu.EI30iXKmiBTy4US1hAn/P4pNUL8yjG','Av.Sol 1524 - La Campiña Chorrillos','MBS','ADMIN'); -- n123
INSERT INTO `usuarios` VALUES (2,'Mary','Jane Watson','mary@gmail','$2a$10$Zvwr1IY42xb2rQkETrqEe.RH3fh/NOsQeyVefakYw/XgwsfvCJR6S','Av.Luna 1524 - Los Laureles La Molina','ANTESANA','CLIENTE'); -- m123
-- --------------------------------------------------------------------------------------------------------------------

INSERT INTO `productos` VALUES (1,'Soldadora de pedestal',2000,'Estas soldadoras por puntos son fácilmente adaptables para diferentes trabajos; satisfacen las exigencias en las diferentes aplicaciones de la pequeña y mediana empresa. Fabricadas bajo normas técnicas de seguridad para el funcionamiento preciso, teniendo una construcción sólida y rígida.','SoldadoraPedestal.jpg',2,1);
INSERT INTO `productos` VALUES (2,'Soldadora portátil tipo pinza',1550.9,'Estas soldadoras son portátiles monofásicas para uso de estrucutras metálicas y carrocerías. Soy muy versátiles por su fácil intercambio de Porta-Electrodos.','SoldadoraPinza.jpg',4,1);
INSERT INTO `productos` VALUES (4,'Controles',1600,'La función del control de soldadura es la de controlar los órganoos de la máquina de soldar, y particularmente los diodos controlados que afectuan la regulación de la corriente de soldadura.','Control.jpg',5,1);                         
INSERT INTO `productos` VALUES (3,'Soldadora para mallas electrosoldadas',550.9,'Esta soldadora sirve con el fin de fabricar paneles o rollos de malla para construcción o reja de acero y cerca metálica, en cualquier diámetro de varilla de acero trefilado.','SoldadoraMalla.png',3,1);
-- --------------------------------------------------------------------------------------------------------------------

#INSERT INTO `clientes` VALUES (1,'Ruben','Blanco Ruiz','rubenruiz@gmail.com','ruben123','Av.Sol 1524 - La Campiña Chorrillos','SOLDADORAS RUBEN',1);
#INSERT INTO `clientes` VALUES (2,'Jorge','Rodriguez Sanches','Antezana@gmail.com','jorgerod123','Av. Pase la República 291 - Cercado de Lima','ANTEZANA',3);   
#INSERT INTO `clientes` VALUES (3,'d','Rodriguez eqw','qwe@gmail.com','rodir','Av. Pase la República 291 - Cercado de Lima','ANTEZANA',3);   
-- --------------------------------------------------------------------------------------------------------------------

INSERT INTO `citas` VALUES (1,'Mantenimiento','2022-11-23','Solicito una cita para el mantenimiento de 4 maquinas',1);
INSERT INTO `citas` VALUES (2,'Reparacion','2022-10-02','Solcito una cita para la reparacion de 3 controladoras',2);
-- --------------------------------------------------------------------------------------------------------------------

INSERT INTO `trabajadores` VALUES(1,'Luis','Gomez Sanchez','40','lusgomez@gmail.com','Tecnico Electronico','71192432');
INSERT INTO `trabajadores` VALUES(2,'Miguel','Heredia Guerrero','30','herediamiguel123@gmail.com','Operario','71952426');
INSERT INTO `trabajadores` VALUES(3,'Alberto','Curaca Romero','25','raul123@gmail.com','Operario','76782462');

#select * from usuarios;
#select * from ordenes;
#select * from detalleordenes;

