-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: amazon_clone
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `OrderId` int(11) NOT NULL AUTO_INCREMENT,
  `Status` varchar(45) DEFAULT 'Pending',
  `DateRecieved` datetime DEFAULT current_timestamp(),
  `DateDelivered` datetime DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `StoreID` int(11) DEFAULT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `StoreID` (`StoreID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`StoreID`) REFERENCES `store` (`StoreID`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'Done','2024-07-22 22:15:56','2024-07-23 21:02:55',1,28),(30,'Done','2024-08-01 00:51:38','2024-08-04 21:16:20',3,28),(31,'Done','2024-08-02 21:40:29','2024-08-04 17:31:16',3,28),(32,'Done','2024-08-02 21:44:41','2024-08-04 00:35:30',3,28),(33,'Pending','2024-08-04 21:20:41',NULL,3,28),(34,'Done','2024-08-05 12:23:12','2024-08-05 16:27:21',3,28),(35,'Done','2024-08-05 16:29:36','2024-08-05 16:40:02',3,28),(36,'Pending','2024-08-05 16:42:18',NULL,3,28);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-05 16:46:42
