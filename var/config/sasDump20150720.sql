-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: sas
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

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
-- Table structure for table `archtradition`
--

DROP TABLE IF EXISTS `archtradition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archtradition` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `archtradition` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `archtradition` (`archtradition`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archtradition`
--

LOCK TABLES `archtradition` WRITE;
/*!40000 ALTER TABLE `archtradition` DISABLE KEYS */;
INSERT INTO `archtradition` VALUES (2,'Eastern'),(1,'Western');
/*!40000 ALTER TABLE `archtradition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archtraditionAttr`
--

DROP TABLE IF EXISTS `archtraditionAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archtraditionAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archtraditionAttr`
--

LOCK TABLES `archtraditionAttr` WRITE;
/*!40000 ALTER TABLE `archtraditionAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `archtraditionAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archtraditionProp`
--

DROP TABLE IF EXISTS `archtraditionProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archtraditionProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `archtraditionId` int(10) unsigned NOT NULL,
  `archtraditionAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `archtraditionId` (`archtraditionId`,`archtraditionAttrId`,`multi`),
  KEY `archtraditionAttrId` (`archtraditionAttrId`,`multi`,`value`),
  KEY `archtraditionAttrId_2` (`archtraditionAttrId`,`value`),
  CONSTRAINT `archtraditionProp_ibfk_1` FOREIGN KEY (`archtraditionId`) REFERENCES `archtradition` (`id`),
  CONSTRAINT `archtraditionProp_ibfk_2` FOREIGN KEY (`archtraditionAttrId`) REFERENCES `archtraditionAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archtraditionProp`
--

LOCK TABLES `archtraditionProp` WRITE;
/*!40000 ALTER TABLE `archtraditionProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `archtraditionProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `church`
--

DROP TABLE IF EXISTS `church`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `church` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `church` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parishId` int(10) unsigned NOT NULL DEFAULT '1',
  `religiousId` int(10) unsigned NOT NULL DEFAULT '1',
  `cityId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `church` (`church`,`parishId`,`religiousId`,`cityId`),
  KEY `parishId` (`parishId`),
  KEY `religiousId` (`religiousId`),
  KEY `cityId` (`cityId`),
  CONSTRAINT `church_ibfk_1` FOREIGN KEY (`parishId`) REFERENCES `parish` (`id`),
  CONSTRAINT `church_ibfk_2` FOREIGN KEY (`religiousId`) REFERENCES `religious` (`id`),
  CONSTRAINT `church_ibfk_3` FOREIGN KEY (`cityId`) REFERENCES `city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `church`
--

LOCK TABLES `church` WRITE;
/*!40000 ALTER TABLE `church` DISABLE KEYS */;
INSERT INTO `church` VALUES (2,'All Saints Catholic Church',26,1,1),(1,'Cathedral of the Immaculate Conception',25,1,1),(16,'Christ Our Light Catholic Church',37,1,3),(5,'Christ the King Roman Catholic Church',28,1,1),(15,'Church of St. Clare',36,1,2),(12,'Church of St. Vincent de Paul',34,1,1),(3,'Church of the Blessed Sacrament',27,1,1),(13,'Grotto of Our Lady of Lourdes',34,1,1),(11,'Historic St. Mary\'s Church on Capitol Hill',33,1,1),(14,'Korean Catholic Apostolate',35,1,2),(6,'Parish of Mater Christi',29,1,1),(7,'Sacred Heart of Jesus Church',30,1,1),(4,'Shrine Church of Our Lady of the Americas',27,1,1),(18,'St. Francis Chapel',1,25,2),(9,'St. Francis of Assisi Parish, Delaware Ave. Community',32,1,1),(10,'St. Francis of Assisi Parish, South End Community',32,1,1),(17,'St. Pius X Catholic Church',38,1,3),(8,'Vietnamese Catholic Apostolate',31,1,1);
/*!40000 ALTER TABLE `church` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `churchAttr`
--

DROP TABLE IF EXISTS `churchAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `churchAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `churchAttr`
--

LOCK TABLES `churchAttr` WRITE;
/*!40000 ALTER TABLE `churchAttr` DISABLE KEYS */;
INSERT INTO `churchAttr` VALUES (1,'isParish',1),(2,'isCathedral',1),(3,'isBasilica',1),(4,'isShrine',1),(5,'isMission',1),(6,'territoryId',1),(7,'streetNote',1),(8,'street',3),(9,'zip',1),(10,'site',1),(11,'nickname',1);
/*!40000 ALTER TABLE `churchAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `churchProp`
--

DROP TABLE IF EXISTS `churchProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `churchProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `churchId` int(10) unsigned NOT NULL,
  `churchAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `churchId` (`churchId`,`churchAttrId`,`multi`),
  KEY `churchAttrId` (`churchAttrId`,`multi`,`value`),
  KEY `churchAttrId_2` (`churchAttrId`,`value`),
  CONSTRAINT `churchProp_ibfk_1` FOREIGN KEY (`churchId`) REFERENCES `church` (`id`),
  CONSTRAINT `churchProp_ibfk_2` FOREIGN KEY (`churchAttrId`) REFERENCES `churchAttr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `churchProp`
--

LOCK TABLES `churchProp` WRITE;
/*!40000 ALTER TABLE `churchProp` DISABLE KEYS */;
INSERT INTO `churchProp` VALUES (1,1,1,1,'parish'),(2,1,2,1,'cathedral'),(3,1,8,1,'125 Eagle Street'),(4,1,9,1,'12202'),(5,1,10,1,'http://cathedralic.com/'),(6,1,11,1,'Immaculate Conception'),(7,2,1,1,'parish'),(8,2,8,1,'16 Homestead Street'),(9,2,9,1,'12203'),(10,2,10,1,'http://rcda.org/churches/AllSaints/'),(11,2,11,1,'All Saints'),(12,3,1,1,'parish'),(13,3,8,1,'607 Central Avenue'),(14,3,9,1,'12206'),(15,3,10,1,'http://blessedsacramentalbany.org/'),(16,3,11,1,'Blessed Sacrament'),(17,4,4,1,'diocesean'),(18,4,8,1,'273 Central Avenue'),(19,4,9,1,'12206'),(20,4,10,1,'http://ourladyoftheamericas.weebly.com/'),(21,4,11,1,'Our Lady of the Americas'),(22,4,5,1,'1'),(23,5,1,1,'parish'),(24,5,8,1,'20 Sumter Avenue'),(25,5,9,1,'12203'),(26,5,10,1,'http://www.ctkparishny.org/'),(27,5,11,1,'Christ the King'),(28,6,1,1,'parish'),(29,6,8,1,'40 Hopewell Street'),(30,6,9,1,'12208'),(31,6,10,1,'http://rcda.org/churches/MaterChristi/'),(32,6,11,1,'Mater Christi'),(33,7,1,1,'parish'),(34,7,8,1,'33 Walter Street'),(35,7,9,1,'12204'),(36,7,10,1,'http://rcda.org/churches/sacredheartofjesus/'),(37,7,11,1,'Sacred Heart'),(38,8,1,1,'parish'),(39,8,8,1,'33 Walter Street'),(40,8,9,1,'12204'),(41,8,10,1,'http://www.vietnamesecatholiccommunityalbany.org/'),(42,8,11,1,'Vietnamese Apostolate'),(43,9,1,1,'parish'),(44,9,8,1,'391 Delaware Avenue'),(45,9,9,1,'12209'),(46,9,10,1,'http://rcda.org/churches/stfrancisofassisi/'),(47,9,11,1,'St. Francis Delaware Ave.'),(48,10,1,1,'co-parish'),(49,10,8,1,'88 Fourth Avenue'),(50,10,9,1,'12202'),(51,10,10,1,'http://rcda.org/churches/stfrancisofassisi/'),(52,10,11,1,'St. Francis South End'),(53,11,1,1,'parish'),(54,11,8,1,'10 Lodge Street'),(55,11,9,1,'12207'),(56,11,10,1,'http://www.hist-stmarys.org/'),(57,11,11,1,'St. Mary'),(58,12,1,1,'parish'),(59,12,8,1,'900 Madison Avenue'),(60,12,9,1,'12208'),(61,12,10,1,'http://www.stvincentalbany.org/'),(62,12,11,1,'St. Vincent'),(63,13,8,1,'481 Yates Street'),(64,13,9,1,'12208'),(65,13,10,1,'http://www.stvincentalbany.org/'),(66,13,11,1,'Our Lady of Lourdes'),(67,14,1,1,'parish'),(68,14,8,1,'17 Exchange Street'),(69,14,9,1,'12205'),(70,14,10,1,'http://www.kccalbany.org/xe/home/'),(71,14,11,1,'Korean Apostolate'),(72,15,1,1,'parish'),(73,15,8,1,'1947 Central Avenue'),(74,15,9,1,'12205'),(75,15,10,1,'http://stclares.nycap.rr.com/'),(76,15,11,1,'St. Clare'),(77,16,1,1,'parish'),(78,16,8,1,'1 Maria Drive'),(79,16,9,1,'12211'),(80,16,10,1,'http://www.christourlightchurch.org/'),(81,16,11,1,'Christ Our Light'),(82,17,1,1,'parish'),(83,17,8,1,'23 Crumitie Road'),(84,17,9,1,'12211'),(85,17,10,1,'http://www.stpiusxloudonville.org/'),(86,17,11,1,'St. Pius X'),(87,18,6,1,'67'),(88,18,8,1,'Wolf Road Shopper\'s Park'),(89,18,9,1,'12205'),(90,18,10,1,'https://sites.google.com/site/stfrancischapel/'),(91,18,11,1,'St. Francis'),(92,18,8,2,'145 Wolf Road');
/*!40000 ALTER TABLE `churchProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `countyId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `city` (`city`,`countyId`),
  KEY `countyId` (`countyId`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`countyId`) REFERENCES `county` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Albany',1),(2,'Colonie',1),(3,'Loudonville',1);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cityAttr`
--

DROP TABLE IF EXISTS `cityAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cityAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cityAttr`
--

LOCK TABLES `cityAttr` WRITE;
/*!40000 ALTER TABLE `cityAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `cityAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cityProp`
--

DROP TABLE IF EXISTS `cityProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cityProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cityId` int(10) unsigned NOT NULL,
  `cityAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cityId` (`cityId`,`cityAttrId`,`multi`),
  KEY `cityAttrId` (`cityAttrId`,`multi`,`value`),
  KEY `cityAttrId_2` (`cityAttrId`,`value`),
  CONSTRAINT `cityProp_ibfk_1` FOREIGN KEY (`cityId`) REFERENCES `city` (`id`),
  CONSTRAINT `cityProp_ibfk_2` FOREIGN KEY (`cityAttrId`) REFERENCES `cityAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cityProp`
--

LOCK TABLES `cityProp` WRITE;
/*!40000 ALTER TABLE `cityProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `cityProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `continent`
--

DROP TABLE IF EXISTS `continent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `continent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `continent` (`continent`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continent`
--

LOCK TABLES `continent` WRITE;
/*!40000 ALTER TABLE `continent` DISABLE KEYS */;
INSERT INTO `continent` VALUES (4,'Africa'),(7,'Antarctica'),(5,'Asia'),(6,'Australia'),(3,'Europe'),(1,'North America'),(2,'South America');
/*!40000 ALTER TABLE `continent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `continentAttr`
--

DROP TABLE IF EXISTS `continentAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continentAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continentAttr`
--

LOCK TABLES `continentAttr` WRITE;
/*!40000 ALTER TABLE `continentAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `continentAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `continentProp`
--

DROP TABLE IF EXISTS `continentProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continentProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `continentId` int(10) unsigned NOT NULL,
  `continentAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `continentId` (`continentId`,`continentAttrId`,`multi`),
  KEY `continentAttrId` (`continentAttrId`,`multi`,`value`),
  KEY `continentAttrId_2` (`continentAttrId`,`value`),
  CONSTRAINT `continentProp_ibfk_1` FOREIGN KEY (`continentId`) REFERENCES `continent` (`id`),
  CONSTRAINT `continentProp_ibfk_2` FOREIGN KEY (`continentAttrId`) REFERENCES `continentAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continentProp`
--

LOCK TABLES `continentProp` WRITE;
/*!40000 ALTER TABLE `continentProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `continentProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country2` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `country3` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `continentId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `country2` (`country2`),
  UNIQUE KEY `country3` (`country3`),
  UNIQUE KEY `country` (`country`),
  KEY `continentId` (`continentId`),
  CONSTRAINT `country_ibfk_1` FOREIGN KEY (`continentId`) REFERENCES `continent` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'US','USA','United States',1);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countryAttr`
--

DROP TABLE IF EXISTS `countryAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countryAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countryAttr`
--

LOCK TABLES `countryAttr` WRITE;
/*!40000 ALTER TABLE `countryAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `countryAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countryProp`
--

DROP TABLE IF EXISTS `countryProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countryProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `countryId` int(10) unsigned NOT NULL,
  `countryAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `countryId` (`countryId`,`countryAttrId`,`multi`),
  KEY `countryAttrId` (`countryAttrId`,`multi`,`value`),
  KEY `countryAttrId_2` (`countryAttrId`,`value`),
  CONSTRAINT `countryProp_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `country` (`id`),
  CONSTRAINT `countryProp_ibfk_2` FOREIGN KEY (`countryAttrId`) REFERENCES `countryAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countryProp`
--

LOCK TABLES `countryProp` WRITE;
/*!40000 ALTER TABLE `countryProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `countryProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `county`
--

DROP TABLE IF EXISTS `county`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `county` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `county` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stateId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `county` (`county`,`stateId`),
  KEY `stateId` (`stateId`),
  CONSTRAINT `county_ibfk_1` FOREIGN KEY (`stateId`) REFERENCES `state` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `county`
--

LOCK TABLES `county` WRITE;
/*!40000 ALTER TABLE `county` DISABLE KEYS */;
INSERT INTO `county` VALUES (1,'Albany',33);
/*!40000 ALTER TABLE `county` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countyAttr`
--

DROP TABLE IF EXISTS `countyAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countyAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countyAttr`
--

LOCK TABLES `countyAttr` WRITE;
/*!40000 ALTER TABLE `countyAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `countyAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countyProp`
--

DROP TABLE IF EXISTS `countyProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countyProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `countyId` int(10) unsigned NOT NULL,
  `countyAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `countyId` (`countyId`,`countyAttrId`,`multi`),
  KEY `countyAttrId` (`countyAttrId`,`multi`,`value`),
  KEY `countyAttrId_2` (`countyAttrId`,`value`),
  CONSTRAINT `countyProp_ibfk_1` FOREIGN KEY (`countyId`) REFERENCES `county` (`id`),
  CONSTRAINT `countyProp_ibfk_2` FOREIGN KEY (`countyAttrId`) REFERENCES `countyAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countyProp`
--

LOCK TABLES `countyProp` WRITE;
/*!40000 ALTER TABLE `countyProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `countyProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day`
--

DROP TABLE IF EXISTS `day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `day` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `day` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `day` (`day`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day`
--

LOCK TABLES `day` WRITE;
/*!40000 ALTER TABLE `day` DISABLE KEYS */;
INSERT INTO `day` VALUES (6,'Friday'),(2,'Monday'),(7,'Saturday'),(1,'Sunday'),(5,'Thursday'),(3,'Tuesday'),(4,'Wednesday');
/*!40000 ALTER TABLE `day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dayAttr`
--

DROP TABLE IF EXISTS `dayAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dayAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dayAttr`
--

LOCK TABLES `dayAttr` WRITE;
/*!40000 ALTER TABLE `dayAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `dayAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dayProp`
--

DROP TABLE IF EXISTS `dayProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dayProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dayId` int(10) unsigned NOT NULL,
  `dayAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dayId` (`dayId`,`dayAttrId`,`multi`),
  KEY `dayAttrId` (`dayAttrId`,`multi`,`value`),
  KEY `dayAttrId_2` (`dayAttrId`,`value`),
  CONSTRAINT `dayProp_ibfk_1` FOREIGN KEY (`dayId`) REFERENCES `day` (`id`),
  CONSTRAINT `dayProp_ibfk_2` FOREIGN KEY (`dayAttrId`) REFERENCES `dayAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dayProp`
--

LOCK TABLES `dayProp` WRITE;
/*!40000 ALTER TABLE `dayProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dayProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diocese`
--

DROP TABLE IF EXISTS `diocese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diocese` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `diocese` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provinceId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `diocese` (`diocese`),
  KEY `provinceId` (`provinceId`),
  CONSTRAINT `diocese_ibfk_1` FOREIGN KEY (`provinceId`) REFERENCES `province` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diocese`
--

LOCK TABLES `diocese` WRITE;
/*!40000 ALTER TABLE `diocese` DISABLE KEYS */;
INSERT INTO `diocese` VALUES (1,NULL,1),(2,NULL,2),(3,NULL,3),(4,NULL,4),(5,NULL,5),(6,NULL,6),(7,NULL,7),(8,NULL,8),(9,NULL,9),(10,NULL,10),(11,NULL,11),(12,NULL,12),(13,NULL,13),(14,NULL,14),(15,NULL,15),(16,NULL,16),(17,NULL,17),(18,NULL,18),(19,NULL,19),(20,NULL,20),(21,NULL,21),(22,NULL,22),(23,NULL,23),(24,NULL,24),(25,'Archdiocese of Anchorage',25),(26,'Archdiocese of Atlanta',26),(27,'Archdiocese of Baltimore',27),(28,'Archdiocese of Boston',28),(29,'Archdiocese of Chicago',29),(30,'Archdiocese of Cincinatti',30),(31,'Archdiocese of Denver',31),(32,'Archdiocese of Detroit',32),(33,'Archdiocese of Dubuque',33),(34,'Archdiocese of Galveston-Houston',34),(35,'Archdiocese of Indianapolis',35),(36,'Archdiocese of Hartford',36),(37,'Archdiocese of Kansas City in Kansas',37),(38,'Archdiocese of Los Angeles',38),(39,'Archdiocese of Louisville',39),(40,'Archdiocese of Miami',40),(41,'Archdiocese of Milwaukee',41),(42,'Archdiocese of Mobile',42),(43,'Archdiocese of New Orleans',43),(44,'Archdiocese of New York',44),(45,'Archdiocese of Newark',45),(46,'Archdiocese of Oklahoma City',46),(47,'Archdiocese of Omaha',47),(48,'Archdiocese of Philadelphia',48),(49,'Archdiocese of Portland in Oregon',49),(50,'Archdiocese of San Antonio',50),(51,'Archdiocese of San Francisco',51),(52,'Archdiocese of Santa Fe',52),(53,'Archdiocese of Seattle',53),(54,'Archdiocese of St. Louis',54),(55,'Archdiocese of St. Paul and Minneapolis',55),(56,'Archdiocese of Washington',56),(57,'Archdiocese of the Military Services',1),(58,'Diocese of Burlington',28),(59,'Diocese of Fall River',28),(60,'Diocese of Machester',28),(61,'Diocese of Portland in Maine',28),(62,'Diocese of Springfield in Massachusetts',28),(63,'Diocese of Worcester',28),(64,'Diocese of Bridgeport',36),(65,'Diocese of Norwich',36),(66,'Diocese of Providence',36),(67,'Diocese of Albany',44),(68,'Diocese of Brooklyn',44),(69,'Diocese of Buffalo',44),(70,'Diocese of Ogdensburg',44),(71,'Diocese of Rochester',44),(72,'Diocese of Rockville Centre',44),(73,'Diocese of Syracuse',44),(74,'Diocese of Camden',45),(75,'Diocese of Metuchen',45),(76,'Diocese of Paterson',45),(77,'Diocese of Trenton',45),(78,'Diocese of Allentown',48),(79,'Diocese of Altoona-Johnstown',48),(80,'Diocese of Erie',48),(81,'Diocese of Greensburg',48),(82,'Diocese of Harrisburg',48),(83,'Diocese of Pittsburgh',48),(84,'Diocese of Scranton',48),(85,'Diocese of Arlington',27),(86,'Diocese of Richmond',27),(87,'Diocese of Wheeling-Charleston',27),(88,'Diocese of Wilmington',27),(89,'Diocese of Saint Thomas',56),(90,'Diocese of Covington',39),(91,'Diocese of Knoxville',39),(92,'Diocese of Lexington',39),(93,'Diocese of Memphis',39),(94,'Diocese of Nashville',39),(95,'Diocese of Owensboro',39),(96,'Diocese of Biloxi',42),(97,'Diocese of Birmingham in Alabama',42),(98,'Diocese of Jackson',42),(99,'Diocese of Alexandria in Louisiana',43),(100,'Diocese of Baton Rouge',43),(101,'Diocese of Houma-Thibodaux',43),(102,'Diocese of Layfayette in Louisiana',43),(103,'Diocese of Lake Charles',43),(104,'Diocese of Shreveport',43),(105,'Diocese of Cleveland',30),(106,'Diocese of Columbus',30),(107,'Diocese of Steubenville',30),(108,'Diocese of Toledo',30),(109,'Diocese of Youngstown',30),(110,'Diocese of Gaylord',32),(111,'Diocese of Grand Rapids',32),(112,'Diocese of Kalamazoo',32),(113,'Diocese of Lansing',32),(114,'Diocese of Marquette',32),(115,'Diocese of Saginaw',32),(116,'Diocese of Belleville',29),(117,'Diocese of Joliet in Illinois',29),(118,'Diocese of Peoria',29),(119,'Diocese of Rockford',29),(120,'Diocese of Springfield in Illinois',29),(121,'Diocese of Evansville',35),(122,'Diocese of Fort Wayne-South Bend',35),(123,'Diocese of Gary',35),(124,'Diocese of Lafayette in Indiana',35),(125,'Diocese of Green Bay',41),(126,'Diocese of La Crosse',41),(127,'Diocese of Madison',41),(128,'Diocese of Superior',41),(129,'Diocese of Bismark',55),(130,'Diocese of Crookston',55),(131,'Diocese of Duluth',55),(132,'Diocese of Fargo',55),(133,'Diocese of New Ulm',55),(134,'Diocese of Rapid City',55),(135,'Diocese of St. Cloud',55),(136,'Diocese of Sioux Falls',55),(137,'Diocese of Winona',55),(138,'Diocese of Davenport',33),(139,'Diocese of Des Moines',33),(140,'Diocese of Sioux City',33),(141,'Diocese of Dodge City',37),(142,'Diocese of Salina',37),(143,'Diocese of Wichita',37),(144,'Diocese of Grand Island',47),(145,'Diocese of Lincoln',47),(146,'Diocese of Jefferson City',54),(147,'Diocese of Kansas City-St. Joseph',54),(148,'Diocese of Springfield-Cape Girardeau',54),(149,'Diocese of Austin',34),(150,'Diocese of Beaumont',34),(151,'Diocese of Brownsville',34),(152,'Diocese of Corpus Christi',34),(153,'Diocese of Tyler',34),(154,'Diocese of Victoria in Texas',34),(155,'Diocese of Amarillo',50),(156,'Diocese of Dallas',50),(157,'Diocese of El Paso',50),(158,'Diocese of Fort Worth',50),(159,'Diocese of Laredo',50),(160,'Diocese of Lubbock',50),(161,'Diocese of San Angelo',50),(162,'Diocese of Little Rock',46),(163,'Diocese of Tulsa',46),(164,'Diocese of Fresno',38),(165,'Diocese of Monterey',38),(166,'Diocese of Orange in California',38),(167,'Diocese of San Bernardino',38),(168,'Diocese of San Diego',38),(169,'Diocese of Honolulu',51),(170,'Diocese of Las Vegas',51),(171,'Diocese of Oakland',51),(172,'Diocese of Reno',51),(173,'Diocese of Sacramento',51),(174,'Diocese of Salt Lake City',51),(175,'Diocese of San Jose in California',51),(176,'Diocese of Santa Rosa in California',51),(177,'Diocese of Stockton',51),(178,'Diocese of Fairbanks',25),(179,'Diocese of Juneau',25),(180,'Diocese of Baker',49),(181,'Diocese of Boise',49),(182,'Diocese of Great Falls-Billings',49),(183,'Diocese of Helena',49),(184,'Diocese of Spokane',53),(185,'Diocese of Yakima',53),(186,'Diocese of Cheyenne',31),(187,'Diocese of Colorado Springs',31),(188,'Diocese of Pueblo',31),(189,'Diocese of Gallup',52),(190,'Diocese of Las Cruces',52),(191,'Diocese of Phoenix',52),(192,'Diocese of Tucson',52),(193,'Diocese of Orlando',40),(194,'Diocese of Palm Beach',40),(195,'Diocese of Pensacola-Tallahassee',40),(196,'Diocese of St. Augustine',40),(197,'Diocese of St. Petersburg',40),(198,'Diocese of Venice in Florida',40),(199,'Diocese of Charleston',26),(200,'Diocese of Charlotte',26),(201,'Diocese of Raleigh',26),(202,'Diocese of Savannah',26),(203,'Archeparchy of Philadelphia',57),(204,'Archeparchy of Pittsburgh',58),(205,'Eparchy of St. Nicholas in Chicago',57),(206,'Eparchy of St. Josaphat in Parma ',57),(207,'Eparchy of Stamford',57),(208,'Eparchy of Parma',58),(209,'Eparchy of Passaic',58),(210,'Holy Protection of Mary Eparchy of Phoenix',58),(211,'St. Thomas Eparchy of Chicago',3),(212,'Eparchy of St. Maron in Brooklyn',4),(213,'Eparchy of Our Lady of Lebanon in Los Angeles',4),(214,'Eparchy of Newton',5),(215,'Eparchy of Our Lady of Nareg in Glendale',7),(216,'Eparchy of St. Peter the Apostle in San Diego',8),(217,'Eparchy of St. Thomas the Apostle in Detroit',8),(218,'Eparchy of St. George in Canton',14),(219,'Eparchy of Our Lady of Deliverance in Newark',15);
/*!40000 ALTER TABLE `diocese` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dioceseAttr`
--

DROP TABLE IF EXISTS `dioceseAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dioceseAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dioceseAttr`
--

LOCK TABLES `dioceseAttr` WRITE;
/*!40000 ALTER TABLE `dioceseAttr` DISABLE KEYS */;
INSERT INTO `dioceseAttr` VALUES (1,'isArch',1),(2,'isMetro',1);
/*!40000 ALTER TABLE `dioceseAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dioceseProp`
--

DROP TABLE IF EXISTS `dioceseProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dioceseProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dioceseId` int(10) unsigned NOT NULL,
  `dioceseAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dioceseId` (`dioceseId`,`dioceseAttrId`,`multi`),
  KEY `dioceseAttrId` (`dioceseAttrId`,`multi`,`value`),
  KEY `dioceseAttrId_2` (`dioceseAttrId`,`value`),
  CONSTRAINT `dioceseProp_ibfk_1` FOREIGN KEY (`dioceseId`) REFERENCES `diocese` (`id`),
  CONSTRAINT `dioceseProp_ibfk_2` FOREIGN KEY (`dioceseAttrId`) REFERENCES `dioceseAttr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dioceseProp`
--

LOCK TABLES `dioceseProp` WRITE;
/*!40000 ALTER TABLE `dioceseProp` DISABLE KEYS */;
INSERT INTO `dioceseProp` VALUES (1,25,1,1,'1'),(2,26,1,1,'1'),(3,27,1,1,'1'),(4,28,1,1,'1'),(5,29,1,1,'1'),(6,30,1,1,'1'),(7,31,1,1,'1'),(8,32,1,1,'1'),(9,33,1,1,'1'),(10,34,1,1,'1'),(11,35,1,1,'1'),(12,36,1,1,'1'),(13,37,1,1,'1'),(14,38,1,1,'1'),(15,39,1,1,'1'),(16,40,1,1,'1'),(17,41,1,1,'1'),(18,42,1,1,'1'),(19,43,1,1,'1'),(20,44,1,1,'1'),(21,45,1,1,'1'),(22,46,1,1,'1'),(23,47,1,1,'1'),(24,48,1,1,'1'),(25,49,1,1,'1'),(26,50,1,1,'1'),(27,51,1,1,'1'),(28,52,1,1,'1'),(29,53,1,1,'1'),(30,54,1,1,'1'),(31,55,1,1,'1'),(32,56,1,1,'1'),(33,57,1,1,'1'),(34,25,2,1,'1'),(35,26,2,1,'1'),(36,27,2,1,'1'),(37,28,2,1,'1'),(38,29,2,1,'1'),(39,30,2,1,'1'),(40,31,2,1,'1'),(41,32,2,1,'1'),(42,33,2,1,'1'),(43,34,2,1,'1'),(44,35,2,1,'1'),(45,36,2,1,'1'),(46,37,2,1,'1'),(47,38,2,1,'1'),(48,39,2,1,'1'),(49,40,2,1,'1'),(50,41,2,1,'1'),(51,42,2,1,'1'),(52,43,2,1,'1'),(53,44,2,1,'1'),(54,45,2,1,'1'),(55,46,2,1,'1'),(56,47,2,1,'1'),(57,48,2,1,'1'),(58,49,2,1,'1'),(59,50,2,1,'1'),(60,51,2,1,'1'),(61,52,2,1,'1'),(62,53,2,1,'1'),(63,54,2,1,'1'),(64,55,2,1,'1'),(65,56,2,1,'1'),(66,203,1,1,'1'),(67,204,1,1,'1'),(68,203,2,1,'1'),(69,204,2,1,'1');
/*!40000 ALTER TABLE `dioceseProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `eventTypeId` int(10) unsigned NOT NULL,
  `eventFilterId` int(10) unsigned NOT NULL DEFAULT '1',
  `churchId` int(10) unsigned NOT NULL,
  `startDate` date NOT NULL DEFAULT '2000-01-01',
  `stopDate` date NOT NULL DEFAULT '3000-01-01',
  `startMonth` int(10) unsigned NOT NULL DEFAULT '1',
  `stopMonth` int(10) unsigned NOT NULL DEFAULT '12',
  `startWeek` int(10) unsigned NOT NULL DEFAULT '1',
  `stopWeek` int(10) unsigned NOT NULL DEFAULT '5',
  `startDay` int(10) unsigned NOT NULL DEFAULT '1',
  `stopDay` int(10) unsigned NOT NULL DEFAULT '7',
  `startTime` time NOT NULL DEFAULT '00:00:00',
  `stopTime` time NOT NULL DEFAULT '24:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `event` (`event`,`eventTypeId`,`eventFilterId`,`churchId`,`startDate`,`stopDate`,`startMonth`,`stopMonth`,`startWeek`,`stopWeek`,`startDay`,`stopDay`,`startTime`,`stopTime`),
  KEY `churchId` (`churchId`),
  KEY `startMonth` (`startMonth`),
  KEY `stopMonth` (`stopMonth`),
  KEY `startWeek` (`startWeek`),
  KEY `stopWeek` (`stopWeek`),
  KEY `stopDay` (`stopDay`),
  KEY `eventFilterId` (`eventFilterId`),
  KEY `startTime` (`startTime`,`stopTime`,`id`),
  KEY `startDay_2` (`startDay`,`stopDay`,`startTime`,`stopTime`,`id`),
  KEY `eventTypeId_2` (`eventTypeId`,`startTime`,`stopTime`,`id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`eventTypeId`) REFERENCES `eventType` (`id`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`churchId`) REFERENCES `church` (`id`),
  CONSTRAINT `event_ibfk_3` FOREIGN KEY (`startMonth`) REFERENCES `month` (`id`),
  CONSTRAINT `event_ibfk_4` FOREIGN KEY (`stopMonth`) REFERENCES `month` (`id`),
  CONSTRAINT `event_ibfk_5` FOREIGN KEY (`startWeek`) REFERENCES `week` (`id`),
  CONSTRAINT `event_ibfk_6` FOREIGN KEY (`stopWeek`) REFERENCES `week` (`id`),
  CONSTRAINT `event_ibfk_7` FOREIGN KEY (`startDay`) REFERENCES `day` (`id`),
  CONSTRAINT `event_ibfk_8` FOREIGN KEY (`stopDay`) REFERENCES `day` (`id`),
  CONSTRAINT `event_ibfk_9` FOREIGN KEY (`eventFilterId`) REFERENCES `eventFilter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (81,'',1,1,2,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(82,'',1,1,2,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:30:00','11:30:00'),(84,'',1,1,2,'2000-01-01','3000-01-01',1,12,1,5,2,5,'09:00:00','09:30:00'),(83,'',1,1,2,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(131,'',1,1,5,'2000-01-01','3000-01-01',1,12,1,1,7,7,'09:00:00','09:30:00'),(127,'',1,1,5,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(128,'',1,1,5,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(129,'',1,1,5,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(132,'',1,1,5,'2000-01-01','3000-01-01',1,12,1,5,2,4,'09:00:00','09:30:00'),(133,'',1,1,5,'2000-01-01','3000-01-01',1,12,1,5,6,6,'09:00:00','09:30:00'),(130,'',1,1,5,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(151,'',1,1,7,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(152,'',1,1,8,'2000-01-01','3000-01-01',1,12,1,1,1,1,'10:30:00','11:30:00'),(153,'',1,1,9,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(154,'',1,1,9,'2000-01-01','3000-01-01',1,12,1,5,1,1,'19:30:00','20:30:00'),(155,'',1,1,9,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(156,'',1,1,10,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:30:00','11:30:00'),(115,'',1,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'07:00:00','08:00:00'),(116,'',1,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:30:00','09:30:00'),(117,'',1,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(118,'',1,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:30:00','12:30:00'),(120,'',1,1,11,'2000-01-01','3000-01-01',1,12,1,5,2,6,'07:00:00','07:30:00'),(121,'',1,1,11,'2000-01-01','3000-01-01',1,12,1,5,2,7,'12:05:00','12:35:00'),(119,'',1,1,11,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(158,'',1,1,12,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:30:00','09:30:00'),(159,'',1,1,12,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:00:00','12:00:00'),(160,'',1,1,12,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:00:00','18:00:00'),(161,'',1,1,14,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(162,'',1,1,15,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:30:00','09:30:00'),(163,'',1,1,15,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:30:00','11:30:00'),(165,'',1,1,15,'2000-01-01','3000-01-01',1,12,1,5,3,5,'08:00:00','08:30:00'),(164,'',1,1,15,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(31,'',1,2,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(34,'',1,2,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:00:00','12:00:00'),(37,'',1,2,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'17:00:00','18:00:00'),(46,'',1,2,1,'2000-01-01','3000-01-01',1,12,1,5,2,6,'07:15:00','07:45:00'),(45,'',1,2,1,'2000-01-01','3000-01-01',1,12,1,5,2,6,'12:15:00','12:45:00'),(47,'',1,2,1,'2000-01-01','3000-01-01',1,12,1,5,7,7,'09:00:00','09:30:00'),(40,'',1,2,1,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:15:00','18:15:00'),(135,'',1,2,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(136,'',1,2,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(137,'',1,2,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:30:00','12:30:00'),(147,'',1,2,6,'2000-01-01','3000-01-01',1,12,1,5,2,6,'08:15:00','08:45:00'),(138,'',1,2,6,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(51,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,2,2,'10:00:00','10:30:00'),(52,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,2,2,'12:10:00','12:40:00'),(53,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,2,2,'18:00:00','18:30:00'),(54,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,3,3,'10:00:00','10:30:00'),(55,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,3,3,'12:10:00','12:40:00'),(56,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,3,3,'18:00:00','18:30:00'),(57,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,4,4,'10:00:00','10:30:00'),(58,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,4,4,'12:10:00','12:40:00'),(59,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,4,4,'18:00:00','18:30:00'),(60,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,5,5,'10:00:00','10:30:00'),(61,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,5,5,'12:10:00','12:40:00'),(62,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,5,5,'18:00:00','18:30:00'),(63,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,6,6,'10:00:00','10:30:00'),(64,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,6,6,'12:10:00','12:40:00'),(65,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,6,6,'18:00:00','18:30:00'),(66,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,7,7,'10:00:00','10:30:00'),(67,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,7,7,'12:10:00','12:40:00'),(68,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(69,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:30:00','18:30:00'),(70,'',1,2,18,'2000-01-01','3000-01-01',1,12,1,5,7,7,'19:00:00','20:00:00'),(32,'',1,3,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(35,'',1,3,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:00:00','12:00:00'),(38,'',1,3,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'17:00:00','18:00:00'),(44,'',1,3,1,'2000-01-01','3000-01-01',1,12,1,5,2,7,'07:15:00','08:15:00'),(43,'',1,3,1,'2000-01-01','3000-01-01',1,12,1,5,2,7,'12:15:00','13:15:00'),(41,'',1,3,1,'2000-01-01','3000-01-01',1,12,1,5,2,7,'17:15:00','18:15:00'),(99,'',1,3,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(100,'',1,3,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:30:00','11:30:00'),(101,'',1,3,3,'2000-01-01','3000-01-01',1,12,1,5,1,6,'12:00:00','13:00:00'),(104,'',1,3,3,'2000-01-01','3000-01-01',1,12,1,5,2,6,'07:00:00','08:00:00'),(105,'',1,3,3,'2000-01-01','3000-01-01',1,12,1,5,2,7,'10:00:00','11:00:00'),(102,'',1,3,3,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(103,'',1,3,3,'2000-01-01','3000-01-01',1,12,1,5,7,7,'19:00:00','20:00:00'),(139,'',1,3,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(140,'',1,3,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(141,'',1,3,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:30:00','12:30:00'),(148,'',1,3,6,'2000-01-01','3000-01-01',1,12,1,5,2,6,'08:15:00','09:15:00'),(149,'',1,3,6,'2000-01-01','3000-01-01',1,12,1,5,2,6,'09:00:00','10:00:00'),(142,'',1,3,6,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(191,'',1,3,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(195,'',1,3,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(199,'',1,3,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(207,'',1,3,17,'2000-01-01','3000-01-01',1,12,1,5,2,6,'06:30:00','07:30:00'),(210,'',1,3,17,'2000-01-01','3000-01-01',1,12,1,5,2,7,'09:00:00','10:00:00'),(203,'',1,3,17,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:00:00','18:00:00'),(77,'',1,3,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'10:00:00','11:00:00'),(78,'',1,3,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'11:00:00','12:00:00'),(79,'',1,3,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'12:10:00','13:10:00'),(74,'',1,3,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'16:00:00','17:00:00'),(75,'',1,3,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'17:30:00','18:30:00'),(76,'',1,3,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'19:00:00','20:00:00'),(33,'',1,4,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(36,'',1,4,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:00:00','12:00:00'),(39,'',1,4,1,'2000-01-01','3000-01-01',1,12,1,5,1,1,'17:00:00','18:00:00'),(42,'',1,4,1,'2000-01-01','3000-01-01',1,12,1,5,2,7,'17:15:00','18:15:00'),(143,'',1,4,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(144,'',1,4,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(145,'',1,4,6,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:30:00','12:30:00'),(150,'',1,4,6,'2000-01-01','3000-01-01',1,12,1,5,2,6,'17:30:00','18:30:00'),(146,'',1,4,6,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(192,'',1,4,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(196,'',1,4,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(200,'',1,4,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(208,'',1,4,17,'2000-01-01','3000-01-01',1,12,1,5,2,6,'06:30:00','07:00:00'),(214,'',1,4,17,'2000-01-01','3000-01-01',1,12,1,5,2,6,'18:00:00','19:00:00'),(211,'',1,4,17,'2000-01-01','3000-01-01',1,12,1,5,2,7,'09:00:00','09:30:00'),(204,'',1,4,17,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:00:00','18:00:00'),(71,'',1,4,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'16:00:00','17:00:00'),(72,'',1,4,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'17:30:00','18:30:00'),(73,'',1,4,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'19:00:00','20:00:00'),(94,'',1,5,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(95,'',1,5,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:30:00','11:30:00'),(96,'',1,5,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(92,'',1,5,3,'2000-01-01','3000-01-01',1,12,1,5,2,6,'09:00:00','09:30:00'),(97,'',1,5,3,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(98,'',1,5,3,'2000-01-01','3000-01-01',1,12,1,5,7,7,'19:00:00','20:00:00'),(193,'',1,5,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(197,'',1,5,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(201,'',1,5,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(212,'',1,5,17,'2000-01-01','3000-01-01',1,12,1,5,2,7,'09:00:00','09:30:00'),(205,'',1,5,17,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:00:00','18:00:00'),(112,'',1,7,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:30:00','10:30:00'),(114,'',1,7,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(167,'',1,7,16,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(169,'',1,7,16,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:15:00','12:15:00'),(173,'',1,7,16,'2000-01-01','3000-01-01',1,12,1,5,2,2,'12:15:00','12:45:00'),(175,'',1,7,16,'2000-01-01','3000-01-01',1,12,1,5,3,3,'09:00:00','09:30:00'),(176,'',1,7,16,'2000-01-01','3000-01-01',1,12,1,5,4,4,'19:00:00','19:30:00'),(171,'',1,7,16,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(85,'',1,9,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(86,'',1,9,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:30:00','11:30:00'),(87,'',1,9,3,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(90,'',1,9,3,'2000-01-01','3000-01-01',1,12,1,5,2,6,'07:00:00','07:30:00'),(91,'',1,9,3,'2000-01-01','3000-01-01',1,12,1,5,2,6,'12:00:00','12:30:00'),(88,'',1,9,3,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(89,'',1,9,3,'2000-01-01','3000-01-01',1,12,1,5,7,7,'19:00:00','20:00:00'),(190,'',1,10,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:00:00','09:00:00'),(194,'',1,10,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'10:00:00','11:00:00'),(198,'',1,10,17,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(206,'',1,10,17,'2000-01-01','3000-01-01',1,12,1,5,2,6,'06:30:00','07:00:00'),(209,'',1,10,17,'2000-01-01','3000-01-01',1,12,1,5,2,7,'09:00:00','09:30:00'),(213,'',1,10,17,'2000-01-01','3000-01-01',1,12,1,5,3,3,'19:00:00','19:30:00'),(202,'',1,10,17,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:00:00','18:00:00'),(111,'',1,11,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:30:00','10:30:00'),(113,'',1,11,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'12:00:00','13:00:00'),(166,'',1,11,16,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:00:00','10:00:00'),(168,'',1,11,16,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:15:00','12:15:00'),(172,'',1,11,16,'2000-01-01','3000-01-01',1,12,1,5,2,2,'12:15:00','12:45:00'),(174,'',1,11,16,'2000-01-01','3000-01-01',1,12,1,5,3,3,'09:00:00','09:30:00'),(170,'',1,11,16,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(3,'',2,1,2,'2000-01-01','3000-01-01',1,12,1,5,7,7,'15:00:00','15:30:00'),(5,'',2,1,5,'2000-01-01','3000-01-01',1,12,1,5,7,7,'15:00:00','15:30:00'),(8,'',2,1,8,'2000-01-01','3000-01-01',1,12,1,1,1,1,'10:15:00','10:30:00'),(9,'',2,1,8,'2000-01-01','3000-01-01',1,12,1,1,1,1,'11:30:00','11:45:00'),(10,'',2,1,9,'2000-01-01','3000-01-01',1,12,1,5,7,7,'15:00:00','15:45:00'),(13,'',2,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'06:45:00','07:00:00'),(14,'',2,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:15:00','08:30:00'),(15,'',2,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'09:45:00','10:00:00'),(16,'',2,1,11,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:15:00','11:30:00'),(12,'',2,1,11,'2000-01-01','3000-01-01',1,12,1,5,7,7,'11:50:00','12:05:00'),(11,'',2,1,11,'2000-01-01','3000-01-01',1,12,1,5,7,7,'15:00:00','16:00:00'),(17,'',2,1,12,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:45:00','17:00:00'),(18,'',2,1,15,'2000-01-01','3000-01-01',1,12,1,5,7,7,'15:00:00','15:30:00'),(1,'',2,2,1,'2000-01-01','3000-01-01',1,12,1,5,2,6,'11:30:00','12:00:00'),(2,'',2,2,1,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:00:00','17:00:00'),(7,'',2,2,6,'2000-01-01','3000-01-01',1,12,1,5,7,7,'15:00:00','15:45:00'),(21,'',2,2,18,'2000-01-01','3000-01-01',1,12,1,5,2,6,'10:30:00','12:00:00'),(22,'',2,2,18,'2000-01-01','3000-01-01',1,12,1,5,2,6,'12:40:00','17:30:00'),(23,'',2,2,18,'2000-01-01','3000-01-01',1,12,1,5,7,7,'10:30:00','12:00:00'),(24,'',2,2,18,'2000-01-01','3000-01-01',1,12,1,5,7,7,'12:40:00','15:45:00'),(25,'',2,4,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'10:30:00','12:00:00'),(26,'',2,4,18,'2000-01-01','3000-01-01',1,12,1,5,2,7,'12:40:00','15:45:00'),(108,'',2,7,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:45:00','09:20:00'),(109,'',2,7,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:30:00','11:50:00'),(189,'',2,7,16,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:00:00','17:15:00'),(4,'',2,9,3,'2000-01-01','3000-01-01',1,12,1,5,7,7,'15:00:00','15:30:00'),(20,'',2,10,17,'2000-01-01','3000-01-01',1,12,1,5,7,7,'16:15:00','16:45:00'),(106,'',2,11,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'08:45:00','09:20:00'),(107,'',2,11,4,'2000-01-01','3000-01-01',1,12,1,5,1,1,'11:30:00','11:50:00'),(19,'',2,11,16,'2000-01-01','3000-01-01',1,12,1,5,7,7,'17:00:00','17:15:00'),(123,'',3,1,11,'2000-01-01','3000-01-01',1,12,1,1,6,6,'07:30:00','12:00:00'),(80,'',3,2,18,'2000-01-01','3000-01-01',1,12,1,5,2,6,'10:30:00','11:50:00'),(184,'',3,7,16,'2000-01-01','3000-01-01',1,12,1,1,4,4,'09:30:00','21:30:00'),(188,'',3,7,16,'2000-01-01','3000-01-01',1,12,2,2,4,4,'09:30:00','19:00:00'),(186,'',3,7,16,'2000-01-01','3000-01-01',1,12,3,5,4,4,'09:30:00','21:30:00'),(93,'',3,9,3,'2000-01-01','3000-01-01',1,12,1,1,6,6,'07:30:00','12:00:00'),(183,'',3,11,16,'2000-01-01','3000-01-01',1,12,1,1,4,4,'09:30:00','21:30:00'),(187,'',3,11,16,'2000-01-01','3000-01-01',1,12,2,2,4,4,'09:30:00','19:00:00'),(185,'',3,11,16,'2000-01-01','3000-01-01',1,12,3,5,4,4,'09:30:00','21:30:00'),(134,'',4,1,5,'2000-01-01','3000-01-01',1,12,1,5,5,5,'09:00:00','09:30:00'),(157,'',4,1,13,'2000-01-01','3000-01-01',1,12,1,5,5,5,'17:15:00','17:45:00'),(178,'',4,7,16,'2000-01-01','3000-01-01',1,12,1,5,4,5,'09:00:00','09:30:00'),(177,'',4,11,16,'2000-01-01','3000-01-01',1,12,1,5,4,5,'09:00:00','09:30:00'),(48,'',6,2,1,'2000-01-01','3000-01-01',1,12,1,5,6,6,'17:15:00','17:45:00'),(122,'',7,1,11,'2000-01-01','3000-01-01',1,12,1,1,7,7,'12:35:00','13:05:00'),(180,'',7,7,16,'2000-01-01','3000-01-01',1,12,1,5,4,4,'18:30:00','19:00:00'),(179,'',7,11,16,'2000-01-01','3000-01-01',1,12,1,5,4,4,'18:30:00','19:00:00'),(110,'Healing Mass',1,11,4,'2000-01-01','3000-01-01',1,12,6,6,6,6,'19:00:00','19:30:00'),(49,'Morning Prayer',5,2,1,'2000-01-01','3000-01-01',1,12,1,5,2,6,'07:45:00','08:00:00'),(50,'Morning Prayer',5,2,1,'2000-01-01','3000-01-01',1,12,1,5,7,7,'08:45:00','09:00:00'),(182,'Morning Prayer',5,7,16,'2000-01-01','3000-01-01',1,12,1,5,6,6,'09:00:00','09:15:00'),(181,'Morning Prayer',5,11,16,'2000-01-01','3000-01-01',1,12,1,5,6,6,'09:00:00','09:15:00'),(124,'Novena to Our Lady of Perpetual Help',8,1,11,'2000-01-01','3000-01-01',1,12,1,5,3,3,'12:35:00','12:50:00'),(125,'Novena to St. Jude',8,1,11,'2000-01-01','3000-01-01',1,12,1,5,4,4,'12:35:00','12:50:00'),(126,'Novena to the Holy Spirit',8,1,11,'2000-01-01','3000-01-01',1,12,1,5,5,5,'12:35:00','12:50:00');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventAttr`
--

DROP TABLE IF EXISTS `eventAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventAttr`
--

LOCK TABLES `eventAttr` WRITE;
/*!40000 ALTER TABLE `eventAttr` DISABLE KEYS */;
INSERT INTO `eventAttr` VALUES (1,'page',1),(2,'note',1);
/*!40000 ALTER TABLE `eventAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventFilter`
--

DROP TABLE IF EXISTS `eventFilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventFilter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventFilter` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventFilter` (`eventFilter`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventFilter`
--

LOCK TABLES `eventFilter` WRITE;
/*!40000 ALTER TABLE `eventFilter` DISABLE KEYS */;
INSERT INTO `eventFilter` VALUES (6,'Advent'),(8,'Advent and Lent'),(5,'Holiday'),(3,'Holy Day'),(4,'Holy Day Vigil'),(7,'Lent'),(1,'Regular'),(9,'Regular (not Holy Day or Holiday)'),(2,'Regular (not Holy Day or Vigil)'),(10,'Regular (not Holy Day, Vigil, or Holiday)'),(11,'Regular (not Lent)');
/*!40000 ALTER TABLE `eventFilter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventFilterAttr`
--

DROP TABLE IF EXISTS `eventFilterAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventFilterAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventFilterAttr`
--

LOCK TABLES `eventFilterAttr` WRITE;
/*!40000 ALTER TABLE `eventFilterAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventFilterAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventFilterProp`
--

DROP TABLE IF EXISTS `eventFilterProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventFilterProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventFilterId` int(10) unsigned NOT NULL,
  `eventFilterAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventFilterId` (`eventFilterId`,`eventFilterAttrId`,`multi`),
  KEY `eventFilterAttrId` (`eventFilterAttrId`,`multi`,`value`),
  KEY `eventFilterAttrId_2` (`eventFilterAttrId`,`value`),
  CONSTRAINT `eventFilterProp_ibfk_1` FOREIGN KEY (`eventFilterId`) REFERENCES `eventFilter` (`id`),
  CONSTRAINT `eventFilterProp_ibfk_2` FOREIGN KEY (`eventFilterAttrId`) REFERENCES `eventFilterAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventFilterProp`
--

LOCK TABLES `eventFilterProp` WRITE;
/*!40000 ALTER TABLE `eventFilterProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventFilterProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventProp`
--

DROP TABLE IF EXISTS `eventProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventId` int(10) unsigned NOT NULL,
  `eventAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventId` (`eventId`,`eventAttrId`,`multi`),
  KEY `eventAttrId` (`eventAttrId`,`multi`,`value`),
  KEY `eventAttrId_2` (`eventAttrId`,`value`),
  CONSTRAINT `eventProp_ibfk_1` FOREIGN KEY (`eventId`) REFERENCES `event` (`id`),
  CONSTRAINT `eventProp_ibfk_2` FOREIGN KEY (`eventAttrId`) REFERENCES `eventAttr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventProp`
--

LOCK TABLES `eventProp` WRITE;
/*!40000 ALTER TABLE `eventProp` DISABLE KEYS */;
INSERT INTO `eventProp` VALUES (1,1,1,1,'http://cathedralic.com/sacraments.htm'),(2,2,1,1,'http://cathedralic.com/sacraments.htm'),(3,4,1,1,'http://blessedsacramentalbany.org/reconcilliation/'),(4,5,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(6,7,1,1,'http://rcda.org/churches/MaterChristi/sacraments.html'),(7,8,1,1,'http://www.vietnamesecatholiccommunityalbany.org/'),(8,8,2,1,'before Mass'),(9,9,1,1,'http://www.vietnamesecatholiccommunityalbany.org/'),(10,9,2,1,'after Mass'),(11,10,1,1,'http://rcda.org/churches/stfrancisofassisi/Sacraments.html'),(12,11,1,1,'http://www.hist-stmarys.org/'),(13,12,1,1,'http://www.hist-stmarys.org/'),(14,12,2,1,'before Mass'),(15,13,1,1,'http://www.hist-stmarys.org/'),(16,13,2,1,'before Mass'),(17,14,1,1,'http://www.hist-stmarys.org/'),(18,14,2,1,'before Mass'),(19,15,1,1,'http://www.hist-stmarys.org/'),(20,15,2,1,'before Mass'),(21,16,1,1,'http://www.hist-stmarys.org/'),(22,16,2,1,'before Mass'),(23,17,1,1,'http://www.stvincentalbany.org/reconciliation'),(24,18,1,1,'http://stclares.nycap.rr.com/cal.html'),(25,19,1,1,'http://www.christourlightchurch.org/Sacraments'),(26,19,2,1,'after Mass'),(27,20,1,1,'http://www.stpiusxloudonville.org/'),(28,21,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(29,22,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(30,23,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(31,24,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(32,25,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(33,26,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(38,31,1,1,'http://www.cathedralic.com/massschedule.htm'),(39,32,1,1,'http://www.cathedralic.com/massschedule.htm'),(40,33,1,1,'http://www.cathedralic.com/massschedule.htm'),(41,34,1,1,'http://www.cathedralic.com/massschedule.htm'),(42,35,1,1,'http://www.cathedralic.com/massschedule.htm'),(43,36,1,1,'http://www.cathedralic.com/massschedule.htm'),(44,37,1,1,'http://www.cathedralic.com/massschedule.htm'),(45,38,1,1,'http://www.cathedralic.com/massschedule.htm'),(46,39,1,1,'http://www.cathedralic.com/massschedule.htm'),(47,40,1,1,'http://www.cathedralic.com/massschedule.htm'),(48,41,1,1,'http://www.cathedralic.com/massschedule.htm'),(49,42,1,1,'http://www.cathedralic.com/massschedule.htm'),(50,43,1,1,'http://www.cathedralic.com/massschedule.htm'),(51,44,1,1,'http://www.cathedralic.com/massschedule.htm'),(52,45,1,1,'http://www.cathedralic.com/massschedule.htm'),(53,46,1,1,'http://www.cathedralic.com/massschedule.htm'),(54,47,1,1,'http://www.cathedralic.com/massschedule.htm'),(55,48,1,1,'http://www.cathedralic.com/massschedule.htm'),(56,49,1,1,'http://www.cathedralic.com/massschedule.htm'),(57,50,1,1,'http://www.cathedralic.com/massschedule.htm'),(58,49,2,1,'after Mass'),(59,51,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(60,51,2,1,'devotions to the Blessed Mother'),(61,52,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(62,52,2,1,'devotions to the Blessed Mother'),(63,53,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(64,53,2,1,'devotions to the Blessed Mother'),(65,54,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(67,54,2,1,'devotions to St. Anthony'),(68,55,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(69,55,2,1,'devotions to St. Anthony'),(70,56,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(71,56,2,1,'devotions to St. Anthony'),(72,57,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(73,58,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(74,59,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(75,60,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(76,60,2,1,'devotions to St. Jude'),(77,61,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(78,61,2,1,'devotions to St. Jude'),(79,62,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(80,62,2,1,'devotions to St. Jude'),(82,58,2,1,'Mass for the sick'),(83,63,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(84,63,2,1,'devotions to the Sacred Heart'),(85,64,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(86,64,2,1,'devotions to the Sacred Heart'),(87,65,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(88,65,2,1,'devotions to the Sacred Heart'),(89,66,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(90,67,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(91,68,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(92,69,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(93,70,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(94,71,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(95,72,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(96,73,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(97,74,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(98,75,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(99,76,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(100,77,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(101,78,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(102,79,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(103,80,1,1,'http://scribe.apollohosting.com/httpdocs/sfchapel/bul_covr.pdf'),(104,80,2,1,'benediction at 11:50'),(105,81,1,1,'http://www.rcda.org/churches/AllSaints/massschedule.html'),(106,82,1,1,'http://www.rcda.org/churches/AllSaints/massschedule.html'),(107,83,1,1,'http://www.rcda.org/churches/AllSaints/massschedule.html'),(108,84,1,1,'http://www.rcda.org/churches/AllSaints/massschedule.html'),(109,85,1,1,'http://blessedsacramentalbany.org/eucharist/'),(110,86,1,1,'http://blessedsacramentalbany.org/eucharist/'),(111,87,1,1,'http://blessedsacramentalbany.org/eucharist/'),(112,88,1,1,'http://blessedsacramentalbany.org/eucharist/'),(113,89,1,1,'http://blessedsacramentalbany.org/eucharist/'),(114,90,1,1,'http://blessedsacramentalbany.org/eucharist/'),(115,91,1,1,'http://blessedsacramentalbany.org/eucharist/'),(116,92,1,1,'http://blessedsacramentalbany.org/eucharist/'),(117,93,1,1,'http://blessedsacramentalbany.org/eucharist/'),(118,86,2,1,'children\'s Liturgy of the Word'),(119,95,2,1,'children\'s Liturgy of the Word'),(120,94,1,1,'http://blessedsacramentalbany.org/eucharist/'),(121,95,1,1,'http://blessedsacramentalbany.org/eucharist/'),(122,96,1,1,'http://blessedsacramentalbany.org/eucharist/'),(123,97,1,1,'http://blessedsacramentalbany.org/eucharist/'),(124,98,1,1,'http://blessedsacramentalbany.org/eucharist/'),(125,100,2,1,'children\'s Liturgy of the Word'),(126,105,2,1,'check bulletin'),(127,99,1,1,'http://blessedsacramentalbany.org/eucharist/'),(128,100,1,1,'http://blessedsacramentalbany.org/eucharist/'),(129,101,1,1,'http://blessedsacramentalbany.org/eucharist/'),(130,102,1,1,'http://blessedsacramentalbany.org/eucharist/'),(131,104,1,1,'http://blessedsacramentalbany.org/eucharist/'),(132,105,1,1,'http://blessedsacramentalbany.org/eucharist/'),(133,103,1,1,'http://blessedsacramentalbany.org/eucharist/'),(134,93,2,1,'if no funeral'),(135,111,1,1,'http://ourladyoftheamericas.weebly.com/'),(136,112,1,1,'http://ourladyoftheamericas.weebly.com/'),(137,113,1,1,'http://ourladyoftheamericas.weebly.com/'),(138,114,1,1,'http://ourladyoftheamericas.weebly.com/'),(139,111,2,1,'English'),(140,112,2,1,'English'),(141,113,2,1,'Spanish'),(142,114,2,1,'Spanish'),(143,115,1,1,'http://www.hist-stmarys.org/'),(144,116,1,1,'http://www.hist-stmarys.org/'),(145,117,1,1,'http://www.hist-stmarys.org/'),(146,118,1,1,'http://www.hist-stmarys.org/'),(147,119,1,1,'http://www.hist-stmarys.org/'),(148,120,1,1,'http://www.hist-stmarys.org/'),(149,121,1,1,'http://www.hist-stmarys.org/'),(150,122,1,1,'http://www.hist-stmarys.org/'),(151,123,1,1,'http://www.hist-stmarys.org/'),(152,124,1,1,'http://www.hist-stmarys.org/'),(153,125,1,1,'http://www.hist-stmarys.org/'),(154,126,1,1,'http://www.hist-stmarys.org/'),(155,122,2,1,'after Mass'),(156,123,2,1,'after Mass'),(157,124,2,1,'after Mass'),(158,125,2,1,'after Mass'),(159,126,2,1,'after Mass'),(160,127,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(161,128,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(162,129,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(163,130,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(164,131,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(165,132,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(166,133,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(167,134,1,1,'http://www.ctkparishny.org/parish-life/mass-schedule-bulletins/'),(168,135,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(169,136,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(170,137,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(171,138,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(172,139,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(173,140,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(174,141,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(175,142,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(176,143,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(177,144,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(178,145,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(179,146,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(180,147,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(181,148,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(182,149,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(183,150,1,1,'http://www.rcda.org/churches/MaterChristi/worshipschedule.html'),(184,148,2,1,'if school\'s not in session'),(185,149,2,1,'if school\'s in session'),(186,151,1,1,'http://www.rcda.org/churches/sacredheartofjesus/'),(187,152,1,1,'http://www.vietnamesecatholiccommunityalbany.org/'),(188,153,1,1,'http://www.rcda.org/churches/stfrancisofassisi/massschedule.html'),(189,154,1,1,'http://www.rcda.org/churches/stfrancisofassisi/massschedule.html'),(190,155,1,1,'http://www.rcda.org/churches/stfrancisofassisi/massschedule.html'),(191,156,1,1,'http://www.rcda.org/churches/stfrancisofassisi/massschedule.html'),(192,157,1,1,'http://www.stvincentalbany.org/mass-times'),(193,158,1,1,'http://www.stvincentalbany.org/mass-times'),(194,159,1,1,'http://www.stvincentalbany.org/mass-times'),(195,160,1,1,'http://www.stvincentalbany.org/mass-times'),(196,161,1,1,'http://www.kccalbany.org/xe/home/'),(197,162,1,1,'http://stclares.nycap.rr.com/cal.html'),(198,163,1,1,'http://stclares.nycap.rr.com/cal.html'),(199,164,1,1,'http://stclares.nycap.rr.com/cal.html'),(200,165,1,1,'http://stclares.nycap.rr.com/cal.html'),(201,166,1,1,'http://www.christourlightchurch.org/'),(202,167,1,1,'http://www.christourlightchurch.org/'),(203,168,1,1,'http://www.christourlightchurch.org/'),(204,169,1,1,'http://www.christourlightchurch.org/'),(205,170,1,1,'http://www.christourlightchurch.org/'),(206,171,1,1,'http://www.christourlightchurch.org/'),(207,172,1,1,'http://www.christourlightchurch.org/'),(208,173,1,1,'http://www.christourlightchurch.org/'),(209,174,1,1,'http://www.christourlightchurch.org/'),(210,175,1,1,'http://www.christourlightchurch.org/'),(211,176,1,1,'http://www.christourlightchurch.org/'),(212,172,2,1,'if no funeral'),(213,173,2,1,'if no funeral'),(214,174,2,1,'if no funeral'),(215,175,2,1,'if no funeral'),(216,189,1,1,'http://www.christourlightchurch.org/Sacraments'),(217,213,2,1,'Marian Devotions'),(218,190,1,1,'http://www.stpiusxloudonville.org/'),(219,191,1,1,'http://www.stpiusxloudonville.org/'),(220,192,1,1,'http://www.stpiusxloudonville.org/'),(221,193,1,1,'http://www.stpiusxloudonville.org/'),(222,194,1,1,'http://www.stpiusxloudonville.org/'),(223,195,1,1,'http://www.stpiusxloudonville.org/'),(224,196,1,1,'http://www.stpiusxloudonville.org/'),(225,197,1,1,'http://www.stpiusxloudonville.org/'),(226,198,1,1,'http://www.stpiusxloudonville.org/'),(227,199,1,1,'http://www.stpiusxloudonville.org/'),(228,200,1,1,'http://www.stpiusxloudonville.org/'),(229,201,1,1,'http://www.stpiusxloudonville.org/'),(230,202,1,1,'http://www.stpiusxloudonville.org/'),(231,203,1,1,'http://www.stpiusxloudonville.org/'),(232,204,1,1,'http://www.stpiusxloudonville.org/'),(233,205,1,1,'http://www.stpiusxloudonville.org/'),(234,206,1,1,'http://www.stpiusxloudonville.org/'),(235,207,1,1,'http://www.stpiusxloudonville.org/'),(236,208,1,1,'http://www.stpiusxloudonville.org/'),(237,209,1,1,'http://www.stpiusxloudonville.org/'),(238,210,1,1,'http://www.stpiusxloudonville.org/'),(239,211,1,1,'http://www.stpiusxloudonville.org/'),(240,212,1,1,'http://www.stpiusxloudonville.org/'),(241,213,1,1,'http://www.stpiusxloudonville.org/'),(242,214,1,1,'http://www.stpiusxloudonville.org/');
/*!40000 ALTER TABLE `eventProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventType`
--

DROP TABLE IF EXISTS `eventType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventType` (`eventType`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventType`
--

LOCK TABLES `eventType` WRITE;
/*!40000 ALTER TABLE `eventType` DISABLE KEYS */;
INSERT INTO `eventType` VALUES (3,'Adoration'),(4,'Communion'),(2,'Confession'),(8,'Devotion'),(5,'Liturgy of the Hours'),(1,'Mass'),(7,'Rosary'),(6,'Stations of the Cross');
/*!40000 ALTER TABLE `eventType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventTypeAttr`
--

DROP TABLE IF EXISTS `eventTypeAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventTypeAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventTypeAttr`
--

LOCK TABLES `eventTypeAttr` WRITE;
/*!40000 ALTER TABLE `eventTypeAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventTypeAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventTypeProp`
--

DROP TABLE IF EXISTS `eventTypeProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventTypeProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventTypeId` int(10) unsigned NOT NULL,
  `eventTypeAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventTypeId` (`eventTypeId`,`eventTypeAttrId`,`multi`),
  KEY `eventTypeAttrId` (`eventTypeAttrId`,`multi`,`value`),
  KEY `eventTypeAttrId_2` (`eventTypeAttrId`,`value`),
  CONSTRAINT `eventTypeProp_ibfk_1` FOREIGN KEY (`eventTypeId`) REFERENCES `eventType` (`id`),
  CONSTRAINT `eventTypeProp_ibfk_2` FOREIGN KEY (`eventTypeAttrId`) REFERENCES `eventTypeAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventTypeProp`
--

LOCK TABLES `eventTypeProp` WRITE;
/*!40000 ALTER TABLE `eventTypeProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventTypeProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `month`
--

DROP TABLE IF EXISTS `month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `month` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `month` (`month`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `month`
--

LOCK TABLES `month` WRITE;
/*!40000 ALTER TABLE `month` DISABLE KEYS */;
INSERT INTO `month` VALUES (4,'April'),(8,'August'),(12,'December'),(2,'February'),(1,'January'),(7,'July'),(6,'June'),(3,'March'),(5,'May'),(11,'November'),(10,'October'),(9,'September');
/*!40000 ALTER TABLE `month` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthAttr`
--

DROP TABLE IF EXISTS `monthAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthAttr`
--

LOCK TABLES `monthAttr` WRITE;
/*!40000 ALTER TABLE `monthAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthProp`
--

DROP TABLE IF EXISTS `monthProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monthId` int(10) unsigned NOT NULL,
  `monthAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `monthId` (`monthId`,`monthAttrId`,`multi`),
  KEY `monthAttrId` (`monthAttrId`,`multi`,`value`),
  KEY `monthAttrId_2` (`monthAttrId`,`value`),
  CONSTRAINT `monthProp_ibfk_1` FOREIGN KEY (`monthId`) REFERENCES `month` (`id`),
  CONSTRAINT `monthProp_ibfk_2` FOREIGN KEY (`monthAttrId`) REFERENCES `monthAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthProp`
--

LOCK TABLES `monthProp` WRITE;
/*!40000 ALTER TABLE `monthProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parish`
--

DROP TABLE IF EXISTS `parish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parish` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parish` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `dioceseId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parish` (`parish`,`identifier`,`dioceseId`),
  KEY `dioceseId` (`dioceseId`),
  CONSTRAINT `parish_ibfk_1` FOREIGN KEY (`dioceseId`) REFERENCES `diocese` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parish`
--

LOCK TABLES `parish` WRITE;
/*!40000 ALTER TABLE `parish` DISABLE KEYS */;
INSERT INTO `parish` VALUES (1,NULL,'',1),(2,NULL,'',2),(3,NULL,'',3),(4,NULL,'',4),(5,NULL,'',5),(6,NULL,'',6),(7,NULL,'',7),(8,NULL,'',8),(9,NULL,'',9),(10,NULL,'',10),(11,NULL,'',11),(12,NULL,'',12),(13,NULL,'',13),(14,NULL,'',14),(15,NULL,'',15),(16,NULL,'',16),(17,NULL,'',17),(18,NULL,'',18),(19,NULL,'',19),(20,NULL,'',20),(21,NULL,'',21),(22,NULL,'',22),(23,NULL,'',23),(24,NULL,'',24),(26,'All Saints','',67),(27,'Blessed Sacrament','',67),(37,'Christ Our Light','',67),(28,'Christ the King','',67),(25,'Immaculate Conception','',67),(35,'Korean Apostolate','',67),(29,'Mater Christi','',67),(30,'Sacred Heart of Jesus','',67),(36,'St. Clare','',67),(32,'St. Francis of Assisi','',67),(33,'St. Mary','',67),(38,'St. Pius X','',67),(34,'St. Vincent de Paul','',67),(31,'Vietnamese Apostolate','',67);
/*!40000 ALTER TABLE `parish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parishAttr`
--

DROP TABLE IF EXISTS `parishAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parishAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parishAttr`
--

LOCK TABLES `parishAttr` WRITE;
/*!40000 ALTER TABLE `parishAttr` DISABLE KEYS */;
INSERT INTO `parishAttr` VALUES (1,'isIntentional',1);
/*!40000 ALTER TABLE `parishAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parishProp`
--

DROP TABLE IF EXISTS `parishProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parishProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parishId` int(10) unsigned NOT NULL,
  `parishAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parishId` (`parishId`,`parishAttrId`,`multi`),
  KEY `parishAttrId` (`parishAttrId`,`multi`,`value`),
  KEY `parishAttrId_2` (`parishAttrId`,`value`),
  CONSTRAINT `parishProp_ibfk_1` FOREIGN KEY (`parishId`) REFERENCES `parish` (`id`),
  CONSTRAINT `parishProp_ibfk_2` FOREIGN KEY (`parishAttrId`) REFERENCES `parishAttr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parishProp`
--

LOCK TABLES `parishProp` WRITE;
/*!40000 ALTER TABLE `parishProp` DISABLE KEYS */;
INSERT INTO `parishProp` VALUES (1,31,1,1,'Vietnamese'),(2,35,1,1,'Korean');
/*!40000 ALTER TABLE `parishProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `province` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `suiIurisId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `province` (`province`),
  KEY `suiIurisId` (`suiIurisId`),
  CONSTRAINT `province_ibfk_1` FOREIGN KEY (`suiIurisId`) REFERENCES `suiIuris` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
INSERT INTO `province` VALUES (1,NULL,1),(2,NULL,2),(3,NULL,3),(4,NULL,4),(5,NULL,5),(6,NULL,6),(7,NULL,7),(8,NULL,8),(9,NULL,9),(10,NULL,10),(11,NULL,11),(12,NULL,12),(13,NULL,13),(14,NULL,14),(15,NULL,15),(16,NULL,16),(17,NULL,17),(18,NULL,18),(19,NULL,19),(20,NULL,20),(21,NULL,21),(22,NULL,22),(23,NULL,23),(24,NULL,24),(25,'Province of Anchorage',1),(26,'Province of Atlanta',1),(27,'Province of Baltimore',1),(28,'Province of Boston',1),(29,'Province of Chicago',1),(30,'Province of Cincinatti',1),(31,'Province of Denver',1),(32,'Province of Detroit',1),(33,'Province of Dubuque',1),(34,'Province of Galveston-Houston',1),(35,'Province of Indianapolis',1),(36,'Province of Hartford',1),(37,'Province of Kansas City',1),(38,'Province of Los Angeles',1),(39,'Province of Louisville',1),(40,'Province of Miami',1),(41,'Province of Milwaukee',1),(42,'Province of Mobile',1),(43,'Province of New Orleans',1),(44,'Province of New York',1),(45,'Province of Newark',1),(46,'Province of Oklahoma City',1),(47,'Province of Omaha',1),(48,'Province of Philadelphia',1),(49,'Province of Portland',1),(50,'Province of San Antonio',1),(51,'Province of San Francisco',1),(52,'Province of Santa Fe',1),(53,'Province of Seattle',1),(54,'Province of St. Louis',1),(55,'Province of St. Paul and Minneapolis',1),(56,'Province of Washington',1),(57,'Metropolia of Philadelphia',2),(58,'Metropolia of Pittsburgh',6);
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provinceAttr`
--

DROP TABLE IF EXISTS `provinceAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provinceAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinceAttr`
--

LOCK TABLES `provinceAttr` WRITE;
/*!40000 ALTER TABLE `provinceAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `provinceAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provinceProp`
--

DROP TABLE IF EXISTS `provinceProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provinceProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `provinceId` int(10) unsigned NOT NULL,
  `provinceAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `provinceId` (`provinceId`,`provinceAttrId`,`multi`),
  KEY `provinceAttrId` (`provinceAttrId`,`multi`,`value`),
  KEY `provinceAttrId_2` (`provinceAttrId`,`value`),
  CONSTRAINT `provinceProp_ibfk_1` FOREIGN KEY (`provinceId`) REFERENCES `province` (`id`),
  CONSTRAINT `provinceProp_ibfk_2` FOREIGN KEY (`provinceAttrId`) REFERENCES `provinceAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinceProp`
--

LOCK TABLES `provinceProp` WRITE;
/*!40000 ALTER TABLE `provinceProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `provinceProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious`
--

DROP TABLE IF EXISTS `religious`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religious` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `religious1Id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religious` (`religious`,`religious1Id`),
  KEY `religious1Id` (`religious1Id`),
  CONSTRAINT `religious_ibfk_1` FOREIGN KEY (`religious1Id`) REFERENCES `religious1` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious`
--

LOCK TABLES `religious` WRITE;
/*!40000 ALTER TABLE `religious` DISABLE KEYS */;
INSERT INTO `religious` VALUES (1,NULL,1),(2,NULL,2),(3,NULL,3),(4,NULL,4),(5,NULL,5),(6,NULL,6),(7,NULL,7),(8,NULL,8),(9,NULL,9),(10,NULL,10),(11,NULL,11),(12,NULL,12),(13,NULL,13),(14,NULL,14),(15,NULL,15),(16,NULL,16),(17,NULL,17),(18,NULL,18),(19,NULL,19),(20,NULL,20),(21,NULL,21),(22,NULL,22),(23,NULL,23),(24,NULL,24),(25,'St. Bernardine of Siena Friary',25);
/*!40000 ALTER TABLE `religious` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious1`
--

DROP TABLE IF EXISTS `religious1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religious1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `religious2Id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religious1` (`religious1`,`religious2Id`),
  KEY `religious2Id` (`religious2Id`),
  CONSTRAINT `religious1_ibfk_1` FOREIGN KEY (`religious2Id`) REFERENCES `religious2` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious1`
--

LOCK TABLES `religious1` WRITE;
/*!40000 ALTER TABLE `religious1` DISABLE KEYS */;
INSERT INTO `religious1` VALUES (1,NULL,1),(2,NULL,2),(3,NULL,3),(4,NULL,4),(5,NULL,5),(6,NULL,6),(7,NULL,7),(8,NULL,8),(9,NULL,9),(10,NULL,10),(11,NULL,11),(12,NULL,12),(13,NULL,13),(14,NULL,14),(15,NULL,15),(16,NULL,16),(17,NULL,17),(18,NULL,18),(19,NULL,19),(20,NULL,20),(21,NULL,21),(22,NULL,22),(23,NULL,23),(24,NULL,24),(25,NULL,25);
/*!40000 ALTER TABLE `religious1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious1Attr`
--

DROP TABLE IF EXISTS `religious1Attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious1Attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious1Attr`
--

LOCK TABLES `religious1Attr` WRITE;
/*!40000 ALTER TABLE `religious1Attr` DISABLE KEYS */;
/*!40000 ALTER TABLE `religious1Attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious1Prop`
--

DROP TABLE IF EXISTS `religious1Prop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious1Prop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religious1Id` int(10) unsigned NOT NULL,
  `religious1AttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religious1Id` (`religious1Id`,`religious1AttrId`,`multi`),
  KEY `religious1AttrId` (`religious1AttrId`,`multi`,`value`),
  KEY `religious1AttrId_2` (`religious1AttrId`,`value`),
  CONSTRAINT `religious1Prop_ibfk_1` FOREIGN KEY (`religious1Id`) REFERENCES `religious1` (`id`),
  CONSTRAINT `religious1Prop_ibfk_2` FOREIGN KEY (`religious1AttrId`) REFERENCES `religious1Attr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious1Prop`
--

LOCK TABLES `religious1Prop` WRITE;
/*!40000 ALTER TABLE `religious1Prop` DISABLE KEYS */;
/*!40000 ALTER TABLE `religious1Prop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious2`
--

DROP TABLE IF EXISTS `religious2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religious2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `religious3Id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religious2` (`religious2`,`religious3Id`),
  KEY `religious3Id` (`religious3Id`),
  CONSTRAINT `religious2_ibfk_1` FOREIGN KEY (`religious3Id`) REFERENCES `religious3` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious2`
--

LOCK TABLES `religious2` WRITE;
/*!40000 ALTER TABLE `religious2` DISABLE KEYS */;
INSERT INTO `religious2` VALUES (1,NULL,1),(2,NULL,2),(3,NULL,3),(4,NULL,4),(5,NULL,5),(6,NULL,6),(7,NULL,7),(8,NULL,8),(9,NULL,9),(10,NULL,10),(11,NULL,11),(12,NULL,12),(13,NULL,13),(14,NULL,14),(15,NULL,15),(16,NULL,16),(17,NULL,17),(18,NULL,18),(19,NULL,19),(20,NULL,20),(21,NULL,21),(22,NULL,22),(23,NULL,23),(24,NULL,24),(25,'Holy Name Province',25);
/*!40000 ALTER TABLE `religious2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious2Attr`
--

DROP TABLE IF EXISTS `religious2Attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious2Attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious2Attr`
--

LOCK TABLES `religious2Attr` WRITE;
/*!40000 ALTER TABLE `religious2Attr` DISABLE KEYS */;
/*!40000 ALTER TABLE `religious2Attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious2Prop`
--

DROP TABLE IF EXISTS `religious2Prop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious2Prop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religious2Id` int(10) unsigned NOT NULL,
  `religious2AttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religious2Id` (`religious2Id`,`religious2AttrId`,`multi`),
  KEY `religious2AttrId` (`religious2AttrId`,`multi`,`value`),
  KEY `religious2AttrId_2` (`religious2AttrId`,`value`),
  CONSTRAINT `religious2Prop_ibfk_1` FOREIGN KEY (`religious2Id`) REFERENCES `religious2` (`id`),
  CONSTRAINT `religious2Prop_ibfk_2` FOREIGN KEY (`religious2AttrId`) REFERENCES `religious2Attr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious2Prop`
--

LOCK TABLES `religious2Prop` WRITE;
/*!40000 ALTER TABLE `religious2Prop` DISABLE KEYS */;
/*!40000 ALTER TABLE `religious2Prop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious3`
--

DROP TABLE IF EXISTS `religious3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious3` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religious3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `religiousTopId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religious3` (`religious3`,`religiousTopId`),
  KEY `religiousTopId` (`religiousTopId`),
  CONSTRAINT `religious3_ibfk_1` FOREIGN KEY (`religiousTopId`) REFERENCES `religiousTop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious3`
--

LOCK TABLES `religious3` WRITE;
/*!40000 ALTER TABLE `religious3` DISABLE KEYS */;
INSERT INTO `religious3` VALUES (1,NULL,1),(2,NULL,2),(3,NULL,3),(4,NULL,4),(5,NULL,5),(6,NULL,6),(7,NULL,7),(8,NULL,8),(9,NULL,9),(10,NULL,10),(11,NULL,11),(12,NULL,12),(13,NULL,13),(14,NULL,14),(15,NULL,15),(16,NULL,16),(17,NULL,17),(18,NULL,18),(19,NULL,19),(20,NULL,20),(21,NULL,21),(22,NULL,22),(23,NULL,23),(24,NULL,24),(25,NULL,25);
/*!40000 ALTER TABLE `religious3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious3Attr`
--

DROP TABLE IF EXISTS `religious3Attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious3Attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious3Attr`
--

LOCK TABLES `religious3Attr` WRITE;
/*!40000 ALTER TABLE `religious3Attr` DISABLE KEYS */;
/*!40000 ALTER TABLE `religious3Attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religious3Prop`
--

DROP TABLE IF EXISTS `religious3Prop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religious3Prop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religious3Id` int(10) unsigned NOT NULL,
  `religious3AttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religious3Id` (`religious3Id`,`religious3AttrId`,`multi`),
  KEY `religious3AttrId` (`religious3AttrId`,`multi`,`value`),
  KEY `religious3AttrId_2` (`religious3AttrId`,`value`),
  CONSTRAINT `religious3Prop_ibfk_1` FOREIGN KEY (`religious3Id`) REFERENCES `religious3` (`id`),
  CONSTRAINT `religious3Prop_ibfk_2` FOREIGN KEY (`religious3AttrId`) REFERENCES `religious3Attr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religious3Prop`
--

LOCK TABLES `religious3Prop` WRITE;
/*!40000 ALTER TABLE `religious3Prop` DISABLE KEYS */;
/*!40000 ALTER TABLE `religious3Prop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religiousAttr`
--

DROP TABLE IF EXISTS `religiousAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religiousAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religiousAttr`
--

LOCK TABLES `religiousAttr` WRITE;
/*!40000 ALTER TABLE `religiousAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `religiousAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religiousProp`
--

DROP TABLE IF EXISTS `religiousProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religiousProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religiousId` int(10) unsigned NOT NULL,
  `religiousAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religiousId` (`religiousId`,`religiousAttrId`,`multi`),
  KEY `religiousAttrId` (`religiousAttrId`,`multi`,`value`),
  KEY `religiousAttrId_2` (`religiousAttrId`,`value`),
  CONSTRAINT `religiousProp_ibfk_1` FOREIGN KEY (`religiousId`) REFERENCES `religious` (`id`),
  CONSTRAINT `religiousProp_ibfk_2` FOREIGN KEY (`religiousAttrId`) REFERENCES `religiousAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religiousProp`
--

LOCK TABLES `religiousProp` WRITE;
/*!40000 ALTER TABLE `religiousProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `religiousProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religiousTop`
--

DROP TABLE IF EXISTS `religiousTop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religiousTop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religiousTop` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `suiIurisId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religiousTop` (`religiousTop`,`suiIurisId`),
  KEY `suiIurisId` (`suiIurisId`),
  CONSTRAINT `religiousTop_ibfk_1` FOREIGN KEY (`suiIurisId`) REFERENCES `suiIuris` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religiousTop`
--

LOCK TABLES `religiousTop` WRITE;
/*!40000 ALTER TABLE `religiousTop` DISABLE KEYS */;
INSERT INTO `religiousTop` VALUES (1,NULL,1),(2,NULL,2),(3,NULL,3),(4,NULL,4),(5,NULL,5),(6,NULL,6),(7,NULL,7),(8,NULL,8),(9,NULL,9),(10,NULL,10),(11,NULL,11),(12,NULL,12),(13,NULL,13),(14,NULL,14),(15,NULL,15),(16,NULL,16),(17,NULL,17),(18,NULL,18),(19,NULL,19),(20,NULL,20),(21,NULL,21),(22,NULL,22),(23,NULL,23),(24,NULL,24),(25,'Order of Friars Minor',1);
/*!40000 ALTER TABLE `religiousTop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religiousTopAttr`
--

DROP TABLE IF EXISTS `religiousTopAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religiousTopAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religiousTopAttr`
--

LOCK TABLES `religiousTopAttr` WRITE;
/*!40000 ALTER TABLE `religiousTopAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `religiousTopAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `religiousTopProp`
--

DROP TABLE IF EXISTS `religiousTopProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `religiousTopProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `religiousTopId` int(10) unsigned NOT NULL,
  `religiousTopAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `religiousTopId` (`religiousTopId`,`religiousTopAttrId`,`multi`),
  KEY `religiousTopAttrId` (`religiousTopAttrId`,`multi`,`value`),
  KEY `religiousTopAttrId_2` (`religiousTopAttrId`,`value`),
  CONSTRAINT `religiousTopProp_ibfk_1` FOREIGN KEY (`religiousTopId`) REFERENCES `religiousTop` (`id`),
  CONSTRAINT `religiousTopProp_ibfk_2` FOREIGN KEY (`religiousTopAttrId`) REFERENCES `religiousTopAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `religiousTopProp`
--

LOCK TABLES `religiousTopProp` WRITE;
/*!40000 ALTER TABLE `religiousTopProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `religiousTopProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rite`
--

DROP TABLE IF EXISTS `rite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rite` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `traditionId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rite` (`rite`),
  KEY `traditionId` (`traditionId`),
  CONSTRAINT `rite_ibfk_1` FOREIGN KEY (`traditionId`) REFERENCES `tradition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rite`
--

LOCK TABLES `rite` WRITE;
/*!40000 ALTER TABLE `rite` DISABLE KEYS */;
INSERT INTO `rite` VALUES (1,'Roman',1),(2,'Byzantine',2),(3,'Maronite',3),(4,'Syrian',3),(5,'Malankara',3),(6,'Chaldean',4),(7,'Syro-Malabar',4),(8,'Armenian',5),(9,'Coptic',6),(10,'Ethiopic',6);
/*!40000 ALTER TABLE `rite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riteAttr`
--

DROP TABLE IF EXISTS `riteAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `riteAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riteAttr`
--

LOCK TABLES `riteAttr` WRITE;
/*!40000 ALTER TABLE `riteAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `riteAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riteProp`
--

DROP TABLE IF EXISTS `riteProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `riteProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `riteId` int(10) unsigned NOT NULL,
  `riteAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `riteId` (`riteId`,`riteAttrId`,`multi`),
  KEY `riteAttrId` (`riteAttrId`,`multi`,`value`),
  KEY `riteAttrId_2` (`riteAttrId`,`value`),
  CONSTRAINT `riteProp_ibfk_1` FOREIGN KEY (`riteId`) REFERENCES `rite` (`id`),
  CONSTRAINT `riteProp_ibfk_2` FOREIGN KEY (`riteAttrId`) REFERENCES `riteAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riteProp`
--

LOCK TABLES `riteProp` WRITE;
/*!40000 ALTER TABLE `riteProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `riteProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state2` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `countryId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state2` (`state2`,`countryId`),
  UNIQUE KEY `state` (`state`,`countryId`),
  KEY `countryId` (`countryId`),
  CONSTRAINT `state_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'AL','Alabama',1),(2,'AK','Alaska',1),(3,'AZ','Arizona',1),(4,'AR','Arkansas',1),(5,'CA','California',1),(6,'CO','Colorado',1),(7,'CT','Connecticut',1),(8,'DE','Delaware',1),(9,'DC','District of Columbia',1),(10,'FL','Florida',1),(11,'GA','Georgia',1),(12,'HI','Hawaii',1),(13,'ID','Idaho',1),(14,'IL','Illinois',1),(15,'IN','Indiana',1),(16,'IA','Iowa',1),(17,'KS','Kansas',1),(18,'KY','Kentucky',1),(19,'LA','Louisiana',1),(20,'ME','Maine',1),(21,'MD','Maryland',1),(22,'MA','Massachusetts',1),(23,'MI','Michigan',1),(24,'MN','Minnesota',1),(25,'MS','Mississippi',1),(26,'MO','Missouri',1),(27,'MT','Montana',1),(28,'NE','Nebraska',1),(29,'NV','Nevada',1),(30,'NH','New Hampshire',1),(31,'NJ','New Jersey',1),(32,'NM','New Mexico',1),(33,'NY','New York',1),(34,'NC','North Carolina',1),(35,'ND','North Dakota',1),(36,'OH','Ohio',1),(37,'OK','Oklahoma',1),(38,'OR','Oregon',1),(39,'PA','Pennsylvania',1),(40,'RI','Rhode Island',1),(41,'SC','South Carolina',1),(42,'SD','South Dakota',1),(43,'TN','Tennessee',1),(44,'TX','Texas',1),(45,'UT','Utah',1),(46,'VT','Vermont',1),(47,'VA','Virginia',1),(48,'WA','Washington',1),(49,'WV','West Virginia',1),(50,'WI','Wisconsin',1),(51,'WY','Wyoming',1);
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stateAttr`
--

DROP TABLE IF EXISTS `stateAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stateAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stateAttr`
--

LOCK TABLES `stateAttr` WRITE;
/*!40000 ALTER TABLE `stateAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `stateAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stateProp`
--

DROP TABLE IF EXISTS `stateProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stateProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stateId` int(10) unsigned NOT NULL,
  `stateAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stateId` (`stateId`,`stateAttrId`,`multi`),
  KEY `stateAttrId` (`stateAttrId`,`multi`,`value`),
  KEY `stateAttrId_2` (`stateAttrId`,`value`),
  CONSTRAINT `stateProp_ibfk_1` FOREIGN KEY (`stateId`) REFERENCES `state` (`id`),
  CONSTRAINT `stateProp_ibfk_2` FOREIGN KEY (`stateAttrId`) REFERENCES `stateAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stateProp`
--

LOCK TABLES `stateProp` WRITE;
/*!40000 ALTER TABLE `stateProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `stateProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suiIuris`
--

DROP TABLE IF EXISTS `suiIuris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suiIuris` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suiIuris` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `riteId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `suiIuris` (`suiIuris`),
  KEY `riteId` (`riteId`),
  CONSTRAINT `suiIuris_ibfk_1` FOREIGN KEY (`riteId`) REFERENCES `rite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suiIuris`
--

LOCK TABLES `suiIuris` WRITE;
/*!40000 ALTER TABLE `suiIuris` DISABLE KEYS */;
INSERT INTO `suiIuris` VALUES (1,'Latin Catholic Church',1),(2,'Ukrainian Greek Catholic Church',2),(3,'Syro-Malabar Catholic Church',7),(4,'Maronite Catholic Church',3),(5,'Melkite Greek Catholic Church',2),(6,'Ruthenian Byzantine Catholic Church',2),(7,'Armenian Catholic Church',8),(8,'Chaldean Catholic Church',6),(9,'Syro-Malankara Catholic Church',5),(10,'Hungarian Greek Catholic Church',2),(11,'Slovak Byzantine Catholic Church',2),(12,'Ethiopian Catholic Church',10),(13,'Coptic Catholic Church',9),(14,'Romanian Church United with Rome, Greek-Catholic',2),(15,'Syriac Catholic Church',4),(16,'Eritrean Catholic Church',10),(17,'Italo-Albanian Byzantine Catholic Church',2),(18,'Byzantine Church of Croatia, Serbia, and Montenegro',2),(19,'Macedonian Greek Catholic Church',2),(20,'Bulgarian Greek Catholic Church',2),(21,'Albanian Byzantine Catholic Church',2),(22,'Greek Byzantine Catholic Church',2),(23,'Russian Greek Catholic Church',2),(24,'Belarusian Greek Catholic Church',2);
/*!40000 ALTER TABLE `suiIuris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suiIurisAttr`
--

DROP TABLE IF EXISTS `suiIurisAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suiIurisAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suiIurisAttr`
--

LOCK TABLES `suiIurisAttr` WRITE;
/*!40000 ALTER TABLE `suiIurisAttr` DISABLE KEYS */;
INSERT INTO `suiIurisAttr` VALUES (1,'nickname',1);
/*!40000 ALTER TABLE `suiIurisAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suiIurisProp`
--

DROP TABLE IF EXISTS `suiIurisProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suiIurisProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suiIurisId` int(10) unsigned NOT NULL,
  `suiIurisAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `suiIurisId` (`suiIurisId`,`suiIurisAttrId`,`multi`),
  KEY `suiIurisAttrId` (`suiIurisAttrId`,`multi`,`value`),
  KEY `suiIurisAttrId_2` (`suiIurisAttrId`,`value`),
  CONSTRAINT `suiIurisProp_ibfk_1` FOREIGN KEY (`suiIurisId`) REFERENCES `suiIuris` (`id`),
  CONSTRAINT `suiIurisProp_ibfk_2` FOREIGN KEY (`suiIurisAttrId`) REFERENCES `suiIurisAttr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suiIurisProp`
--

LOCK TABLES `suiIurisProp` WRITE;
/*!40000 ALTER TABLE `suiIurisProp` DISABLE KEYS */;
INSERT INTO `suiIurisProp` VALUES (1,1,1,1,'Latin'),(2,2,1,1,'Ukranian'),(3,3,1,1,'Syro-Malabar'),(4,4,1,1,'Maronite'),(5,5,1,1,'Melkite'),(6,6,1,1,'Ruthenian'),(7,7,1,1,'Armenian'),(8,8,1,1,'Chaldean'),(9,9,1,1,'Syro-Malankara'),(10,10,1,1,'Hungarian'),(11,11,1,1,'Slovak'),(12,12,1,1,'Ethiopian'),(13,13,1,1,'Coptic'),(14,14,1,1,'Romanian'),(15,15,1,1,'Syriac'),(16,16,1,1,'Eritrean'),(17,17,1,1,'Italo-Albanian'),(18,18,1,1,'Croatian'),(19,19,1,1,'Macedonian'),(20,20,1,1,'Bulgarian'),(21,21,1,1,'Albanian'),(22,22,1,1,'Greek'),(23,23,1,1,'Russian'),(24,24,1,1,'Belarusian');
/*!40000 ALTER TABLE `suiIurisProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tradition`
--

DROP TABLE IF EXISTS `tradition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tradition` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tradition` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `archtraditionId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tradition` (`tradition`),
  KEY `archtraditionId` (`archtraditionId`),
  CONSTRAINT `tradition_ibfk_1` FOREIGN KEY (`archtraditionId`) REFERENCES `archtradition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tradition`
--

LOCK TABLES `tradition` WRITE;
/*!40000 ALTER TABLE `tradition` DISABLE KEYS */;
INSERT INTO `tradition` VALUES (1,'Latin',1),(2,'Byzantine',2),(3,'Antiochian',2),(4,'Chaldean',2),(5,'Armenian',2),(6,'Alexandrian',2);
/*!40000 ALTER TABLE `tradition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traditionAttr`
--

DROP TABLE IF EXISTS `traditionAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traditionAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traditionAttr`
--

LOCK TABLES `traditionAttr` WRITE;
/*!40000 ALTER TABLE `traditionAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `traditionAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traditionProp`
--

DROP TABLE IF EXISTS `traditionProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traditionProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `traditionId` int(10) unsigned NOT NULL,
  `traditionAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `traditionId` (`traditionId`,`traditionAttrId`,`multi`),
  KEY `traditionAttrId` (`traditionAttrId`,`multi`,`value`),
  KEY `traditionAttrId_2` (`traditionAttrId`,`value`),
  CONSTRAINT `traditionProp_ibfk_1` FOREIGN KEY (`traditionId`) REFERENCES `tradition` (`id`),
  CONSTRAINT `traditionProp_ibfk_2` FOREIGN KEY (`traditionAttrId`) REFERENCES `traditionAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traditionProp`
--

LOCK TABLES `traditionProp` WRITE;
/*!40000 ALTER TABLE `traditionProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `traditionProp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `week`
--

DROP TABLE IF EXISTS `week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `week` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `week` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `week` (`week`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `week`
--

LOCK TABLES `week` WRITE;
/*!40000 ALTER TABLE `week` DISABLE KEYS */;
INSERT INTO `week` VALUES (5,'fifth'),(1,'first'),(4,'fourth'),(6,'last'),(2,'second'),(3,'third');
/*!40000 ALTER TABLE `week` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekAttr`
--

DROP TABLE IF EXISTS `weekAttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekAttr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `multiLimit` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekAttr`
--

LOCK TABLES `weekAttr` WRITE;
/*!40000 ALTER TABLE `weekAttr` DISABLE KEYS */;
/*!40000 ALTER TABLE `weekAttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekProp`
--

DROP TABLE IF EXISTS `weekProp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekProp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `weekId` int(10) unsigned NOT NULL,
  `weekAttrId` int(10) unsigned NOT NULL,
  `multi` int(10) unsigned DEFAULT '1',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `weekId` (`weekId`,`weekAttrId`,`multi`),
  KEY `weekAttrId` (`weekAttrId`,`multi`,`value`),
  KEY `weekAttrId_2` (`weekAttrId`,`value`),
  CONSTRAINT `weekProp_ibfk_1` FOREIGN KEY (`weekId`) REFERENCES `week` (`id`),
  CONSTRAINT `weekProp_ibfk_2` FOREIGN KEY (`weekAttrId`) REFERENCES `weekAttr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekProp`
--

LOCK TABLES `weekProp` WRITE;
/*!40000 ALTER TABLE `weekProp` DISABLE KEYS */;
/*!40000 ALTER TABLE `weekProp` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-07-20 14:00:10
