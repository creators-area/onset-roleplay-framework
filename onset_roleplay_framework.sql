-- MySQL Script generated by MySQL Workbench
-- Mon Oct 28 10:50:15 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema onset_roleplay
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `accounts` (
  `steamid` VARCHAR(17) NOT NULL,
  `steam_name` VARCHAR(32) NOT NULL,
  `game_version` MEDIUMINT(10) UNSIGNED NOT NULL,
  `locale` VARCHAR(6) NOT NULL,
  `count_login` INT(10) UNSIGNED NOT NULL,
  `count_kick` INT(10) UNSIGNED NOT NULL,
  `last_ip` VARCHAR(16) NOT NULL,
  `created_at` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`steamid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `steamid_UNIQUE` ON `accounts` (`steamid` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bans` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `banned` VARCHAR(17) NOT NULL,
  `banned_by` VARCHAR(17) NOT NULL,
  `ban_time` INT(10) UNSIGNED NOT NULL,
  `expire_time` INT(10) UNSIGNED NOT NULL,
  `reason` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_banned_by_steam_id`
    FOREIGN KEY (`banned_by`)
    REFERENCES `accounts` (`steamid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_banned_steam_id`
    FOREIGN KEY (`banned`)
    REFERENCES `accounts` (`steamid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_banned_by_steam_id_idx` ON `bans` (`banned_by` ASC) VISIBLE;

CREATE INDEX `fk_banned_steam_id_idx` ON `bans` (`banned` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `permanent_objects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `permanent_objects` (
  `id` INT(10) UNSIGNED NOT NULL,
  `model_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `x` INT NOT NULL,
  `y` INT NOT NULL,
  `z` INT NOT NULL,
  `pitch` INT NOT NULL,
  `yaw` INT NOT NULL,
  `roll` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_id` VARCHAR(17) NOT NULL,
  `health` FLOAT NOT NULL,
  `armor` FLOAT NOT NULL,
  `cash` INT(11) UNSIGNED NOT NULL,
  `bank_cash` INT(11) UNSIGNED NOT NULL,
  `created_at` INT(10) UNSIGNED NOT NULL,
  `updated_at` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_account_steam_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `accounts` (`steamid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `players` (`id` ASC) VISIBLE;

CREATE INDEX `fk_account_steam_id_idx` ON `players` (`account_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `related_to` INT UNSIGNED NULL,
  `action` VARCHAR(50) NOT NULL,
  `extra` TEXT NULL,
  `created_at` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_related_to_account`
    FOREIGN KEY (`related_to`)
    REFERENCES `players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_related_to_account_idx` ON `logs` (`related_to` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(65) NOT NULL,
  `description` VARCHAR(191) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `name_UNIQUE` ON `permissions` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(65) NOT NULL,
  `description` VARCHAR(191) NULL,
  `is_default` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `name_UNIQUE` ON `roles` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `accounts_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `accounts_has_roles` (
  `accounts_steamid` VARCHAR(17) NOT NULL,
  `roles_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`accounts_steamid`, `roles_id`),
  CONSTRAINT `fk_accounts_has_roles_accounts1`
    FOREIGN KEY (`accounts_steamid`)
    REFERENCES `accounts` (`steamid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_has_roles_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_accounts_has_roles_roles1_idx` ON `accounts_has_roles` (`roles_id` ASC) VISIBLE;

CREATE INDEX `fk_accounts_has_roles_accounts1_idx` ON `accounts_has_roles` (`accounts_steamid` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `roles_has_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roles_has_permissions` (
  `roles_id` INT UNSIGNED NOT NULL,
  `permissions_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`roles_id`, `permissions_id`),
  CONSTRAINT `fk_roles_has_permissions_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_permissions_permissions1`
    FOREIGN KEY (`permissions_id`)
    REFERENCES `permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_roles_has_permissions_permissions1_idx` ON `roles_has_permissions` (`permissions_id` ASC) VISIBLE;

CREATE INDEX `fk_roles_has_permissions_roles1_idx` ON `roles_has_permissions` (`roles_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `model_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `name` VARCHAR(65) NOT NULL,
  `price` FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `weapons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `weapons` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `model_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `name` VARCHAR(65) NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `car_dealers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_dealers` (
  `vehicles_id` INT UNSIGNED NOT NULL,
  `permanent_objects_id` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`vehicles_id`, `permanent_objects_id`),
  CONSTRAINT `fk_vehicles_has_permanent_objects_vehicles1`
    FOREIGN KEY (`vehicles_id`)
    REFERENCES `vehicles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehicles_has_permanent_objects_permanent_objects1`
    FOREIGN KEY (`permanent_objects_id`)
    REFERENCES `permanent_objects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_vehicles_has_permanent_objects_permanent_objects1_idx` ON `car_dealers` (`permanent_objects_id` ASC) VISIBLE;

CREATE INDEX `fk_vehicles_has_permanent_objects_vehicles1_idx` ON `car_dealers` (`vehicles_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `players_has_vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players_has_vehicles` (
  `vehicles_id` INT UNSIGNED NOT NULL,
  `players_id` INT UNSIGNED NOT NULL,
  `buy_at` INT(10) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vehicles_id`, `players_id`),
  CONSTRAINT `fk_players_has_vehicles_vehicles1`
    FOREIGN KEY (`vehicles_id`)
    REFERENCES `vehicles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_players_has_vehicles_players1`
    FOREIGN KEY (`players_id`)
    REFERENCES `players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_accounts_has_vehicles_vehicles1_idx` ON `players_has_vehicles` (`vehicles_id` ASC) VISIBLE;

CREATE INDEX `fk_players_has_vehicles_players1_idx` ON `players_has_vehicles` (`players_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `players_has_weapons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players_has_weapons` (
  `weapons_id` INT UNSIGNED NOT NULL,
  `players_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`weapons_id`, `players_id`),
  CONSTRAINT `fk_players_has_weapons_weapons1`
    FOREIGN KEY (`weapons_id`)
    REFERENCES `weapons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_players_has_weapons_players1`
    FOREIGN KEY (`players_id`)
    REFERENCES `players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_accounts_has_weapons_weapons1_idx` ON `players_has_weapons` (`weapons_id` ASC) VISIBLE;

CREATE INDEX `fk_players_has_weapons_players1_idx` ON `players_has_weapons` (`players_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `npc_weapons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npc_weapons` (
  `weapons_id` INT UNSIGNED NOT NULL,
  `permanent_objects_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`weapons_id`, `permanent_objects_id`),
  CONSTRAINT `fk_weapons_has_permanent_objects_weapons1`
    FOREIGN KEY (`weapons_id`)
    REFERENCES `weapons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weapons_has_permanent_objects_permanent_objects1`
    FOREIGN KEY (`permanent_objects_id`)
    REFERENCES `permanent_objects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_weapons_has_permanent_objects_permanent_objects1_idx` ON `npc_weapons` (`permanent_objects_id` ASC) VISIBLE;

CREATE INDEX `fk_weapons_has_permanent_objects_weapons1_idx` ON `npc_weapons` (`weapons_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cosmetics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cosmetics` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `model_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `name` VARCHAR(65) NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `price` FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `properties` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(191) NOT NULL,
  `price` FLOAT UNSIGNED NOT NULL,
  `saleable` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `name_UNIQUE` ON `properties` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `estate_agent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estate_agent` (
  `permanent_objects_id` INT(10) UNSIGNED NOT NULL,
  `properties_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`permanent_objects_id`, `properties_id`),
  CONSTRAINT `fk_permanent_objects_has_properties_permanent_objects1`
    FOREIGN KEY (`permanent_objects_id`)
    REFERENCES `permanent_objects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permanent_objects_has_properties_properties1`
    FOREIGN KEY (`properties_id`)
    REFERENCES `properties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_permanent_objects_has_properties_properties1_idx` ON `estate_agent` (`properties_id` ASC) VISIBLE;

CREATE INDEX `fk_permanent_objects_has_properties_permanent_objects1_idx` ON `estate_agent` (`permanent_objects_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `players_has_properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players_has_properties` (
  `properties_id` INT UNSIGNED NOT NULL,
  `players_id` INT UNSIGNED NOT NULL,
  `buy_at` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`properties_id`, `players_id`),
  CONSTRAINT `fk_players_has_properties_properties1`
    FOREIGN KEY (`properties_id`)
    REFERENCES `properties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_players_has_properties_players1`
    FOREIGN KEY (`players_id`)
    REFERENCES `players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_accounts_has_properties_properties1_idx` ON `players_has_properties` (`properties_id` ASC) VISIBLE;

CREATE INDEX `fk_accounts_has_properties_players1_idx` ON `players_has_properties` (`players_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `players_has_cosmetics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players_has_cosmetics` (
  `players_id` INT UNSIGNED NOT NULL,
  `cosmetics_id` INT UNSIGNED NOT NULL,
  `is_equipped` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`players_id`, `cosmetics_id`),
  CONSTRAINT `fk_players_has_cosmetics_players1`
    FOREIGN KEY (`players_id`)
    REFERENCES `players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_players_has_cosmetics_cosmetics1`
    FOREIGN KEY (`cosmetics_id`)
    REFERENCES `cosmetics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_players_has_cosmetics_cosmetics1_idx` ON `players_has_cosmetics` (`cosmetics_id` ASC) VISIBLE;

CREATE INDEX `fk_players_has_cosmetics_players1_idx` ON `players_has_cosmetics` (`players_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `onset_roleplay`.`accounts_AFTER_INSERT` AFTER INSERT ON `accounts` FOR EACH ROW
BEGIN
	DECLARE default_role_id int;
    SELECT id INTO default_role_id FROM roles WHERE is_default = 1 LIMIT 1;
    INSERT INTO accounts_has_roles VALUES ( NEW.steamid, default_role_id );
END$$


DELIMITER ;
