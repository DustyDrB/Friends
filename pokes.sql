-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema blackbelt
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blackbelt
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blackbelt` DEFAULT CHARACTER SET utf8 ;
USE `blackbelt` ;

-- -----------------------------------------------------
-- Table `blackbelt`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blackbelt`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `alias` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `pw_hash` VARCHAR(255) NULL,
  `date_created` DATETIME NULL,
  `date_updated` DATETIME NULL,
  `birthday` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blackbelt`.`Pokes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blackbelt`.`Pokes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NULL,
  `date_updated` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blackbelt`.`Pokes_has_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blackbelt`.`Pokes_has_users` (
  `poke_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`poke_id`, `user_id`),
  INDEX `fk_Pokes_has_users_users1_idx` (`user_id` ASC),
  INDEX `fk_Pokes_has_users_Pokes_idx` (`poke_id` ASC),
  CONSTRAINT `fk_Pokes_has_users_Pokes`
    FOREIGN KEY (`poke_id`)
    REFERENCES `blackbelt`.`Pokes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pokes_has_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `blackbelt`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
