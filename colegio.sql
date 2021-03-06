-- MySQL Script generated by MySQL Workbench
-- Wed Jun 14 19:29:36 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alumnos` (
  `doc_identificacion` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `apellido` VARCHAR(30) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `grado` VARCHAR(20) NOT NULL,
  `estado_grado` ENUM('aprobado', 'no aprobado') NOT NULL,
  PRIMARY KEY (`doc_identificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grados` (
  `idgrados` INT NOT NULL,
  `grado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idgrados`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inscripciones_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inscripciones_cursos` (
  `id_curso` INT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  PRIMARY KEY (`id_curso`),
  CONSTRAINT `fk_grado`
    FOREIGN KEY (`id_curso`)
    REFERENCES `mydb`.`grados` (`idgrados`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inscripciones_cursos_estudiantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inscripciones_cursos_estudiantes` (
  `id_alumno` VARCHAR(15) NOT NULL,
  `nombre_alumno` VARCHAR(45) NOT NULL,
  `id_curso` INT NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_alumno`, `id_curso`),
  INDEX `fk_curso_idx` (`id_curso` ASC),
  CONSTRAINT `fk_curso_inscripcion`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `mydb`.`alumnos` (`doc_identificacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_curso`
    FOREIGN KEY (`id_curso`)
    REFERENCES `mydb`.`inscripciones_cursos` (`id_curso`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`examen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`examen` (
  `id_alumno` VARCHAR(15) NOT NULL,
  `estado` ENUM('aprobado', 'no aprobado') NOT NULL,
  PRIMARY KEY (`id_alumno`),
  CONSTRAINT `fk_estado_examen`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `mydb`.`inscripciones_cursos_estudiantes` (`id_alumno`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
