CREATE DATABASE  IF NOT EXISTS `gestion_viajes` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestion_viajes`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: roundhouse.proxy.rlwy.net    Database: gestion_viajes
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `datosVuelo`
--

DROP TABLE IF EXISTS `datosVuelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datosVuelo` (
  `id_vuelo` int NOT NULL AUTO_INCREMENT,
  `aeropuerto_origen` varchar(70) DEFAULT NULL,
  `ciudad_origen` varchar(70) DEFAULT NULL,
  `nombre_compañia_aerea` varchar(30) DEFAULT NULL,
  `ciudad_destino` varchar(70) DEFAULT NULL,
  `aeropuerto_destino` varchar(70) DEFAULT NULL,
  `tipo_viajero` varchar(20) DEFAULT NULL,
  `precio_medio` decimal(7,2) DEFAULT NULL,
  `clase` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_vuelo`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datosVuelo`
--

LOCK TABLES `datosVuelo` WRITE;
/*!40000 ALTER TABLE `datosVuelo` DISABLE KEYS */;
INSERT INTO `datosVuelo` VALUES (106,'ADOLFO SUAREZ BARAJAS','MADRID','ADOLFO SUAREZ BARAJAS','BERLIN','BRANDENBURG','ADULT',386.44,'ECONOMY'),(113,'ADOLFO SUAREZ BARAJAS','MADRID','ADOLFO SUAREZ BARAJAS','ROME','FIUMICINO','ADULT',110.36,'ECONOMY'),(115,'ADOLFO SUAREZ BARAJAS','MADRID','ADOLFO SUAREZ BARAJAS','ROME','FIUMICINO','ADULT',220.72,'ECONOMY'),(116,'ADOLFO SUAREZ BARAJAS','MADRID','ADOLFO SUAREZ BARAJAS','LONDON','HEATHROW','ADULT',117.82,'ECONOMY'),(117,'ADOLFO SUAREZ BARAJAS','MADRID','ADOLFO SUAREZ BARAJAS','BARCELONA','AIRPORT','ADULT',117.29,'ECONOMY'),(118,'AIRPORT','BARCELONA','AIRPORT','MADRID','ADOLFO SUAREZ BARAJAS','ADULT',102.29,'ECONOMY');
/*!40000 ALTER TABLE `datosVuelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `id_direccion` int NOT NULL AUTO_INCREMENT,
  `cod_pais` char(2) DEFAULT NULL,
  `pais` varchar(70) DEFAULT NULL,
  `cod_ciudad` char(4) DEFAULT NULL,
  `ciudad` varchar(70) DEFAULT NULL,
  `calle` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_direccion`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
INSERT INTO `direccion` VALUES (95,'DE','null','BER','Berlin','virtuell - Jelbi-Punkt U Wilmersdorfer Straße/Kantstraße, 10627 Berlin, Alemania'),(100,'IT','null','ROM','Rome','Via Milano, 29, 00065 Fiano Romano RM, Italia'),(101,'IT','null','ROM','Rome','Via Torquato Taramelli, 6, 00197 Roma RM, Italia'),(102,'GB','null','LON','London','1 Western Gateway, London E16 1XL, Reino Unido'),(103,'ES','null','BCN','Barcelona','C/ de la Selva de Mar, 7X, Sant Martí, 08019 Barcelona, España'),(104,'ES','null','MAD','Madrid','Paseo de las Delicias, 26, Arganzuela, 28045 Madrid, España');
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habitacion`
--

DROP TABLE IF EXISTS `habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habitacion` (
  `id_habitacion` varchar(10) NOT NULL,
  `id_hotel` varchar(10) DEFAULT NULL,
  `fecha_entrada` date DEFAULT NULL,
  `fecha_salida` date DEFAULT NULL,
  `habitacion_disponible` tinyint(1) GENERATED ALWAYS AS (((to_days(`fecha_salida`) - to_days(`fecha_entrada`)) > 0)) STORED,
  `num_cama` tinyint DEFAULT NULL,
  `tipo_cama` varchar(20) DEFAULT NULL,
  `precio_noche` double DEFAULT NULL,
  `precio_total` double DEFAULT NULL,
  PRIMARY KEY (`id_habitacion`),
  KEY `id_hotel` (`id_hotel`),
  CONSTRAINT `habitacion_ibfk_1` FOREIGN KEY (`id_hotel`) REFERENCES `hotel` (`id_hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitacion`
--

LOCK TABLES `habitacion` WRITE;
/*!40000 ALTER TABLE `habitacion` DISABLE KEYS */;
INSERT INTO `habitacion` (`id_habitacion`, `id_hotel`, `fecha_entrada`, `fecha_salida`, `num_cama`, `tipo_cama`, `precio_noche`, `precio_total`) VALUES ('77X5NHM2FS','ARBCNFOR','2024-06-07','2024-06-09',1,'QUEEN',269,602.7),('BE7O0PR96B','BWROM041','2024-11-12','2024-11-15',1,'SINGLE',208,642),('K3C5Q6C42I','BWBER265','2024-11-11','2024-11-14',2,'SINGLE',1033,3099),('MICCTAGLQC','ARMADCAR','2024-06-24','2024-06-30',1,'TWIN',227,1496),('MOADH17AL5','ALLON591','2024-06-09','2024-06-12',1,'KING',343,1027),('RCO8N9VE3F','BWROM182','2024-10-10','2024-10-14',1,'QUEEN',200,808);
/*!40000 ALTER TABLE `habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `id_hotel` varchar(10) NOT NULL,
  `id_direccion` int DEFAULT NULL,
  `nombre_hotel` varchar(70) DEFAULT NULL,
  `latitud_hotel` decimal(9,6) DEFAULT NULL,
  `longitud_hotel` decimal(9,6) DEFAULT NULL,
  PRIMARY KEY (`id_hotel`),
  UNIQUE KEY `nombre_hotel` (`nombre_hotel`),
  KEY `hotel_ibfk_1` (`id_direccion`),
  CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`id_direccion`) REFERENCES `direccion` (`id_direccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES ('ALLON591',102,'ALOFT LONDON EXCEL',51.508160,0.026460),('ARBCNFOR',103,'AC BY MARRIOTT BARCELONA FORUM',41.405560,2.213290),('ARMADCAR',104,'AC CARLTON MADRID',40.405160,-3.693470),('BWBER265',95,'BW HOTEL KANTSTRASSE BERLIN',52.506660,13.305740),('BWROM041',101,'BEST WESTERN HOTEL RIVOLI',41.922440,12.483380),('BWROM182',100,'BEST WESTERN PARK HOTEL',42.141790,12.604640);
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `contraseña` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(100) NOT NULL,
  `sesion_activa` tinyint(1) NOT NULL DEFAULT '0',
  `modo_oscuro` tinyint(1) NOT NULL DEFAULT '0',
  `ultima_sesion` timestamp NULL DEFAULT NULL,
  `ultima_conexion` datetime DEFAULT NULL,
  `ultima_conexion_temporal` datetime DEFAULT NULL,
  `ultima_modificacion_contrasenna` timestamp NULL DEFAULT NULL,
  `sexo` enum('Masculino','Femenino','Otro') DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (32,'Jose','Juli@n2003','soy.jjulian@gmail.com',0,0,NULL,'2024-06-06 10:53:45','2024-06-07 16:57:32','2024-05-23 00:00:00','Masculino','611419484','2003-02-14'),(38,'Apa','Apa1234*','alvaro.04apa@gmail.com',0,0,NULL,'2024-06-07 17:09:47','2024-06-07 17:13:18','2024-05-30 00:00:00','Masculino','665430758','2006-05-30'),(45,'carlos05','Datrebil@2003','caaarlosvelasco@gmail.com',0,1,NULL,'2024-06-07 12:06:52','2024-06-07 12:17:52','2024-06-06 00:00:00','Masculino','659284152','2000-01-20');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viaje`
--

DROP TABLE IF EXISTS `viaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viaje` (
  `id_viaje` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_habitacion` varchar(50) DEFAULT NULL,
  `id_vuelo` int DEFAULT NULL,
  `numero_viajeros` int DEFAULT NULL,
  PRIMARY KEY (`id_viaje`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_habitacion` (`id_habitacion`),
  KEY `viaje_ibfk_3` (`id_vuelo`),
  CONSTRAINT `viaje_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `viaje_ibfk_2` FOREIGN KEY (`id_habitacion`) REFERENCES `habitacion` (`id_habitacion`),
  CONSTRAINT `viaje_ibfk_3` FOREIGN KEY (`id_vuelo`) REFERENCES `datosVuelo` (`id_vuelo`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viaje`
--

LOCK TABLES `viaje` WRITE;
/*!40000 ALTER TABLE `viaje` DISABLE KEYS */;
INSERT INTO `viaje` VALUES (122,45,'K3C5Q6C42I',106,2),(126,45,'BE7O0PR96B',113,1),(127,45,'RCO8N9VE3F',115,2),(128,32,'MOADH17AL5',116,1),(129,32,'77X5NHM2FS',117,1),(130,38,'MICCTAGLQC',118,1);
/*!40000 ALTER TABLE `viaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'gestion_viajes'
--

--
-- Dumping routines for database 'gestion_viajes'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-07 17:16:36
