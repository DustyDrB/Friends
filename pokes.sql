-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema poke_app
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema poke_app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `poke_app` DEFAULT CHARACTER SET utf8 ;
USE `poke_app` ;

-- -----------------------------------------------------
-- Table `poke_app`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poke_app`.`Users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `alias` VARCHAR(255) NULL,
  `pw_hash` VARCHAR(255) NULL,
  `birthdate` DATETIME NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poke_app`.`Pokes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poke_app`.`Pokes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poke_app`.`Pokes_has_Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poke_app`.`Pokes_has_Users` (
  `Poke_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  PRIMARY KEY (`Poke_id`, `User_id`),
  INDEX `fk_Pokes_has_Users_Users1_idx` (`User_id` ASC),
  INDEX `fk_Pokes_has_Users_Pokes_idx` (`Poke_id` ASC),
  CONSTRAINT `fk_Pokes_has_Users_Pokes`
    FOREIGN KEY (`Poke_id`)
    REFERENCES `poke_app`.`Pokes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pokes_has_Users_Users1`
    FOREIGN KEY (`User_id`)
    REFERENCES `poke_app`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
