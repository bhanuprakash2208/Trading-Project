-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.13-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for capstone
DROP DATABASE IF EXISTS `capstone`;
CREATE DATABASE IF NOT EXISTS `capstone` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `capstone`;

-- Dumping structure for table capstone.buy_order
DROP TABLE IF EXISTS `buy_order`;
CREATE TABLE IF NOT EXISTS `buy_order` (
  `bid` varchar(255) NOT NULL,
  `orderdate` date DEFAULT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `remainingquantity` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `clientid` varchar(255) DEFAULT NULL,
  `instrumentid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bid`),
  KEY `FKml97nrle0ofy60rncmpdigtk` (`clientid`),
  KEY `FKjakr3b0mm7xj8d2dvb77bblke` (`instrumentid`),
  CONSTRAINT `FKjakr3b0mm7xj8d2dvb77bblke` FOREIGN KEY (`instrumentid`) REFERENCES `instrument` (`instrumentid`),
  CONSTRAINT `FKml97nrle0ofy60rncmpdigtk` FOREIGN KEY (`clientid`) REFERENCES `client` (`clientid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table capstone.buy_order: ~6 rows (approximately)
/*!40000 ALTER TABLE `buy_order` DISABLE KEYS */;
INSERT INTO `buy_order` (`bid`, `orderdate`, `price`, `quantity`, `remainingquantity`, `status`, `clientid`, `instrumentid`) VALUES
	('B001', '2021-09-20', 55, 75, 25, 'Partially Completed', 'DBS001', 'I002'),
	('B002', '2021-09-20', 112, 50, 50, 'Waiting', 'DBS001', 'I001'),
	('B003', '2021-09-24', 90, 50, 0, 'Completed', 'DBS001', 'I001'),
	('B004', '2021-09-24', 201, 50, 50, 'Waiting', 'DBS004', 'I004'),
	('B005', '2021-09-24', 45, 50, 25, 'Partially Completed', 'DBS002', 'I002'),
	('B006', '2021-09-24', 55, 50, 0, 'Completed', 'DBS002', 'I002');
/*!40000 ALTER TABLE `buy_order` ENABLE KEYS */;

-- Dumping structure for table capstone.client
DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `clientid` varchar(255) NOT NULL,
  `clientname` varchar(255) DEFAULT NULL,
  `remainingtransactionlimit` double NOT NULL,
  `transactionlimit` double NOT NULL,
  `custodianid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`clientid`),
  KEY `FKctq44rj32ieimfwbtrr1303oy` (`custodianid`),
  CONSTRAINT `FKctq44rj32ieimfwbtrr1303oy` FOREIGN KEY (`custodianid`) REFERENCES `custodian` (`custodianid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table capstone.client: ~9 rows (approximately)
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` (`clientid`, `clientname`, `remainingtransactionlimit`, `transactionlimit`, `custodianid`) VALUES
	('DBS001', 'MACQUARIE BANK LIMITED', 13990000, 14000000, 'CS001'),
	('DBS002', 'LLOYDS BANK CORPORATE MARKETS PLC', 13993375, 14000000, 'CS001'),
	('DBS003', 'KEYBANK NATIONAL ASSOCIATION', 17995500, 18000000, 'CS001'),
	('DBS004', 'JP MORGAN SECURITIES LLC', 4998875, 5000000, 'CS001'),
	('DBS005', 'JEFFERIES FINANCIAL SERVICES, INC.', 21000006, 21000006, 'CS002'),
	('DBS006', 'JB DRAX HONORE UK LTD', 21000006, 21000006, 'CS002'),
	('DBS007', 'J ARON & COMPANY SINGAPORE PTE', 18000006, 18000006, 'CS002'),
	('DBS008', 'HSBC BANK PLC', 17500015, 17500015, 'CS003'),
	('DBS009', 'GOLDMAN SACHS PARIS INC ET CIE', 28000024, 28000024, 'CS003');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;

-- Dumping structure for table capstone.client_stocks
DROP TABLE IF EXISTS `client_stocks`;
CREATE TABLE IF NOT EXISTS `client_stocks` (
  `quantity` int(11) NOT NULL,
  `instrumentid` varchar(255) NOT NULL,
  `clientid` varchar(255) NOT NULL,
  PRIMARY KEY (`clientid`,`instrumentid`),
  KEY `FKpqmtt26kd8uk4yu8xiqooyrcq` (`instrumentid`),
  CONSTRAINT `FKpqmtt26kd8uk4yu8xiqooyrcq` FOREIGN KEY (`instrumentid`) REFERENCES `instrument` (`instrumentid`),
  CONSTRAINT `FKr99e1b9edvekoi7xb9pc0tuff` FOREIGN KEY (`clientid`) REFERENCES `client` (`clientid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table capstone.client_stocks: ~4 rows (approximately)
/*!40000 ALTER TABLE `client_stocks` DISABLE KEYS */;
INSERT INTO `client_stocks` (`quantity`, `instrumentid`, `clientid`) VALUES
	(100, 'I001', 'DBS001'),
	(500, 'I002', 'DBS001'),
	(125, 'I002', 'DBS002'),
	(200, 'I002', 'DBS003');
/*!40000 ALTER TABLE `client_stocks` ENABLE KEYS */;

-- Dumping structure for table capstone.custodian
DROP TABLE IF EXISTS `custodian`;
CREATE TABLE IF NOT EXISTS `custodian` (
  `custodianid` varchar(255) NOT NULL,
  `custodianname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`custodianid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table capstone.custodian: ~3 rows (approximately)
/*!40000 ALTER TABLE `custodian` DISABLE KEYS */;
INSERT INTO `custodian` (`custodianid`, `custodianname`, `password`) VALUES
	('CS001', 'BNP Paribas Securities ServicesFrance', 'bnp'),
	('CS002', 'The Bank of New York Mellon CorporationU.S.', 'bny'),
	('CS003', 'EuroclearBelgium', 'ebg');
/*!40000 ALTER TABLE `custodian` ENABLE KEYS */;

-- Dumping structure for table capstone.instrument
DROP TABLE IF EXISTS `instrument`;
CREATE TABLE IF NOT EXISTS `instrument` (
  `instrumentid` varchar(255) NOT NULL,
  `expirydate` date DEFAULT NULL,
  `facevalue` double NOT NULL,
  `instrumentname` varchar(255) DEFAULT NULL,
  `minquantity` int(11) NOT NULL,
  PRIMARY KEY (`instrumentid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table capstone.instrument: ~5 rows (approximately)
/*!40000 ALTER TABLE `instrument` DISABLE KEYS */;
INSERT INTO `instrument` (`instrumentid`, `expirydate`, `facevalue`, `instrumentname`, `minquantity`) VALUES
	('I001', '2021-09-20', 100, 'US treasury Bills', 25),
	('I002', '2021-09-20', 50, 'RBI-2026 -6.5%', 25),
	('I003', '2021-09-20', 1000, 'RBI-2045 -8%', 25),
	('I004', '2020-09-20', 200, 'USDINR', 25),
	('I005', '2021-09-20', 500, 'EUR USD-FUT', 25);
/*!40000 ALTER TABLE `instrument` ENABLE KEYS */;

-- Dumping structure for table capstone.sell_order
DROP TABLE IF EXISTS `sell_order`;
CREATE TABLE IF NOT EXISTS `sell_order` (
  `sellid` varchar(255) NOT NULL,
  `orderdate` date DEFAULT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `remainingquantity` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `clientid` varchar(255) DEFAULT NULL,
  `instrumentid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sellid`),
  KEY `FK3n1c2rtkyklxe0hpw5tlblr5v` (`clientid`),
  KEY `FKpjp6w1jm6vimc6nkdwweqwlfx` (`instrumentid`),
  CONSTRAINT `FK3n1c2rtkyklxe0hpw5tlblr5v` FOREIGN KEY (`clientid`) REFERENCES `client` (`clientid`),
  CONSTRAINT `FKpjp6w1jm6vimc6nkdwweqwlfx` FOREIGN KEY (`instrumentid`) REFERENCES `instrument` (`instrumentid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table capstone.sell_order: ~5 rows (approximately)
/*!40000 ALTER TABLE `sell_order` DISABLE KEYS */;
INSERT INTO `sell_order` (`sellid`, `orderdate`, `price`, `quantity`, `remainingquantity`, `status`, `clientid`, `instrumentid`) VALUES
	('S001', '2021-09-24', 55, 100, 50, 'Partially Completed', 'DBS001', 'I002'),
	('S002', '2021-09-24', 90, 50, 0, 'Completed', 'DBS003', 'I001'),
	('S003', '2021-09-24', 55, 50, 0, 'Completed', 'DBS002', 'I002'),
	('S004', '2021-09-24', 56, 100, 100, 'Waiting', 'DBS003', 'I002'),
	('S005', '2021-09-24', 45, 25, 0, 'Completed', 'DBS004', 'I002');
/*!40000 ALTER TABLE `sell_order` ENABLE KEYS */;

-- Dumping structure for table capstone.trade_history
DROP TABLE IF EXISTS `trade_history`;
CREATE TABLE IF NOT EXISTS `trade_history` (
  `tradeid` int(11) NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `tradeamount` double NOT NULL,
  `tradedate` date DEFAULT NULL,
  `buyerorder_id` varchar(255) DEFAULT NULL,
  `sellerorder_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tradeid`),
  KEY `FKr33pl7divo3ekole05f8bdn67` (`buyerorder_id`),
  KEY `FKmyusebbonl9491w4cj7lxrmbp` (`sellerorder_id`),
  CONSTRAINT `FKmyusebbonl9491w4cj7lxrmbp` FOREIGN KEY (`sellerorder_id`) REFERENCES `sell_order` (`sellid`),
  CONSTRAINT `FKr33pl7divo3ekole05f8bdn67` FOREIGN KEY (`buyerorder_id`) REFERENCES `buy_order` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table capstone.trade_history: ~4 rows (approximately)
/*!40000 ALTER TABLE `trade_history` DISABLE KEYS */;
INSERT INTO `trade_history` (`tradeid`, `price`, `quantity`, `tradeamount`, `tradedate`, `buyerorder_id`, `sellerorder_id`) VALUES
	(1, 55, 50, 2750, '2021-09-24', 'B006', 'S001'),
	(2, 90, 50, 4500, '2021-09-24', 'B003', 'S002'),
	(3, 55, 50, 2750, '2021-09-24', 'B001', 'S003'),
	(4, 45, 25, 1125, '2021-09-24', 'B005', 'S005');
/*!40000 ALTER TABLE `trade_history` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
