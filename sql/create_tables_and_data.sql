-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: techwheels
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `hubs`
--

DROP TABLE IF EXISTS `hubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hubs` (
  `Hub_id` decimal(6,0) NOT NULL,
  `Hub_name` varchar(100) NOT NULL,
  `campus_address` varchar(50) DEFAULT NULL,
  `GPS_coordinates` varchar(100) DEFAULT NULL,
  `total_number_parking_spots` int DEFAULT NULL,
  `operating_hours` varchar(100) DEFAULT NULL,
  `charging_station` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Hub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hubs`
--

LOCK TABLES `hubs` WRITE;
/*!40000 ALTER TABLE `hubs` DISABLE KEYS */;
INSERT INTO `hubs` VALUES (1,'North Avenue Hub','North Avenue','40.7360,-73.8170',30,'7AM-10PM','Yes'),(2,'East Hub','Library Lot','40.7350,-73.8150',25,'8AM-9PM','Yes'),(3,'South Hub','South Avenue','40.7340,-73.8160',20,'7AM-11PM','No');
/*!40000 ALTER TABLE `hubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_photo`
--

DROP TABLE IF EXISTS `incident_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident_photo` (
  `incident_id` decimal(6,0) NOT NULL,
  `photo` varchar(200) NOT NULL,
  PRIMARY KEY (`incident_id`,`photo`),
  CONSTRAINT `incident_photo_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident_report` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident_photo`
--

LOCK TABLES `incident_photo` WRITE;
/*!40000 ALTER TABLE `incident_photo` DISABLE KEYS */;
INSERT INTO `incident_photo` VALUES (801,'scratch_photo_1.jpg'),(801,'scratch_photo_2.jpg');
/*!40000 ALTER TABLE `incident_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_report`
--

DROP TABLE IF EXISTS `incident_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident_report` (
  `incident_id` decimal(6,0) NOT NULL,
  `trip_id` decimal(6,0) NOT NULL,
  `member_id` decimal(6,0) NOT NULL,
  `reviewed_staff_id` decimal(6,0) DEFAULT NULL,
  `incident` varchar(300) DEFAULT NULL,
  `date_reported` date DEFAULT NULL,
  `severity_level` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  KEY `trip_id` (`trip_id`),
  KEY `member_id` (`member_id`),
  KEY `reviewed_staff_id` (`reviewed_staff_id`),
  CONSTRAINT `incident_report_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`trip_id`),
  CONSTRAINT `incident_report_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  CONSTRAINT `incident_report_ibfk_3` FOREIGN KEY (`reviewed_staff_id`) REFERENCES `staff` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident_report`
--

LOCK TABLES `incident_report` WRITE;
/*!40000 ALTER TABLE `incident_report` DISABLE KEYS */;
INSERT INTO `incident_report` VALUES (801,601,2,401,'scratch','2026-05-11','Minor');
/*!40000 ALTER TABLE `incident_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_record`
--

DROP TABLE IF EXISTS `maintenance_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_record` (
  `maintenance_id` decimal(6,0) NOT NULL,
  `vehicle_id` decimal(6,0) NOT NULL,
  `maintenance_date` date DEFAULT NULL,
  `work_performed_description` varchar(300) DEFAULT NULL,
  `maintenance_cost` decimal(10,2) DEFAULT NULL,
  `performed_staff_id` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`maintenance_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `performed_staff_id` (`performed_staff_id`),
  CONSTRAINT `maintenance_record_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`),
  CONSTRAINT `maintenance_record_ibfk_2` FOREIGN KEY (`performed_staff_id`) REFERENCES `staff` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_record`
--

LOCK TABLES `maintenance_record` WRITE;
/*!40000 ALTER TABLE `maintenance_record` DISABLE KEYS */;
INSERT INTO `maintenance_record` VALUES (701,203,'2026-05-05','brake replacement',450.00,402),(702,202,'2026-04-20','Battery',180.00,402);
/*!40000 ALTER TABLE `maintenance_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_phone`
--

DROP TABLE IF EXISTS `member_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_phone` (
  `Member_id` decimal(6,0) NOT NULL,
  `Phone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`Member_id`,`Phone_number`),
  CONSTRAINT `member_phone_ibfk_1` FOREIGN KEY (`Member_id`) REFERENCES `members` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_phone`
--

LOCK TABLES `member_phone` WRITE;
/*!40000 ALTER TABLE `member_phone` DISABLE KEYS */;
INSERT INTO `member_phone` VALUES (1,'718-123-2272'),(2,'917-456-7444'),(3,'646-545-6997');
/*!40000 ALTER TABLE `member_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` decimal(6,0) NOT NULL,
  `cuny_id_number` decimal(6,0) NOT NULL,
  `full_name` varchar(40) NOT NULL,
  `campus_email` varchar(40) NOT NULL,
  `home_address` varchar(50) DEFAULT NULL,
  `driver_license_number` varchar(20) DEFAULT NULL,
  `license_expiration_date` date DEFAULT NULL,
  `tier_id` decimal(6,0) NOT NULL,
  PRIMARY KEY (`member_id`),
  KEY `tier_id` (`tier_id`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`tier_id`) REFERENCES `membership_tier` (`tier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,123456,'A','A@qc.cuny.edu','1111, Queens, NY','D1234567','2027-05-01',1),(2,122256,'B','B@qc.cuny.edu','21-17, Queens, NY','D5257567','2023-09-01',2),(3,523277,'C','C@qc.cuny.edu','61-13, Queens, NY','A7123555','2022-02-01',3),(4,444555,'John Doe','john@qc.cuny.edu','Queens NY','D5555555','2028-01-01',1),(5,423455,'Doe','DDD@qc.cuny.edu','Queens NY','D551235','2028-01-01',1),(6,411155,'h','h@qc.cuny.edu','Queens NY','D523445','2028-01-01',3),(1234,229985,'y','y@qc.cuny.edu','1122','151595','2017-11-11',3),(2222,123456,'w','w@qc.cuny.edu','55555','1598513','2022-05-01',1);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_card`
--

DROP TABLE IF EXISTS `membership_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_card` (
  `Membership_card_number` decimal(12,0) NOT NULL,
  `membership_issue_date` date NOT NULL,
  `membership_expiration_date` date NOT NULL,
  `card_status` varchar(30) NOT NULL,
  `Member_id` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`Membership_card_number`),
  KEY `Member_id` (`Member_id`),
  CONSTRAINT `membership_card_ibfk_1` FOREIGN KEY (`Member_id`) REFERENCES `members` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_card`
--

LOCK TABLES `membership_card` WRITE;
/*!40000 ALTER TABLE `membership_card` DISABLE KEYS */;
INSERT INTO `membership_card` VALUES (5001,'2021-01-01','2027-01-01','Active',1),(5002,'2022-04-01','2029-04-01','Active',2),(5003,'2003-05-01','2028-05-01','Active',3);
/*!40000 ALTER TABLE `membership_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_tier`
--

DROP TABLE IF EXISTS `membership_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_tier` (
  `tier_id` decimal(6,0) NOT NULL,
  `tier_name` varchar(40) NOT NULL,
  `max_reservations_per_week` int DEFAULT NULL,
  `max_checkout_hours` int DEFAULT NULL,
  PRIMARY KEY (`tier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_tier`
--

LOCK TABLES `membership_tier` WRITE;
/*!40000 ALTER TABLE `membership_tier` DISABLE KEYS */;
INSERT INTO `membership_tier` VALUES (1,'Basic',3,6),(2,'Premium',7,24),(3,'Faculty/Staff',NULL,72);
/*!40000 ALTER TABLE `membership_tier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `reservation_id` decimal(6,0) NOT NULL,
  `required_vehicle_type` varchar(50) DEFAULT NULL,
  `scheduled_pickup_time` datetime DEFAULT NULL,
  `expected_return_time` datetime DEFAULT NULL,
  `reservation_status` varchar(50) DEFAULT NULL,
  `member_id` decimal(6,0) NOT NULL,
  `vehicle_id` decimal(6,0) NOT NULL,
  `pickup_hub_id` decimal(6,0) NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `member_id` (`member_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `pickup_hub_id` (`pickup_hub_id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`),
  CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`pickup_hub_id`) REFERENCES `hubs` (`Hub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (302,'Sedan','2026-05-11 10:00:00','2026-05-11 18:00:00','Completed',2,202,2),(303,'Cargo Van','2026-05-12 08:00:00','2026-05-12 14:00:00','Cancelled',3,203,3),(304,'van','2026-05-01 09:00:00','2026-05-02 09:00:00','active',1234,203,2);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `employee_id` decimal(6,0) NOT NULL,
  `staff_name` varchar(20) NOT NULL,
  `staff_role` varchar(50) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (401,'D','Fleet Manager','2022-08-01'),(402,'E','Maintenance Technician','2023-01-20'),(403,'F','Hub Attendant','2024-02-10');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_email`
--

DROP TABLE IF EXISTS `staff_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_email` (
  `employee_id` decimal(6,0) NOT NULL,
  `staff_email` varchar(50) NOT NULL,
  PRIMARY KEY (`employee_id`,`staff_email`),
  CONSTRAINT `staff_email_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `staff` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_email`
--

LOCK TABLES `staff_email` WRITE;
/*!40000 ALTER TABLE `staff_email` DISABLE KEYS */;
INSERT INTO `staff_email` VALUES (401,'d@techwheels.cuny.edu'),(402,'e@techwheels.cuny.edu'),(403,'f@techwheels.cuny.edu');
/*!40000 ALTER TABLE `staff_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_hub`
--

DROP TABLE IF EXISTS `staff_hub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_hub` (
  `employee_id` decimal(6,0) NOT NULL,
  `hub_id` decimal(6,0) NOT NULL,
  PRIMARY KEY (`employee_id`,`hub_id`),
  KEY `hub_id` (`hub_id`),
  CONSTRAINT `staff_hub_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `staff` (`employee_id`),
  CONSTRAINT `staff_hub_ibfk_2` FOREIGN KEY (`hub_id`) REFERENCES `hubs` (`Hub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_hub`
--

LOCK TABLES `staff_hub` WRITE;
/*!40000 ALTER TABLE `staff_hub` DISABLE KEYS */;
INSERT INTO `staff_hub` VALUES (401,1),(402,2),(402,3);
/*!40000 ALTER TABLE `staff_hub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_phone`
--

DROP TABLE IF EXISTS `staff_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_phone` (
  `employee_id` decimal(6,0) NOT NULL,
  `staff_phone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`employee_id`,`staff_phone_number`),
  CONSTRAINT `staff_phone_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `staff` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_phone`
--

LOCK TABLES `staff_phone` WRITE;
/*!40000 ALTER TABLE `staff_phone` DISABLE KEYS */;
INSERT INTO `staff_phone` VALUES (401,'718-888-1000'),(402,'718-888-2000'),(403,'718-888-3000');
/*!40000 ALTER TABLE `staff_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `trip_id` decimal(6,0) NOT NULL,
  `reservation_id` decimal(6,0) NOT NULL,
  `member_id` decimal(6,0) NOT NULL,
  `vehicle_id` decimal(6,0) NOT NULL,
  `pickup_hub_id` decimal(6,0) NOT NULL,
  `return_hub_id` decimal(6,0) DEFAULT NULL,
  `scheduled_pickup_times` datetime DEFAULT NULL,
  `scheduled_return_times` datetime DEFAULT NULL,
  `actual_pickup_times` datetime DEFAULT NULL,
  `actual_return_times` datetime DEFAULT NULL,
  `pickup_odometer_readings` int DEFAULT NULL,
  `return_odometer_readings` int DEFAULT NULL,
  `late_returns` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`trip_id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `member_id` (`member_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `pickup_hub_id` (`pickup_hub_id`),
  KEY `return_hub_id` (`return_hub_id`),
  CONSTRAINT `trip_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`),
  CONSTRAINT `trip_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  CONSTRAINT `trip_ibfk_3` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`),
  CONSTRAINT `trip_ibfk_4` FOREIGN KEY (`pickup_hub_id`) REFERENCES `hubs` (`Hub_id`),
  CONSTRAINT `trip_ibfk_5` FOREIGN KEY (`return_hub_id`) REFERENCES `hubs` (`Hub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (601,302,2,202,2,1,'2026-05-11 10:00:00','2026-05-11 18:00:00','2026-05-11 10:10:00','2026-05-11 18:30:00',8000,8060,'Yes');
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `vehicle_id` decimal(6,0) NOT NULL,
  `make` varchar(20) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `license_plate_number` varchar(20) NOT NULL,
  `vehicle_type` varchar(20) DEFAULT NULL,
  `fuel_power_type` varchar(20) DEFAULT NULL,
  `seating_capacity` int DEFAULT NULL,
  `current_mileage` int DEFAULT NULL,
  `vehicle_status` varchar(20) DEFAULT NULL,
  `restricted` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (201,'Toyota','Camry',2022,'White','NYA1234','Sedan','Gasoline',5,15000,'Checked Out','No'),(202,'Tesla','Model 3',2023,'Black','NYE5678','Sedan','Electric',5,8000,'Checked Out','No'),(203,'Ford','Transit',2021,'Blue','NYC9999','Cargo Van','Gasoline',2,30000,'Under Maintenance','Yes');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-23 12:03:46
