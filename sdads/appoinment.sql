-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for appointment-schedual
DROP DATABASE IF EXISTS `appointment-schedual`;
CREATE DATABASE IF NOT EXISTS `appointment-schedual` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `appointment-schedual`;

-- Dumping structure for table appointment-schedual.appointment
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE IF NOT EXISTS `appointment` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Time` datetime DEFAULT NULL,
  `State` int(11) DEFAULT NULL,
  `ProfileId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_appointment_profile` (`ProfileId`),
  CONSTRAINT `FK_appointment_profile` FOREIGN KEY (`ProfileId`) REFERENCES `profile` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.customer
DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `Id` int(11) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(50) DEFAULT NULL,
  `Image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_customer_user` FOREIGN KEY (`Id`) REFERENCES `user` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.diagnosticservice
DROP TABLE IF EXISTS `diagnosticservice`;
CREATE TABLE IF NOT EXISTS `diagnosticservice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(250) DEFAULT NULL,
  `Price` double DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.doctor
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE IF NOT EXISTS `doctor` (
  `Id` int(11) NOT NULL,
  `Email` varchar(50) DEFAULT '',
  `Position` varchar(50) DEFAULT '0',
  `Certificate` varchar(50) DEFAULT '',
  `PhoneNumber` varchar(50) DEFAULT '',
  `Image` varchar(50) DEFAULT '',
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_doctor_user` FOREIGN KEY (`Id`) REFERENCES `user` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.examinationdetail
DROP TABLE IF EXISTS `examinationdetail`;
CREATE TABLE IF NOT EXISTS `examinationdetail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DoctorId` int(11) DEFAULT NULL,
  `AppointmentId` int(11) DEFAULT NULL,
  `Diagnostic` int(11) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `State` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_examination_doctor` (`DoctorId`),
  KEY `FK_examination_appoinment` (`AppointmentId`),
  CONSTRAINT `FK_examination_appoinment` FOREIGN KEY (`AppointmentId`) REFERENCES `appointment` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_examination_doctor` FOREIGN KEY (`DoctorId`) REFERENCES `doctor` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.examinationservice
DROP TABLE IF EXISTS `examinationservice`;
CREATE TABLE IF NOT EXISTS `examinationservice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DoctorId` int(11) DEFAULT NULL,
  `DiagnosticServiceId` int(11) DEFAULT NULL,
  `ExaminationDetailId` int(11) DEFAULT NULL,
  `Document` varbinary(10000) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_service_doctor` (`DoctorId`),
  KEY `FK_service_diagnosticService` (`DiagnosticServiceId`),
  KEY `FK_service_detail` (`ExaminationDetailId`),
  CONSTRAINT `FK_service_detail` FOREIGN KEY (`ExaminationDetailId`) REFERENCES `examinationdetail` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_service_diagnosticService` FOREIGN KEY (`DiagnosticServiceId`) REFERENCES `diagnosticservice` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_service_doctor` FOREIGN KEY (`DoctorId`) REFERENCES `doctor` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.medicine
DROP TABLE IF EXISTS `medicine`;
CREATE TABLE IF NOT EXISTS `medicine` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Image` varchar(1000) DEFAULT NULL,
  `Unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.prescription
DROP TABLE IF EXISTS `prescription`;
CREATE TABLE IF NOT EXISTS `prescription` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ExaminationId` int(11) DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_prescription_examination` (`ExaminationId`),
  CONSTRAINT `FK_prescription_examination` FOREIGN KEY (`ExaminationId`) REFERENCES `examinationdetail` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.prescriptiondetail
DROP TABLE IF EXISTS `prescriptiondetail`;
CREATE TABLE IF NOT EXISTS `prescriptiondetail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PrescriptionId` int(11) DEFAULT NULL,
  `MedicineId` int(11) DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_detail_prescription` (`PrescriptionId`),
  KEY `FK_detail_medicine` (`MedicineId`),
  CONSTRAINT `FK_detail_medicine` FOREIGN KEY (`MedicineId`) REFERENCES `medicine` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_detail_prescription` FOREIGN KEY (`PrescriptionId`) REFERENCES `prescription` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.profile
DROP TABLE IF EXISTS `profile`;
CREATE TABLE IF NOT EXISTS `profile` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerId` int(11) DEFAULT NULL,
  `Fullname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_profile_customer` (`CustomerId`),
  CONSTRAINT `FK_profile_customer` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.role
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Description` varchar(250) DEFAULT NULL,
  `Permissions` binary(60) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table appointment-schedual.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Fullname` varchar(50) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `RoleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_usre_role` (`RoleId`),
  CONSTRAINT `FK_usre_role` FOREIGN KEY (`RoleId`) REFERENCES `role` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
