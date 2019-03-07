-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema theater
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `theater` ;

-- -----------------------------------------------------
-- Schema theater
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `theater` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `theater` ;

-- -----------------------------------------------------
-- Table `theater`.`ROLLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`ROLLE` (
  `rol_id` INT NOT NULL AUTO_INCREMENT,
  `rol_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rol_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `theater`.`PERSON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`PERSON` (
  `per_id` INT NOT NULL AUTO_INCREMENT,
  `per_vName` VARCHAR(45) NULL,
  `per_nName` VARCHAR(45) NOT NULL,
  `per_geburt` DATE NULL,
  `per_geschlecht` CHAR(1) NOT NULL DEFAULT 'm' COMMENT '0 = männlich\n1 = weiblich',
  `rol_id` INT NOT NULL,
  PRIMARY KEY (`per_id`),
  INDEX `fk_PERSON_ROLLE1_idx` (`rol_id` ASC),
  UNIQUE INDEX `index3` (`per_vName` ASC, `per_nName` ASC),
  CONSTRAINT `fk_PERSON_ROLLE1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `theater`.`ROLLE` (`rol_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `theater`.`ADRESSE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`ADRESSE` (
  `adr_id` INT NOT NULL AUTO_INCREMENT,
  `adr_strasse` VARCHAR(45) NOT NULL,
  `adr_plz` VARCHAR(45) NOT NULL,
  `adr_ort` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adr_id`),
  UNIQUE INDEX `unique_adresse` (`adr_strasse` ASC, `adr_plz` ASC, `adr_ort` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `theater`.`GENRE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`GENRE` (
  `gen_id` INT NOT NULL AUTO_INCREMENT,
  `gen_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gen_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `theater`.`DRAMA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`DRAMA` (
  `dra_id` INT NOT NULL AUTO_INCREMENT,
  `dra_name` VARCHAR(45) NOT NULL,
  `gen_id` INT NOT NULL,
  `autor_id` INT NOT NULL,
  PRIMARY KEY (`dra_id`),
  INDEX `fk_DRAMA_GENRE1_idx` (`gen_id` ASC),
  INDEX `fk_DRAMA_PERSON1_idx` (`autor_id` ASC),
  UNIQUE INDEX `dra_name_UNIQUE` (`dra_name` ASC, `autor_id` ASC, `gen_id` ASC),
  CONSTRAINT `fk_DRAMA_GENRE1`
    FOREIGN KEY (`gen_id`)
    REFERENCES `theater`.`GENRE` (`gen_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DRAMA_PERSON1`
    FOREIGN KEY (`autor_id`)
    REFERENCES `theater`.`PERSON` (`per_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `theater`.`dramaevent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`dramaevent` (
  `eve_id` INT NOT NULL AUTO_INCREMENT,
  `eve_termin` DATETIME NOT NULL,
  `dra_id` INT NOT NULL,
  PRIMARY KEY (`eve_id`),
  INDEX `fk_EVENT_DRAMA1_idx` (`dra_id` ASC),
  UNIQUE INDEX `eve_termin_UNIQUE` (`eve_termin` ASC, `dra_id` ASC),
  CONSTRAINT `fk_EVENT_DRAMA1`
    FOREIGN KEY (`dra_id`)
    REFERENCES `theater`.`DRAMA` (`dra_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `theater`.`CREW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`CREW` (
  `eve_id` INT NOT NULL,
  `per_id` INT NOT NULL,
  INDEX `fk_CREW_EVENT1_idx` (`eve_id` ASC),
  INDEX `fk_CREW_PERSON1_idx` (`per_id` ASC),
  PRIMARY KEY (`eve_id`, `per_id`),
  CONSTRAINT `fk_CREW_EVENT1`
    FOREIGN KEY (`eve_id`)
    REFERENCES `theater`.`dramaevent` (`eve_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CREW_PERSON1`
    FOREIGN KEY (`per_id`)
    REFERENCES `theater`.`PERSON` (`per_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `theater`.`ADRESSE_PERSON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theater`.`ADRESSE_PERSON` (
  `adr_id` INT NOT NULL,
  `per_id` INT NOT NULL,
  `adr_per_hausNr` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`adr_id`, `per_id`),
  INDEX `fk_ADRESSE_has_PERSON_PERSON1_idx` (`per_id` ASC),
  INDEX `fk_ADRESSE_has_PERSON_ADRESSE1_idx` (`adr_id` ASC),
  CONSTRAINT `fk_ADRESSE_has_PERSON_ADRESSE1`
    FOREIGN KEY (`adr_id`)
    REFERENCES `theater`.`ADRESSE` (`adr_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ADRESSE_has_PERSON_PERSON1`
    FOREIGN KEY (`per_id`)
    REFERENCES `theater`.`PERSON` (`per_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `theater`.`ROLLE`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`ROLLE` (`rol_id`, `rol_name`) VALUES (NULL, 'Schauspieler');
INSERT INTO `theater`.`ROLLE` (`rol_id`, `rol_name`) VALUES (NULL, 'Hausmeister');
INSERT INTO `theater`.`ROLLE` (`rol_id`, `rol_name`) VALUES (NULL, 'Putzfrau');
INSERT INTO `theater`.`ROLLE` (`rol_id`, `rol_name`) VALUES (NULL, 'Autor');

COMMIT;


-- -----------------------------------------------------
-- Data for table `theater`.`PERSON`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`PERSON` (`per_id`, `per_vName`, `per_nName`, `per_geburt`, `per_geschlecht`, `rol_id`) VALUES (NULL, 'Paul', 'Jahn', '1974-11-02', 'm', 1);
INSERT INTO `theater`.`PERSON` (`per_id`, `per_vName`, `per_nName`, `per_geburt`, `per_geschlecht`, `rol_id`) VALUES (NULL, 'Maria', 'Hubschmid', '1985-02-13', 'w', 1);
INSERT INTO `theater`.`PERSON` (`per_id`, `per_vName`, `per_nName`, `per_geburt`, `per_geschlecht`, `rol_id`) VALUES (NULL, 'Werner', 'Fahl', '1965-04-05', 'm', 2);
INSERT INTO `theater`.`PERSON` (`per_id`, `per_vName`, `per_nName`, `per_geburt`, `per_geschlecht`, `rol_id`) VALUES (NULL, 'Karin', 'Bram', '1964-09-20', 'w', 1);
INSERT INTO `theater`.`PERSON` (`per_id`, `per_vName`, `per_nName`, `per_geburt`, `per_geschlecht`, `rol_id`) VALUES (NULL, 'Johann Wolfgang', 'von Goethe', NULL, 'm', 4);
INSERT INTO `theater`.`PERSON` (`per_id`, `per_vName`, `per_nName`, `per_geburt`, `per_geschlecht`, `rol_id`) VALUES (NULL, 'Wilhelm', 'Shakespear', NULL, 'm', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `theater`.`ADRESSE`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`ADRESSE` (`adr_id`, `adr_strasse`, `adr_plz`, `adr_ort`) VALUES (NULL, 'Wiener Straße', '4020', 'Linz');
INSERT INTO `theater`.`ADRESSE` (`adr_id`, `adr_strasse`, `adr_plz`, `adr_ort`) VALUES (NULL, 'Hauptstraße', '4040', 'Urfahr');
INSERT INTO `theater`.`ADRESSE` (`adr_id`, `adr_strasse`, `adr_plz`, `adr_ort`) VALUES (NULL, 'Hauptplatz', '4020', 'Linz');

COMMIT;


-- -----------------------------------------------------
-- Data for table `theater`.`GENRE`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`GENRE` (`gen_id`, `gen_name`) VALUES (NULL, 'Komödie');
INSERT INTO `theater`.`GENRE` (`gen_id`, `gen_name`) VALUES (NULL, 'Tragödie');
INSERT INTO `theater`.`GENRE` (`gen_id`, `gen_name`) VALUES (NULL, 'Lustspiel');
INSERT INTO `theater`.`GENRE` (`gen_id`, `gen_name`) VALUES (NULL, 'Kindertheater');

COMMIT;


-- -----------------------------------------------------
-- Data for table `theater`.`DRAMA`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`DRAMA` (`dra_id`, `dra_name`, `gen_id`, `autor_id`) VALUES (NULL, 'Romeo und Julia', 2, 6);
INSERT INTO `theater`.`DRAMA` (`dra_id`, `dra_name`, `gen_id`, `autor_id`) VALUES (NULL, 'Faust', 2, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `theater`.`dramaevent`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`dramaevent` (`eve_id`, `eve_termin`, `dra_id`) VALUES (NULL, '2017-12-01 20:00:00', 1);
INSERT INTO `theater`.`dramaevent` (`eve_id`, `eve_termin`, `dra_id`) VALUES (NULL, '2017-12-04 20:00:00', 2);
INSERT INTO `theater`.`dramaevent` (`eve_id`, `eve_termin`, `dra_id`) VALUES (NULL, '2018-02-20 19:15:00', 2);
INSERT INTO `theater`.`dramaevent` (`eve_id`, `eve_termin`, `dra_id`) VALUES (NULL, '2018-02-20 21:00:00', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `theater`.`CREW`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`CREW` (`eve_id`, `per_id`) VALUES (1, 2);
INSERT INTO `theater`.`CREW` (`eve_id`, `per_id`) VALUES (1, 4);
INSERT INTO `theater`.`CREW` (`eve_id`, `per_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `theater`.`ADRESSE_PERSON`
-- -----------------------------------------------------
START TRANSACTION;
USE `theater`;
INSERT INTO `theater`.`ADRESSE_PERSON` (`adr_id`, `per_id`, `adr_per_hausNr`) VALUES (1, 1, '105');
INSERT INTO `theater`.`ADRESSE_PERSON` (`adr_id`, `per_id`, `adr_per_hausNr`) VALUES (2, 2, '10');
INSERT INTO `theater`.`ADRESSE_PERSON` (`adr_id`, `per_id`, `adr_per_hausNr`) VALUES (3, 3, '5');
INSERT INTO `theater`.`ADRESSE_PERSON` (`adr_id`, `per_id`, `adr_per_hausNr`) VALUES (3, 4, '2a');

COMMIT;

