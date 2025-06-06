-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos` (
  `Prod_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Prod_Descripcion` VARCHAR(60) NULL,
  `Prod_ColorId` SMALLINT(4) UNSIGNED NULL,
  `Prod_UnidadId` SMALLINT(2) UNSIGNED NULL,
  `Prod_Medida` DECIMAL(6,2) UNSIGNED NULL,
  `Prod_ProvId` INT UNSIGNED NULL,
  `Prod_CompraSusp` BIT(1) NULL,
  `Prod_VentaSusp` BIT(1) NULL,
  `Prod_Status` CHAR(1) NULL,
  PRIMARY KEY (`Prod_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sucursales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sucursales` (
  `Suc_Id` SMALLINT(3) UNSIGNED NOT NULL,
  `Suc_Nombre` VARCHAR(50) NULL,
  `Suc_Status` CHAR(1) NULL,
  PRIMARY KEY (`Suc_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Depositos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Depositos` (
  `Dep_Id` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Dep_SucId` SMALLINT(3) UNSIGNED NOT NULL,
  `Dep_Status` CHAR(1) NULL,
  `Dep_Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`Dep_Id`),
  INDEX `FK_Dep_Sucursales_idx` (`Dep_SucId` ASC),
  CONSTRAINT `FK_Dep_Sucursales`
    FOREIGN KEY (`Dep_SucId`)
    REFERENCES `mydb`.`Sucursales` (`Suc_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DepSecciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DepSecciones` (
  `DS_Id` MEDIUMINT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `DS_DepId` SMALLINT(4) UNSIGNED NULL,
  `DS_Nombre` VARCHAR(45) NULL,
  `DS_Status` CHAR(1) NULL,
  PRIMARY KEY (`DS_Id`),
  INDEX `FK_DS_Depositos_idx` (`DS_DepId` ASC),
  CONSTRAINT `FK_DS_Depositos`
    FOREIGN KEY (`DS_DepId`)
    REFERENCES `mydb`.`Depositos` (`Dep_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Racks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Racks` (
  `Rack_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Rack_DSId` MEDIUMINT(6) UNSIGNED NULL,
  `Rack_Nro` MEDIUMINT(4) UNSIGNED NULL,
  `Rack_Filas` TINYINT(2) UNSIGNED NULL,
  `Rack_Columnas` TINYINT(3) UNSIGNED NULL,
  PRIMARY KEY (`Rack_Id`),
  INDEX `FK_Racks_DS_idx` (`Rack_DSId` ASC),
  CONSTRAINT `FK_Racks_DS`
    FOREIGN KEY (`Rack_DSId`)
    REFERENCES `mydb`.`DepSecciones` (`DS_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StockDet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StockDet` (
  `STD_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `STD_ProdId` INT UNSIGNED NULL,
  `STD_RackId` INT UNSIGNED NULL,
  `STD_Fila` TINYINT(2) UNSIGNED NULL,
  `STD_Columna` TINYINT(3) UNSIGNED NULL,
  `STD_Stock` MEDIUMINT(5) NULL,
  `STD_UltMov` DATE NULL,
  `STD_UltInventario` DATE NULL,
  PRIMARY KEY (`STD_Id`),
  INDEX `FechaUltMov` (`STD_UltMov` ASC),
  INDEX `FechaUltInventario` (`STD_UltInventario` ASC),
  UNIQUE INDEX `ReckFilaColumna` (`STD_RackId` ASC, `STD_Fila` ASC, `STD_Columna` ASC),
  UNIQUE INDEX `ProdRackFilaColumna` (`STD_ProdId` ASC, `STD_RackId` ASC, `STD_Fila` ASC, `STD_Columna` ASC),
  CONSTRAINT `FK_STD_Productos`
    FOREIGN KEY (`STD_ProdId`)
    REFERENCES `mydb`.`Productos` (`Prod_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_STD_Racks`
    FOREIGN KEY (`STD_RackId`)
    REFERENCES `mydb`.`Racks` (`Rack_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mapa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mapa` (
  `Mapa_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Mapa_RackId` INT UNSIGNED NULL,
  `Mapa_Fila` SMALLINT(2) UNSIGNED NULL,
  `Mapa_Columna` SMALLINT(3) UNSIGNED NULL,
  `Mapa_ProdId` INT UNSIGNED NULL,
  `Mapa_Cantidad` MEDIUMINT(5) UNSIGNED NULL,
  PRIMARY KEY (`Mapa_Id`),
  INDEX `FK_Mapa_Racks_idx` (`Mapa_RackId` ASC),
  CONSTRAINT `FK_Mapa_Racks`
    FOREIGN KEY (`Mapa_RackId`)
    REFERENCES `mydb`.`Racks` (`Rack_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StockMae`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StockMae` (
  `STM_ProdId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `STM_Stock` INT NULL,
  `STM_Status` CHAR(1) NULL,
  `STM_UltMov` DATE NULL,
  `STM_UltInventario` DATE NULL,
  PRIMARY KEY (`STM_ProdId`),
  INDEX `FechaUltMov` (`STM_UltMov` ASC),
  INDEX `FechaultInventario` (`STM_UltInventario` ASC),
  CONSTRAINT `FK_STM_Productos`
    FOREIGN KEY (`STM_ProdId`)
    REFERENCES `mydb`.`Productos` (`Prod_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StockHist2019`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StockHist2019` (
  `SH_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SH_Mes` TINYINT(2) UNSIGNED NULL,
  `SH_ProdId` INT UNSIGNED NULL,
  `SH_DepId` SMALLINT(4) UNSIGNED NULL,
  `SH_Stock` INT NULL,
  `SH_Costo` DECIMAL(10,2) UNSIGNED NULL,
  PRIMARY KEY (`SH_Id`),
  INDEX `Mes` (`SH_Mes` ASC),
  INDEX `FK_SH_Productos_idx` (`SH_ProdId` ASC),
  INDEX `FK_SH_Depositos_idx` (`SH_DepId` ASC),
  CONSTRAINT `FK_SH_Productos`
    FOREIGN KEY (`SH_ProdId`)
    REFERENCES `mydb`.`Productos` (`Prod_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SH_Depositos`
    FOREIGN KEY (`SH_DepId`)
    REFERENCES `mydb`.`Depositos` (`Dep_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StockMovDet2019_08`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StockMovDet2019_08` (
  `SMD_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SMD_Fecha` DATETIME NULL,
  `SMD_Mov` CHAR(1) NULL,
  `SMD_ProdId` INT UNSIGNED NULL,
  `SMD_RackId` INT UNSIGNED NULL,
  `SMD_Cant` MEDIUMINT(5) NULL,
  PRIMARY KEY (`SMD_Id`),
  INDEX `Fecha` (`SMD_Fecha` ASC),
  INDEX `FK_SMD_Racks_idx` (`SMD_RackId` ASC),
  INDEX `FK_SMD_Productos_idx` (`SMD_ProdId` ASC),
  CONSTRAINT `FK_SMD_Racks`
    FOREIGN KEY (`SMD_RackId`)
    REFERENCES `mydb`.`Racks` (`Rack_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SMD_Productos`
    FOREIGN KEY (`SMD_ProdId`)
    REFERENCES `mydb`.`Productos` (`Prod_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
