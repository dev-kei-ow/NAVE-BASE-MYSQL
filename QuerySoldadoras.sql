CREATE DATABASE bdsoldadoras;
USE bdsoldadoras;

CREATE TABLE `trabajador` (

idTrabajador  int NOT NULL AUTO_INCREMENT,
nombre        varchar(20) NOT NULL,
apellido      varchar(20) NOT NULL,
edad          int NOT NULL,
correo        varchar(50) NOT NULL,
cargo         varchar(50) NOT NULL,
dni           int NOT NULL,
PRIMARY KEY (idTrabajador)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `usuario` (

idUsuario  int NOT NULL AUTO_INCREMENT,
nombre     varchar(20) NOT NULL,
apellido   varchar(20) NOT NULL,
correo     varchar(50) NOT NULL,
pass       varchar(250) NOT NULL,
direccion  varchar(50) NOT NULL,
empresa    varchar(50) NOT NULL,
tipo       varchar(50) NULL,
PRIMARY KEY (idUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `producto` (

idProducto   int NOT NULL AUTO_INCREMENT,
nombre       varchar(50) NOT NULL,
precio       double NOT NULL,
descripcion  varchar(500) NOT NULL,
imagen       varchar(255) NOT NULL,
cantidad     int NOT NULL,
idUsuario    int NOT NULL,
PRIMARY KEY (idProducto),
KEY `FK_Producto_Usuario` (idUsuario),
CONSTRAINT `FK_Producto_Usuario` FOREIGN KEY (idUsuario) REFERENCES `usuario` (idUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `orden` (

idOrden        int NOT NULL AUTO_INCREMENT,
numero         varchar(20) NOT NULL,
fechaCreacion  date NOT NULL,
fechaRecibida  date NOT NULL,
total          double NOT NULL,
idUsuario      int NOT NULL,
PRIMARY KEY (idOrden),
KEY `FK_Orden_Usuario` (idUsuario),
CONSTRAINT `FK_Orden_Usuario` FOREIGN KEY (idUsuario) REFERENCES `usuario` (idUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# 1-M and M-1 -> un producto esta asociado con muchas ordenes - una orden puede contener muchos productos
CREATE TABLE `detalle_orden` (

idDetalle    int NOT NULL AUTO_INCREMENT,
nombre       varchar(50) NOT NULL,
cantidad     int NOT NULL,
precio       double NOT NULL,
precioTotal  double NOT NULL,
idProducto   int NOT NULL,
idOrden      int NOT NULL,
PRIMARY KEY (idDetalle),
KEY `FK_DetalleOrden_Producto` (idProducto),
CONSTRAINT `FK_DetalleOrden_Producto` FOREIGN KEY (idProducto) REFERENCES `producto` (idProducto),
KEY `FK_DetalleOrden_Orden` (idOrden),
CONSTRAINT `FK_DetalleOrden_Orden` FOREIGN KEY (idOrden) REFERENCES `orden` (idOrden)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `pago` (

idPago      int NOT NULL AUTO_INCREMENT,
tipoPago    varchar(50) NOT NULL,
fecha       date NOT NULL,
igv         double NOT NULL,
montototal  double NOT NULL,
idDetalle   int NOT NULL,
PRIMARY KEY (idPago),
KEY `FK_Pago_Detalle` (idDetalle),
CONSTRAINT `FK_Pago_Detalle` FOREIGN KEY (idDetalle) REFERENCES `detalle_orden` (idDetalle)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `cita` (

idCita         int NOT NULL AUTO_INCREMENT,
tipoCita       varchar(50) NOT NULL,
fechaRecibida  date NOT NULL,
descripcion    varchar(500) NOT NULL,
idUsuario      int NOT NULL,
PRIMARY KEY (idCita),
KEY `FK_Citas_Usuario` (idUsuario),
CONSTRAINT `FK_Citas_Usuario` FOREIGN KEY (idUsuario) REFERENCES `usuario` (idUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `detallecita` (

fechaRecibida    date NOT NULL,
fechaProgramada  date NOT NULL,
descripcion      varchar(50) NOT NULL,
idCita           int NOT NULL,
KEY `FK_DetCitas_Citas` (idCita),
CONSTRAINT `FK_DetCitas_Citas` FOREIGN KEY (idCita) REFERENCES `cita` (idCita)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- INSERTS --------------------------------------------------------------------------------------------------------------------

INSERT INTO `usuario` VALUES (1,'Nelson','Jamanca Lovera','nel@gmail','$2a$10$w89N16hJtPVm93pv.tWBgu.EI30iXKmiBTy4US1hAn/P4pNUL8yjG','Av.Sol 1524 - La Campiña Chorrillos','MBS','ADMIN'); -- n123
INSERT INTO `usuario` VALUES (2,'Mary','Jane Watson','mary@gmail','$2a$10$Zvwr1IY42xb2rQkETrqEe.RH3fh/NOsQeyVefakYw/XgwsfvCJR6S','Av.Luna 1524 - Los Laureles La Molina','ANTESANA','CLIENTE'); -- m123
-- --------------------------------------------------------------------------------------------------------------------

INSERT INTO `producto` VALUES (1,'Soldadora de pedestal',2000,'Estas soldadoras por puntos son fácilmente adaptables para diferentes trabajos; satisfacen las exigencias en las diferentes aplicaciones de la pequeña y mediana empresa. Fabricadas bajo normas técnicas de seguridad para el funcionamiento preciso, teniendo una construcción sólida y rígida.','SoldadoraPedestal.jpg',2,1);
INSERT INTO `producto` VALUES (2,'Soldadora portátil tipo pinza',1550.9,'Estas soldadoras son portátiles monofásicas para uso de estrucutras metálicas y carrocerías. Soy muy versátiles por su fácil intercambio de Porta-Electrodos.','SoldadoraPinza.jpg',4,1);
INSERT INTO `producto` VALUES (4,'Controles',1600,'La función del control de soldadura es la de controlar los órganoos de la máquina de soldar, y particularmente los diodos controlados que afectuan la regulación de la corriente de soldadura.','Control.jpg',5,1);                         
INSERT INTO `producto` VALUES (3,'Soldadora para mallas electrosoldadas',550.9,'Esta soldadora sirve con el fin de fabricar paneles o rollos de malla para construcción o reja de acero y cerca metálica, en cualquier diámetro de varilla de acero trefilado.','SoldadoraMalla.png',3,1);
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

