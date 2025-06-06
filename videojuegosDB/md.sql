CREATE SCHEMA `videojuegosdb` ;
--------------------------------------

CREATE TABLE `videojuegosdb`.`juegos` (
  `juegoID` INT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NULL,
  `AñoLanzamiento` INT NULL,
  `DesarrolladorID` VARCHAR(45) NULL,
  `PlataformaID` VARCHAR(45) NULL,
  PRIMARY KEY (`juegoID`));
----------------------------------------

CREATE TABLE `videojuegosdb`.`desarrolladores` (
  `DesarrolladorID` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Pais` VARCHAR(45) NULL,
  PRIMARY KEY (`DesarrolladorID`));
  ------------------------------------------

 CREATE TABLE `videojuegosdb`.`plataformas` (
 `plataformaID` INT NOT NULL AUTO_INCREMENT,
 `Nombre` VARCHAR(45) NULL,
 `Tipo` VARCHAR(45) NULL,
 PRIMARY KEY (`plataformaID`));

--------------------------------------------------

ALTER TABLE `videojuegosdb`.`juegos` 
CHANGE COLUMN `DesarrolladorID` `DesarrolladorID` INT NULL DEFAULT NULL ,
CHANGE COLUMN `PlataformaID` `PlataformaID` INT NULL DEFAULT NULL ;

--------------------------------------------------

ALTER TABLE `videojuegosdb`.`juegos` 
ADD INDEX `plataformaid_idx` (`PlataformaID`);
;
ALTER TABLE `videojuegosdb`.`juegos` 
ADD CONSTRAINT `plataformaid`
  FOREIGN KEY (`PlataformaID`)
  REFERENCES `videojuegosdb`.`plataformas` (`PlataformaID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  -------------------------------------------------------

ALTER TABLE `videojuegosdb`.`juegos` 
ADD INDEX `desarrolladorid_idx` (`DesarrolladorID`);
;
ALTER TABLE `videojuegosdb`.`juegos` 
ADD CONSTRAINT `desarrolladorid`
  FOREIGN KEY (`DesarrolladorID`)
  REFERENCES `videojuegosdb`.`desarrolladores` (`DesarrolladorID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
---------------------------------------------------------

-- Insertar datos en la tabla Desarrolladores
INSERT INTO Desarrolladores (Nombre, Pais) VALUES 
('Naughty Dog', 'Estados Unidos'),
('Nintendo', 'Japón'),
('CD Projekt Red', 'Polonia');

-- Insertar datos en la tabla Plataformas
INSERT INTO Plataformas (Nombre, Tipo) VALUES 
('PlayStation 4', 'Consola'),
('Nintendo Switch', 'Consola'),
('PC', 'Computadora');

-- Insertar datos en la tabla Juegos
INSERT INTO Juegos (Titulo, AñoLanzamiento, DesarrolladorID, PlataformaID) VALUES 
('The Last of Us Part II', 2020, 1, 1),  -- Desarrollado por Naughty Dog para PlayStation 4
('The Legend of Zelda: Breath of the Wild', 2017, 2, 2),  -- Desarrollado por Nintendo para Nintendo Switch
('Cyberpunk 2077', 2020, 3, 3);  -- Desarrollado por CD Projekt Red para PC
