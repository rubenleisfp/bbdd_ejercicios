-- Actores
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Marlon Brando','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Al Pacino','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Robert De Niro','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('John Travolta','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Samuel L. Jackson','USA','H');
INSERT INTO `bbdd_videoclub`.`actores` (`Nombre`,`Nacionalidad`,`Sexo`) VALUES ('Uma Thurman','USA','M');

-- Director
INSERT INTO `bbdd_videoclub`.`director` (`Nombre`, `Nacionalidad`) VALUES ('Francis Ford Coppola','USA');
INSERT INTO `bbdd_videoclub`.`director` (`Nombre`, `Nacionalidad`) VALUES ('Martin Scorsese','USA');
INSERT INTO `bbdd_videoclub`.`director` (`Nombre`, `Nacionalidad`) VALUES ('Quentin Tarantino','USA');

-- Pelicula
INSERT INTO `bbdd_videoclub`.`pelicula` (`ID`,`Titulo`,`Productora`,`Nacionalidad`,`Fecha`,`Director`) VALUES (1,'El Padrino','Paramount', 'USA','1972','Francis Ford Coppola');
INSERT INTO `bbdd_videoclub`.`pelicula` (`ID`,`Titulo`,`Productora`,`Nacionalidad`,`Fecha`,`Director`) VALUES (2,'Uno de los nuestros','Warner', 'USA','1990','Martin Scorsese');
INSERT INTO `bbdd_videoclub`.`pelicula` (`ID`,`Titulo`,`Productora`,`Nacionalidad`,`Fecha`,`Director`) VALUES (3,'Pulp Fiction','Miramax', 'USA','1994','Quentin Tarantino');

-- Actua
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Marlon Brando',1,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Al Pacino',1,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Al Pacino',2,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Robert De Niro',2,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('John Travolta',3,1);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Samuel L. Jackson',3,0);
INSERT INTO `bbdd_videoclub`.`actua` (`Actor`, `ID_Peli`, `Prota`) VALUES('Uma Thurman',3,1);

-- Ejemplares
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (1,1, 'Nuevo');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (1,2, 'Segunda mano');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (2,1, 'Nuevo');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (2,2, 'Segunda mano');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (3,1, 'Nuevo');
INSERT INTO `bbdd_videoclub`.`ejemplar` (`ID_Peli`,`Numero`,`Estado`) VALUES (3,2, 'Segunda mano');

-- Socio
INSERT INTO `bbdd_videoclub`.`socio` (`DNI`,`Nombre`,`Direccion`,`Telefono`,`Avalador`) VALUES('34895298U', 'Raul Sanchez Gomez', 'Calle Rosal 32, A Coruña 15007', '615054879',null);
INSERT INTO `bbdd_videoclub`.`socio` (`DNI`,`Nombre`,`Direccion`,`Telefono`,`Avalador`) VALUES('45214786T', 'Sandra Pérez Fernández', 'Calle Rosal 34, A Coruña 15007', '632547979',null);

-- Alquila
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('34895298U',3,2,'2023-05-04',null);
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('34895298U',2,1,'2023-05-05',null);
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('45214786T',1,1,'2023-05-03','2023-05-04');
INSERT INTO `bbdd_videoclub`.`alquila` (`DNI`,`ID_Peli`,`Numero`,`FechaAlquiler`,`FechaDevolucion`) VALUES
('45214786T',2,2,'2023-05-04','2023-05-05');