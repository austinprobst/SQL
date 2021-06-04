-- MySQL dump 10.13  Distrib 5.7.23, for osx10.9 (x86_64)
--
-- Host: localhost    Database: medical
-- ------------------------------------------------------
-- Server version	5.7.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `specialization` varchar(50) NOT NULL,
  `acceptsMedicare` enum('Y','N') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Wagner K.','Family Medicine','Y'),(2,'Smith O.','Oncology','Y'),(3,'Peterson Y.','Internal Medicine','N'),(4,'Johnson J.','Nutritionist','Y');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first` varchar(25) NOT NULL,
  `last` varchar(35) NOT NULL,
  `hasInsurance` enum('Y','N') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'John','Adams','N'),(2,'Thomas','Jefferson','Y'),(3,'George','Washington','N'),(4,'Teddy','Roosvelt','Y');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doctor$id` int(10) unsigned NOT NULL,
  `patient$id` int(10) unsigned NOT NULL,
  `appointmentDate` date NOT NULL,
  `treatment` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor$id` (`doctor$id`),
  KEY `patient$id` (`patient$id`),
  CONSTRAINT `visits_ibfk_1` FOREIGN KEY (`doctor$id`) REFERENCES `doctor` (`id`),
  CONSTRAINT `visits_ibfk_2` FOREIGN KEY (`patient$id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
INSERT INTO `visits` VALUES (1,1,1,'2017-01-19','High Blood Pressure'),(2,4,4,'2016-12-26','Weight Gain'),(3,3,2,'2000-06-22','IBS'),(4,3,1,'2015-04-04','Ulcer'),(5,1,1,'2017-03-12','High Blood Pressure');
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;

select appointmentDate as 'Visit', treatment as 'Reason'
    from visits where doctor$id=1 && 2016 < Year(appointmentDate) < 2019;

select doctor.name, doctor.specialization, visits.treatment
    from doctor join visits on doctor.id=doctor$id
    where patient$id = 1;

*come back to #3*

select patients.first, patients.last as 'Patient',
    visits.appointmentDate as 'Date', visits.treatment as 'Condition',
    doctor.name as 'Doctor' from visits join patients.id=patient$id
    join doctor.id=doctor$id order by patients.last, visits.appointmentDate;

select doctor.name as 'Physician', patients.first, patients.last as 'Patient',
    from patients join doctor on patients.id = patient$id
    where hasInsurance = 'Y' order by patients.last;

select doctor.name as 'Dr', doctor.specialization as 'Specialty', 
    visits.appointmentDate as 'Visit', patient.first, patient.last as 
    'Patient' from patients join doctor on patients.id=patient$id 
    where doctor.specialization = 'Internal Medicine' or 'Family Medicine 
    order by doctor.specialization;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-20 23:47:24
