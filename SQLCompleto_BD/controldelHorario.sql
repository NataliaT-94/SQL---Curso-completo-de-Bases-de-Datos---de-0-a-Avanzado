-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ControldeHorario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ControldeHorario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ControldeHorario` DEFAULT CHARACTER SET utf8 ;
USE `ControldeHorario` ;

-- -----------------------------------------------------
-- Table `ControldeHorario`.`Estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Estados` (
  `Estado_Id` TINYINT(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Est_Descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`Estado_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Paises` (
  `Pais_Id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Pais_Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`Pais_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Provincias` (
  `Provin_Id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Provin_PaisId` TINYINT(3) UNSIGNED NOT NULL,
  `Provin_Nombre` VARCHAR(60) NULL,
  PRIMARY KEY (`Provin_Id`),
  INDEX `FK_Provin_Pais_idx` (`Provin_PaisId` ASC),
  CONSTRAINT `FK_Provin_Pais`
    FOREIGN KEY (`Provin_PaisId`)
    REFERENCES `ControldeHorario`.`Paises` (`Pais_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Localidades` (
  `Local_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Local_ProvinId` MEDIUMINT(8) UNSIGNED NOT NULL,
  `Local_Nombre` VARCHAR(60) NULL,
  PRIMARY KEY (`Local_Id`),
  INDEX `FK_Local_Provincia_idx` (`Local_ProvinId` ASC),
  CONSTRAINT `FK_Local_Provincia`
    FOREIGN KEY (`Local_ProvinId`)
    REFERENCES `ControldeHorario`.`Provincias` (`Provin_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`PoliticaHoraria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`PoliticaHoraria` (
  `PH_Id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `PH_HorarioFlexible` BIT(1) NULL,
  `PH_Nombre` VARCHAR(80) NULL,
  `PH_Estado` BIT(1) NULL DEFAULT 1,
  PRIMARY KEY (`PH_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Categoria` (
  `Categ_Id` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Categ_Nombre` VARCHAR(60) NULL,
  PRIMARY KEY (`Categ_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Sectores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Sectores` (
  `Sector_Id` SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Sector_Nombre` VARCHAR(60) NULL,
  PRIMARY KEY (`Sector_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Empleados` (
  `Emp_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Emp_Apellido` VARCHAR(60) NULL,
  `Emp_Nombre` VARCHAR(100) NULL,
  `Emp_FechaNac` DATE NULL,
  `Emp_FechaAlta` DATE NULL,
  `Emp_FechaBaja` DATE NULL,
  `Emp_EstadoId` TINYINT(2) UNSIGNED NULL DEFAULT 1,
  `Emp_LocalidadId` INT UNSIGNED NULL,
  `Emp_CategoriaId` SMALLINT(4) UNSIGNED NULL,
  `Emp_Salario` DECIMAL(10,2) UNSIGNED NULL DEFAULT 0,
  `Emp_PoliticaHorariaId` SMALLINT(4) UNSIGNED NULL,
  `Emp_Domicilio` VARCHAR(150) NULL,
  `Emp_Email` VARCHAR(80) NULL,
  `Emp_Telefono` VARCHAR(20) NULL,
  `Emp_SectorId` SMALLINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`Emp_Id`),
  INDEX `FK_Emp_Estado_idx` (`Emp_EstadoId` ASC),
  INDEX `FK_Emp_Localidad_idx` (`Emp_LocalidadId` ASC),
  INDEX `FK_Emp_PH_idx` (`Emp_PoliticaHorariaId` ASC),
  INDEX `FK_Emp_Categ_idx` (`Emp_CategoriaId` ASC),
  INDEX `FK_Emp_Sector_idx` (`Emp_SectorId` ASC),
  CONSTRAINT `FK_Emp_Estado`
    FOREIGN KEY (`Emp_EstadoId`)
    REFERENCES `ControldeHorario`.`Estados` (`Estado_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Emp_Localidad`
    FOREIGN KEY (`Emp_LocalidadId`)
    REFERENCES `ControldeHorario`.`Localidades` (`Local_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Emp_PH`
    FOREIGN KEY (`Emp_PoliticaHorariaId`)
    REFERENCES `ControldeHorario`.`PoliticaHoraria` (`PH_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Emp_Categ`
    FOREIGN KEY (`Emp_CategoriaId`)
    REFERENCES `ControldeHorario`.`Categoria` (`Categ_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Emp_Sector`
    FOREIGN KEY (`Emp_SectorId`)
    REFERENCES `ControldeHorario`.`Sectores` (`Sector_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`PoliticaHoraria_Detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`PoliticaHoraria_Detalle` (
  `PHD_Id` MEDIUMINT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `PHD_PHId` SMALLINT(5) UNSIGNED NOT NULL,
  `PHD_DiaSemana` TINYINT(1) UNSIGNED NULL,
  `PHD_HoraD` TIME NULL,
  `PHD_HoraH` TIME NULL,
  `PHD_Horas` TINYINT(2) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`PHD_Id`),
  INDEX `FK_PHD_PH_idx` (`PHD_PHId` ASC),
  CONSTRAINT `FK_PHD_PH`
    FOREIGN KEY (`PHD_PHId`)
    REFERENCES `ControldeHorario`.`PoliticaHoraria` (`PH_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`ControlHorario_Mov`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`ControlHorario_Mov` (
  `CHM_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CHM_Fecha` DATE NULL,
  `CHM_Hora` TIME NULL,
  `CHM_EmpleadoId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`CHM_Id`),
  INDEX `Fecha` (`CHM_Fecha` ASC),
  INDEX `FechaEmp` (`CHM_Fecha` ASC, `CHM_EmpleadoId` ASC),
  INDEX `FK_CHM_Emp_idx` (`CHM_EmpleadoId` ASC),
  CONSTRAINT `FK_CHM_Emp`
    FOREIGN KEY (`CHM_EmpleadoId`)
    REFERENCES `ControldeHorario`.`Empleados` (`Emp_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`ControlHorario_Res`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`ControlHorario_Res` (
  `CHR_Id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CHR_Fecha` DATE NULL,
  `CHR_EmpleadoId` INT UNSIGNED NOT NULL,
  `CHR_Hora` TINYINT(2) NULL,
  PRIMARY KEY (`CHR_Id`),
  INDEX `Fecha` (`CHR_Fecha` ASC),
  INDEX `FechaEmpleado` (`CHR_Fecha` ASC, `CHR_EmpleadoId` ASC),
  INDEX `FK_CHR_Emp_idx` (`CHR_EmpleadoId` ASC),
  CONSTRAINT `FK_CHR_Emp`
    FOREIGN KEY (`CHR_EmpleadoId`)
    REFERENCES `ControldeHorario`.`Empleados` (`Emp_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Infracciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Infracciones` (
  `Infrac_Id` SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Infrac_Nombre` VARCHAR(60) NULL,
  PRIMARY KEY (`Infrac_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`ControlHorario_Nov`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`ControlHorario_Nov` (
  `CHN_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CHN_Fecha` DATE NULL,
  `CHN_InfraccionId` SMALLINT(3) UNSIGNED NOT NULL,
  `CHN_EmpleadoId` INT UNSIGNED NOT NULL,
  `CHN_Horas` TINYINT(1) UNSIGNED NULL,
  `CHN_Minutos` TINYINT(3) UNSIGNED NULL,
  PRIMARY KEY (`CHN_Id`),
  INDEX `Fecha` (`CHN_Fecha` ASC),
  INDEX `Empleado` (`CHN_EmpleadoId` ASC),
  INDEX `FechaEmpleado` (`CHN_Fecha` ASC, `CHN_EmpleadoId` ASC),
  INDEX `FK_CHN_Infrac_idx` (`CHN_InfraccionId` ASC),
  CONSTRAINT `FK_CHN_Emp`
    FOREIGN KEY (`CHN_EmpleadoId`)
    REFERENCES `ControldeHorario`.`Empleados` (`Emp_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_CHN_Infrac`
    FOREIGN KEY (`CHN_InfraccionId`)
    REFERENCES `ControldeHorario`.`Infracciones` (`Infrac_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`Novedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`Novedades` (
  `Noved_Id` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Noved_Descripcion` VARCHAR(60) NULL,
  PRIMARY KEY (`Noved_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ControldeHorario`.`ControlHorario_Exc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ControldeHorario`.`ControlHorario_Exc` (
  `CHE_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CHE_EmpleadoId` INT UNSIGNED NOT NULL,
  `CHE_FechaD` DATE NULL,
  `CHE_FechaH` DATE NULL,
  `CHE_NovedadId` SMALLINT(4) UNSIGNED NOT NULL,
  `CHE_Horas` SMALLINT(5) NULL,
  PRIMARY KEY (`CHE_Id`),
  INDEX `FK_CHE_Emp_idx` (`CHE_EmpleadoId` ASC),
  INDEX `FK_CHE_Noved_idx` (`CHE_NovedadId` ASC),
  CONSTRAINT `FK_CHE_Emp`
    FOREIGN KEY (`CHE_EmpleadoId`)
    REFERENCES `ControldeHorario`.`Empleados` (`Emp_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_CHE_Noved`
    FOREIGN KEY (`CHE_NovedadId`)
    REFERENCES `ControldeHorario`.`Novedades` (`Noved_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
