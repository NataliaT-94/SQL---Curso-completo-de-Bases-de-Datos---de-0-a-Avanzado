--Relaciones
    -- 1:n Es una relacion de uno a muchos, se hace click primero en la tabla hijo y luego en la tabla padre
    -- n:m Es una relacion de muchos a muchos


--Consignas:
    --Se realizaran ventas de Productos
    --Se manejarandatos de Proveedores
    --Se manejaran datos de Clientes
    --Los productos estaran asociados a multiples Categorias
    --Los productos estaran asociados a una lista de productos
    --Se deberan guardar las ventas y su detalle, unidos a clientes y productos

-- Creamos las tablas
    --Productos
    --Proveedores
    --Clientes
    --Categorias
    --Precios
    --Ventas_Enc
    --Ventas_Detalle

-- Relacionamos tablas
    -- Productos 1:n Proveedores
    -- Categorias n:m Productos : Se crea automaticamente una tabla auxiliar el cual relaciona a categoria con varios productos
    -- Preoductos 1:1 Precios
    -- Ventas_Enc 1:n Clientes
    -- Ventas_Detalle 1:n Ventas_Enc
    -- Ventas_Detalle 1:n Productos


-- Layer : Subsistemas, es un conjunto de tablas pertenecientes al mismo campo
    --Productos:
        --Productos
        --Precios
        --Categorias
        --Tabla creada de la relacion entre productos y categorias

    --Ventas:
        --Clientes
        --Ventas_Enc
        --Ventas_Detalle

    --Compras:
        --Proveedores

-----------------------

--Para IMportar el Codigo de la tabla
DataBase>Forward Engineer>





-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ventasSistema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ventasSistema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ventasSistema` DEFAULT CHARACTER SET utf8 ;
USE `ventasSistema` ;

-- -----------------------------------------------------
-- Table `ventasSistema`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`proveedores` (
  `Prov_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Prov_Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`Prov_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ventasSistema`.`precios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`precios` (
  `Pcios_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Precios_ProdId` INT NULL,
  `Precios_Valor` DECIMAL(10,3) UNSIGNED NOT NULL,
  PRIMARY KEY (`Pcios_Id`),
  UNIQUE INDEX `Precios_ProdId_UNIQUE` (`Precios_ProdId` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ventasSistema`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`productos` (
  `Prod_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Prod_Descripcion` VARCHAR(60) NULL,
  `Prod_Color` VARCHAR(45) NULL,
  `Prod_ProvId` INT NULL,
  `proveedores_Prov_Id` INT UNSIGNED NOT NULL,
  `precios_Pcios_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Prod_Id`, `proveedores_Prov_Id`),
  INDEX `fk_productos_proveedores_idx` (`proveedores_Prov_Id` ASC) VISIBLE,
  INDEX `fk_productos_precios1_idx` (`precios_Pcios_Id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_proveedores`
    FOREIGN KEY (`proveedores_Prov_Id`)
    REFERENCES `ventasSistema`.`proveedores` (`Prov_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_precios1`
    FOREIGN KEY (`precios_Pcios_Id`)
    REFERENCES `ventasSistema`.`precios` (`Pcios_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ventasSistema`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`clientes` (
  `Cli_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Cli_Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`Cli_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ventasSistema`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`categorias` (
  `Categ_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Categ_Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`Categ_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ventasSistema`.`categorias_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`categorias_has_productos` (
  `categorias_Categ_Id` INT UNSIGNED NOT NULL,
  `productos_Prod_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`categorias_Categ_Id`, `productos_Prod_Id`),
  INDEX `fk_categorias_has_productos_productos1_idx` (`productos_Prod_Id` ASC) VISIBLE,
  INDEX `fk_categorias_has_productos_categorias1_idx` (`categorias_Categ_Id` ASC) VISIBLE,
  CONSTRAINT `fk_categorias_has_productos_categorias1`
    FOREIGN KEY (`categorias_Categ_Id`)
    REFERENCES `ventasSistema`.`categorias` (`Categ_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categorias_has_productos_productos1`
    FOREIGN KEY (`productos_Prod_Id`)
    REFERENCES `ventasSistema`.`productos` (`Prod_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ventasSistema`.`ventas_Enc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`ventas_Enc` (
  `VentasE_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `VentasE_Fecha` DATE NULL,
  `VentasE_CliId` INT NULL,
  `VentasE_Total` DECIMAL(10,2) NULL,
  `clientes_Cli_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`VentasE_Id`, `clientes_Cli_Id`),
  UNIQUE INDEX `VentasE_CliId_UNIQUE` (`VentasE_CliId` ASC) VISIBLE,
  INDEX `fk_ventas_Enc_clientes1_idx` (`clientes_Cli_Id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_Enc_clientes1`
    FOREIGN KEY (`clientes_Cli_Id`)
    REFERENCES `ventasSistema`.`clientes` (`Cli_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ventasSistema`.`ventas_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ventasSistema`.`ventas_detalle` (
  `VentasD_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `VentasD_VEId` BIGINT(10) NULL,
  `VentasD_ProdId` INT NULL,
  `VentasD_Cantidad` MEDIUMINT(5) NULL,
  `ventas_Enc_VentasE_Id` BIGINT(10) UNSIGNED NOT NULL,
  `ventas_Enc_clientes_Cli_Id` INT UNSIGNED NOT NULL,
  `productos_Prod_Id` INT UNSIGNED NOT NULL,
  `productos_proveedores_Prov_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`VentasD_Id`, `ventas_Enc_VentasE_Id`, `ventas_Enc_clientes_Cli_Id`, `productos_Prod_Id`, `productos_proveedores_Prov_Id`),
  INDEX `fk_ventas_detalle_ventas_Enc1_idx` (`ventas_Enc_VentasE_Id` ASC, `ventas_Enc_clientes_Cli_Id` ASC) VISIBLE,
  INDEX `fk_ventas_detalle_productos1_idx` (`productos_Prod_Id` ASC, `productos_proveedores_Prov_Id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_detalle_ventas_Enc1`
    FOREIGN KEY (`ventas_Enc_VentasE_Id` , `ventas_Enc_clientes_Cli_Id`)
    REFERENCES `ventasSistema`.`ventas_Enc` (`VentasE_Id` , `clientes_Cli_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_detalle_productos1`
    FOREIGN KEY (`productos_Prod_Id` , `productos_proveedores_Prov_Id`)
    REFERENCES `ventasSistema`.`productos` (`Prod_Id` , `proveedores_Prov_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
