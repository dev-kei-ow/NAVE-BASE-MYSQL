-- -----------------------------------------------------
-- Schema carteleradb
-- -----------------------------------------------------
CREATE DATABASE `bdcartelera`;
USE `bdcartelera`;

-- -----------------------------------------------------
-- Table `BdCarteleraWeb`.`Cines`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `cines` ;

CREATE TABLE `cines` (

 idCine       int PRIMARY KEY AUTO_INCREMENT,
 razonSocial  varchar(100) NOT NULL,
 nombre       varchar(20) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------
-- Table `BdCarteleraWeb`.`Peliculas`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `peliculas` ;

CREATE TABLE `peliculas` (

 idPelicula     int PRIMARY KEY AUTO_INCREMENT,
 titulo         varchar(45) NOT NULL,
 duracion       varchar(10) NULL,
 clasificacion  varchar(20) NULL,
 idioma         varchar(20) NULL,
 trailerId      varchar(30) NOT NULL,
 formato        varchar(3) NULL,
 sinopsis       varchar(200) NULL,
 rutaPortada         varchar(255) NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `generos` (

 idGenero  int PRIMARY KEY AUTO_INCREMENT,
 nombre    varchar(45) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
  

CREATE TABLE `generos_peliculas` (

 idPelicula  int NOT NULL,
 idGenero    int NOT NULL,
 CONSTRAINT FK_Pelicula_Generos FOREIGN KEY (idPelicula) REFERENCES `peliculas` (idPelicula),
 CONSTRAINT FK_Genero_Peliculas FOREIGN KEY (idGenero) REFERENCES `generos` (idGenero)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


  -- -----------------------------------------------------
-- Table `BdCarteleraWeb`.`Categorias`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `categorias` ;

CREATE TABLE `categorias` (

 idCategoria  int PRIMARY KEY AUTO_INCREMENT,
 codigo        varchar(45) NOT NULL,
 descripcion   varchar(45) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------
-- Table `BdCarteleraWeb`.`Sedes`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `sedes` ;

CREATE TABLE `sedes` (

 idSede       int PRIMARY KEY AUTO_INCREMENT,
 nombre       varchar(45) NOT NULL,
 direccion    varchar(45) NOT NULL,
 idCategoria  int NOT NULL,
 idCine       int NOT NULL,
 CONSTRAINT FK_Sedes_Categorias FOREIGN KEY (idCategoria) REFERENCES `categorias` (idCategoria),
 CONSTRAINT FK_Sedes_Cines FOREIGN KEY (idCine) REFERENCES `cines` (idCine)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------
-- Table `BdCarteleraWeb`.`Salas`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `salas` ;

CREATE TABLE `salas` (

 idSala     int PRIMARY KEY AUTO_INCREMENT,
 nombre     varchar(10) NOT NULL,
 capacidad  int NULL,
 idSede     int NOT NULL,
 CONSTRAINT FK_Salas_Sedes FOREIGN KEY (idSede) REFERENCES `sedes` (idSede)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------
-- Table `BdCarteleraWeb`.`Funciones`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `funciones` ;

CREATE TABLE `funciones` (
 
 idFuncion   int PRIMARY KEY AUTO_INCREMENT,
 horaInicio  varchar(20) NOT NULL,
 horaFin     varchar(20) NOT NULL,
 precio      varchar(20) NOT NULL,
 idSala      int NOT NULL,
 idPelicula  int NOT NULL,
 CONSTRAINT FK_Funciones_Salas FOREIGN KEY (idSala) REFERENCES `salas` (idSala),
 CONSTRAINT FK_Funciones_Peliculas FOREIGN KEY (idPelicula) REFERENCES `peliculas` (idPelicula)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `categorias`
(`id_categoria`,
`codigo`,
`descripcion`)
VALUES
(1,
"01",
"PREMIUM");


INSERT INTO `categorias`
(`id_categoria`,
`codigo`,
`descripcion`)
VALUES
(2,
"02",
"REGULAR");

INSERT INTO `cines`
(`id_cine`,
`razonSocial`,
`nombre`)
VALUES
(1,
"UVK Multicines SA",
"UVK");

INSERT INTO `cines`
(`id_cine`,
`razonSocial`,
`nombre`)
VALUES
(2,
"Cineplex SA",
"CINEPLANET");

INSERT INTO `cines`
(`id_cine`,
`razonSocial`,
`nombre`)
VALUES
(3,
"Cinemark del Peru SA",
"UVK");

/* :::PELICULA INSERTS::: ACCION */
INSERT INTO `peliculas`
(`idPelicula`,
`titulo`,
`duracion`,
`clasificacion`,
`idioma`,
`trailerId`,
`formato`,
`sinopsis`,
`rutaPortada`)
VALUES
(1,
"Aquaman",
"2h 30min",
"APT",
"Ingles",
"WDkg3h8PCVU&t=1s&ab_channel=WarnerBros.Pictures",
"2D",
"Arthur Curry se entera de que es el heredero del reino submarino de la Atlántida. Así se convertirá en Aquaman.",
"Aquaman.jpg");

/* :::PELICULA INSERTS::: ACCION */
INSERT INTO `peliculas`
(`idPelicula`,
`titulo`,
`duracion`,
`clasificacion`,
`idioma`,
`trailerId`,
`formato`,
`sinopsis`,
`rutaPortada`)
VALUES
(2,
"Terremoto 8.0",
"1h 50min",
"+14",
"Ingles",
"QPwEwaYNEgQ&ab_channel=MundoCine_CAM",
"2D",
"En el año 1904 un terremoto de magnitud 5.4 en la escala de Richter sacudió a Oslo con el epicentro en la Fosa de Oslo que corre debajo de la capital noruega",
"Terremoto 8.0.jpg");

/* :::PELICULA INSERTS::: ANIMACION */
INSERT INTO `peliculas`
(`idPelicula`,
`titulo`,
`duracion`,
`clasificacion`,
`idioma`,
`trailerId`,
`formato`,
`sinopsis`,
`rutaPortada`)
VALUES
(3,
"Dragon Ball Super: Broly",
"1h 50min",
"APT",
"Latino",
"wTG-9paCo88&ab_channel=FandangoLatam",
"2D",
"La Tierra disfruta en paz la celebración de el Torneo del Poder. Sin embargo, Goku es consciente de que existen enemigos aún por descubrir en el Universo.",
"Dragon Ball Super Broly.jpg");

/* :::PELICULA INSERTS::: CIENCIA FICCION */
INSERT INTO `peliculas`
(`idPelicula`,
`titulo`,
`duracion`,
`clasificacion`,
`idioma`,
`trailerId`,
`formato`,
`sinopsis`,
`rutaPortada`)
VALUES
(4,
"Bumblebee",
"2h",
"APT",
"ingles",
"lcwmDAYt22k&ab_channel=ParamountPictures",
"3D",
"Sexta entrega de la saga 'Transformers', esta vez centrada en el hermano pequeño de los Autobots, Bumblebee",
"Transformes BumBleBee.jpg");

/* :::PELICULA INSERTS::: ACCION, AVENTURA */
INSERT INTO `peliculas`
(`idPelicula`,
`titulo`,
`duracion`,
`clasificacion`,
`idioma`,
`trailerId`,
`formato`,
`sinopsis`,
`rutaPortada`)
VALUES
(5,
"Spider Man No Way Home",
"2h 28min",
"PG13",
"Ingles",
"r6t0czGbuGI&ab_channel=SonyPicturesArgentina",
"3D",
"Tras descubrirse la identidad secreta de Peter Parker como Spider-Man,Peter le pide ayuda al Doctor Strange para recuperar su vida, pero algo sale mal y provoca una fractura en el multiverso",
"Spider Man No Way Home.jpg");

/* :::PELICULA INSERTS::: CIENCIA FICCION */
INSERT INTO `peliculas`
(`idPelicula`,
`titulo`,
`duracion`,
`clasificacion`,
`idioma`,
`trailerId`,
`formato`,
`sinopsis`,
`rutaPortada`)
VALUES
(6,
"Venom",
"1h 52min",
"PG-R",
"Español España",
"mYTmQWZkw10&ab_channel=SonyPicturesEspaña",
"3D",
"Eddie Brock establece una simbiosis con un ente alienígena que le ofrece superpoderes, pero el ser se apodera de su personalidad y lo vuelve perverso",
"Venom.jpg");

/* :::GENEROS INSERTS::: */

INSERT INTO `generos`
(`nombre`)
VALUES
('Accion');
INSERT INTO `generos`
(`nombre`)
VALUES
('Animacion');
INSERT INTO `generos`
(`nombre`)
VALUES
('Ciencia Ficcion');
INSERT INTO `generos`
(`nombre`)
VALUES
('Aventura');


-- INSERT'S SEDES --
INSERT INTO `sedes`
(`id_sede`,
`nombre`,
`direccion`,
`id_categoria`,
`id_cine`)
VALUES
(1,
"UVK BASADRE",
"Calle las Palmeras 208,San Isidro",
1,
1);

INSERT INTO `sedes`
(`id_sede`,
`nombre`,
`direccion`,
`id_categoria`,
`id_cine`)
VALUES
(2,
"UVK CENTRO DE LIMA",
"Plaza San Martin,Jr de La Union,Lima",
2,
1);

INSERT INTO `sedes`
(`id_sede`,
`nombre`,
`direccion`,
`id_categoria`,
`id_cine`)
VALUES
(3,
"Cineplanet La Rambla",
"Centro Comercial la Rambla,San Borja",
1,
2);

INSERT INTO `sedes`
(`id_sede`,
`nombre`,
`direccion`,
`id_categoria`,
`id_cine`)
VALUES
(4,
"Cineplanet Alcazar",
"Santa Cruz 288,Miraflores",
2,
2);

INSERT INTO `sedes`
(`id_sede`,
`nombre`,
`direccion`,
`id_categoria`,
`id_cine`)
VALUES
(5,
"Cinemark San Miguel",
"Av La Marina 1123,San Miguel",
2,
3);


INSERT INTO `salas`
(`id_sala`,
`nombre`,
`capacidad`,
`id_sede`)
VALUES
(1,
"Sala 9",
80,
1);

INSERT INTO `salas`
(`id_sala`,
`nombre`,
`capacidad`,
`id_sede`)
VALUES
(2,
"Sala 8",
70,
1);

INSERT INTO `salas`
(`id_sala`,
`nombre`,
`capacidad`,
`id_sede`)
VALUES
(3,
"Sala A",
70,
2);

INSERT INTO `salas`
(`id_sala`,
`nombre`,
`capacidad`,
`id_sede`)
VALUES
(4,
"Sala C",
70,
3);


INSERT INTO `salas`
(`id_sala`,
`nombre`,
`capacidad`,
`id_sede`)
VALUES
(5,
"Sala Gold",
65,
4);

INSERT INTO `salas`
(`id_sala`,
`nombre`,
`capacidad`,
`id_sede`)
VALUES
(6,
"Sala Main",
65,
5);

INSERT INTO  `funciones`
(`id_funcion`,
`horaInicio`,
`horaFin`,
`precio`,
`id_sala`,
`id_pelicula`)
VALUES
(1,
"03:00 PM",
"05:00 PM",
"S/.35",
1,
1);

INSERT INTO `funciones`
(`id_funcion`,
`horaInicio`,
`horaFin`,
`precio`,
`id_sala`,
`id_pelicula`)
VALUES
(2,
"06:00 PM",
"07:45 PM",
"S/35",
1,
2);

INSERT INTO `funciones`
(`id_funcion`,
`horaInicio`,
`horaFin`,
`precio`,
`id_sala`,
`id_pelicula`)
VALUES
(3,
"08:00 PM",
"10:00 PM",
"S/35",
1,
3);

INSERT INTO `funciones`
(`id_funcion`,
`horaInicio`,
`horaFin`,
`precio`,
`id_sala`,
`id_pelicula`)
VALUES
(4,
"11:00 PM",
"01:00 AM",
"S/35",
1,
4);





