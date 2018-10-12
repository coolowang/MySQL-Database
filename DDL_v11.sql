-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema capitaliq
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema capitaliq
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `capitaliq` DEFAULT CHARACTER SET utf16 ;
USE `capitaliq` ;

-- -----------------------------------------------------
-- Table `capitaliq`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capitaliq`.`board` (
  `board_member_id` INT(11) NOT NULL,
  `person_id` INT(11) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`board_member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `capitaliq`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capitaliq`.`company` (
  `company_id` INT(11) NOT NULL,
  `name` VARCHAR(222) NOT NULL,
  `industry` VARCHAR(222) NOT NULL,
  `exchange` VARCHAR(45) NULL DEFAULT NULL,
  `ticker` VARCHAR(45) NULL DEFAULT NULL,
  `year_founded` INT(11) NULL DEFAULT NULL,
  `address1` VARCHAR(222) NULL DEFAULT NULL,
  `address2` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`company_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `capitaliq`.`company_board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capitaliq`.`company_board` (
  `company_id` INT(11) NOT NULL,
  `board_member_id` INT(11) NOT NULL,
  PRIMARY KEY (`company_id`, `board_member_id`),
  INDEX `fk_company_board_company1_idx1` (`company_id` ASC),
  INDEX `fk_company_board_board1_idx1` (`board_member_id` ASC),
  CONSTRAINT `fk_company_board_board1`
    FOREIGN KEY (`board_member_id`)
    REFERENCES `capitaliq`.`board` (`board_member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_board_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `capitaliq`.`company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `capitaliq`.`company_exec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capitaliq`.`company_exec` (
  `person_id` INT(11) NOT NULL,
  `company_id` INT(11) NULL DEFAULT NULL,
  `exec_id` INT(11) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `exec_title` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  INDEX `fk_company_exec_company1_idx1` (`company_id` ASC),
  CONSTRAINT `fk_company_exec_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `capitaliq`.`company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `capitaliq`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capitaliq`.`owner` (
  `owner_id` INT(11) NOT NULL,
  `owner_name` VARCHAR(255) NULL DEFAULT NULL,
  `owner_type_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`owner_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `capitaliq`.`company_owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capitaliq`.`company_owner` (
  `company_owner_id` INT(11) NOT NULL,
  `company_id` INT(11) NULL DEFAULT NULL,
  `owner_id` INT(11) NULL DEFAULT NULL,
  `num_shares` BIGINT(11) NULL DEFAULT NULL,
  `share_total_value` DECIMAL(19,9) NULL DEFAULT NULL,
  PRIMARY KEY (`company_owner_id`),
  INDEX `fk_company_owner_company1_idx1` (`company_id` ASC),
  INDEX `fk_company_owner_owner1_idx1` (`owner_id` ASC),
  CONSTRAINT `fk_company_owner_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `capitaliq`.`company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_owner_owner1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `capitaliq`.`owner` (`owner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `capitaliq`.`financial_metrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capitaliq`.`financial_metrics` (
  `financial_id` INT(11) NOT NULL,
  `company_id` INT(11) NOT NULL,
  `year` INT(11) NULL DEFAULT NULL,
  `stock_price` DECIMAL(19,9) NULL DEFAULT NULL,
  `market_cap` DECIMAL(19,9) NULL DEFAULT NULL,
  `debt` DECIMAL(19,9) NULL DEFAULT NULL,
  `pe` DECIMAL(19,9) NULL DEFAULT NULL,
  `ev_ebitda` DECIMAL(19,9) NULL DEFAULT NULL,
  `ebitda` DECIMAL(19,9) NULL DEFAULT NULL,
  `sales` DECIMAL(19,9) NULL DEFAULT NULL,
  `growth` DECIMAL(19,9) NULL DEFAULT NULL,
  PRIMARY KEY (`financial_id`),
  INDEX `fk_financial_metrics_company1` (`company_id` ASC),
  CONSTRAINT `fk_financial_metrics_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `capitaliq`.`company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
