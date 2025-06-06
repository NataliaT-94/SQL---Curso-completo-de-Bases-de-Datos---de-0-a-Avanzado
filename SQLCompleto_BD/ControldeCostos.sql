-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ControldeCostos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ControldeCostos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ControldeCostos` DEFAULT CHARACTER SET utf8 ;
USE `ControldeCostos` ;

-- -----------------------------------------------------
-- Table `ControldeCostos`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeCostos`.`Productos` (
  `Prod_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Prod_Descripcion` VARCHAR(80) NULL,
  `Prod_ColorId` SMALLINT(4) UNSIGNED NULL,
  `Prod_UnidadId` SMALLINT(2) UNSIGNED NULL,
  `Prod_Medida` DECIMAL(6,2) NULL,
  `Prod_ProvId` INT UNSIGNED NULL,
  `Prod_CompraSusp` BIT(1) NULL,
  `Prod_VentaSusp` BIT(1) NULL,
  `Prod_Status` CHAR(1) NULL,
  PRIMARY KEY (`Prod_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeCostos`.`Listas_CostosPrecios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeCostos`.`Listas_CostosPrecios` (
  `LCP_Id` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LCP_Nombre` VARCHAR(45) NULL,
  `LCP_CP` ENUM('C', 'P') NULL,
  `LCP_Status` CHAR(1) NULL,
  `LCP_FechaDesde` DATE NULL,
  `LCP_FechaHasta` DATE NULL,
  PRIMARY KEY (`LCP_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeCostos`.`Costos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeCostos`.`Costos` (
  `Costo_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Costo_LCPId` SMALLINT(4) UNSIGNED NULL,
  `Costo_ProdId` INT UNSIGNED NULL,
  `Costo_PrecioLista` DECIMAL(10,4) UNSIGNED NULL,
  `Costo_Cotizacion` DECIMAL(10,4) NULL DEFAULT 1,
  `Costo_MonedaCorriente` DECIMAL(10,4) NULL,
  `Costo_Dto1` DECIMAL(4,2) NULL,
  `Costo_Dto2` DECIMAL(4,2) NULL,
  `Costo-Dto3` DECIMAL(4,2) NULL,
  `Costo_Dto4` DECIMAL(4,2) NULL,
  `Costo_Dto5` DECIMAL(4,2) NULL,
  `Costo_Transporte` DECIMAL(4,2) NULL,
  `Costo_IVA` DECIMAL(4,2) NULL,
  `Costo_CostoCIVA` DECIMAL(10,2) NULL,
  `Costo_CostoSIVA` DECIMAL(10,2) NULL,
  `Costo_Fecha` DATETIME NULL,
  PRIMARY KEY (`Costo_Id`),
  INDEX `FK_Costos_LCP_idx` (`Costo_LCPId` ASC),
  INDEX `FK_Costos_Productos_idx` (`Costo_ProdId` ASC),
  CONSTRAINT `FK_Costos_LCP`
    FOREIGN KEY (`Costo_LCPId`)
    REFERENCES `ControldeCostos`.`Listas_CostosPrecios` (`LCP_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Costos_Productos`
    FOREIGN KEY (`Costo_ProdId`)
    REFERENCES `ControldeCostos`.`Productos` (`Prod_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeCostos`.`CostosHistorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeCostos`.`CostosHistorial` (
  `CostoH_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CostoH_CostoId` BIGINT(10) UNSIGNED NULL,
  `CostoH_Fecha` DATETIME NULL,
  `CostoH_Campo` TINYINT(2) NULL,
  `CostoH_ValorAnt` DECIMAL(10,4) NULL,
  `Costoh_ValorPost` DECIMAL(10,4) NULL,
  `CostosHistorialcol` VARCHAR(45) NULL,
  PRIMARY KEY (`CostoH_Id`),
  INDEX `CostoID_Fecha` (`CostoH_CostoId` ASC, `CostoH_Fecha` ASC),
  INDEX `CostoID_Campo` (`CostoH_CostoId` ASC, `CostoH_Campo` ASC),
  CONSTRAINT `FK_CH_Costos`
    FOREIGN KEY (`CostoH_CostoId`)
    REFERENCES `ControldeCostos`.`Costos` (`Costo_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeCostos`.`Precios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeCostos`.`Precios` (
  `Precio_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Precio_LCPId` SMALLINT(4) UNSIGNED NULL,
  `Precio_ProdId` INT UNSIGNED NULL,
  `Precio_Margen` DECIMAL(5,2) NULL,
  `Precio_Precio` DECIMAL(10,4) NULL,
  PRIMARY KEY (`Precio_Id`),
  INDEX `FK_Precios_LCP_idx` (`Precio_LCPId` ASC),
  INDEX `FK_Precios_Productos_idx` (`Precio_ProdId` ASC),
  CONSTRAINT `FK_Precios_LCP`
    FOREIGN KEY (`Precio_LCPId`)
    REFERENCES `ControldeCostos`.`Listas_CostosPrecios` (`LCP_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Precios_Productos`
    FOREIGN KEY (`Precio_ProdId`)
    REFERENCES `ControldeCostos`.`Productos` (`Prod_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ControldeCostos`.`PreciosHistorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeCostos`.`PreciosHistorial` (
  `PrecioH_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `PrecioH_PrecioId` BIGINT(10) UNSIGNED NULL,
  `PrecioH_Fecha` DATETIME NULL,
  `PrecioH_MargenAnt` DECIMAL(5,2) UNSIGNED NULL,
  `PrecioH_MargenPost` DECIMAL(5,2) UNSIGNED NULL,
  `PrecioH_PrecioAnt` DECIMAL(10,4) UNSIGNED NULL,
  `PrecioH_PrecioPost` DECIMAL(10,4) UNSIGNED NULL,
  PRIMARY KEY (`PrecioH_Id`),
  INDEX `PrecioID_Fecha` (`PrecioH_PrecioId` ASC, `PrecioH_Fecha` ASC),
  CONSTRAINT `FK_PH_Precios`
    FOREIGN KEY (`PrecioH_PrecioId`)
    REFERENCES `ControldeCostos`.`Precios` (`Precio_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
