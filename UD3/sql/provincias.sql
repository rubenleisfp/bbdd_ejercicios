/*
-- Query: SELECT * FROM bbdd_empleados_regiones.provincia
-- Date: 2024-03-12 12:31
*/
INSERT INTO `PROVINCIA` (`CodProvincia`,`Nombre`,`CodRegion`) VALUES (15,'A Coruña',12);
INSERT INTO `PROVINCIA` (`CodProvincia`,`Nombre`,`CodRegion`) VALUES (27,'Lugo',12);

INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (9,'Betanzos',15);
INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (19,'Carballo',15);
INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (31,'Monforte',27);
INSERT INTO `LOCALIDAD` (`CodLocalidad`,`Nombre`,`CodProvincia`) VALUES (902,'Burela',27);