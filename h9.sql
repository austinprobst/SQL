-- MySQL dump 10.13  Distrib 5.7.23, for osx10.9 (x86_64)
--
-- Host: localhost    Database: vehicle
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


--***************
-- Austin Probst 
-- CS234
--***************


--
-- Table structure for table `manufacturer`
--

DROP TABLE IF EXISTS `manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacturer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `yearEstablished` int(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer`
--

LOCK TABLES `manufacturer` WRITE;
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
INSERT INTO `manufacturer` VALUES (1,'FORD',1901),(2,'GM',1898),(3,'CHRYSLER',1910);
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `models`
--

DROP TABLE IF EXISTS `models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `models` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manufacturer$id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `yearIntroduced` int(4) NOT NULL,
  `isInProduction` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `manufacturer$id` (`manufacturer$id`),
  CONSTRAINT `models_ibfk_1` FOREIGN KEY (`manufacturer$id`) REFERENCES `manufacturer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `models`
--

LOCK TABLES `models` WRITE;
/*!40000 ALTER TABLE `models` DISABLE KEYS */;
INSERT INTO `models` VALUES (1,1,'ESCORT',1982,'N'),(2,1,'F150',1960,'Y'),(3,1,'EXPLORER',1980,'Y'),(4,2,'ESCALADE',2005,'Y'),(5,2,'CAMARO',1980,'Y'),(6,2,'TRANS AM',1972,'N'),(7,3,'RAM',1989,'Y'),(8,3,'NEON',2000,'N'),(9,3,'VIPER',1993,'Y');
/*!40000 ALTER TABLE `models` ENABLE KEYS */;
UNLOCK TABLES;

select manufacturer.name, models.name from manufacturer join models on 
    -> manufacturer.id=manufacturer$id;

select manufacturer.name as Maker, models.name as Model
    -> from manufacturer join models on manufacturer.id=manufacturer$id;

select manufacturer.name as Maker, models.name as Model, 
    -> yearIntroduced as Year from manufacturer 
    -> join models on manufacturer.id=manufacturer$id
    -> order by yearIntroduced;

select manufacturer.name as Maker, models.name as Model,
    -> yearIntroduced as Year from manufacturer
    -> join models on manufacturer.id=manufacturer$id
    -> order by yearIntroduced, manufacturer.name, models.name;

select manufacturer.name as Maker, models.name as Discontinued
    -> from manufacturer join models on manufacturer.id=manufacturer$id
    -> where models.isInProduction = 'N' 
    -> order by manufacturer.name, models.name;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-18 22:49:42
